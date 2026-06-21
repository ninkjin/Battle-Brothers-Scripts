this.hunting_hexen_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Target = null,
		Dude = null,
		IsPlayerAttacking = true
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.hunting_hexen";
		this.m.Name = "女巫的契约";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 900 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("ProtecteeName", this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"呆在 %townname% 附近，保护 %employer%的长子"
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

				if (r <= 20)
				{
					this.Flags.set("IsSpiderQueen", true);
				}
				else if (r <= 40)
				{
					this.Flags.set("IsCurse", true);
				}
				else if (r <= 50)
				{
					this.Flags.set("IsEnchantedVillager", true);
				}
				else if (r <= 55)
				{
					this.Flags.set("IsSinisterDeal", true);
				}

				this.Flags.set("StartTime", this.Time.getVirtualTimeF());
				this.Flags.set("Delay", this.Math.rand(10, 30) * 1.0);
				local envoy = this.World.getGuestRoster().create("scripts/entity/tactical/humans/firstborn");
				envoy.setName(this.Flags.get("ProtecteeName"));
				envoy.setTitle("");
				envoy.setFaction(1);
				this.Flags.set("ProtecteeID", envoy.getID());
				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Home != null && !this.Contract.m.Home.isNull())
				{
					this.Contract.m.Home.getSprite("selection").Visible = true;
				}

				this.World.State.setUseGuests(true);
			}

			function update()
			{
				if (!this.Contract.isPlayerNear(this.Contract.getHome(), 600))
				{
					this.Flags.set("IsFail2", true);
				}

				if (this.Flags.has("IsFail1") || this.World.getGuestRoster().getSize() == 0)
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.has("IsFail2"))
				{
					this.Contract.setScreen("Failure2");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.has("IsVictory"))
				{
					if (this.Flags.get("IsCurse"))
					{
						local bros = this.World.getPlayerRoster().getAll();
						local candidates = [];

						foreach( bro in bros )
						{
							if (bro.getSkills().hasSkill("trait.superstitious"))
							{
								candidates.push(bro);
							}
						}

						if (candidates.len() == 0)
						{
							this.Contract.setScreen("Success");
						}
						else
						{
							this.Contract.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];
							this.Contract.setScreen("Curse");
						}
					}
					else if (this.Flags.get("IsEnchantedVillager"))
					{
						this.Contract.setScreen("EnchantedVillager");
					}
					else
					{
						this.Contract.setScreen("Success");
					}

					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("StartTime") + this.Flags.get("Delay") <= this.Time.getVirtualTimeF())
				{
					if (this.Flags.get("IsSpiderQueen"))
					{
						this.Contract.setScreen("SpiderQueen");
					}
					else if (this.Flags.get("IsSinisterDeal") && this.World.Assets.getStash().hasEmptySlot())
					{
						this.Contract.setScreen("SinisterDeal");
					}
					else
					{
						this.Contract.setScreen("Encounter");
					}

					this.World.Contracts.showActiveContract();
				}
				else if (!this.Flags.get("IsBanterShown") && this.Math.rand(1, 1000) <= 1 && this.Flags.get("StartTime") + 6.0 <= this.Time.getVirtualTimeF())
				{
					this.Flags.set("IsBanterShown", true);
					this.Contract.setScreen("Banter");
					this.World.Contracts.showActiveContract();
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getID() == this.Flags.get("ProtecteeID"))
				{
					this.Flags.set("IsFail1", true);
					this.World.getGuestRoster().clear();
				}
			}

			function onActorRetreated( _actor, _combatID )
			{
				if (_actor.getID() == this.Flags.get("ProtecteeID"))
				{
					this.Flags.set("IsFail1", true);
					this.World.getGuestRoster().clear();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Hexen")
				{
					this.Flags.set("IsVictory", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Hexen")
				{
					this.Flags.set("IsFail2", true);
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
			Text = "[img]gfx/ui/events/event_79.png[/img]{你发现 %employer% 脖子上戴着一串项链，尽管它标配的奇术珠宝被换成了大蒜和洋葱。 他眼里泛着泪光。%SPEECH_ON%噢佣兵见到你真好！请，坐。%SPEECH_OFF%弯腰躲过叉满草药的条幅，你在他面前就座。 你眯起眼喝了口水。他继续道。%SPEECH_ON%听着，这会让我听起来像是你见过的最大的蠢货，但是听着。 许多年以前我的初生子，%protectee%，带着疾病来到这个世界。 绝望之时，我寻求了女巫们的帮助…%SPEECH_OFF%你举起手。 你问他是不是签了个契约并且她们是来这收债的。他点头。%SPEECH_ON%是的，她们承诺了十八年而今晚他就十八了。 这不是一项简单的任务，佣兵。 这些女人的危险程度超越任何钢铁，而且我想她们知道我拒绝偿还时会显露出更加可怕的样貌。 你确认你想保护我的孩子吗？%SPEECH_OFF%擦了擦眼泪，你权衡选择… | %employer% 在他房间的一个角落里。 他被扭曲地被迫看向窗外就好像巢里的土拨鼠。 察觉到你的阴影，他跳起抱紧胸口。 他的懦弱此时显然不宜取笑，他诚恳的跟你说道。%SPEECH_ON%女巫对我的家庭下了咒！ 好吧，咒的是我的血脉。 好吧，更准确来说是我的初生子，%protectee%。许多个月以前我塞那个进…你知道的，我老婆。 我找女巫们寻求点帮助然后她们给我煮了点床上用品。 当然，她们毕竟是女巫，她们现在回来要求带走我的初生子！%SPEECH_OFF%你对女巫对他做的事情表示震惊并表达同情。%employer% 有点生气。%SPEECH_ON%这可不是开玩笑的！ 我需要给我的初生子点保护，你愿意帮忙保护 %protectee% 吗？%SPEECH_OFF% | 你发现 %employer% 充满激情的翻着书。 这种方式显露出他之前翻过了而且现在他只是在匆忙的寻找未发现的线索。 什么都没有，然后他就把书愤怒的丢下了桌子。 看到了你，他擦了擦额头并解释起来。%SPEECH_ON%我到处寻找办法，但是看起来我还是得靠点钢铁。 我说的钢铁就是你，佣兵。 实话实说。 我许多年前跟女巫达成了一个交易以保护我的初生子，%protectee%，那是一场严重的发烧。 孩子活了下来，但是现在这些可恶的女人找回来要求我的孩子作为报酬。%SPEECH_OFF%你点头。这奸计就像放高利贷似的。 他接着说，一根手指插在书桌上。%SPEECH_ON%我需要你待在这里，佣兵。 我需要一把剑来让 %protectee% 平安度过今晚，并且杀死这写该死的婆娘好让我的血脉从这场噩梦幸存下来。 你愿意帮忙吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{想要对付这种敌人，你必须给我们丰厚的报酬。 | 用满满一袋克朗来说服我这是值得的。 | 我希望能得到丰厚的报酬来和这样的敌人作战。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{听完我觉得你应该遵守契约。 | 这不值得冒险。 | 我可不想让战队跟这样的敌人扯上关系。}",
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
			Text = "[img]gfx/ui/events/event_79.png[/img]{%randombrother% 来到你身边。 他用他的小指掏着耳朵。%SPEECH_ON%嘿队长。你有见到什么俏皮女人吗？%SPEECH_OFF%听到这，%randombrother2% 走过来。他探过身。%SPEECH_ON%嘿，我听说她们女巫可漂亮了，但那就是她们搞到你的方法。 她们用魅力蛊惑你然后吃掉你的灵魂。%SPEECH_OFF%笑着，%randombrother% 在 %randombrother2%的衣服上擦了擦汗。%SPEECH_ON%那么她们得到 %randomtown% 去搞我的灵魂了，因为另一个女人在她们做到的。%SPEECH_OFF% | 你在检查装备时 %randombrother% 走过来。 你之前派他去侦查了下环境而他看起来准备好报告了。%SPEECH_ON%先生，目前没看到什么特别的，但是我跟一些当地人聊了聊。 按他们的说法，女巫们会和普通人们立契约然后再多年后收取投资报酬，通常带着巨额利息。 他们说她们可以蛊惑你让你把她们看成放荡的风骚女子。 她们能在床上做到你入土！ 我得说这听起来很像知了荒诞可笑。%SPEECH_OFF%点着头，你问他知了是什么玩意。他笑道。%SPEECH_ON%认真的？是一种坚果，先生。%SPEECH_OFF% | 兄弟们在闲度时间，打趣说着女人，女巫之类的东西之间真的有什么区别吗这样的话题。%randombrother% 伸出手。%SPEECH_ON%现在说真的，我听说过这些女巫的故事。 她们可以给你下咒来让你看到幻觉。 她们会迫使你签血契而且如果你不偿还她们就会切下你的膝盖骨用来占卜。 在我还是个孩子的时候，我的邻居跟一个女巫做了交易然后他就消失了。 我之后见到个神秘的女人带着个新鲜颅骨做成的提灯！%SPEECH_OFF%%randombrother2% 专注地点头。%SPEECH_ON%难以置信，但是有人知道巫女都干些什么吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保持专注，小伙子们。",
					function getResult()
					{
						if (this.Flags.get("StartTime") + this.Flags.get("Delay") - 3.0 <= this.Time.getVirtualTimeF())
						{
							this.Flags.set("Delay", this.Flags.get("Delay") + 5.0);
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SpiderQueen",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_106.png[/img]{一个女人孤身穿过你面前走向树林中一个缺口。 她闲散地走着，大腿在丝制裙子中若隐若现。 她的皮肤没有任何斑点，翡翠色的眼睛在红发之间张望，放荡的神情是你记事起从未见过的。 你知道这个女人是个女巫，因为这种完美不存在于这世上，而且特别是在这片地方就像浓妆艳抹地去下葬一样。 而这正是她所做的。 你拔出剑并命令她带着荣誉迎接她的末日。 女巫的皮肤皱起成它真正的，骇人的样貌，而她喜悦的笑道。%SPEECH_ON%啊，我刚才掌握了你一会，然而下面软了，上面又占领高地了。 你的体味可真令人愉悦，佣兵。 我会确保它们把你留给我亲自驾到的。%SPEECH_OFF%在你能问她是什么意思之前，她本站在中间的两棵树如开花般冒出了蜘蛛腿。 大团的黑色球体从树丛中冒出并疾步爬向下方的地面，织网蛛们饥饿地拍打着它们的下颌。 女巫抬起手，她的手指如同木偶师指挥着上方的黑云一样弹跳起来。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Hexen";
						p.Entities = [];
						p.Music = this.Const.Music.CivilianTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.Entities.push({
							ID = this.Const.EntityType.Spider,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/enemies/spider_bodyguard",
							Faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID(),
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.Spider,
							Variant = 0,
							Row = 1,
							Script = "scripts/entity/tactical/enemies/spider_bodyguard",
							Faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID(),
							Callback = null
						});
						p.Entities.push({
							ID = this.Const.EntityType.Hexe,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/hexe",
							Faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID(),
							function Callback( _e, _t )
							{
								_e.m.Name = "蜘蛛女王";
							}

						});
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Spiders, 50 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SinisterDeal",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_106.png[/img]{%randombrother% 吹了下口哨并把他的帽子点向一个从不知何处冒出来在战队面前展露姿色的一群美女。 你按住佣兵并走上前，在你能开口前一个女人举起手跨步走来会面你。%SPEECH_ON%让我给你展示我的真实姿态，佣兵。%SPEECH_OFF%她的手臂伸向两旁并变灰和皱缩得像湿杏仁皮一般。 曾经鲜亮如丝般的头发一长束一长束的落下直到她丑陋奇异的头完全露出，最后的几簇头发里密集堆积着虫子和虱子好像一个即将死去的世界的最后集会一般。 她鞠躬，她抬起脸面对你时蜡黄的脸上正咧着嘴在笑。%SPEECH_ON%我们有很强大的力量，佣兵，这你肯定看的出来。 我提出一个交易。%SPEECH_OFF%她双手各掏出一个小瓶子，其中一个装着一滴绿色液体，另一个则是蓝色的。 她笑着把它们在指尖旋转起来说道。%SPEECH_ON%一瓶强身健体，又或精气十足。 男人们会为了其中任何一个自相残杀。 我提出其中一支来交换初生子的生命。 一个陌生人的后代有什么价值呢？ 你都杀了不少陌生人了，不是吗？ 站到一边去，佣兵，并让我们带走他。 或者跟我们作对，拿你的人，还有你自己的生命冒险，一切只为了一个到时候都不会记住你长相的小子。这都是你的选择。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我决不会把那个男孩交给你们这群巫婆。拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Hexen";
						p.Entities = [];
						p.Music = this.Const.Music.CivilianTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.HexenAndNoSpiders, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				},
				{
					Text = "我渴望身强体壮。",
					function getResult()
					{
						return "SinisterDealBodily";
					}

				},
				{
					Text = "我渴望精气十足。",
					function getResult()
					{
						return "SinisterDealSpiritual";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SinisterDealBodily",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_106.png[/img]{女巫笑了。%SPEECH_ON%一个没有强身健体去闯荡世界的男人什么都不是。 给，佣兵。 请不要浪费它。%SPEECH_OFF%她把瓶子丢给你。 半空中旋转着，它泛起青绿色的光芒照在土地上，每一抹微光都从未播种的泥土中催生出一朵小花。 你抓住了玻璃瓶。 它在你手中震动着，你筋骨的疼痛慢慢消去，就好像你的拳头一直都在沉睡而你就是不知道。 当你抬起头寻求解释时女巫们已经走了。 只剩下一声哭号，从遥远的距离回想着然而完全无法辨别有多远。 无疑是源于 %employer% 初生子的死。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "太好了，不能拒绝。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 2, "背叛了" + this.Contract.getEmployer().getName() + "和女巫达成了协议");
						this.World.Contracts.finishActiveContract(true);
						return;
					}

				}
			],
			function start()
			{
				local item = this.new("scripts/items/special/bodily_reward_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "SinisterDealSpiritual",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_106.png[/img]{她的手一翻然后手腕一碰，女巫将绿色的玻璃瓶滑入她的袖子里。 剩下的蓝色瓶子被她抓着向你伸过来。%SPEECH_ON%你是个聪明人，佣兵。%SPEECH_OFF%她刺耳的哼了一声，她肥胖的鼻子皱缩成一个蛆那么粗然后落了回来。%SPEECH_ON%我确实从你的血中察觉到一个思维敏锐的男人，佣兵。 我几乎想要自己享有这血。%SPEECH_OFF%她的眼睛盯着你就像一只猫盯着一只断肢的蟋蟀，一个还敢动的蟋蟀。 但她的笑容很快回来了，比起牙齿更多看到牙龈，比起粉色看起来更像黑色。%SPEECH_ON%啊，好吧，协议就是协议。给你。%SPEECH_OFF%她将瓶子丢到空中而在你抓住它并转眼时巫女们已经走了。 你听到可怕虐待产生的细微哭号，距离听起来即近又远，而你毫不怀疑是源于 %employer% 初生子的死。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "太好了，不能拒绝。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail * 2, "背叛了" + this.Contract.getEmployer().getName() + "和女巫达成了协议");
						this.World.Contracts.finishActiveContract(true);
						return;
					}

				}
			],
			function start()
			{
				local item = this.new("scripts/items/special/spiritual_reward_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Encounter",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_106.png[/img]{%randombrother% 吹了个口哨并喊了出来。%SPEECH_ON%We've company. 好的。.. beautiful company...%SPEECH_OFF%一个放荡的女人正接近着队伍。 她大摇大摆的轻松走过来，一根手指玩弄着耳朵，另一个捏着一块石头悬在她要爆衣般的巨大胸部上。 你拍了拍佣兵的肩膀。%SPEECH_ON%那可不是普通女人。%SPEECH_OFF%言语刚离开你的嘴唇，女人丰满年轻的外貌皱缩成一片，灰色而她华美的头发从她的头顶衰落，你眼前只剩下一个丑陋的老女人，咧着嘴露出一张仅存邪念的笑容。 拿起武器！保护 %protectee% 的安全！ | 你看到一个女人接近着队伍。 她穿着红衣，项链在她丰满的胸部前晃荡。 很特别的景象，但她也太无暇了，而这种东西不存在于这世上。\n\n你拔出你的剑。女士见到你的兵器后向你露出诡笑。 头发成片的从她的头上落下而残余的皱缩成一缕灰发。 她的皮肤缩水成灰色的山谷而她的手指变得如此长以致弯曲。 她向你伸出一根手指尖叫道没有人能阻止她的契约生效。 你向战队大喊，确保 %protectee% 不受伤害。 | 一个女人被发现正接近战队。 佣兵们被她的美丽所蛊惑，但你没那么肤浅。 你拔出你的剑并把它敲的响到引起这个所谓的女士的怒火。 她讥笑起来，嘴唇咧起张得几乎到双耳边。 她的皮肤锁紧起来直到它皱成苍白的灰色。 她笑啊笑，头发不停地掉。 女巫一根手指指向你。%SPEECH_ON%啊，我闻出了你的身世，佣兵，但是你从何来毫无关系。 契约必须被初生子的血履行而任何阻拦我们的人也将同样流血！%SPEECH_OFF%战队已经组成阵型同时你告诉 %protectee% 别抬头。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.CombatID = "Hexen";
						p.Entities = [];
						p.Music = this.Const.Music.BeastsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.HexenAndNoSpiders, 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Curse",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_124.png[/img]{随着你起身回去找 %employer%，你发现 %superstitious% 低头盯着地上的一个女巫。 你可以看到那邪恶女人的嘴唇仍在动着而你赶了过去。 她正说着的咒语被你靴底强制闭上了嘴。 她笑着，牙齿在破碎的牙龈里滚来滚去。 你拔出剑刺进了她的眉间，彻底的让她永眠。%superstitious% 几乎在颤抖。%SPEECH_ON%她知道我的一切！ 她什么都知道，队长！ 她无所不知！她知道我何时会死还有死法！%SPEECH_OFF%你告诉他无视那个女巫告诉他的一切。 点着头，他返回了战队里，但他的脸因没法充耳不闻的预言陷入阴沉。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不要去想它。",
					function getResult()
					{
						return "Success";
					}

				}
			],
			function start()
			{
				this.Characters.push(this.Contract.m.Dude.getImagePath());
				local effect = this.new("scripts/skills/effects_world/afraid_effect");
				this.Contract.m.Dude.getSkills().add(effect);
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = this.Contract.m.Dude.getName() + "是害怕的"
				});
				this.Contract.m.Dude.worsenMood(1.5, "被女巫诅咒了");

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
			ID = "EnchantedVillager",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_124.png[/img]{随着伙计们从战斗中恢复过来，一个年轻的农民呼喊着跑过战场。 你转身看到他倒在一个女巫前并抱起她可怕的皮包骨的尸体，紧紧的抱在臂间前后摇荡着。 看到你，他咒骂起来。%SPEECH_ON%你为什么这么做，哏？ 你们这些该死的混蛋！ 她两星期前刚嫁给我而现在我必须埋葬她。 好吧不如送我去陪她！ 来吧，你们这群野蛮杂种！ 这个世界会将我们一起埋葬，我的挚爱！%SPEECH_OFF%You raise an eyebrow. 他肯定是在你来之前被女巫蛊惑了，或许是给女巫们当跟班。 不论你的想法如何，几个伙计都被面前悲痛的小子搅乱了情绪。 不过，一个更强硬的佣兵咧起了嘴并把他的手放在了他的武器上问他能不能满足这小子的请求。 你摇摇头并命令伙计们组成阵型。} ",
			Image = "",
			List = [],
			Options = [
				{
					Text = "可怜的蠢货。",
					function getResult()
					{
						return "Success";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_124.png[/img]{战斗结束了，%randombrother% 来到你身边。 他说 %protectee% 在战斗中死了。 说他的眼球还有舌头都不见了，他的脸看起来像两块湿布粘在一起一样。 现在恐怕不适合回去找 %employer%。 | 你低头看着 %protectee%的尸体。 眼球被拽出悬在他的面颊上好像湿嗉子一样。 他的脸拉扯成一张笑容，尽管产生这种变形的东西不能更不是在开玩笑。%randombrother% 问战队是否该回去找 %employer% 而你摇了摇头。 | 你发现 %employer%的初生子瘫倒在地上。 每一个关节或挖或凿出，不过这是何时或如何发生的，你完全无法理解。%randombrother% 试着移动尸体，但它扭曲着发出响声就像一个断了线的木偶。 佣兵面露恐惧并把尸体丢回到地上而它皱成了个包着胸腔的篮子，头则像巢中的蛋。 现在回去找 %employer% 也没有意义了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "该死，该死，该死！",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能保护" + this.Contract.getEmployer().getName() + "的长子。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_16.png[/img]{%employer% 花钱让你保护 %protectee%。当你离开 %townname% 把这个初生子丢给女巫们时就已经放弃了这个艰难的保护工作。 别浪费时间回去拿报酬了。 | 你的任务是在 %protectee% 保护 %townname% 的安全，或者你忘了？ 别浪费时间回去了，那个初生子无疑已经死了或者，更糟的，被女巫们以某种邪恶的目的带走了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "哦，该死的。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能保护" + this.Contract.getEmployer().getName() + "的长子。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_79.png[/img]{%employer% 拥抱起 %protectee%，紧紧地抱着。 他看着你。%SPEECH_ON%所以成了，全部的女巫都死了？%SPEECH_OFF%你点头。他点头回应。%SPEECH_ON%谢谢你！谢谢你，雇佣兵！%SPEECH_OFF%他指向房间角落里的一个箱子。 它装满了你的报酬。 | 你把 %protectee% 带回给 %employer%。他和初生子如同两个相同的梦一般拥抱在一起，慢慢的会和起来尽管还存在着现实诉求。 终于，他们抱了又抱并停下来盯着另一方来确认都是真的。 你告诉 %employer% 女巫们全死了，但他应该把这个故事作为秘密。他点头。%SPEECH_ON%鬼魂们以傲慢为食，这我知道，而且我会带着这个故事进坟墓的。 我为你今天的作为感谢你，佣兵。 我对你的谢意你无法想象。 我只有一个办法能表示我的感谢。%SPEECH_OFF%他交给你一袋金子。 看到包里装满了硬币，你的脸上露出了温暖的笑容。 | %protectee% 从你身边跑进 %employer%的双臂。他越过他初生子的肩膀看过来。%SPEECH_ON%这么说一切都结束了，我们就摆脱诅咒了？%SPEECH_OFF%你耸耸肩并回应道。%SPEECH_ON%你已经摆脱女巫了。%SPEECH_OFF%他咬了咬嘴唇并点头。%SPEECH_ON%好的，足够好了。 你的报酬就在那边的袋子里，跟我们谈好的一样多。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "最后一切都解决了。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "受保护的" + this.Contract.getEmployer().getName() + "的长子。");
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
			"superstitious",
			this.m.Dude != null ? this.m.Dude.getName() : ""
		]);
		_vars.push([
			"direction",
			this.m.Target == null || this.m.Target.isNull() ? "" : this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Target.getTile())]
		]);
		_vars.push([
			"protectee",
			this.m.Flags.get("ProtecteeName")
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/abducted_children_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Home.getSprite("selection").Visible = false;
			this.World.State.setUseGuests(true);
			this.World.getGuestRoster().clear();
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

