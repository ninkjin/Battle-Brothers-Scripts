this.roaming_beasts_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.roaming_beasts";
		this.m.Name = "狩猎野兽";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 500 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

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
					"追捕造成恐慌的野兽于" + this.Contract.m.Home.getName()
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

				if (this.Math.rand(1, 100) <= 5 && this.World.Assets.getBusinessReputation() > 500)
				{
					this.Flags.set("IsHumans", true);
				}
				else
				{
					local village = this.Contract.getHome().get();
					local twists = [];
					local r;
					r = 50;

					if (this.isKindOf(village, "small_lumber_village") || this.isKindOf(village, "medium_lumber_village"))
					{
						r = r + 50;
					}
					else if (this.isKindOf(village, "small_tundra_village") || this.isKindOf(village, "medium_tundra_village"))
					{
						r = r + 50;
					}
					else if (this.isKindOf(village, "small_snow_village") || this.isKindOf(village, "medium_snow_village"))
					{
						r = r + 50;
					}
					else if (this.isKindOf(village, "small_steppe_village") || this.isKindOf(village, "medium_steppe_village"))
					{
						r = r - 25;
					}
					else if (this.isKindOf(village, "small_swamp_village") || this.isKindOf(village, "medium_swamp_village"))
					{
						r = r - 25;
					}

					twists.push({
						F = "IsDirewolves",
						R = r
					});
					r = 50;

					if (this.isKindOf(village, "small_steppe_village") || this.isKindOf(village, "medium_steppe_village"))
					{
						r = r + 50;
					}
					else if (this.isKindOf(village, "small_farming_village") || this.isKindOf(village, "medium_farming_village"))
					{
						r = r + 25;
					}
					else if (this.isKindOf(village, "small_tundra_village") || this.isKindOf(village, "medium_tundra_village"))
					{
						r = r - 25;
					}
					else if (this.isKindOf(village, "small_snow_village") || this.isKindOf(village, "medium_snow_village"))
					{
						r = r - 50;
					}
					else if (this.isKindOf(village, "small_swamp_village") || this.isKindOf(village, "medium_swamp_village"))
					{
						r = r + 25;
					}

					twists.push({
						F = "IsGhouls",
						R = r
					});

					if (this.Const.DLC.Unhold)
					{
						r = 50;

						if (this.isKindOf(village, "small_lumber_village") || this.isKindOf(village, "medium_lumber_village"))
						{
							r = r + 100;
						}
						else if (this.isKindOf(village, "small_tundra_village") || this.isKindOf(village, "medium_tundra_village"))
						{
							r = r - 25;
						}
						else if (this.isKindOf(village, "small_steppe_village") || this.isKindOf(village, "medium_steppe_village"))
						{
							r = r - 25;
						}
						else if (this.isKindOf(village, "small_snow_village") || this.isKindOf(village, "medium_snow_village"))
						{
							r = r - 50;
						}
						else if (this.isKindOf(village, "small_swamp_village") || this.isKindOf(village, "medium_swamp_village"))
						{
							r = r + 25;
						}

						twists.push({
							F = "IsSpiders",
							R = r
						});
					}

					local maxR = 0;

					foreach( t in twists )
					{
						maxR = maxR + t.R;
					}

					local r = this.Math.rand(1, maxR);

					foreach( t in twists )
					{
						if (r <= t.R)
						{
							this.Flags.set(t.F, true);
							  // [346]  OP_JMP            0      5    0    0
						}
						else
						{
							r = r - t.R;
						}
					}
				}

				local playerTile = this.World.State.getPlayer().getTile();
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 5, 10);
				local party;

				if (this.Flags.get("IsHumans"))
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.BanditsDisguisedAsDirewolves, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群凶猛的恐狼正在寻找猎物。");
					party.setFootprintType(this.Const.World.FootprintsType.Direwolves);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Direwolves, 0.75);
				}
				else if (this.Flags.get("IsGhouls"))
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Nachzehrers", false, this.Const.World.Spawn.Ghouls, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群找尸体吃的食尸鬼。");
					party.setFootprintType(this.Const.World.FootprintsType.Ghouls);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Ghouls, 0.75);
				}
				else if (this.Flags.get("IsSpiders"))
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Webknechts", false, this.Const.World.Spawn.Spiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群织网蛛正在蹦蹦跳跳的前行。");
					party.setFootprintType(this.Const.World.FootprintsType.Spiders);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Spiders, 0.75);
				}
				else
				{
					party = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).spawnEntity(tile, "Direwolves", false, this.Const.World.Spawn.Direwolves, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					party.setDescription("一群凶猛的恐狼正在寻找猎物。");
					party.setFootprintType(this.Const.World.FootprintsType.Direwolves);
					this.Const.World.Common.addFootprintsFromTo(this.Contract.m.Home.getTile(), party.getTile(), this.Const.BeastFootprints, this.Const.World.FootprintsType.Direwolves, 0.75);
				}

				party.setAttackableByAI(false);
				party.setFootprintSizeOverride(0.75);
				this.Contract.m.Target = this.WeakTableRef(party);
				party.getSprite("banner").setBrush("banner_beasts_01");
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
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
					if (this.Flags.get("IsHumans"))
					{
						this.Contract.setScreen("CollectingProof");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("CollectingGhouls");
						this.World.Contracts.showActiveContract();
					}
					else if (this.Flags.get("IsSpiders"))
					{
						this.Contract.setScreen("CollectingSpiders");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						this.Contract.setScreen("CollectingPelts");
						this.World.Contracts.showActiveContract();
					}

					this.Contract.setState("Return");
				}
				else if (!this.Flags.get("IsWorkOfBeastsShown") && this.World.getTime().IsDaytime && this.Contract.m.Target.isHiddenToPlayer() && this.Math.rand(1, 9000) <= 1)
				{
					this.Flags.set("IsWorkOfBeastsShown", true);
					this.Contract.setScreen("WorkOfBeasts");
					this.World.Contracts.showActiveContract();
				}
			}

			function onTargetAttacked( _dest, _isPlayerAttacking )
			{
				if (this.Flags.get("IsHumans") && !this.Flags.get("IsAttackDialogTriggered"))
				{
					this.Flags.set("IsAttackDialogTriggered", true);
					local troops = this.Contract.m.Target.getTroops();

					foreach( t in troops )
					{
						t.ID = this.Const.EntityType.BanditRaider;
					}

					this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;
					this.Contract.setScreen("Humans");
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
					if (this.Flags.get("IsHumans"))
					{
						this.Contract.setScreen("Success2");
					}
					else if (this.Flags.get("IsGhouls"))
					{
						this.Contract.setScreen("Success3");
					}
					else if (this.Flags.get("IsSpiders"))
					{
						this.Contract.setScreen("Success4");
					}
					else
					{
						this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_43.png[/img]{在你等待 %employer% 解释他的需求时，你进来的路上寻思这个定居点为什么格外的安静。%employer% 提起嗓门 %SPEECH_ON%这个地方被神诅咒还有非自然的野兽！ 它们在晚上进来，目带红光，肆意屠杀。 我们的奶牛大多数都被杀死了而且我担心一旦牛没了，我们就会是下一个。 之前我们派了村里最强壮的小伙子们去找到并杀死这些野兽但我们之后再也没听到他们的消息。%SPEECH_OFF%他沉重的叹息。%SPEECH_ON%跟随 %direction% 的脚印解决那些野兽好让我们能再次平平安安的生活！ 我们没有多少钱，但是所有人都贡献了一份来雇你。%SPEECH_OFF% | %employer% 在你找到他时整看向窗户外。 手里拿着一个杯子－外面一片寂静。 他转向你，几乎是清醒的。%SPEECH_ON%来这里的路上，有没有意识到这里有多安静？%SPEECH_OFF%你说你注意到了，但你想是因为自己看着就像个佣兵。 这正是你所习惯的。%employer% 点头喝了一口。%SPEECH_ON%啊，当然。不幸的是，人们不是在害怕你。 这次不是。我们过去几个星期有几起人被攻击的事件。 某种野兽在游荡，我们不知道是什么，只知道它们带走了谁。 我们请求过我们的领主，当然，但是他没有做任何事情来帮我们…%SPEECH_OFF%他又深深的饮了一口。 当他喝完时，他转向你，杯子空着。%SPEECH_ON%你愿不愿意去猎捕这些怪物？ 求你了，佣兵，帮帮我们。%SPEECH_OFF% | %employer% 在你找到他时正听着几个农民谈话。 当他们看到你，他们很快离开，给他手里留了一个袋子。他举起它来。%SPEECH_ON%这里面有克朗。 那些人给我克朗，好给某个人，任何人，来帮帮我们。 人们在失踪，佣兵，而当他们被找到时他们…不只是死了，而是…被撕烂了。 残缺不全。所有人都很害怕，不敢去任何地方。%SPEECH_OFF%他盯向袋子，然后看向你。%SPEECH_ON%我希望你对这个活有兴趣。%SPEECH_OFF% | 你发现 %employer% 正读着一个卷轴。 他把文件丢给你并让你读上面的名字。 字迹很潦草，但是还看得出是名字。 你停下来抱歉，说明你是个外乡人。 他点头并把卷轴拿回去。%SPEECH_ON%这没什么，佣兵。如果你还不明白，这些名字是男人，女人，还有小孩的，全部都在上个星期过世了。%SPEECH_OFF%上个星期？那上面可有很多个名字。 他，看起来读懂了你，沉重的点头。%SPEECH_ON%是，我们的情况很糟。 失去了这么多生命。 我们相信这是什么肮脏的生物干的，无法理解的野兽。 很显然，我们想雇你去解决掉它们。 有兴趣接受这个委托吗，雇佣兵？%SPEECH_OFF% | %employer%的脚边有几只狗，吐着舌头在地上趴着。%SPEECH_ON%它们过去几天都在找失踪了的人。 像神隐一样消失到不知哪里去的人。%SPEECH_OFF%他伏身抚摸其中一只狗，挠着它的后脑勺。 通常来说，狗会有所回应，但这个可怜虫几乎不给任何回应。%SPEECH_ON%不过，人们不知道我知道了的一些东西，人们不是在消失…他们在被抓走。 可怕的野兽在游荡，佣兵，而且我需要你去追杀它们。 可恶，或许你能找到几个人，但我不抱信心。%SPEECH_OFF%其中一条狗呼出长长一声疲倦的叹息，好似在暗示什么。 | %employer% 拿着一个贴着卷轴的袋子，但是上面写的名字不是你的。 他小心的掂量着它，硬币的形状在他的指间环绕，它们的叮当声低沉。他转向你。%SPEECH_ON%你认识那个名字吗？%SPEECH_OFF%你摇头。他继续道。%SPEECH_ON%一个星期前我们派在 %direction% 著名的 %randomnoble% 去猎杀一些近几个星期都在这一代制造恐怖的野兽。 你知道为什么这个袋子还在我手里吗？%SPEECH_OFF%你耸耸肩答道。%SPEECH_ON%因为他没回来？%SPEECH_OFF%%employer% 点头并放下袋子。 他坐在桌子的边缘上。%SPEECH_ON%没错。因为他没有回来。 现在，你觉得是为什么？ 我想是因为他死了，但我们不要这么悲观。 我想是因为外面那些野兽需要更多。 我想他们需要像你一样的人，佣兵。 你愿意帮助我们解决这个贵族解决不了的问题吗？%SPEECH_OFF% | %employer% 从书架取下一本书。 当他把它放在桌上，灰又或者尘埃从中涌出。 他打开它，一页一页的慢慢翻着。%SPEECH_ON%你相信怪物吗，佣兵？ 我是认真的，因为我相信你比我见得多。%SPEECH_OFF%你点头然后说。%SPEECH_ON%已经过了相信与否，是的。%SPEECH_OFF%他翻开另一页。他抬头看着你。%SPEECH_ON%好，我们相信你怪物来到了 %townname%。我们相信它们是人们在消失的原因。 知道这意味着什么吗？ 我需要你去找到这些“虚幻”的生物，像杀死其他生物一样杀死它们。有兴趣吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{这对你值多少钱？ | %townname% 愿意支付多少？ | 我们来谈谈酬劳。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这听起来不像是适合我们的工作。 | 我祝你好运，但我们不会参与其中。}",
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
			ID = "Humans",
			Title = "在攻击前…",
			Text = "[img]gfx/ui/events/event_07.png[/img]{这些完全不是野兽，而是人穿着狼皮！ 看到了邪恶的“真”面目，手下对于最熟悉不过的敌人感到放松。 | 随着你靠近怪物，你意识到这些丑陋的生物不是野兽，而是伪装起来的人！ 你不知道为什么他们要玩这种扮演游戏，但是他们正在拔武器。 至于你而言，兽还是人，他们都会死。 | 你碰巧看到一个人从肩上卸下狼头。 他看到了你，手里仍拿着伪装，然后快速的把它穿了回去。你拔出你的剑。%SPEECH_ON%现在才开始伪装有点迟了。%SPEECH_OFF%你的武器切过他的面具使他后退。 在你能刺穿他之前，他跑路了，向着一群同样装束的人。 他们看到你就拔出了武器。 不论什么原因让这些蠢货玩起了扮装，现在不重要。 | 你遇到一具背后插着几根箭的野兽尸体。 伤害看起来并不致命…然后当你用剑尖掀起生物的毛发后，兽头掉了下来，露出了下面的人。%SPEECH_ON%是你干的吗？%SPEECH_OFF%前方传来声音。 那里站着几个人正在卸下他们的伪装：你追寻的野兽。 领头的人抬高音量。%SPEECH_ON%杀了他们！杀光他们！%SPEECH_OFF%不，这些还是野兽，不过是更柔弱点的那种。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "准备进攻！",
					function getResult()
					{
						this.Contract.getActiveState().onTargetAttacked(this.Contract.m.Target, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "WorkOfBeasts",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_60.png[/img]{你在草地上偶然发现一具尸体。 通常来说，尸体并不令人意外，到处都有人所以见到几具尸体只是个时间问题。 除了这具尸体背后有一个巨大的撕裂伤并且一些脏器不见了。\n\n%helpfulbrother% 走上来。%SPEECH_ON%脏器不见了是因为狼，又或甚至是兔子。 怎么，你没听说过只极端饥饿的兔子吗？%SPEECH_OFF%他吐了口唾沫，啃了啃指甲。%SPEECH_ON%不论如何，这些伤口，可不是兔子还是狗或者随便什么。 它得更加…大…更加危险。%SPEECH_OFF%你感谢他细致的观察并告诉他回到队伍里去。 | 一个农民走向你，衣服像片撕碎的碎布一样。 带着些许不好意思，他用手遮住大腿根。%SPEECH_ON%求求，先生们，过来看看这…恐怖的景象。%SPEECH_OFF%当你问他在说什么，他抬起手，髋部向你突过来。 他转身像木偶一样逃跑，又喊又叫的。 一个女人在他发疯时走过来。 她手抱着胸。%SPEECH_ON%他因为他的兄弟被野兽撕碎发疯了。%SPEECH_OFF%你转向她，半期待这位女士会脱下衣服把她的体态用她喜欢的姿势摇晃起来。 但并没有，她只是看着你。%SPEECH_ON%我知道 %townname% 雇了些人去解决这些野兽而且你看起来非常像个雇工。 求你了，先生，从这些邪恶中保护我们…还有它们散步的邪恶…%SPEECH_OFF% | 你遇到了一只牛的尸体，内脏不见了，一半在围栏上而另一半分布在稍远的草地上，间距呈肠子的极限长度。 像一块血肉模糊的附件。\n\n一个农夫靠近过来，踮起他的帽子露出眼睛。%SPEECH_ON%野兽干的。我没有看到它们，如果你想问的话，但我确实在你到之前听到了这惨剧。 光是听已经足够让我保持低调躲起来了。 求求你，如果你来这里是为了找这些生物，快点，因为我损失不起更多牲口了。%SPEECH_OFF% | 一个劈着柴的农民在你面前挺起身。%SPEECH_ON%神啊很高兴见到你，先生。 我就说我听说过佣兵们正在四处搜寻在这片地方制造恐怖的野兽。%SPEECH_OFF%你问他是否看到过什么能帮上忙的。 他放下手伸向斧柄。%SPEECH_ON%不能说我看到什么，不。 但我听到些东西。 我知道离这里不远的一个男人和女人被抓走了。 好吧，他们一起消失的。 传闻说他们在森林里死了。 吊在树上什么的，你知道的？ 或者，等等，或许他们只是走开去单独共处了！ 可恶…可恶！那个女孩儿讨厌她父亲而且那小子只是个无名小辈只不过长得好看嘴巴好听。 是啊，这说得通多了。%SPEECH_OFF%他停下来然后看向你。%SPEECH_ON%不论如何，我确定哪些怪物在附近。 眼睛瞪大点，佣兵。%SPEECH_OFF% | 一个女人跑出小屋拦住你。 几乎喘不上气，她问你是否见过一个男孩。 你摇头表示反对。她抬起手。%SPEECH_ON%他差不多这么大。 一头褐色头发。 不是天生的，但是那孩子真的很喜欢泥巴。 当他笑的时候他的牙齿就像星星，闪亮的散落着。%SPEECH_OFF%你摇头再次否认。%SPEECH_ON%他很会丢石头。丢的很远。 我告诉过他不要在领主的手下在附近时展示力量，不然他们会带他进军队。%SPEECH_OFF%她气喘吁吁，从她眼前吹开一丝头发。%SPEECH_ON%好吧糟糕了，不论如何，如果你看到他，让我知道。 我想他是我孩子。 还有，小心暗处。 野兽在这块儿蹲人草丛。%SPEECH_OFF%在你能说任何话之前，她收起衣服颠簸的走回了屋子。 | 你遇到一个男人蹲在一条从头到尾被摧毁的狗。 你蹲在他身边。%SPEECH_ON%是野兽干的吗？%SPEECH_OFF%他摇摇头表示否定。%SPEECH_ON%不，我做到了，终于做到了！ 可恶的家伙不会再让我睡不着了。%SPEECH_OFF%就在这时，路另一边的小屋开门跑出一个人喊叫着。%SPEECH_ON%那是我的狗吗你个婊子养的？%SPEECH_OFF%杀狗者快速起身。%SPEECH_ON%是野兽！它们昨晚又来了！%SPEECH_OFF%你安静的留下他们在狗躺着的地方争吵。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们继续前进。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingPelts",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_56.png[/img]{野兽死了，你命令手下拿走它们的毛皮作为证据。 你的雇主，%employer%，应该会很高兴看到它们。 | 解决了这些丑恶的生物，你开始剥它们的皮。 残暴的生物需要残暴的证据。 不然你的雇主，%employer%，可能不会相信你完成的工作。 | 战斗结束了，你让手下开始收集毛皮好拿回去给 %employer%，你的雇主。 | 你的雇主，%employer%，如果没见到证据或许不会相信这里发生了什么。 你命令手下开始剥毛皮，战利品，头皮，随便什么只要能证明你在这里取得的胜利。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "赶紧结束这件事吧，我们还有克朗要拿。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingProof",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你的手下拿下这些蠢货的伪装不然你的雇主，%employer%，可能不会相信你在这里完成的工作。 | 你的雇主或许不会相信这里发生了什么。 你命令手下收集伪装。%bro1%，从一具尸体上取下面具，开始寻思。%SPEECH_ON%所以他们把自己打扮成这样来吸引我们，现在他们都死了。 我希望他们不要以为这是个游戏。%SPEECH_OFF%%bro2% 用其中一件伪装服擦干净了他的刀。%SPEECH_ON%如果是个游戏，我很享受它。%SPEECH_OFF% | %randombrother% 向尸体点头。%SPEECH_ON%很有可能 %employer% 不会相信是一群强盗打扮成了野兽。%SPEECH_OFF%表达了统一，你命令手下开始收集面具和伪装作为证据。 | 你会需要证据好展示给你的雇主，%employer%。这些不是你本来在找的野兽，但是他们确实带着很多伪装，而你的雇主很可能有兴趣看看。 其中一个人大声寻思。%SPEECH_ON%那他们为什么要扮成这样？%SPEECH_OFF%%bro2% 收集时把一件伪装卷在身上。%SPEECH_ON%仪式性自杀？毕竟他们欢快的舞蹈吸引到我们注意。%SPEECH_OFF%他捡起其中一副伪装，死者的头也被一起提了起来。 当这位佣兵把死人的头踢出去时，他笑了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "回 %townname%！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingGhouls",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_131.png[/img]{战斗结束了，你走到一个死食尸鬼边蹲下来。 如果不是因为一扇扭曲牙齿形成的门，你可以很轻松的把头放进野兽巨大的喉咙里。 比起欣赏眼前的牙科灾难，你掏出一把刀并把它的头割下来，穿过一层非常硬的表皮后，意外的，发现下面的肌腱非常柔软。 你举起头并命令 %companyname% 照做。毕竟，%employer% 会想要点证据的。 | 食尸鬼的尸体平躺着，一动不动，看起来更像岩石而不是野兽。 苍蝇已经在它的嘴里偶合，在充满泡沫的死亡残骸上播种生命。 你命令 %randombrother% 拿走它的头，因为 %employer% 需要证据。 | 死掉的食尸鬼零零散散倒在地上。 你蹲在其中一只边上然后看向它的嘴。 不论它肺里有什么依然在散发出味道，一股恶臭的风吹出。 用手帕遮住鼻子，你用另一只手用刀切向脖子，割下头并且举起来。 你命令几个兄弟跟着做因为 %employer% 会想看点证据。 | 一个死掉的食尸鬼是非常特别的样本。 你不得不寻思它在生态圈里是什么样的定位。 形状粗糙的似人，肌肉像某种野兽，而头部特征就好像个野人的噩梦里冒出来的一样。 你命令 %companyname% 开始收集这些丑恶东西的头好给 %employer% 点证据。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "回 %townname%！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "CollectingSpiders",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_123.png[/img]{你命令你的人巡视战场尽可能的收集蜘蛛的肢体。 有几个人不小心碰到了织网蛛腿上的毛，很快就发起皮疹挠了起来。 | 蜘蛛像在阁楼的角落里一样散落在战场上。 死后，它们看起来像紧紧闭在一起的巨大手套。 你让手下扭下它们的腿并从遗骸上收集证据。 | 雇佣兵们打扫着战场，切和锯着蜘蛛们僵硬的遗体好带回给 %employer%。就算死了，织网蛛依然很渗人，看起来随时都能弹回生命并缠住最近的活物。 它们可怕的特征和超现实的尺寸并没有阻止一些佣兵在边上跳舞，弹着舌头，围着捉弄那些不愿意靠近这些玩意的人。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "回 %townname%！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你回到 %employer% 并把其中一条毛皮摊在他的办公桌上。 它无生气的爪子拍打在边上的橡木上。 他抬起一个，然后让它再掉下去。%SPEECH_ON%我看得出来你找到了我们要找的野兽。%SPEECH_OFF%你告诉他战斗经过。 他看起来非常满意，从他的书柜里拿出一个小木箱并交过来。%SPEECH_ON%%reward_completion% crowns, as agreed upon. %townname% 的人们需要你通过消灭这些恐怖的东西带来的安宁。%SPEECH_OFF% | 当你走进 %employer%的房间他几乎立刻弹了起来。%SPEECH_ON%天啊你手里的是什么，佣兵？%SPEECH_OFF%你举着毛皮的脖颈处。 黑色的血从脖子处流出溅在地上。%SPEECH_ON%其中一只你在找的野兽。 如果你需要剩下的证据，它们就在外面…%SPEECH_OFF%他举起手，制止你。%SPEECH_ON%一个就足够我相信了。 做得非常好，佣兵。 你的报酬在 %randomname% 那里，一个你应该在大堂里经过了的议员。 他有张丑脸而且他带着 %reward_completion% 克朗，如同约定的。%SPEECH_OFF%他又看了一眼野兽然后慢慢摇了摇头。%SPEECH_ON%愿死者和生还者在这些丑恶生物的逝去中找到宁静。%SPEECH_OFF% | %employer% 拿着杯葡萄酒欢迎你。%SPEECH_ON%喝吧，野兽－杀手。%SPEECH_OFF%你很好奇他怎么知道你已经成功了。 他挥挥手打消你的好奇。%SPEECH_ON%我在这一块有很多耳目－不是密探，当然，但是人们嘴巴都很大。 我应该知道，因为我就是！ 你干的很好，佣兵，所以来一口吧。 这是好酒。%SPEECH_OFF%不错。尽管一袋 %reward_completion% 克朗的报酬更好。%employer% 制止了你。%SPEECH_ON%只是想跟你说，雇佣兵，这些野兽杀了不少好男人和女人。 这些人或许害怕你，毕竟你是个佣兵，但是他们还是会永远对此保持感谢的。%SPEECH_OFF%你掂量了下克朗。很感谢，确实… | %employer% 后退了几步。%SPEECH_ON%啊，呃，我看得出来你杀了这些野兽。 你拿着的可真是一条好毛皮。%SPEECH_OFF%你放下你拿来的：一块厚、重的野兽毛皮落在地上堆成了一堆毛和皮。 他，几乎过于害怕靠近，丢给你一个袋子。%SPEECH_ON%%reward_completion% crowns, as agreed upon. 我会告诉人们你成功的事情。 终于，我们可以安生了。%SPEECH_OFF% | %employer% 坐在桌边，腿架在桌角上。 他的眼睛盯着天花板，脸的角落衰老的皱纹紧紧的夹在一起。 他看着你。%SPEECH_ON%欢迎回来。我听说了你的事迹…你和怪物的战斗。%SPEECH_OFF%你点头，东张西望搜寻报酬。 他带你去开门。%SPEECH_ON%%randomname%，%townname% 的议员，在外面拿着你的报酬。说好的 %reward_completion% 克朗。 还有 %townname% 的人民，或许害怕你，依然受你的到来恩惠。谢谢你，雇佣兵。%SPEECH_OFF% | %employer% 在你回来时正在喂他的一条狗。 狗放下了它的骨头来闻了闻你带来的皮。 他指向毛皮。%SPEECH_ON%那是什么肮脏的东西？%SPEECH_OFF%你耸耸肩把它丢到他桌上。 狗用鼻子闻了问其中的一个爪子，低声咆了一声，然后开始舔它。%employer% 短暂的笑了，然后走到他的书架，拿起一个木箱子交给你。%SPEECH_ON%%reward_completion% crowns, was it? 你应该知道你把给人民的安宁带到了 %townname%。%SPEECH_OFF%You nod.%SPEECH_ON%他们的喜悦会通过克朗表现吗？%SPEECH_OFF%%employer% 对你贪婪的幽默皱起了眉头。%SPEECH_ON%不，不会。 好运，雇佣兵。%SPEECH_OFF%}",
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
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除镇上的恐狼");
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
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer% 欢迎你回来。%SPEECH_ON%我已经听说了，我认为是非常棒的消息。 就是，我有点难以置信。 一群强盗玩扮装。 披着狼皮的…狼？%SPEECH_OFF%他向你露出微笑，希望你因他的笑话发笑。 你耸耸肩。他也耸耸肩。%SPEECH_ON%啊，好吧。你的报酬，%reward_completion% 克朗，就在外面等着你。 我会告诉 %townname% 的人们他们害怕的怪物其实是人。%SPEECH_OFF% | 你带着蠢货强盗们的服装回来。%employer% 左右摇摆着伪装。%SPEECH_ON%有趣。他们做工很出色。 我几乎要说这帮强盗很聪明。%SPEECH_OFF%他捡起其中一个面具并且看起来准备穿上试试，然后停下来好像他不应该在观众面前做这个。 他放下它向你笑。%SPEECH_ON%好，不论如何，佣兵…做得好。 你会拿到 %reward_completion% 克朗，在外面 %townname%的议员手里，他在等着你。 他会试图找你的。 现在，%townname% 的人们可以安葬死者并终于安宁下来了。%SPEECH_OFF% | %employer% 大笑着看你的展品。%SPEECH_ON%人？只是人？%SPEECH_OFF%你点头，但是试图让他回到正轨。%SPEECH_ON%他们杀害了许多农民，但他们仍然是一个危险的群体。%SPEECH_OFF%你的雇主点头。%SPEECH_ON%当然，当然！ 我不是想贬低任何东西或任何人。 不要假设什么，佣兵，那些死掉的人是我的朋友和邻居！ 不论如何，你完成了我的任务而我也因此非常感谢。%SPEECH_OFF%他递过来一袋克朗。你数了其中的 %reward_completion% 后准备离开。 那人向你喊道。%SPEECH_ON%你肯定能理解我试图在这个可怕世界中寻找幽默的，对吧？ 因为是我去了那些被杀死的人的葬礼。 我不会带着紧皱的眉头进坟墓的，不论这该死的地方怎么强迫我。%SPEECH_OFF% | 你展示给 %employer% 那些调皮强盗的证据。 他捡起一堆伪装，从手指上擦下干血。%SPEECH_ON%That is the blood of men alright. 你确认他们不是在玩而真正的怪物还在外面？%SPEECH_OFF%你张嘴说明他们用非常不玩耍的武器攻击了你。%employer% 点头，看起来明白了，但是还有些怀疑。%SPEECH_ON%好吧，我想我可以等等看怪物会不会回来。 如果它们回来了，好吧，一个被背叛的人会变成一个杰出的怪物，你不这么认为吗？%SPEECH_OFF%你告诉他付钱并等着看他是不是该这么不信任。 他点头，给你 %reward_completion% 克朗并向你告别。%SPEECH_ON%我真的希望你在说实话，雇佣兵。%townname% 需要从这个该死的世界不停鞭打过来的恐怖中歇息一下。%SPEECH_OFF% | %employer% 用手指划过一件伪装的边缘。%SPEECH_ON%毛摸起来很软。非常真实…%SPEECH_OFF%他抬头看着你。%SPEECH_ON%我不得不猜测是不是他们杀死了原本的怪物，然后…决定穿它们的皮？ 不过，为什么？你认为他们是不是被诅咒了？%SPEECH_OFF%你耸耸肩答道。%SPEECH_ON%我只能说他们除了怪物的伪装，还有它们的残忍。 他们攻击了我们并且付出了代价。 有没有本地人近期见到什么生物？%SPEECH_OFF%他拿出一袋子 %reward_completion% 克朗滑给你。%SPEECH_ON%不，他们没有。实际上，他们又开始出去探险了。 我不是指到路上去，但是离开他们前门对很多人是很大的进步了！ 你给我们带来了安宁，佣兵，为此我们感谢你。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "兽，人…克朗才是重要的。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除镇上伪装成恐狼的强盗");
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
			ID = "Success3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你发现 %employer% 坐在他的月桂树上。 他站起身穿上裤子，一个仆人赶快从他之前坐着的地方取回一个桶。 可怜的仆人快速的跑出房间。%employer% 指向你手上晃来晃去的食尸鬼头。%SPEECH_ON%这太恶心了。%randomname%，给这个人他的报酬。%reward% 克朗，对吧？%SPEECH_OFF% | 你把食尸鬼的头放在 %employer%的办公桌上。 因为某种原因，液体还从它的脖子流出，从桌子的边缘滴下并且无疑的弄脏了它。 他靠后，手指放在肚子上。%SPEECH_ON%食尸鬼？然后还有什么，幽灵？%SPEECH_OFF%那人暗自窃笑。%SPEECH_ON%对你没什么太过困难的，佣兵。%SPEECH_OFF%他打了个响指然后一个仆人走过来，交给你一袋 %reward% 克朗。 | 在战场和走到 %employer%的地方的路上，食尸鬼的喉咙充满了苍蝇，舌头变成了一个不成型的抽动着的黑球，充斥着嗡嗡声。%employer% 看了一眼然后用布遮住他的嘴巴。%SPEECH_ON%是的，我懂了，拿走它，请。%SPEECH_OFF%他唤来一个卫兵然后你收到了一袋 %reward% 克朗。 | %employer% 冷冰冰的探上身好好看看你带来的食尸鬼的头。%SPEECH_ON%难得一见，雇佣兵。 我很高兴你把它带来给我。%SPEECH_OFF%他靠回去。%SPEECH_ON%把它留在办公桌上。 或许我可以用它来吓孩子。 我想小家伙们有点太过适应好生活了。%SPEECH_OFF%他打了个响指然后一个仆人走来给你了你 %reward% 克朗。 | 你把食尸鬼的头交给 %employer%，他盯着它看了很长时间。%SPEECH_ON%这让我回想起了某个人。 我不太能把我的手指放在上面，而且我不确认我应该。 抱歉，佣兵，我没有付钱占用着你的时间。 仆人，给他他的钱！%SPEECH_OFF%你如同承诺一样的收到了报酬。 | %employer% 收下食尸鬼的头并举起它。 几只喵喵叫的猫似乎不知从哪儿冒出来，在它下面盘旋，就像秃鹰在头顶盘旋一样。 他把它丢出窗户而猫们追了出去。%SPEECH_ON%干得好，佣兵。%reward% 克朗，如同约定的。%SPEECH_OFF% | 你把一只食尸鬼的头摆在 %employer%的桌子上。 他从面前的餐盘抬头看向你，看了看头，然后你。%SPEECH_ON%我在吃饭，佣兵。%SPEECH_OFF%被恶心到的他推到一边的银器发出碰撞声。 一个仆人把食物收走，或许是为了他自己吃。%employer% 拿出一个袋子并把它放在桌上。%SPEECH_ON%%reward_completion% 克朗我们谈好的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "清除镇上的食尸鬼");
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
			ID = "Success4",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你进入 %employer%的办公室背着死蜘蛛。 他尖叫而他的椅子也随着它飞过地板发出号哭。 他跳起来从办公桌上掏出一把黄油刀。 你从肩上丢下死织网蛛，它的背朝下摔在地上发出咔嗒声。 这个城里人慢慢的靠过来。 他把黄油刀收进一片面包里并摇头。%SPEECH_ON%旧神啊，你几乎让我发了心脏病。%SPEECH_OFF%点头，你告诉他踩死这些野兽得用点比大靴子更厉害的东西。他点头。%SPEECH_ON%当然，佣兵，当然！ 你的报酬 %reward_completion% 克朗就在角落里。 而且，请，走的时候带走那个亵渎神灵的东西。%SPEECH_OFF% | 猫在你走进 %employer%的房间时就逃跑了。 几条狗，总是有点神秘，围着你的腿嗅蜘蛛的尸体，它们的鼻子缩着跑开但总是回来再闻一下。 这个城里人正在写笔记而且他不敢想象他的眼睛。 他把他的羽毛笔放下。%SPEECH_ON%那是一只巨大的蜘蛛吗？%SPEECH_OFF%你点头。他笑着捡起它的羽毛笔。%SPEECH_ON%或许我应该给你推荐一双非常大的靴子。 你的 %reward_completion% 就在这个袋子里。 拿上它把。都在那。 你可以离开尸体了。 我想近距离观察一下这个生物。%SPEECH_OFF% | %employer% 在你进入时正在办生日派对，你背着个巨大蜘蛛还把它丢着滑过地上。 它粗糙的毛擦过石头发出嘶嘶声而它的八条腿像某种恐怖家具一样上下摆动然后滑向一边弹到一个书架角上并翻过身来做的好像准备好跳起来。 现场混乱了起来，因为所有人都在尖叫着跑出门或者跳下最近的窗户，一大片彩色纸屑随着他们飘舞。 这个城里人站在空荡荡的房间里咬了下嘴唇。%SPEECH_ON%说真的，佣兵，有必要吗？%SPEECH_OFF%你点头并告诉他有必要雇你还有非常大的必要付你钱。 他摇了摇头并且示意向角落里的一条假驴尾巴。%SPEECH_ON%你的袋子就在那，里面装着 %reward_completion% 克朗，和我们谈好的一样。 现在把那玩意带出去并告诉人们活动还不需要结束。%SPEECH_OFF% | 你不认为你能把蜘蛛的尸体塞进 %employer%的房间，所以你选择从窗户外面丢过去。 你听到一声惊恐的惨叫还有家具掉落的响声。 过了一会边上的窗户打开了。 这个城里人探出身。%SPEECH_ON%哦非常棒，佣兵，非常棒！ 愿旧神因此给你一千年无聊日子！%SPEECH_OFF%点头，你问他你的报酬。 他不满的丢给你一个袋子。%SPEECH_ON%%reward_completion% 克朗在里面。 现在拿上那玩意走！%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "一场成功的狩猎。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "为镇子清除了织网蛛");
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
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_helpful = [];
		local candidates_bro1 = [];
		local candidates_bro2 = [];
		local helpful;
		local bro1;
		local bro2;

		foreach( bro in brothers )
		{
			if (bro.getBackground().isLowborn() && !bro.getBackground().isOffendedByViolence() && !bro.getSkills().hasSkill("trait.bright") && bro.getBackground().getID() != "background.hunter")
			{
				candidates_helpful.push(bro);
			}

			if (!bro.getSkills().hasSkill("trait.player"))
			{
				candidates_bro1.push(bro);

				if (!bro.getBackground().isOffendedByViolence() && bro.getBackground().isCombatBackground())
				{
					candidates_bro2.push(bro);
				}
			}
		}

		if (candidates_helpful.len() != 0)
		{
			helpful = candidates_helpful[this.Math.rand(0, candidates_helpful.len() - 1)];
		}
		else
		{
			helpful = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro1.len() != 0)
		{
			bro1 = candidates_bro1[this.Math.rand(0, candidates_bro1.len() - 1)];
		}
		else
		{
			bro1 = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		if (candidates_bro2.len() > 1)
		{
			do
			{
				bro2 = candidates_bro2[this.Math.rand(0, candidates_bro2.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else if (brothers.len() > 1)
		{
			do
			{
				bro2 = brothers[this.Math.rand(0, brothers.len() - 1)];
			}
			while (bro2.getID() == bro1.getID());
		}
		else
		{
			bro2 = bro1;
		}

		_vars.push([
			"helpfulbrother",
			helpful.getName()
		]);
		_vars.push([
			"bro1",
			bro1.getName()
		]);
		_vars.push([
			"bro2",
			bro2.getName()
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
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/disappearing_villagers_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Target != null && !this.m.Target.isNull())
			{
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

