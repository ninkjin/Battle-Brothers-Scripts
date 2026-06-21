this.civilwar_trapped_soldiers_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_trapped_soldiers";
		this.m.Title = "在%town%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]你遇到一大群吵吵闹闹的农民。 你仔细一看，这些农民包围了一队举着 %noblehouse% 旗帜的士兵，这个村庄就是属于他们的。 每个士兵都拔出了自己的剑，但是他们被逼到了角落里，寡不敌众。 村民们大喊大叫，指指点点。%SPEECH_ON%杀人犯！强奸犯！纵火犯！%SPEECH_OFF%口水和烂西红柿跟雨点一样飞向那些士兵。%randombrother% 来问你，是该介入此事还是置身事外。",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "我们必须制止这一切。",
					function getResult( _event )
					{
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
					Text = "这不是我们的战斗。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "D";
						}
						else
						{
							return "E";
						}
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
			Text = "[img]gfx/ui/events/event_43.png[/img]没有人应该被处以私刑，尤其是那些战士。 你命令你的人站出来，大声发出命令，让一半的人都看到你。 人群一下安静了下来，你自信的点了点头。%SPEECH_ON%都给我让开，农民们。这些人或许应该受到一些惩罚，但你们这些私刑可不在其中。%SPEECH_OFF%一个衣衫褴褛的农民大叫起来。%SPEECH_ON%但他们是杀人犯，甚至更糟！%SPEECH_OFF%你做出一个严厉的表情。%SPEECH_ON%我的人也一样。 现在给我让开。%SPEECH_OFF%人们照你说的做了。 获救的士兵告诉你 %noblehouse% 会知道你在这里的事迹。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "这件事做的很好。 ",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationFavor, "救了他们的一些人");
				this.World.Assets.addMoralReputation(1);
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationMinorOffense);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_43.png[/img]没有理由让士兵像这样被私刑处置。或者，因为你内心突然拥有了正义感而这么认为。你大声喊道，表明自己是一个中立的第三方，来调解这件事。在礼貌的一秒钟后，农民们更加尖锐和歇斯底里，宣称你们只是来自%noblehouse%更多的士兵。你举起手来解释，然而一场肉搏战爆发了。 \n\n你只能面露愁容地看着你的士兵一个接一个地杀死农民，就像强壮的农民在收割着最新鲜的小麦田一样。这是一个可怕的景象，一些旁观者惊恐地看着，然后逃走了，肯定会告诉别人你在这里做了什么。相反，士兵们却感谢你那已经染满鲜血和尸液的士兵们。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "不知道我期望什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "救了他们的一些人");
				this.World.Assets.addMoralReputation(-2);
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationOffense, "杀了一些他们的人");
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
					local injury = bro.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = bro.getName() + " 遭受 " + injury.getNameOnly()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_43.png[/img]参与其中可能只会使事情变得更加复杂，农民善变，没有文化又固执己见。 你命令你的人尽量站在一边，不要引起注意。\n\n 一块扔出去的石头吹响了进攻的号角，随着而来的是一堵由干草叉和大砍刀组成的墙。 被包围的士兵奋起试图防抗，但总结他们防御的最佳解释就是一声尖叫。 一个士兵从人堆中被拉出来，又踢又叫，农民们不停的用干草叉插他，直到这名士兵一动不动。 另一个士兵被三个愤怒的农民用绳子捆起来，吊到一棵树上，勒死了。\n\n混乱之后，人群满足了，安静了下来。 孩子们围着死者跳舞。 一个可怜而喃喃自语的男人在尸体周围走来走去，从每具尸体的口袋里掏钱。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "战争的冲突遇上了农民的疯狂。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.World.Assets.addMoralReputation(-1);
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_43.png[/img]你决定置身事外。 这不是你的战斗，卷入其中只会让事情变得更复杂。 站在后面，你看着人群向士兵们挤过来。 在混乱的喧闹声中传来一阵扭打声，刺耳的声音盖过了嘈杂的声音，是那些还没有做好面对疯狂农民的士兵发出的扭曲尖叫。 但一名士兵从人群中挤出去，把农民从腿上踢下来，并用匕首刺穿了一个农民的眼睛。 他设法向附近的一匹马冲刺，骑上马，鞭策它冲刺。 那个人经过时，眼睛盯着 %companyname%的旗帜。 你不禁会想，%noblehouse% 可能会在这一天听到你保持中立的消息…",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我肯定他什么也不会说。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "拒绝帮助他们的人");
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 2)
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

