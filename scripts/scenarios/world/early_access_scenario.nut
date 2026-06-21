this.early_access_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.early_access";
		this.m.Name = "新战团";
		this.m.Description = "[p=c][img]gfx/ui/events/event_80.png[/img][/p][p]多年来，你以微薄的报酬做着刀口舔血的工作，终于攒下足够的克朗去组建一支你自己的雇佣兵战团。追随你的是三个经验丰富的佣兵，你以前曾与他们并肩战斗过。\n\n[color=#bcad8c]快速开始进入世界，没有任何特殊的优势或劣势。[/color][/p]";
		this.m.Difficulty = 1;
		this.m.Order = 10;
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
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"companion_1h_background"
		]);
		bros[0].getBackground().m.RawDescription = "{你在一场与强盗的战斗中救了%name%的命，而他之后在一场盗贼的小巷埋伏中报了恩。考虑到寻常罪犯比强盗档次要低，你经常和他开玩笑说，他在‘互相擦屁股’的债务上还有些落后。}";
		bros[0].setPlaceInFormation(3);
		bros[1].setStartValuesEx([
			"companion_2h_background"
		]);
		bros[1].getBackground().m.RawDescription = "{不管%name%有什么毛病，你都希望他永远别改。一个特别热爱打架、嫖娼、赌博、唱歌、斗狗、把妹、古怪地洗盘子、呕吐，当然还有喝酒的家伙，他一直是一个不可或缺的活宝。而他恰巧也成为了一名优秀的战士。}";
		bros[1].setPlaceInFormation(4);
		bros[2].setStartValuesEx([
			"companion_ranged_background"
		]);
		bros[2].getBackground().m.RawDescription = "在他加入战团之前，你曾多次与%name%有所交集。第一次你们都是普通劳工。第二次你们都是佣兵。现在是第三次了，他加入了你的战团。如果一切顺利的话，他这次会留下来，你们两个都会找到你们想要的财富。";
		bros[2].setPlaceInFormation(5);
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.m.Money = this.World.Assets.m.Money + 400;
	}

	function onSpawnPlayer()
	{
		local randomVillage;

		for( local i = 0; i != this.World.EntityManager.getSettlements().len(); i = ++i )
		{
			randomVillage = this.World.EntityManager.getSettlements()[i];

			if (!randomVillage.isMilitary() && !randomVillage.isIsolatedFromRoads() && randomVillage.getSize() >= 3 && !randomVillage.isSouthern())
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
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList(this.Const.Music.IntroTracks, this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.early_access_scenario_intro");
		}, null);
	}

});

