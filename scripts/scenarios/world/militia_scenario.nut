this.militia_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.militia";
		this.m.Name = "平民民兵";
		this.m.Description = "[p=c][img]gfx/ui/events/event_141.png[/img][/p][p]它最初是由勇敢或绝望的人自愿组成的一支破破烂烂的保卫自己家园的民兵队伍，但现在已经成长为一支小型军队。一支每天都需要补给的军队。也许民兵的服务可以租出去？\n\n[color=#bcad8c]平民军队：[/color]以12个装备低劣的平民开始游戏。\n[color=#bcad8c]人海[/color]：一次最多可带16人参加战斗，名册中最多可有25人。\n[color=#bcad8c]肮脏平民[/color]: 永远不能雇佣任何不是低出生平民的人。[/p]";
		this.m.Difficulty = 1;
		this.m.Order = 20;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 12; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.worsenMood(1.5, "在战斗中失去了许多朋友");
			bro.improveMood(0.5, "是民兵的一部分");
			bro.m.HireTime = this.Time.getVirtualTimeF();

			while (names.find(bro.getNameOnly()) != null)
			{
				bro.setName(this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]);
			}

			names.push(bro.getNameOnly());
		}

		local bros = roster.getAll();
		bros[0].setStartValuesEx([
			"farmhand_background"
		]);
		bros[0].getBackground().m.RawDescription = "%name%是一个农夫的儿子，大概希望在某个时候成为自己儿子的父亲。目前，他和你在一起，这是梦想和现实之间令人遗憾的冲突。";
		bros[0].improveMood(3.0, "最近坠入了爱河");
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/pitchfork"));
		bros[1].setStartValuesEx([
			"farmhand_background"
		]);
		bros[1].getBackground().m.RawDescription = "%name%曾拥有一个农庄，这个农庄早就被无数过往的军队踏平了，包括他曾经为之战斗过的军队。他对你的‘效忠’可以说是肚子空空的结果。";
		bros[1].worsenMood(0.5, "卷入了一场斗殴");
		bros[1].addLightInjury();
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/warfork"));
		bros[2].setStartValuesEx([
			"poacher_background"
		]);
		bros[2].getBackground().m.RawDescription = "有一个普遍的玩笑说%name%实际上是隐藏起来的贵族，但据你所知他只单纯是个偷猎者。世界的磨难将他带至了此时此处，除了你希望他能重新站起来之外，别无他言。";
		bros[2].worsenMood(0.5, "卷入了一场斗殴");
		bros[2].addLightInjury();
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/staff_sling"));
		bros[3].setStartValuesEx([
			"vagabond_background",
			"thief_background",
			"gambler_background"
		]);
		bros[3].getBackground().m.RawDescription = "你注意到%name%对某些特定贵族有些躲闪。似乎他是一个小偷小摸但还逍遥法外的寻常罪犯，但只要他打得好，对你来说就没什么大不了的。";
		bros[3].improveMood(1.5, "偷了别人的劈刀");
		items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/scramasax"));
		bros[4].setStartValuesEx([
			"daytaler_background"
		]);
		bros[4].getBackground().m.RawDescription = "作为一个临时工和普通劳工，%name%宁愿加入你的队伍也不愿再浪费体力去为贵族建造漂亮的新门厅。";
		bros[4].worsenMood(0.5, "卷入了一场斗殴");
		bros[4].addLightInjury();
		bros[5].setStartValuesEx([
			"miller_background"
		]);
		bros[5].getBackground().m.RawDescription = "为了寻求财富，%name%在你新成立的佣兵团中找到了正确的位置。不幸的是，他的背景是种地、推磨、铺石头，而且他还都不擅长。";
		bros[5].improveMood(1.0, "期待成为一个富有的佣兵");
		local items = bros[5].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/pitchfork"));
		bros[6].setStartValuesEx([
			"fisherman_background"
		]);
		bros[6].getBackground().m.RawDescription = "%name%说他来内陆之前是个水手，后来加入了民兵，现在又加入了你的佣兵团。他希望最终拥有一艘船，并扬起它的帆驶向大洋。你真心的希望有一天他能做到。";
		bros[6].worsenMood(0.25, "最近觉得有点不舒服");
		bros[7].setStartValuesEx([
			"militia_background"
		]);
		bros[7].getBackground().m.RawDescription = "%name%显然已经加入过许多民兵，它们全部最终都因为这样或那样的原因解散了。由于在其中任何一个都没赚到啥钱，所以他希望通过当个全新的佣兵来改变这种状况。";
		bros[7].improveMood(3.0, "最近成了父亲");
		bros[7].m.PerkPoints = 0;
		bros[7].m.LevelUps = 0;
		bros[7].m.Level = 1;
		bros[8].setStartValuesEx([
			"minstrel_background"
		]);
		bros[8].getBackground().m.RawDescription = "作为一个真正的小伙子，%name%喜欢在酒吧里纵情款待女士，在教堂里把把妹。你感觉到他只是为了把他的‘乐趣’传播到全世界。";
		local items = bros[8].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/lute"));
		bros[9].setStartValuesEx([
			"daytaler_background"
		]);
		bros[9].getBackground().m.RawDescription = "临时工，劳工，商队帮工，水手，民兵，%name%都做过一点。希望他对这雇佣兵工作的新尝试能持续下去。";
		bros[9].worsenMood(1.0, "被偷走了他信赖的劈刀");
		bros[10].setStartValuesEx([
			"militia_background"
		]);
		bros[10].getBackground().m.RawDescription = "和你一样，%name%厌倦了民兵被过度用于解决毫无准备的贵族们的危机。他可以说在向雇佣兵工作转变中最热切的那个。";
		bros[10].worsenMood(0.5, "不喜欢民兵中的一些人卷入了一场斗殴");
		bros[10].m.PerkPoints = 0;
		bros[10].m.LevelUps = 0;
		bros[10].m.Level = 1;
		bros[11].setStartValuesEx([
			"butcher_background",
			"tailor_background",
			"shepherd_background"
		]);
		bros[11].getBackground().m.RawDescription = "%name%很明确的是在逃避他的妻子。你遇到她一次后就完全同意了他的逃跑计划，这不仅仅是因为这样你能在前线多放一个人。那婆娘是真他娘疯狂。";
		bros[11].improveMood(1.0, "设法摆脱了他的妻子");
		this.World.Assets.m.BusinessReputation = -100;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/ground_grains_item"));
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);
		this.World.Assets.m.Money = this.World.Assets.m.Money / 2;
		this.World.Assets.m.ArmorParts = this.World.Assets.m.ArmorParts / 2;
		this.World.Assets.m.Medicine = this.World.Assets.m.Medicine / 2;
		this.World.Assets.m.Ammo = this.World.Assets.m.Ammo / 2;
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
		this.World.Flags.set("HomeVillage", randomVillage.getName());
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

				if (tile.Type == this.Const.World.TerrainType.Ocean || tile.Type == this.Const.World.TerrainType.Shore)
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
		this.World.Assets.updateLook(8);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		randomVillage.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(40.0, "被认为是确保村庄安全的当地英雄");
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/retirement_01.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.militia_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.World.Assets.m.BrothersMax = 25;
		this.World.Assets.m.BrothersMaxInCombat = 16;
		this.World.Assets.m.BrothersScaleMax = 14;
	}

	function onUpdateHiringRoster( _roster )
	{
		local garbage = [];
		local bros = _roster.getAll();

		foreach( i, bro in bros )
		{
			if (!bro.getBackground().isLowborn())
			{
				garbage.push(bro);
			}
		}

		foreach( g in garbage )
		{
			_roster.remove(g);
		}
	}

});

