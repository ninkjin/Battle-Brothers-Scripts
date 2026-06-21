this.destroy_goblin_camp_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.destroy_goblin_camp";
		this.m.Name = "摧毁哥布林营地。";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		local camp = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getNearestSettlement(this.World.State.getPlayer().getTile());
		this.m.Destination = this.WeakTableRef(camp);
		this.m.Flags.set("DestinationName", this.m.Destination.getName());
		this.m.Payment.Pool = 900 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 2);

		if (r == 1)
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
					"摧毁 " + this.Flags.get("DestinationName") + "，位于%origin%的%direction%"
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
				this.Contract.m.Destination.clearTroops();
				this.Contract.m.Destination.setLastSpawnTimeToNow();

				if (this.Contract.getDifficultyMult() < 1.15 && !this.Contract.m.Destination.getFlags().get("IsEventLocation"))
				{
					this.Contract.m.Destination.getLoot().clear();
				}

				this.Contract.addUnitsToEntity(this.Contract.m.Destination, this.Const.World.Spawn.GoblinRaiders, 110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setLootScaleBasedOnResources(110 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				this.Contract.m.Destination.setResources(this.Math.min(this.Contract.m.Destination.getResources(), 100 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult()));
				this.Contract.m.Destination.setDiscovered(true);
				this.World.uncoverFogOfWar(this.Contract.m.Destination.getTile().Pos, 500.0);

				if (this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().get("Betrayed") && this.Math.rand(1, 100) <= 75)
				{
					this.Flags.set("IsBetrayal", true);
				}
				else
				{
					local r = this.Math.rand(1, 100);

					if (r <= 20 && this.World.Assets.getBusinessReputation() > 1000)
					{
						if (this.Contract.getDifficultyMult() >= 0.95)
						{
							this.Flags.set("IsAmbush", true);
						}
					}
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onDestinationAttacked.bindenv(this));
				}
			}

			function update()
			{
				if (this.Contract.m.Destination == null || this.Contract.m.Destination.isNull())
				{
					if (this.Flags.get("IsBetrayal"))
					{
						if (this.Flags.get("IsBetrayalDone"))
						{
							this.Contract.setScreen("Betrayal2");
							this.World.Contracts.showActiveContract();
						}
						else
						{
							this.Contract.setScreen("Betrayal1");
							this.World.Contracts.showActiveContract();
						}
					}
					else
					{
						this.Contract.setScreen("SearchingTheCamp");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Return");
					}
				}
			}

			function onDestinationAttacked( _dest, _isPlayerAttacking = true )
			{
				if (this.Flags.get("IsAmbush"))
				{
					if (!this.Flags.get("IsAttackDialogTriggered"))
					{
						this.Flags.set("IsAttackDialogTriggered", true);
						this.Contract.setScreen("Ambush");
						this.World.Contracts.showActiveContract();
					}
					else
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						p.LocationTemplate = null;
						p.CombatID = "Ambush";
						p.Music = this.Const.Music.GoblinsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.GoblinRaiders, 50 * this.Contract.getScaledDifficultyMult(), this.Contract.m.Destination.getFaction());
						this.World.Contracts.startScriptedCombat(p, false, false, false);
					}
				}
				else
				{
					this.World.Contracts.showCombatDialog();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Betrayal")
				{
					this.Flags.set("IsBetrayalDone", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Betrayal")
				{
					this.Flags.set("IsBetrayalDone", true);
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
					this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_61.png[/img]{%employer%正在阅读一卷卷轴，当你走进去的时候。他向你挥手让你离开，或许以为你是个仆人。你的剑鞘发出咣当声撞击在墙上，这时他抬起头来，然后迅速放下了他手中的文件。%SPEECH_ON%啊，雇佣兵！很高兴见到你。我有一个问题，特别适合一个有你那种...嗜好的人。%SPEECH_OFF%他停顿了一下，仿佛期待着你的回应。当你没有回答时，他笨拙地继续说道。%SPEECH_ON%是的，当然，是任务。在 %origin% 的 %direction% 方向上的 %location%，有一些地精已经建立了一个据点。我本来想带着我的骑士去处理这件事，但不值得。这些骑士们认为‘杀死地精‘是不值得的事情。我说这完全是胡说，我想他们只是不想死在小个子手中。荣誉，勇气，所有这些。%SPEECH_OFF%他笑了起来，并抬起了手。%SPEECH_ON% 但对你来说不值得，只要报酬合适，对吧？%SPEECH_OFF% | [%employer%]正在大声吼着一个离开他房间的男人。当他冷静下来时，他礼貌地向你问好。%SPEECH_ON%见到你真好。你知道让“忠诚”的人去杀一些地精有多难吗?%SPEECH_OFF%他吐了口痰，并用袖子擦了擦嘴巴。%SPEECH_ON%显然这不是最高尚的任务。有什么关于那些小家伙永远不公正战斗的。你能相信吗？居然是这些人告诉我，一个贵族，什么是“高贵”的或者“不高贵”的。无论如何，雇佣兵，我需要你去%origin%的%direction%根除一些设立营地的地精。你能为我做到这点吗？%SPEECH_OFF% | %employer%抽出剑又把它收回鞘里。他似乎在剑的反光中看着自己，然后又将其轻轻收回。%SPEECH_ON%农民又开始骚扰我了。他们说有些地精在%origin%的%direction%设了营。在今天一个年轻的男孩被送到我的脚边，他被毒镖射中了。我没有理由不相信他们。%SPEECH_OFF%他将剑猛地插入鞘中。%SPEECH_ON%你愿意帮我解决这个问题吗？%SPEECH_OFF% | 醉醺醺的%employer%满脸通红，当你走进他的房间时，他砰的一声把杯子砸在桌子上。%SPEECH_ON%佣兵，对吧？%SPEECH_OFF%他的卫兵看了过来点了点头。贵族笑了。%SPEECH_ON%噢，好的。要派更多的人去送死了。%SPEECH_OFF%他停了一下，然后爆发出大笑声。%SPEECH_ON%我开个玩笑，仅仅是个玩笑而已。我们在%origin% %direction%的%location%有一些麻烦的哥布林。我需要你去处理掉他们。你行吗，还是我应该去找别人来挖……我的意思是，你行吗？%SPEECH_OFF%他再次把自己关在饮料中。 | %employer%在比较两个卷轴，当你走进他的时候。%SPEECH_ON%我的税吏们最近有点力不从心。真可惜，虽然我想现在你们应该会做更好的生意，因为我再也不能给我的所谓“忠诚”的骑士们发薪水去到任何地方了。%SPEECH_OFF%他把纸扔在一边，双手抱在桌子上。%SPEECH_ON%我的间谍报告，在%origin%%direction%的某个地方，哥布林们建起了一个营地。我需要你去那里做我的大臣拒绝做的工作。%SPEECH_OFF% | %employer%一边进食面包，你进门了，但他没有分享给你。他把两端浸入酒杯，然后把它们塞进嘴里。他说话了，但只有渣子没有实质的词语。 %SPEECH_ON%好久没见到你，雇佣兵。我有一些%origin%%direction%的地方有些地精需要清除。我本可以派骑士去处理他们，但他们可能会碰到更重要和不易损失的事情。我相信你明白我的意思。 %SPEECH_OFF%他把剩下的面包全都往嘴里塞。他突然咳嗽起来，你想关上门，终结一切。不幸的是，他的痛苦引起了警卫的注意，警卫冲了进来，一拳狠狠地击中了这个贵族的胸口，这场景很快变得有点意外。 | 你找到了%employer%，他正在送几个骑士走，并且狠狠地咒骂着。然而，看到你的出现，他却暂时变得镇定了。%SPEECH_ON%佣兵！见到你真是太好了！比那些所谓的“人”要强多了。%SPEECH_OFF%他坐下来倒了一杯饮料，有些看着它发愣，然后一口喝了下去。%SPEECH_ON%我的效忠诸侯拒绝去对付设置在%origin%%direction%的哥布林。他们会谈论伏击，毒药，所有这些...%SPEECH_OFF%他的话语愈加含糊。%SPEECH_ON%嗯... -嗝-，你都懂的，对吧？你知道我接下来要问什么吧？当然你知道，-嗝-, 我需要你帮我再拿一杯酒！哈，开玩笑的，去杀了那些哥布林，好吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{对抗哥布林可不是件容易的事。 | 我相信你会丰厚地支付报酬。 | 让我们谈钱。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不划算。 | 我们还有其他要事。}",
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
			ID = "Ambush",
			Title = "接近营地时…",
			Text = "[img]gfx/ui/events/event_48.png[/img]{你走进了哥布林的营地，发现营地空无一人。但你知道事实并非如此——你已经走进了一个陷阱。就在此时，该死的绿皮族从你的各个方向出现了。你大喊最大声的战斗口号，命令士兵们准备战斗！ | 哥布林欺骗了你！他们离开了营地并转回来，将你包围起来。需要小心谨慎地准备士兵，因为这个陷阱不会轻易逃脱。 | 你应该知道得更清楚：你正走进一个哥布林的陷阱！他们的士兵布置在你的周围，公司却像一群待宰的绵羊一样站着！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "小心！",
					function getResult()
					{
						this.Contract.getActiveState().onDestinationAttacked(this.Contract.m.Destination);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Betrayal1",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_78.png[/img]{在你杀死最后一个哥布林之后，你突然被一群重装士兵包围。他们的中尉向前迈出一步，拇指勾在腰带上，握着一把剑。%SPEECH_ON%嗯，嗯，你真的很蠢。%employer%不会轻易忘记——他还没有忘记你上次背叛他的事情。这算是一个小小……报复。%SPEECH_OFF%突然间，所有人冲着中尉的背后前进。准备战斗，这是个埋伏！ | 当你用剑清理完哥布林之后，你突然看到一群手持%employer%旗帜的人向你走来，并拔出武器。你突然想到，你已经被设了局，而这群人刚刚让你先和哥布林战斗，真混蛋！让他们付出代价吧！ | 一个像是从空中冒出来的人过来迎接你。他武装精良，披着铠甲，还很开心地朝你笑，咧着嘴角。%SPEECH_ON%晚上好，雇佣兵。对付那些绿皮怪干得不错，是吗？%SPEECH_OFF%他停顿片刻，笑容褪去。%SPEECH_ON%%employer%向你问好。%SPEECH_OFF%就在这时，一群人从路边涌出。这是个埋伏！这个该死的贵族背叛了你们！ | 一群身穿%faction%颜色的武装士兵跟在你身后，展开队形，瞪着你们的战团。他们的首领打量着你。%SPEECH_ON%我很愿意从你已经死去的手中夺过这把剑来。%SPEECH_OFF%你耸耸肩，询问为什么会有人设下你们。%SPEECH_ON%%employer%不会忘记那些背叛他或他家族的人的。这就是你所需要知道的全部。当你死了，我说什么都没有用了。%SPEECH_OFF%掏出武器，因为这是个埋伏！ | 你的手下搜查了哥布林的营地，却寻不到一个人。突然间，一群身穿%faction%颜色的士兵出现在你们身后，这个小队的中尉神情恶劣地走了过来，那块布上绣着%employer%的徽章。%SPEECH_ON%真遗憾这些绿皮没有解决掉你。如果你想知道我为什么在这里，那就是为了清算欠%employer%的债。你当时答应完成任务，结果骗了他，现在你得付出代价。%SPEECH_OFF%你拔出剑，剑锋在中尉的面前一闪。%SPEECH_ON%看来%employer%又要失望了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationBetrayal);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).getFlags().set("Betrayed", false);
						local tile = this.World.State.getPlayer().getTile();
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.TerrainTemplate = this.Const.World.TerrainTacticalTemplate[tile.TacticalType];
						p.Tile = tile;
						p.CombatID = "Betrayal";
						p.Music = this.Const.Music.NobleTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.Noble, 140 * this.Contract.getScaledDifficultyMult(), this.Contract.getFaction());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Betrayal2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{你在你腿上抹去了剑上的血并收回鞘内。 伏击者死了，扭曲成这样那样的姿势。%randombrother% 走过来问你现在怎么办。 看起来 %faction% 不会是最友善的人了。 | 你将伏击者的尸体从你剑上踹开。 看起来 %faction% 现在起不会是最友善的人了。 也许下一次，当我同意为这些人做点什么的时候，我真的做到了。 | 好吧，非常明显，这里学到的是不要接一个你完成不了的活。 这块土地上的人们对那些不守承诺的人可真不怎么友好… | 你背叛了 %faction%，但是不要在这事上钻牛角尖。 他们也背叛了你，这才是最重要的！ 未来，你最好注意着点他们和任何带着他们旗帜的人。 | %employer%，从你脚下的士兵尸体判断，看来不再喜欢你了。 如果你要猜的话，这是因为你以前做了些什么－失败，背叛，背后说坏话，睡了一个贵族的女儿？ 这些全部都被你回想起来寻思着。 重要的是你们两个之间的裂缝不会轻易修复了。 你最好看着点 %faction%的人一段时间。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "只是为了报酬……",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "SearchingTheCamp",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_83.png[/img]{消灭了最后的地精后，你瞄了一眼他们的营地。他们似乎是开心的那种——堆满了小玩意和乐器，所有这些都可以当武器使用。只需要将它们浸入摆放在废墟中心的巨大毒锅中，就可以实现。你将它踢翻，并告诉士兵们准备回去见你们的雇主%employer%。 | 地精们发挥出了他们的战斗技巧，但你们设法打败了他们。他们的营地燃起了火焰，你命令士兵们准备好带着好消息返回%employer%。 | 矮绿皮们虽然表现得很强悍，但你的队伍打得更好。最后的地精被杀死，你看了看他们毁坏的营地。似乎他们不是完全孤单的——有证据表明，一些地精在战斗中逃走了。可能是亲属？孩子？不管了，是时候回去找雇主%employer%了。 | 啊，这是场漂亮的战斗。%employer%现在应该在等待听到好消息了。 | 难怪人们不愿与地精作战，他们的战斗力远超他们的身材。很遗憾不能将他们的思维放在人类身上，但也许让这种凶猛之能被这样小的生物所包容也是最好的！}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "是时候领工钱了。",
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
			Text = "[img]gfx/ui/events/event_04.png[/img]{你进入%employer%的房间，在地上放了几个地精的头。他扫了一眼。%SPEECH_ON%嗯，比文书记录上写的要大得多。%SPEECH_OFF%你简述了对绿皮兽营地的摧毁。贵族点头，揉着下巴。%SPEECH_ON%不错。如承诺的那样，这是你的报酬。%SPEECH_OFF%他递给你一个装满%reward_completion%克朗的金属口袋。 | %employer%在你进来的时候正在用小石头扔一只胆小的猫。他看了你一眼，给了那只可怜的小家伙一个轻微的逃脱的机会，透过窗户溜走了。贵族用几块石头追着赶走了它，庆幸每一次都没打到。%SPEECH_ON%见到你很高兴，雇佣兵。我的间谍已经把你的行动报告给我了。这是你承诺的报酬。%SPEECH_OFF%他在桌子上滑过一个装满%reward_completion%克朗的木盒。 | %employer%在你回来的时候正在剥开坚果。他一边说话，一边咬牙切齿，把壳子扔到地上。%SPEECH_ON%喂，很高兴再次见到你。你成功了吧？%SPEECH_OFF%你拿起几个地精头，每个都拴在一条统一的带子上。它们扭曲着，凝视着房间和彼此。贵族举起手。%SPEECH_ON%请，请，我们这里是有尊严的人。放在那个地方。%SPEECH_OFF%你耸了耸肩，把他们交给在走廊里等待的%randombrother%。%employer%走到桌子旁边，递给你一个装有%reward_completion%克朗的金属口袋。%SPEECH_ON%如约，你的报酬。干得好，雇佣兵。%SPEECH_OFF% | %employer%看到你拿着地精头进来后大笑。%SPEECH_ON%该死，不要把这些带进来。给它们让狗吃了。%SPEECH_OFF%他有点喝醉了。你不确定他是因为你成功了而兴奋还是他天生喜欢喝点麦酒。%SPEECH_ON%你的报酬是——嗝——%reward_completion%克朗，对吧？%SPEECH_OFF%你想'改变'一下细节，但站在门外的警卫向谈话的人摇了摇头。哦，好吧，看来确实是%reward_completion%克朗。 | 当你回到%employer%的时候，他的腿上有个女人。实际上，她正在低头弯腰，他的手在空中。他们都盯着你看，停下来，然后她迅速钻到他的桌子下面，他挺直身子。%SPEECH_ON%雇佣兵！很高兴见到你！我想你已经成功摧毁那些绿皮兽了，是吗？%SPEECH_OFF%可怜的女孩在桌子下碰了一下头，但你想着不要在意，就告诉那个人远征成功了。他鼓掌，打算站起来，但又改了主意。%SPEECH_ON%如果你愿意，你的%reward_completion%克朗报酬在我的书架上。%SPEECH_OFF%当你取走报酬时，他尴尬地笑了笑。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "摧毁了哥布林营地");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isGreenskinInvasion())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

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
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Origin, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"location",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.m.Destination.getName()
		]);
		_vars.push([
			"direction",
			this.m.Destination == null || this.m.Destination.isNull() ? "" : this.Const.Strings.Direction8[this.m.Origin.getTile().getDirection8To(this.m.Destination.getTile())]
		]);
	}

	function onOriginSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Origin.addSituation(this.new("scripts/entity/world/settlements/situations/greenskins_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}

		if (this.m.Origin != null && !this.m.Origin.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Origin.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
		}
	}

	function onIsValid()
	{
		if (this.m.IsStarted)
		{
			if (this.m.Destination == null || this.m.Destination.isNull() || !this.m.Destination.isAlive())
			{
				return false;
			}

			if (this.m.Origin.getOwner().getID() != this.m.Faction)
			{
				return false;
			}

			return true;
		}
		else
		{
			return true;
		}
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

