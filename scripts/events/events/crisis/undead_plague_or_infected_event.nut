this.undead_plague_or_infected_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.undead_plague_or_infected";
		this.m.Title = "在路上…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_59.png[/img]你偶然遇到一群坐在路边的农民。 男人，女人，孩子。衣服很脏，靴子满是泥泞，皮肤都溃烂了。 有些人带着像是咬痕的伤口。 队伍的长者说。%SPEECH_ON%拜托了，先生，你有吃的或水能给我们吗？%SPEECH_OFF%他似乎看到你在盯着脓疱和咬痕。他摇了摇头。%SPEECH_ON%噢，别介意那些。 仅仅是的猎狐出了点问题。 我们只需要一点点帮助，然后我们就可以自己走了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我可以匀出一点食物。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
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
					Text = "这不是我们的问题。",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "留着你们只会壮大亡灵队伍。 最好现在就解决你们。",
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
			Text = "[img]gfx/ui/events/event_59.png[/img]你命令手下善待他们－通过把他们全部杀掉。 长者带着妇女和小孩离开，一边男人们从地上站了起来。 其中一个，摇晃着泛着碧绿色开始蜕皮的腿，指着你。%SPEECH_ON%你这混蛋可真是个大善人啊。 我真希望我会复活成亡灵。 这样我的尸体就能杀死你们这些该死的野蛮人。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那我就杀你们两次好了。",
					function getResult( _event )
					{
						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
						}

						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.PeasantsArmed, this.Math.rand(50, 100), this.Const.Faction.Enemy);
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
			Text = "[img]gfx/ui/events/event_59.png[/img]你让 %randombrother% 分发一些食物和用品。 长者一边感谢一边说，无论他走到哪里，他都会高度赞扬 %companyname%。 有几个人因为你没有做过分的事，似乎松了一口气。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是做了力所能及的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(3);
				local food = this.World.Assets.getFoodItems();

				for( local i = 0; i < 2; i = ++i )
				{
					local idx = this.Math.rand(0, food.len() - 1);
					local item = food[idx];
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你失去了 " + item.getName()
					});
					this.World.Assets.getStash().remove(item);
					food.remove(idx);
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_29.png[/img]你让 %randombrother% 分发一些食物和用品。 长者一边感谢一边说，无论他走到哪里，他都会高度赞扬 %companyname%。 拿着一块面包，你蹲在一个父亲抱着的生病的孩子旁边。 但是当你递出一片面包的时候，这个孩子却抬起头来，咬住了他父亲的脖子。 任何一个只要还够健康能站起来的农民都跑了。 剩下的...剩下的摇摇晃晃地站起来，脸色苍白，下巴松弛，眼睛因狂乱的饥饿而发红。 你赶快命令雇佣兵们组成阵型。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好心没好报。",
					function getResult( _event )
					{
						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
						}

						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Center;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Peasants, this.Math.rand(10, 30), this.Const.Faction.PlayerAnimals);
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.ZombiesLight, this.Math.rand(60, 90), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
						this.World.State.startScriptedCombat(properties, false, false, true);
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
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local food = this.World.Assets.getFoodItems();

		if (food.len() < 3)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			local d = currentTile.getDistanceTo(t.getTile());

			if (d <= 4)
			{
				return;
			}
		}

		this.m.Score = 10;
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

