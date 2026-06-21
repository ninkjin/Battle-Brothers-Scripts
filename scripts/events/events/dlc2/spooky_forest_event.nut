this.spooky_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Brave = null,
		Lumberjack = null
	},
	function create()
	{
		this.m.ID = "event.spooky_forest";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]在森林中扎营时，%randombrother%叫你从指挥帐篷里出来。你问他想做什么，他用手指捂住嘴示意安静。他指了指一棵通向深夜黑暗的高大树木。你听到有东西像是在用整个树枝筑成一个巢，发出劈啪声响。只听到这个声音暂停了一下，然后就会发出喉咙里咕哝、嘻笑不停的嘶啦声，就像一只鸟在蛇的肚子里求救一样。当你把视线落回来时，士兵们正在盯着你看，希望你有关于这件事的一个主意。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是一些动物。回去做你的工作吧。",
					function getResult( _event )
					{
						return "WalkOff";
					}

				},
				{
					Text = "安全总比粗心大意好。 我们要砍倒这棵树。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "CutdownGood";
						}
						else
						{
							return "CutdownBad";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Lumberjack != null)
				{
					this.Options.push({
						Text = "%lumberjack%，你很清楚如何砍伐树木。 去做吧。",
						function getResult( _event )
						{
							return "Lumberjack";
						}

					});
				}

				if (_event.m.Brave != null)
				{
					this.Options.push({
						Text = "%bravebro%，你是这群人中最勇敢的。 去看看这是怎么回事。",
						function getResult( _event )
						{
							return "Brave";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Lumberjack",
			Text = "[img]gfx/ui/events/event_25.png[/img]你让伐木工人%lumberjack%砍树。他点了点头，使用了各种可用的工具，不全是斧子。他把树木从一侧裂开，在缝隙中塞入武器柄，然后去另一侧砍树干。他的速度让你感到惊叹，这种真诚很少在生活中见到。一个人把家安在他的事业上，目光注视着一个无可争议的未来，他的双手像是为此而生。%SPEECH_ON%啊哟！%SPEECH_OFF%他喊着，树木倒下。它裂开并倒在林中，长长的树干掉进金属丝网篱笆中，猛烈地撞击着地面，似乎使整个地球颤动。你拔出剑，去调查被砍伐的树顶。你发现两个纳克泽尔被砍扁在那里，牙齿像没有帽子的蘑菇一样散落在森林地面上。这场凄惨的景象让你的战团感到恐惧。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "所以谜团就解开了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Lumberjack.getImagePath());
				local item = this.new("scripts/items/misc/ghoul_teeth_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Brave",
			Text = "[img]gfx/ui/events/event_25.png[/img]%bravebro%，这个勇气无畏的雇佣兵，迅速攀上树上，毫不畏惧。他的速度如此之快，仿佛看到了一个美丽的姑娘。很快便不见了他的身影。只听到他爬的声响，刺刺的，仿佛在扒树皮。过了一会儿，你听到了他的回声，他的下降声音时进时停，因为他在寻找安全的脚跟。你看到他重新出现在视野中，先是一双鞋子的脚底，就像悬挂在黑暗中的黄油托盘一样。他的影子随即滑下来，直到最后一个跳跃落在地上。他有意屈膝，并倚靠树干，双手疲惫地垂在膝盖上。%SPEECH_ON%在树洞中，我发现了一只黑熊，但那只野兽已经死了至少两天。当我靠近时，我看到一群蝙蝠飞出树洞，它们可能在吃它的内脏。这把刀从它们的逃离中脱落了。%SPEECH_OFF%他转身在地上扔了一把剑，上面沾满了粘稠的蜜糖和松针，但在其他方面看起来是一把不错的武器。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看那把刀。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brave.getImagePath());
				local item = this.new("scripts/items/weapons/arming_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "CutdownGood",
			Text = "[img]gfx/ui/events/event_25.png[/img]你命令战团砍倒这棵树。他们开始进行任务，但没有太多的经验，在树干朝着意料之外的方向倾倒时，结果是一场疯狂的逃命。一只非常害怕的黑熊从树顶上蹦出来。它的鼻子里还嵌着一个蜂巢，它呼哧呼哧地逃进森林的黑暗中。\n\n没有人被压伤，但混乱和残骸让一些人遭受了更多的伤害。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，这是一项值得努力的工作…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.swift") || bro.getSkills().hasSkill("trait.sure_footed") || bro.getSkills().hasSkill("trait.lucky") || bro.getSkills().hasSkill("trait.quick"))
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 20)
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
			ID = "CutdownBad",
			Text = "[img]gfx/ui/events/event_25.png[/img]你命令士兵砍倒树木。%randombrother% 用力劈了一下，一只脚放在树干上，拧动工具，但就在这个时候，他像被弹出去一样飞了出去。一根树枝随着树干发出一声长长的嘎吱声，仿佛一些古老的木头正在被砍伐。你看着木头从土壤中松动并拔起。翠绿色的眼睛猛然睁开，追逐着落叶的旋转。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真见鬼！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.Entities = [];
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Schrats, this.Math.rand(90, 110), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
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
			ID = "WalkOff",
			Text = "[img]gfx/ui/events/event_25.png[/img]你不必为这种小事烦恼。可能只是一只山猫或老鹰什么的。如果情况更严重，众人将一起应对。有些人对这种想法并不满意。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是一些动物…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.worsenMood(0.5, "担心你没有对可能的威胁采取行动");

						if (bro.getMoodState() <= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 15)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_lumberjack = [];
		local candidates_brave = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.lumberjack")
			{
				candidates_lumberjack.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.brave") || bro.getSkills().hasSkill("trait.fearless"))
			{
				candidates_brave.push(bro);
			}
		}

		if (candidates_lumberjack.len() != 0)
		{
			this.m.Lumberjack = candidates_lumberjack[this.Math.rand(0, candidates_lumberjack.len() - 1)];
		}

		if (candidates_brave.len() != 0)
		{
			this.m.Brave = candidates_brave[this.Math.rand(0, candidates_brave.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"lumberjack",
			this.m.Lumberjack ? this.m.Lumberjack.getNameOnly() : ""
		]);
		_vars.push([
			"bravebro",
			this.m.Brave ? this.m.Brave.getNameOnly() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Lumberjack = null;
		this.m.Brave = null;
	}

});

