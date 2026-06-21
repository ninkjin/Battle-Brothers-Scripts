this.treant_vs_giants_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.treant_vs_giants";
		this.m.Title = "在途中…";
		this.m.Cooldown = 150.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_107.png[/img]{%randombrother%在森林地面上一个坑中扭曲着小腿，愤怒地诅咒着。%SPEECH_ON%我该死的，就好像我的狗不够吵闹一样！%SPEECH_OFF%你转过身去告诉他安静点，突然你看到一个不死族乱爬上了战团刚刚攀登的小山坡。而你们都奋力攀爬，这个巨人却向上跳跃和抓住倾斜的斜坡，在其身后留下小的山崩。你还没来得及大声喊出来，一颗巨大的树从仍未移动的树冠群中掉下来，把巨人绞断了。一颗口水球呼啸着穿过森林，打破着树枝和灌木，巨人砸到了森林地面上，即使在这个距离下，也能感觉到地面在颤抖。你看到更多的不死族巨人出现了，更多的树魔鬼（schrats）脱离了森林中的伪装，准备与他们战斗。这是一场树魔鬼对抗不死族的大乱斗！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "准备攻击。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "让我们离开这个鬼地方吧。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_107.png[/img]{你蹲下身子，下令士兵快步前行。他们像蚂蚁一样快速通过，头上的树叶和毛发碎片四散而下，巨人战斗的力量像闪电般砸在你耳边。但你设法离开那里，远离了怪物的战争。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "死里逃生。",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_107.png[/img]{你抽出了剑，但%randombrother%却把他的手搭在你的肩膀上。%SPEECH_ON%真的需要这样，队长吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是的，真的。",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Random;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.UnholdBog, 100, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Schrats, 100, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Bandits).getID());
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				},
				{
					Text = "再想一想，不对。",
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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().Days < 20)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 25)
			{
				return false;
			}
		}

		this.m.Score = 5;
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

