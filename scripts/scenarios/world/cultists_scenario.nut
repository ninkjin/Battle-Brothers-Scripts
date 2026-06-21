this.cultists_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.cultists";
		this.m.Name = "达库尔邪教徒";
		this.m.Description = "[p=c][img]gfx/ui/events/event_140.png[/img][/p][p]达库尔在等候着。你带领着一小群人献身于这名古老神明，现在是时候传道了。找到更多的追随者，获取财富，并以献祭取悦达库尔。\n\n[color=#bcad8c]邪教徒：[/color]以四名装备简陋的邪教徒开始游戏。更多邪教徒可能会自愿聚集到你身边。\n[color=#bcad8c]献祭：[/color]达库尔偶尔会要求你进行献祭，但也会对那些忠于他的人给予恩惠。[/p]";
		this.m.Difficulty = 2;
		this.m.Order = 80;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 4; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.getSkills().add(this.new("scripts/skills/traits/cultist_fanatic_trait"));

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"cultist_background"
		]);
		bros[0].getBackground().m.RawDescription = "当%name%加入时，他热情地称你为团长，声称‘这是从探索我等所向之黑暗之路的正确方式’。";
		bros[0].setPlaceInFormation(2);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.equip(this.new("scripts/items/weapons/scramasax"));
		items.equip(this.new("scripts/items/helmets/cultist_hood"));
		items.equip(this.new("scripts/items/armor/leather_wraps"));
		bros[1].setStartValuesEx([
			"cultist_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name%在路上发现了你。他声称他知道你是雇佣兵团长。你当时穿的是普通的衣服，但他说，以达库尔的黑暗之名，你身上有一种明显的黑色气息。";
		bros[1].setPlaceInFormation(3);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
		items.equip(this.new("scripts/items/armor/cultist_leather_robe"));
		items.equip(this.new("scripts/items/helmets/hood"));
		bros[2].setStartValuesEx([
			"cultist_background"
		]);
		bros[2].getBackground().m.RawDescription = "%name%是一个安静的人，他的指纹下有阴影，像苍白海岸下的盐水一样流动。当他和你握手时，你仿佛能听到你理智在发出嘶嘶声。";
		bros[2].setPlaceInFormation(4);
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.equip(this.new("scripts/items/weapons/battle_whip"));
		items.equip(this.new("scripts/items/helmets/cultist_leather_hood"));
		bros[3].setStartValuesEx([
			"cultist_background"
		]);
		bros[3].getBackground().m.RawDescription = "%name%在一家酒馆外与你结伴。你第一次见到他的时候，他手臂上有一道横贯血管的伤疤，这意味着他不应该还活着。但每天早晨，他的伤疤似乎都移动了，慢慢的爬向一个地方：他的额头。";
		bros[3].setPlaceInFormation(5);
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Body));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		items.equip(this.new("scripts/items/helmets/cultist_hood"));
		items.equip(this.new("scripts/items/armor/leather_wraps"));
		this.World.Assets.addMoralReputation(-10);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 400;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() == 1)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 4), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 4));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 4), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 4));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore || tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 1)
				{
				}
				else if (tile.Type != this.Const.World.TerrainType.Plains && tile.Type != this.Const.World.TerrainType.Steppe && tile.Type != this.Const.World.TerrainType.Tundra && tile.Type != this.Const.World.TerrainType.Snow)
				{
				}
				else
				{
					local path = this.World.getNavigator().findPath(tile, randomVillageTile, navSettings, 0);

					if (!path.isEmpty())
					{
						randomVillageTile = tile;
						break;
					}
				}
			}
		}
		while (1);

		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(7);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.cultists_scenario_intro");
		}, null);
	}

	function onUpdateDraftList( _list )
	{
		if (_list.len() >= 10)
		{
			_list.push("cultist_background");
		}
	}

});

