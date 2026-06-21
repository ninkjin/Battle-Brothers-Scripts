this.man_in_forest_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.man_in_forest";
		this.m.Title = "在途中…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_76.png[/img]当你们在在树间跋涉时，一个男人突然从一个灌木丛中出现。 树枝和杂草和他那被汗水浸透的头发纠缠在一起。 他一见到你就突然紧张了起来。%SPEECH_ON%拜托，别再这样了。%SPEECH_OFF%你举手让他冷静下来然后问他发生了什么事。 这个陌生人退了一步。%SPEECH_ON%拜托，别再这样了！%SPEECH_OFF%他转身就跑，一路跌跌撞撞地往他来时的路跑。%randombrother% 急匆匆地来到你身边。%SPEECH_ON%我们应该跟着他吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "跟上他，快点！",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 45)
						{
							return "B";
						}
						else if (r <= 90)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "他不关我们的事。让他走。",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_50.png[/img]你跟着那个人走进灌木丛。 在泥泞的地面上那个人的踪迹非常容易寻找，他慌张的逃跑给团队留下了很多指引。 但突然，它们消失了。 跟着足迹团队来到了一片空地，然后足迹和线索就全部消失了好像那人凭空不见了。 你听到上面传来哨声。 抬头看，你看见那个男人正坐在一根树枝上。他挥了挥手。%SPEECH_ON%你好，陌生人。%SPEECH_OFF%他瞥了一眼空地。 装备精良的人们正在不断的靠近。 那人在树上不屑的哼了一声。%SPEECH_ON%再见，陌生人。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BanditTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.BanditDefenders, this.Math.rand(90, 110) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_25.png[/img]他的足迹表明他很慌乱这股恐惧迫使他从你的视线中逃离。 像他这样恐慌的人并不难找，不幸的是，他不能再害怕了，因为你找到了一堆被肢解的很彻底的尸块是刚才那家伙的。\n\n一声低沉的咆哮震动了附近的灌木丛。 你看过去，看到那野兽从树后慢慢地走出来。 你对他们大喊让他们武装起来。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Direwolves, this.Math.rand(90, 110) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_25.png[/img]这个受惊的人不难找到。 你看到他蜷缩在树下。 他胸口怀抱着一样东西那姿势就像守护他在寒冷冬夜里唯一可以取暖的东西。 这个男人，不知道因为上面缘故，已经死去了。 你从他已经僵硬的手中撬出了那东西。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是什么？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/named/named_dagger");
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.SnowyForest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

