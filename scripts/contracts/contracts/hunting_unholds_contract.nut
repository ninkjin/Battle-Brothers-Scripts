this.hunting_unholds_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true
	},
	function setEnemyType( _t )
	{
		this.m.Flags.set("EnemyType", _t);
	}

	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_unholds";
		this.m.Name = "狩猎巨人";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 750 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"追捕城镇附近的巨魔于 " + this.Contract.m.Home.getName()
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);

				if (r <= 40)
				{
					this.Flags.set("IsDriveOff", true);
				}
				else if (r <= 50)
				{
					this.Flags.set("IsSignsOfAFight", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 6, 12, [
					this.Const.World.TerrainType.Mountains
				]);
				local nearTile = this.Contract.getTileToSpawnLocation(playerTile, 4, 8);
				local party;

				if (this.Flags.get("EnemyType") == 0)
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Unholds", false, this.Const.World.Spawn.UnholdBog, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else if (this.Flags.get("EnemyType") == 1)
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Unholds", false, this.Const.World.Spawn.UnholdFrost, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Unholds", false, this.Const.World.Spawn.Unhold, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				}

				party.setDescription("一个或多个正摇晃着前进的巨人。");
				party.setFootprintType(this.Const.World.FootprintsType.Unholds);
				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				party.getFlags().set("IsUnholds", true);
				this.Const.World.Common.addFootprintsFromTo(nearTile, party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Unholds, 0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
				local roam = this.new("scripts/ai/world/orders/roam_order");
				roam.setPivot(this.Contract.m.Home);
				roam.setMinRange(2);
				roam.setMaxRange(8);
				roam.setAllTerrainAvailable();
				roam.setTerrain(this.Const.World.TerrainType.Ocean, false);
				roam.setTerrain(this.Const.World.TerrainType.Shore, false);
				roam.setTerrain(this.Const.World.TerrainType.Mountains, false);
				c.addOrder(roam);
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Target != null && !this.Contract.m.Target.isNull())
				{
					this.Contract.m.Target.getSprite("selection").Visible = true;
					this.Contract.m.Target.setOnCombatWithPlayerCallback(this.onTargetAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Target == null || this.Contract.m.Target.isNull() || !this.Contract.m.Target.isAlive())
				{
					if (this.Flags.get("IsSignsOfAFight"))
					{
						this.Contract.setScreen("SignsOfAFight");
					}
					else
					{
						this.Contract.setScreen("Victory");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsBanterShown") && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 10.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsDriveOff") && !this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					local bros = this.World.getPlayerRoster().getAll();
					local candidates = [];

					foreach( bro in bros )
					{
						if (bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.barbarian" || bro.getSkills().hasSkill("trait.dumb"))
						{
							candidates.push(bro);
						}
					}

					if (candidates.len() == 0)
					{
						this.World.Contracts.showCombatDialog(_isPlayerAttacking);
					}
					else
					{
						this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
						this.Contract.setScreen("DriveThemOff");
						this.World.Contracts.showActiveContract();
					}
				}
				else if (!this.Flags.get("IsEncounterShown"))
				{
					this.Flags.set("IsEncounterShown", true);
					this.Contract.setScreen("Encounter");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					this.World.Contracts.showCombatDialog(_isPlayerAttacking);
				}
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					if (this.Flags.get("IsDriveOffSuccess"))
					{
						this.Contract.setScreen("SuccessPeaceful");
					}
					else
					{
						this.Contract.setScreen("Success");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_79.png[/img]{当你进入 %employer%的房间你见到他在床边附身，带着一种几乎预谋着什么似的畏缩看着外面。 他眯着眼，然后睁开，然后又眯起来。 他啪地拉上窗帘并猛地转头看向你。%SPEECH_ON%你不会碰巧看到一个非常愤怒的女人正在过来，对吧？ 啊，不要在意。看看这个。%SPEECH_OFF%他丢给你一张卷轴，而你卷开了它。 上面粗糙的画着看起来像是个男人弓着背俯视一个蚂蚁或者某种昆虫。 你不太能辨别。%employer% 拍拍手。%SPEECH_ON%本地的农夫报告有牲口失踪。 他们只找到些足够人摆个棺材那么大的脚印。 我这听起来觉得像是道听途说散布谣言，可能是竞争对手在试着隐瞒犯罪，但我会交给你判断。 搜寻周围的领地并看看能找到什么。 如果你真的遇到个巨人我想你知道该做什么。%SPEECH_OFF% | 你见到 %employer% 坐在他的办公桌旁，似乎和村里一半的农夫在开会。 他们弓身在卷轴前并在纸上留下铅印，画着看起来像巨人或者带角的胖子。 一个人画着个火柴人操着另一个火柴人。%employer% 丢给你一张更启示性的一页，上面画着一个怪物的面容。%SPEECH_ON%这些好先生们跟我说有个巨人在附近。 我不想怀疑我同僚们的顾虑并因此寻求你的服务，佣兵。 钱已经在桌子上了，你要做的只是搜寻 %townname% 附近的领地并找到这个怪兽。你怎么说？%SPEECH_OFF% | 你见到 %employer% 挡着一群农民。 他们带着草叉和没点燃的火把进到了他的房间，他得不停的警告他们不要点火把，以免把这纯木建筑点着了。 看到你，%employer% 像个掉到水里的人喊救生筏一样向你喊道。%SPEECH_ON%佣兵！天啊快过来。 这些人说有个野兽出现了。%SPEECH_OFF%其中一个农民用他的草叉重重地咚了下地面。%SPEECH_ON%不，不是什么寻常野兽，但是个怪物吧？ 一个巨人！一个大只佬。一只大只佬巨人。 在外面。就在那边。我见到过它。%SPEECH_OFF%叹口气同时点了个头，%employer% 回到对话中。%SPEECH_ON%好。所以呢，我愿意拿出一份钱雇你去找这个巨人。 你愿意接吗？%SPEECH_OFF% | %employer% 坐在办公桌边手抱着头。 他在轻声自言自语。%SPEECH_ON%这个说怪物，那个野兽。 “噢我的鸡被拿了”，噢或许你应该考虑下把它放到个笼子里你该死的－噢，嗨，佣兵！%SPEECH_OFF%他从椅子上站起来，扔给你一张纸。 上面粗糙的画着一只头很大的野兽。%SPEECH_ON%人们报道有个巨人在这片区域游荡。 我会开个好价钱来雇人好好调查这些报告，当然还有解决这个野兽的丰厚报酬。 你能行吗？求你了给我个肯定的回答。%SPEECH_OFF% | %employer% 不情愿的欢迎你进入他的房间，假装他不需要你的帮助，尽管显然他完全不想要。%SPEECH_ON%啊，佣兵。通常来说 %townname% 这样的地方不会找你们这种人，但我想恐怕有巨魔被目击到在这片区域游荡，偷了足够多的牲口以至人们集起了一波钱来雇一个像你一样的人。 有兴趣捕猎这头肮脏的生物吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{与巨人战斗可不便宜。 | 价钱合适，%companyname% 就能帮上忙。 | 我们来谈谈克朗。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 这不值得冒险。}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Banter",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_71.png[/img]{%randombrother% 侦查完回来。 他报告说附近的一个农场被摧毁了，一个洞捅穿了它的屋顶像什么人踢了个蚁丘一样。 你问他有没有幸存者。他点头。%SPEECH_ON%某种程度上。一个拒绝说一句话的小伙子。 一个不停叫我滚的女人。除此之外，没有。 他们是出于情境和运气幸存下来的。 这个世界不会允许他们在这呆多久。%SPEECH_OFF%你告诉这个佣兵把这判断留在心里并让战队再次继续前进。 | 你在路边见到半头牛。 它比起屠宰更多的是被巨大的暴力不均的扯开。 它的大部分内脏滑到了地上堆成一团。 坟墓大小的脚印领向别处。 这场屠杀的踪迹穿过一段被粉碎的栅栏，沿着踪迹望去你能看到一个谷仓的废墟。%randombrother% 笑道。%SPEECH_ON%我们救差一大坨屎了。%SPEECH_OFF%你告诉他检查它的靴子。 | 几个路上遇到的农民警示你。%SPEECH_ON%离开这里！ 那盔甲连舔一下都挡不住！%SPEECH_OFF%你问他们巨魔的事而他们的说辞总结起来描述了一个怪物般的巨人不久前刚一路破坏过这片区域。 看起来你的方向没错。 | 巨魔留下了一团糟。 牲口被踩扁，别的被破碎并像被吸过蜜般。 鸡在地上啄着，一个农夫看着他们。他点头。%SPEECH_ON%刚好错过。%SPEECH_OFF%看来你在接近了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "它们不远了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_104.png[/img]{巨魔们让你部分回想起任何一群工人，围着灭了的篝火，挠着肚子并弓着身像块石头一样躺在地上。 当然，你的到来使它们起身并摧毁了任何你和它们间的相似处，或许除了差不多大小的第三条腿。 怪兽吼着跺脚，但它们没有进攻。 它们伸出手并试图轰走你。 但是 %companyname% 大老远到这里不是来放弃的。 你拔出你的剑并带领伙计们前进。 | 每一只巨魔无比巨大。 它们对前来交战的蚂蚁感到困惑。 其中一只挠着头欢快的打了个嗝，牛血如雨点洒向战队。 不过看起来它们认出了你手中的钢剑，上面的反光将它们从饱睡中惊醒。 地震般的跺脚后，它们冲过来把你赶出地盘，或者赶到地盘的地里。 | %companyname% 全员头脚相叠仍然无法比肩一只巨魔。 但你就站在这里，挥着剑准备与这些巨兽交战。 它们难以置信的看着你，不知道拿群这么想面对它们的小生物怎么办。 其中一只挠挠肚皮，狗大小的皮屑下起了雪。 好吧，继续在这上面计较也没什么意义。 你命令战队前进！ | 巨魔闻到了你并主动冲出来面对 %companyname%。它们看起来如同学步的小孩，只是像山一样，腿难堪地向前爬动着但每一步从脚底传来震动，它们大嘴张开好像见到大餐般留着口水。 你冷静的拔出你的剑并让伙计们组成阵型。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "DriveThemOff",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_104.png[/img]{你正让伙计们组成阵型，%shouter% 跑过你直接冲向了巨魔。 他大声呼喊，他像个蠢货般甩着手臂。 巨魔们停了下来互相看了看。 你不确定该不该让他继续…}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "攻击它们！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				},
				{
					Text = "%shouter% 知道他在做什么。",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 35)
						{
							return "DriveThemOffSuccess";
						}
						else
						{
							return "DriveThemOffFailure";
						}
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "DriveThemOffSuccess",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_104.png[/img]{比起更好的判断，你放手让 %shouter% 去做。 他完全没停下来，像他在追一群正为他脱衣的漂亮女人一样。 震惊的是，巨魔们后退了一步。 它们一个个开始撤退直到只剩一个巨人。\n\n%shouter% 跑到他的脚边像只狂吠的狗一样发出些返祖的尖叫，如此刺耳以致你寻思是否每个埋在地里的祖先都听到了它。 巨魔摆手遮面好像要保护自己一样，然后开始后退，越来越远直到它离开！它们都跑了！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可别回来咯！",
					function getResult()
					{
						this.Contract.m.Target.die();
						this.Contract.m.Target = null;
						this.Contract.setState("Return");
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				this.Contract.m.Dude.improveMood(3.0, "他一个人设法赶走了那些巨魔");

				if (this.Contract.m.Dude.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[this.Contract.m.Dude.getMoodState()],
						text = this.Contract.m.Dude.getName() + this.Const.MoodStateEvent[this.Contract.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "DriveThemOffFailure",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_104.png[/img]{比起更好的判断，你放手让 %shouter% 去做。 他完全没停下来，像他在追一群正为他脱衣的漂亮女人一样。 震惊的是，巨魔们后退了一步。 它们一个个开始撤退直到只剩一个巨人。\n\n%shouter% 跑到他的脚边像只狂吠的狗一样发出些返祖的尖叫，如此刺耳以致你寻思是否每个埋在地里的祖先都听到了它。 巨魔摆手到面前然后把它甩向 %shouter% 拍飞了他。 他在空中翻滚起来而他的尖叫伴随他一起像被老鹰抓住的兔子一般。 他空翻着的尖叫声回响在空中直到它砰地一声重重的摔在地上。 巨人轻声笑到发抖。 这场闹剧吸引了刚离开的巨魔们的注意，它们全部转过身开始走回来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "到此为止吧。",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, false);
						return 0;
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				local injury;

				if (this.Math.rand(1, 100) <= 50)
				{
					injury = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntBody);
				}
				else
				{
					injury = this.Contract.m.Dude.addInjury(this.Const.Injury.BluntHead);
				}

				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = this.Contract.m.Dude.getName() + " 遭受 " + injury.getNameOnly()
				});
				this.Contract.m.Dude.worsenMood(1.0, "他一个人没能赶走那些巨魔");

				if (this.Contract.m.Dude.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[this.Contract.m.Dude.getMoodState()],
						text = this.Contract.m.Dude.getName() + this.Const.MoodStateEvent[this.Contract.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_113.png[/img]{巨魔们被消灭了，你命令伙计们尽所能收集战利品作为你完成工作的证明，而且可能还可以自己用来干点什么。 如果人能用牛皮制革，这些巨人肯定也有什么有价值的东西？ 不论如何，%employer% 还等着呢。 | 巨人们全部被消灭了，%employer% 应该在等你回去了。 他的城镇现在永远安全了并且不再需要你这样的佣兵。 你思索了一阵直到你开始笑起来，你的人向你投以无法理解的目光。 你告诉他们无视它并整队好开始回程。 | 可怕的怪物们战斗的很顽强，但他们斗不过 %companyname% 的集体力量，才智和蛋蛋尺寸。你告诉伙计们尽可能收集战利品准备回程去找 %employer%。 | 最后一只巨魔被消灭，你点了点名。%randombrother% 正在其中一只的肚皮上弹跳并在你告诉他下来的时候有点失望。%employer% 想看到的是杀手和他们的战利品，不是一群儿童。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候拿报酬了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SignsOfAFight",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_113.png[/img]{巨人们被消灭，你让伙计们准备回程去找 %employer%，但 %randombrother% 喉间的颤抖吸引了你的注意力。 你走过去看到他站在一只倒下的巨魔前。 他指向它的血肉，撕开成片并像玉米穗般耷拉着。 这种伤害远超过你武器的能力。 这位佣兵转过身来，眼睛睁地大大的。%SPEECH_ON%你觉得那是什么东西干的？%SPEECH_OFF%继续看着皮肤，有碟状的凹陷伤痕，穿刺的地方留下了一个洞。 你爬到巨魔身上并把你的剑插进其中一个孔，翘出来一颗同你前臂差不多长的牙齿。 它的边上有倒刺，牙叠牙。 伙计们看到了这一切并互相窸窣讨论起来，而你希望自己没有这个发现因为你完全无法想象或理解。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "荒野黑暗且充满了恐怖。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_79.png[/img]{%employer% 欢迎你归来，几乎立刻说他从你离开起再没听到任何关于巨魔的故事。 你点头并给出缘由的证据，巨人们油滑的遗体噼里啪啦的被你倒在他的地板上。 木头被染得好像你铺了张地毯。 这位镇长咬了咬嘴唇。%SPEECH_ON%你妈的，佣兵？%SPEECH_OFF%你翘首扬起眉头。 他让手耷拉下去并略微屈腰。%SPEECH_ON%啊，别担心！一切都很好！ 这儿，你的报酬，谈好的！%SPEECH_OFF% | 你回到 %employer% 这儿发现他在跟小孩讲故事。 他的手抓过空气并像个野兽一样咆哮。 敲了敲门，你侵入了这个剧场。%SPEECH_ON%好，然后无比荣誉的佣兵消灭了怪物！%SPEECH_OFF%孩子们向你适时的到来发出欢呼。 这位镇长起身交给你约定的报酬，说他有个哨兵一路跟着你并且它已经听过了你成功的消息。 他问你要不要呆一会给孩子们讲讲故事。 你告诉他你不会免费干活并离开了房间。 | 你在镇子里找了一阵才找到 %employer%，他被一个躲在被子里的年轻女孩赶起身站在房间里。 这位镇长快速的着装，没有因他的裸体有一丝顾虑。 他把一个硬币弹向女孩然后和你说道。%SPEECH_ON%啊，佣兵，我正等着你呢！ 你的赏金，如同约定的！%SPEECH_OFF%他把钱袋交给你，但一块硬币滑出来掉到地板缝里了。 他咬了咬嘴唇然后跑到女孩边上从手里取回硬币并把它放到了袋子里。 | %employer% 在与农民们争论未交的税以及领主会怎样不择手段的拿到他们的钱。 你这样全副武装的人的到来显得恰到好处并让几个农民忙着去拿他们的钱袋。 你告诉他们安静下来然后要镇长去拿你的报酬。 他从抽屉里把它取了出来，只停下来好把一个农民手里的钱币倒进去灌满它，然后他把它交给了你。%SPEECH_ON%感谢你的工作，佣兵。%SPEECH_OFF% | 你向 %employer% 报告了你的工作而他，令人意外的毫无疑问。%SPEECH_ON%好，我有个哨兵跟着你的队伍而且他在你之前回到了镇子里。 你们俩的每个词都对得上。 Your pay, as promised.%SPEECH_OFF%他交给你一个袋子。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除了附近的巨魔");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "SuccessPeaceful",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_79.png[/img]{%employer% 手指抚到眼角然后向前展开。%SPEECH_ON%让我理一理，你的一个佣兵把那些巨人叫跑了？%SPEECH_OFF%你点头并告诉他它们的方向，还挺重要的，是向着远离 %townname%。镇长卧在椅子上。%SPEECH_ON%好。那么好吧。我想这现在不是我的麻烦了。 死了或者走了，我想都一样。%SPEECH_OFF%他交给你一个袋子，但他额外抓了一会。%SPEECH_ON%你知道如果你在撒谎而且它们回来的话我会派出我所有的信鸽去宣传你的荣耀。%SPEECH_OFF%你起身，拔出剑，并跟他说它们到时候就可以拿他的头做窝了。 他点头并放开钱。%SPEECH_ON%别在意，佣兵，只是生意。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除了附近的巨魔");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"shouter",
			this.m.Dude != null ? this.m.Dude.getName() : ""
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/unhold_attacks_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
				this.m.Target.setAttackableByAI(true);
				this.m.Target.getSprite("selection").Visible = false;
				this.m.Target.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(3);
			}
		}
	}

	function onIsValid()
	{
		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Target != null && !this.m.Target.isNull())
		{
			_out.writeU32(this.m.Target.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local target = _in.readU32();

		if (target != 0)
		{
			this.m.Target = this.WeakTableRef(this.World.getEntityByID(target));
		}

		this.contract.onDeserialize(_in);
	}

});

