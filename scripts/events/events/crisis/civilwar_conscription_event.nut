this.civilwar_conscription_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_conscription";
		this.m.Title = "在%town%";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{%noblehouse% 的士兵正试图征召当地老百姓。 可以理解的是，百姓们不想参与战争，也不情愿去参军。 贵族的军官显然没有带够人手，他向你求助。 | 你遇到一群农民，他们大声喊叫，打倒了 %noblehouse% 的几个士兵。他们声明他们绝不会参加贵族家族之间的战争。%SPEECH_ON%领主为我们做了什么？！%SPEECH_OFF%一个人的质问得到了许多人的欢呼。 一名军官吼叫着回复他。%SPEECH_ON%他将他的地赐给你，使你和你的家族兴旺！%SPEECH_OFF%一位老人吐了一口唾沫。%SPEECH_ON%这不是那个老婊子的地盘。 在那个混蛋这么说之前，这不是任何人的土地。 为什么？就因为他愚弄了一些士兵，让他们认为他是对的？%SPEECH_OFF%人群的欢呼声越来越大。%SPEECH_ON%你已经夺走了我们很多人的生命，所以滚吧！ 如果他们的生命不能解决你们高贵的争吵，那么我们最后一个人还能做什么呢？%SPEECH_OFF%军官转向你，请求帮助，好像你特别有说服力，能让人们为他们不关心的事情去死。 | 一大群农民挤在穿过 %town% 的道路上。当你走近时，你意识到一群来自 %noblehouse% 的士兵正试图征召当地人，显然，这不是那些人想要参与的战斗。 因为没有足够的人手独自处理这一情况，士兵们的军官看向你。%SPEECH_ON%唉，雇佣兵。你能帮我说服这些小矮子参军吗？ 贵族老爷会知道你的行为的…%SPEECH_OFF% | Seemingly every villager is standing out in the road that snakes through %town%. Pushing your way through the crowd, you come to a small group of bewildered and scared soldiers of %noblehouse%. Their lieutenant has his hands up, a scroll dangling from one.%SPEECH_ON%这些不是我的命令，但我必须执行它们！%SPEECH_OFF%一个农民吐了一口唾沫。%SPEECH_ON%是的，带它们到坟墓里去吧！%SPEECH_OFF%军官见了，请你帮忙。%SPEECH_ON%佣兵！我们需要士兵参加贵族家族之间的伟大战争… 这些…白痴刁民，不服从命令。 领主的命令！ 帮助我们，我会亲自确保贵族们听到你在这里的工作。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "非常好。 农民们，你们需要尽力而为！",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);

						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "这不是他们的战斗，军官。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);

						if (this.Math.rand(1, 100) <= 50)
						{
							return "D";
						}
						else
						{
							return "E";
						}
					}

				},
				{
					Text = "这根本不是我们的战斗。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_43.png[/img]{虽然这不是你的战斗，并且几乎与你无关，但是你本能感到与贵族们的好关系会在未来得到回报。 考虑到这一点，你命令你的人开始围捕农民，把年轻人和老年人分开，把瘦弱的和强壮的分开。 看到你的人看起来能毫无顾忌地杀害平民，平民不得不服从你的命令，分成了几群人。 军官从这群人中抽出一批，把它们推到路上。 他非常感谢你的帮助，并且表示贵族们会听到 %companyname%。 | 你拔出你的剑，命令农民从强壮到弱小排好队。 你瞥了军官一眼。%SPEECH_ON%女人？%SPEECH_OFF%他摇了摇头。 你回到人群中。%SPEECH_ON%我们只征男人！从最强壮到最瘦弱。给我排好队。%SPEECH_OFF%本地人只能零零星星地发牢骚或者轻声哭泣，但不得不遵守命令。 军官通知你，贵族们会知道你在这里的所作所为。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "很高兴能为你服务。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助征募了一些农民");
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationMinorOffense, "帮助征募他们的人民");
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_60.png[/img]{这场战斗与你无关，但你毫不怀疑获得贵族的好感在未来会对你有帮助。 你命令你的手下把人群分开，从弱者中挑出强者。 但是农民们拒绝合作，一块石头从你脸上擦过。%randombrother% 冲向人群并刺穿了行凶者的胸部。 几个村民决定反击，拿出了干草叉和火把。 %companyname% 剩下的人则抽出武器，在几次短暂的杀戮之后，人群安静下来。 你四处寻找军官，但是他和他的手下却不见踪影。 | 你拔出剑命令村民开始排队，从最强壮到最瘦弱。 但这时，一个老人用不合时宜的反战情绪召集村民。%randombrother% 见状，上去对着老人就是一拳，砰的一声，老人无声的倒在泥地上。 但不幸的是，这种行为只会激怒群众，引发一场大混战。 你的雇佣兵冷酷无情，任何敢反抗的人都被砍翻在地。 混战过后，有的人被砍伤了，有的人死在泥地里，边上只剩下一脸困惑和悲伤的女人，而军官和他的士兵却不见了踪影。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "事情给搞砸了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-2);
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationAttacked, "砍倒民众");
				local brothers = this.World.getPlayerRoster().getAll();
				local candidates = [];

				foreach( bro in brothers )
				{
					if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
					{
						candidates.push(bro);
					}
				}

				local numInjured = this.Math.min(candidates.len(), this.Math.rand(1, 3));

				for( local i = 0; i < numInjured; i = ++i )
				{
					local idx = this.Math.rand(0, candidates.len() - 1);
					local bro = candidates[idx];
					candidates.remove(idx);

					if (this.Math.rand(1, 100) <= 50)
					{
						local injury = bro.addInjury(this.Const.Injury.Brawl);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = bro.getName() + " 遭受 " + injury.getNameOnly()
						});
					}
					else
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你转向军官。%SPEECH_ON%这场战斗与我们无关，但若你招不到人，或许这场战斗也与你无关。回去吧。%SPEECH_OFF%军官整了整了他的盔甲并挺直身子。%SPEECH_ON%不管有没有你，他们都要跟我们走。%SPEECH_OFF%他话音刚落，一块石头从他的头上敲下来，把他得不省人事。 他的两个手下冲到他身边，开始把他拉开。 其中一个向你吐了口唾沫。%SPEECH_ON%别以为我们会忘记这个。%SPEECH_OFF%你朝军官点头。%SPEECH_ON%是的，你最好记住，因为他肯定不会。%SPEECH_OFF% | 军官交叉双臂，好像在说“怎么样？”。你摇了摇头。%SPEECH_ON%找个人来强迫农民。 如果你自己做不到，那或许你的队伍本身就太弱了，从一开始就没有想赢？%SPEECH_OFF%他怒气冲冲地走上前去，与你相撞，就像两只打架的公鸡那样。 几个农民突然拿着干草叉和镰刀从四面八方走来。 军官瞥了一眼这意想不到的增援，然后又看了看你。他走开了。%SPEECH_ON%好吧，我想是这样的。 贵族们会知道你的错误的，雇佣兵。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "滚你妈的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationMinorOffense, "阻止他们的人征召农民");
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationFavor, "使他们的人民免遭征兵");
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你告诉军官，你不会参与他这极其失败的招募行动。 他点了点头，拔出了剑，他的手下也跟着拔了出来。%SPEECH_ON%好吧，如果今天我们不招募到这些人，那我就把他们通通都杀了。 任何否定领主决定的人，今天必须得死。%SPEECH_OFF%衣衫褴褛的人群一边传来嘀咕声一边退去。 %randombrother% 瞥了你一眼。%SPEECH_ON%先生，我们应该做点什么吗？ 那边的贵族走狗会害死很多人的。%SPEECH_OFF% | 军官轻叩靴子。%SPEECH_ON%好吧，你到底帮不棒忙？%SPEECH_OFF%你看着这群人，光着脚，衣衫褴褛，不过有几个壮汉站在弱者中间，就像脆弱的篱笆旁的树木。 你转身对着军官，摇了摇头。他耸耸肩。%SPEECH_ON%好了，伙计们。没有招到人我们肯定不能回去。 要么我们带着人回去，要么我们带着他们的人头回去！%SPEECH_OFF%那人拔出剑来，他的士兵们也跟着拔了出来。人群后退，就像一大群苍蝇被 %randombrother% 赶到你身边。%SPEECH_ON%我们应该做点什么吗？ 这些白痴人数远远超过贵族的士兵，但士兵们无疑会在死之前杀掉很多人。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我们别插手。",
					function getResult( _event )
					{
						return "F";
					}

				},
				{
					Text = "我们帮贵族这边！",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "我们帮农民这边！",
					function getResult( _event )
					{
						return "H";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_02.png[/img]贵族的战争不是你的战斗，和农民争吵不是你的战斗，阻止士兵屠杀平民也不是你的职责，你叫兄弟们站到一边去，别管这件事情。\n\n不出所料，士兵们挥舞着剑或者棍棒冲向人群。站在前排的农民无法阻挡士兵的进攻，纷纷倒下，但是农民的数量很快就压倒了军官和他的手下。几个少年推倒了一座小屋的烟囱，雨点般的石块将一个士兵砸进泥里。当其他士兵停下脚步时观察情况，一个农夫冲过来用干草叉刺穿一个士兵，把他像一捆干草一样高高举到空中。军官看情况不对，打算逃跑，但他被两个拿着剃毛刀的妇女绊倒了。\n\n一段时间后，战斗结束了，所有士兵都死了，但是村民也死了不少。随后，镇民们把贵族的手下的尸体挂在了树上，以便进一步肢解。你的雇佣兵们感谢你没有多管闲事。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "好。我们走吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_94.png[/img]在这里，我们必须做出一个选择－要么站在无能为力的平民一边，要么站在那些随意滥用权力的暴力使节一边。 在这两者中，你认为帮助后者在未来可能会对你更有帮助。 你命令 %companyname% 与士兵站在一起。 这是一场速战速决的战斗，结局是农民逃到田野里，妇女乞求不要处死伤员。 他们的请求被无视了。\n\n 军官擦着他的刀，感谢你救了他和他的手下。%SPEECH_ON%那不是我能做出的最明智的决定，但出于某种原因，我知道你会来帮忙的。 我已经有一段时间没有好好享受杀戮了。 谢谢了，佣兵。贵族们将会听到你在这里的事迹。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "很高兴能为你服务。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "帮助他们的人征募了一些农民");
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationAttacked, "砍倒民众");
				local brothers = this.World.getPlayerRoster().getAll();
				local candidates = [];

				foreach( bro in brothers )
				{
					if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
					{
						candidates.push(bro);
					}
				}

				local numInjured = this.Math.min(candidates.len(), this.Math.rand(1, 3));

				for( local i = 0; i < numInjured; i = ++i )
				{
					local idx = this.Math.rand(0, candidates.len() - 1);
					local bro = candidates[idx];
					candidates.remove(idx);

					if (this.Math.rand(1, 100) <= 50)
					{
						local injury = bro.addInjury(this.Const.Injury.Brawl);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = bro.getName() + " 遭受 " + injury.getNameOnly()
						});
					}
					else
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_87.png[/img]唉，无力的平民站起来反抗混蛋贵族。 而你决定站在平民这边。 一旦士兵与农民发生冲突，你就命令 %companyname% 的人乘虚而入。 背刺贵族一方。 你亲自偷袭军官，用匕首划过他的脖子。 他转过身来，紧紧抓住自己致命的伤口，试图弥补这无法弥补的伤口。 看到你，他的眼睛睁得大大的，不知所措，好像他从没有想到会有一个佣兵出卖他。 他咳嗽带出出一股深红色的激流，随后跪倒在泥地里，没了声息。\n\n 当你清洁刀刃时，一位老人慢慢走近。 他感谢你拯救了这个小村庄，并承诺传播你的“圣洁”声誉。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我们在这里做得好吗？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "杀了一些他们的人");
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationFavor, "使他们的人民免遭征兵");
				this.World.Assets.addMoralReputation(4);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 1)
			{
				continue;
			}

			local d = playerTile.getDistanceTo(t.getTile());

			if (d < bestDistance)
			{
				bestDistance = d;
				bestTown = t;
			}
		}

		if (bestTown == null || bestDistance > 3)
		{
			return;
		}

		this.m.NobleHouse = bestTown.getOwner();
		this.m.Town = bestTown;
		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
		_vars.push([
			"town",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
		this.m.Town = null;
	}

});

