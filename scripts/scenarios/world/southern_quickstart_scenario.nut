this.southern_quickstart_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.southern_quickstart";
		this.m.Name = "南方雇佣兵";
		this.m.Description = "[p=c][img]gfx/ui/events/event_156.png[/img][/p][p]多年来，你和你那一小队雇佣兵一直为小商贩做些肮脏的勾当，但你还是比起强盗好不了多少。你想要的远比这多，你想要一切。而金铎会指引你的道路。\n\n[color=#bcad8c]快速开始进入世界南部，没有任何特殊的优势或劣势。[/color][/p]";
		this.m.Difficulty = 1;
		this.m.Order = 11;
	}

	function isValid()
	{
		return this.Const.DLC.Desert;
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
			bro.improveMood(1.5, "加入了一个佣兵团");

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.SouthernNames[this.Math.rand(0, this.Const.Strings.SouthernNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"companion_1h_southern_background"
		]);
		bros[0].getBackground().m.RawDescription = "{%name%曾是一个维齐尔的精英先锋。在一场激烈的战斗中，他的整个军团被歼灭，而他自己则被埋在他们的尸体下面。他被遗弃在了沙漠之中，直到今天他都不愿告诉你他靠什么手段幸存了下来。但他对你忠贞不渝，这比任何战争故事都重要。}";
		bros[0].setPlaceInFormation(3);
		bros[1].setStartValuesEx([
			"companion_2h_southern_background"
		]);
		bros[1].getBackground().m.RawDescription = "{如果忠诚是金子，%name%可能是金铎目光所及之下最富有的人。你发现这个人在巷子里被伏击了，帮助他击退了盗贼，他向你宣誓效忠一年。而自那之后已经过了许多年。尽管%name%遇到你时就被揍了一顿，当他没有被伏击时他是一名强大的斗士。}";
		bros[1].setPlaceInFormation(4);
		bros[2].setStartValuesEx([
			"companion_ranged_southern_background"
		]);
		bros[2].getBackground().m.RawDescription = "{你不完全清楚%name%的过去，只知道他的道路没有人们希望的那样闪耀。他说他干过许多行当，但是军队不要他，城市警卫不要他，女人们当然也不要他，所以他选择了当一名逐币者。他认为一个光荣而迅速的死亡会把他带到镀金者的目光中，这样他就可以问问他为什么要让他的人生如此残酷。当他不自怨自艾的时候，%name%可以是欢快和有趣的。只要记得让他远离酒和牧师。}";
		bros[2].setPlaceInFormation(5);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 400;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isIsolatedFromRoads() && randomVillage.isSouthern())
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
		this.World.Assets.updateLook(13);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.southern_quickstart_scenario_intro");
		}, null);
	}

});

