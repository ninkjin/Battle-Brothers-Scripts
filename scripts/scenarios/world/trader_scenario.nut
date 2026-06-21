this.trader_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.trader";
		this.m.Name = "贸易商队";
		this.m.Description = "[p=c][img]gfx/ui/events/event_41.png[/img][/p][p]你经营着一支小型贸易商队，你将大部分克朗都投资进了贸易商品。但是道路已经变得很危险了，强盗和绿皮埋伏着，并且有谣言说还有更糟的东西出没。\n\n[color=#bcad8c]商队：[/color]以两名你雇佣的商队帮工开始游戏。\n[color=#bcad8c]交易员：[/color]买卖时得到10%更有利的价格。\n[color=#bcad8c]不是战士：[/color]没有初始声望，并且之后获得声望的速度只有正常的66%。[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 19;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 2; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
			bro.worsenMood(0.5, "遇到了另一个被绿皮屠杀的商队");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"caravan_hand_background"
		]);
		bros[0].getBackground().m.RawDescription = "临时工，石匠，磨坊工，%name%都干过来了，不断的更换工作却毫不犹豫一下将其中某个当做真正的职业。你也不确定他是否愿意长期当一名商队帮工，但当被要求从事佣兵工作时，他一样毫不犹豫的同意了…";
		bros[0].setPlaceInFormation(3);
		bros[0].m.Talents = [];
		local talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Fatigue] = 1;
		bros[1].setStartValuesEx([
			"caravan_hand_background"
		]);
		bros[1].getBackground().m.RawDescription = "你遇到%name%时，他正被扔出一家酒吧，乍一看只不过是个醉酒的恶棍。但你看到他击退了三个抢劫未遂者。当然，他们最终成功地夺走了他的靴子，但他们无法真正打败他的精神。你被打动，带走他作为一名商队帮工。";
		bros[1].setPlaceInFormation(4);
		bros[1].m.Talents = [];
		local talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 2;
		talents[this.Const.Attributes.MeleeDefense] = 1;
		talents[this.Const.Attributes.Hitpoints] = 1;
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/scimitar"));
		this.World.Assets.m.BusinessReputation = 0;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/bread_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/mead_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/wine_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/amber_shards_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/cloth_rolls_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/dies_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/furs_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/trade/salt_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2 + 400;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3)
			{
				break;
			}
		}

		local randomVillageTile = randomVillage.getTile();
		local navSettings = this.World.getNavigator().createSettings();
		navSettings.ActionPointCosts = this.Const.World.TerrainTypeNavCost_Flat;

		do
		{
			local x = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.X - 8), this.Math.min(this.Const.World.Settings.SizeX - 2, randomVillageTile.SquareCoords.X + 8));
			local y = this.Math.rand(this.Math.max(2, randomVillageTile.SquareCoords.Y - 8), this.Math.min(this.Const.World.Settings.SizeY - 2, randomVillageTile.SquareCoords.Y + 8));

			if (!this.World.isValidTileSquare(x, y))
			{
			}
			else
			{
				local tile = this.World.getTileSquare(x, y);

				if (tile.IsOccupied)
				{
				}
				else if (tile.getDistanceTo(randomVillageTile) <= 5)
				{
				}
				else if (!tile.HasRoad)
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
		this.World.Assets.updateLook(9);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.trader_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.World.Assets.m.BusinessReputationRate = 0.66;
		this.World.Assets.m.BuyPriceMult = 0.9;
		this.World.Assets.m.SellPriceMult = 1.1;
	}

});

