this.greenskins_trapped_goblin_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_trapped_goblin";
		this.m.Title = "在途中…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]战队穿过一片灌木丛，进入一片空地，在那里他们发现了一个蹲着的哥布林。 它转向人群，呼吸困难，眼神忧郁。 你看到一个巨大的捕熊器紧紧地夹住它的大腿下部。 绿皮试图咆哮，但只咳出一些血。\n\n 在奄奄一息的哥布林旁边，一个人脸朝下倒在草地上。 他的屁股上有个亮闪闪的东西，但你不知道那是什么。%randombrother% 来到你身边。%SPEECH_ON%可能是个陷阱。 陷阱中的陷阱。 他的其他伙伴可能离这里不远。 然后，如果我们离开，他一旦得到自由，会告诉每个人我们在这里。 我们应该怎么做？%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "杀死它。",
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
					Text = "别管它。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 70)
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
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]不管怎样，哥布林是不能活下去的。 你走进空地，想把它从痛苦中解脱出来，也想看看尸体里藏着什么宝物。 绿皮一看到你就收缩起来，咆哮着爬起来，它把依附的锁链弄松动了。%randombrother% 手持武器，小心地接近野兽，然后一击杀死它。\n\n 威胁解除后，你把死人的尸体翻过来，把所有有价值的东西带走。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "一只哥布林不足为虑。 ",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item;
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/named/named_dagger");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/rondel_dagger");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/dagger");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/knife");
				}
				else if (r == 5)
				{
					item = this.new("scripts/items/loot/golden_chalice_item");
				}
				else if (r == 6)
				{
					item = this.new("scripts/items/loot/silver_bowl_item");
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_69.png[/img]这是一场你死我活的战争，没有一个绿皮可以活着。 你走到田野里，杀死这个肮脏的东西。 在此基础上，你滚动死者的尸体，并抢夺所有值得拿走的东西。 正当你准备离开的时候，一声咕噜作响的咆哮声从树林中传来。%randombrother% 拿出武器并伸出手指。%SPEECH_ON%食尸鬼！%SPEECH_OFF%该死！他们一定是闻到了快死的妖精的味道，才来享用的。 他们中的一些人已经在用兽人的骨头剔牙了…",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "比预想的要麻烦了…",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Ghouls, this.Math.rand(70, 90), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item;
				local r = this.Math.rand(1, 6);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/named/named_dagger");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/rondel_dagger");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/dagger");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/knife");
				}
				else if (r == 5)
				{
					item = this.new("scripts/items/loot/golden_chalice_item");
				}
				else if (r == 6)
				{
					item = this.new("scripts/items/loot/silver_bowl_item");
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_25.png[/img]你不会为了一个微不足道的哥布林和一个或有或无任何值钱东西的死人而拿整个战队去冒险的。 战队离开了一片空地的距离，继续穿过森林，没有遇到任何麻烦。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "最好保持战队良好的状态，来应对更大的威胁。",
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
			ID = "E",
			Text = "[img]gfx/ui/events/event_48.png[/img]你不会为了一个微不足道的哥布林和一个或有或无任何值钱东西的死人而拿整个战队去冒险的。 战队离开了一片空地的距离，继续穿过森林。\n\n 走了不到五分钟，你就听到从后面传来隆隆的脚步声。 声音够大，够有力，不管是谁干的，都不怕被人听见。 你低头等待，兽人和哥布林毫无意外地从树林中穿过。 其中一个是你留在捕熊器里的那个杂种，他的腿匆匆裹上了亚麻和树叶。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "该死，那个小杂种发现我们了！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.GoblinsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.EnemyBanners = [
							"banner_goblins_03"
						];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.GreenskinHorde, this.Math.rand(70, 90), this.Const.Faction.Enemy);
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
		if (!this.World.FactionManager.isGreenskinInvasion())
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
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 5)
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

