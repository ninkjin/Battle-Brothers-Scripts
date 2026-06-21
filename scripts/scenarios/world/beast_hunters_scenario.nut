this.beast_hunters_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.beast_hunters";
		this.m.Name = "野兽杀手";
		this.m.Description = "[p=c][img]gfx/ui/events/event_122.png[/img][/p][p]你和你的手下依靠狩猎威胁文明边缘的村庄的众多野兽为生。这是一项危险的工作，但报酬足够高，而且总会有更大的野兽的可杀，更多的克朗可赚。\n\n[color=#bcad8c]野兽杀手：[/color]以三名有体面装备的野兽杀手开始游戏，外带一些野兽战利品。\n[color=#bcad8c]专家追踪者：[/color]能看到更远处的足迹。\n[color=#bcad8c]专家剥皮者：[/color]你杀死的每只野兽都有50%概率额外掉落一件战利品。\n[color=#bcad8c]偏见：[/color]大多数人不相信你这类人，所以交易价格变差10%。[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 90;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Unhold;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 3; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.improveMood(1.0, "杀死了一个危险的女巫");
			bro.worsenMood(2.5, "遭到背叛失去了大部分战团同伴");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"beast_hunter_background"
		]);
		bros[0].getBackground().m.RawDescription = "在那场摧毁了你的野兽杀手团的强盗伏击中，%name%救了你。他没有拿这样事压你，因为你曾救过他很多次。这个人缺少感情，这让他在这个世界上过的不太好，但是单这一点也足够让他成为一名出色的野兽杀手。";
		bros[0].setPlaceInFormation(3);
		bros[0].addLightInjury();
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/boar_spear"));
		items.equip(this.new("scripts/items/tools/throwing_net"));
		bros[1].setStartValuesEx([
			"beast_hunter_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name%是一个来自城市的年轻小伙子，用他的话说，他靠着铲除‘杀手兔’的巢穴入了野兽杀手这行。你不确定这说法的真实性，但不管怎样，他在战场上证明自己的次数已经多得你都数不清了。";
		bros[1].setPlaceInFormation(4);
		bros[1].addLightInjury();
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.Bravery] = 1;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/spetum"));
		bros[2].setStartValuesEx([
			"beast_hunter_background"
		]);
		bros[2].getBackground().m.RawDescription = "在野兽杀手这行里，头发花白的老手很少见，而%name%当然不是之中之一。相反，他是一个聪明的文化人，他通过阅读书籍而不是练剑开始了对怪物狩猎的探索。他的内心足够战士，然而是他的学习和准备在战斗中带给了真正的优势。";
		bros[2].setPlaceInFormation(5);
		bros[2].addInjury(this.Const.Injury.Brawl);
		bros[2].m.Talents = [];
		local talents = bros[2].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.RangedSkill] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Ammo));
		items.equip(this.new("scripts/items/weapons/hunting_bow"));
		items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
		items.equip(this.new("scripts/items/accessory/wardog_item"));

		foreach( bro in bros )
		{
			bro.m.PerkPoints = 1;
			bro.m.LevelUps = 1;
			bro.m.Level = 2;
		}

		this.World.Assets.m.BusinessReputation = 200;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/witch_hair_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/werewolf_pelt_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/werewolf_pelt_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/accessory/night_vision_elixir_item"));
		this.World.Assets.m.Money = this.Math.round(this.World.Assets.m.Money * 0.75);
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() <= 1)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 3), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 3));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 3), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 3));

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
		this.World.Assets.updateLook(11);
		this.World.spawnLocation("scripts/entity/world/locations/battlefield_location", randomVillageTile.Coords).setSize(1);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.CivilianTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.beast_hunters_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.World.Assets.m.BuyPriceMult = 1.1;
		this.World.Assets.m.SellPriceMult = 0.9;
		this.World.Assets.m.ExtraLootChance = 50;
		this.World.Assets.m.FootprintVision = 1.5;
	}

});

