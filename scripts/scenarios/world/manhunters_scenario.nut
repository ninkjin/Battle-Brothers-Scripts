this.manhunters_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.manhunters";
		this.m.Name = "搜捕者";
		this.m.Description = "[p=c][img]gfx/ui/events/event_172.png[/img][/p][p]城邦和游牧民之间不断的冲突有利于好生意。你队伍大部分都是俘虏构成，为了获得自由被迫战斗，而他们数量在每次战斗后都会增加。\n\n[color=#bcad8c]俘虏大军：[/color]以两名搜捕者和四名负债者开始游戏。一次最多可携带16人参战。负债者与不多于非负债者会使你的人不满意。\n[color=#bcad8c]监工：[/color]所有非负债者都可以在战斗中鞭打负债者的来重置他们的士气并增加他们的属性。\n[color=#bcad8c]俘虏：[/color]负债者获得的经验增加10%，等级上限为7级，如果被击倒将直接死亡。[/p]";
		this.m.Difficulty = 3;
		this.m.Order = 89;
		this.m.IsFixedLook = true;
	}

	function isValid()
	{
		return this.Const.DLC.Desert;
	}

	function onSpawnAssets()
	{
		local roster = this.World.getPlayerRoster();
		local names = [];

		for( local i = 0; i < 6; i = ++i )
		{
			local bro;
			bro = roster.create("scripts/entity/tactical/player");
			bro.m.HireTime = this.Time.getVirtualTimeF();
		}

		local bros = roster.getAll();
		local talents;
		bros[0].setStartValuesEx([
			"manhunter_background"
		]);
		bros[0].setTitle("坚忍者");
		bros[0].getBackground().m.RawDescription = "{从某种意义上说，你并不特别关心%name%。他对俘虏、罪犯之类的人既不憎恨也不宽恕。他只是处理他的生意。但他对你也是如此平静，坚定，这有点麻烦。这个人很有潜力，这就是为什么你让他加入%companyname%，但你只是希望他接下来能展示出一些激情。}";
		bros[0].setPlaceInFormation(12);
		local items = bros[0].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/weapons/oriental/light_southern_mace"));
		bros[0].getSkills().add(this.new("scripts/skills/actives/whip_slave_skill"));
		bros[0].m.Talents = [];
		talents = bros[0].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.Bravery] = 2;
		talents[this.Const.Attributes.RangedDefense] = 1;
		local traits = bros[0].getSkills().getAllSkillsOfType(this.Const.SkillType.Trait);

		foreach( t in traits )
		{
			if (!t.isType(this.Const.SkillType.Special) && !t.isType(this.Const.SkillType.Background))
			{
				bros[0].getSkills().remove(t);
			}
		}

		bros[1].setStartValuesEx([
			"manhunter_background"
		]);
		bros[1].setTitle("鞭子");
		bros[1].getBackground().m.RawDescription = "{%name%是你认识的最糟糕的人之一。即使以你的标准来衡量，他对负债者也是无休无止的残暴，并且需要为杀死一部分你的俘虏负责。尽管如此，他的刻薄作风也将对战团很有好处。考虑到你已经因为丢失库存而鞭打了他一到三次，你知道他除了打人外也能承受打击。}";
		bros[1].setPlaceInFormation(13);
		local items = bros[1].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Offhand));
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Head));
		items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		items.equip(this.new("scripts/items/weapons/battle_whip"));
		bros[1].getSkills().add(this.new("scripts/skills/actives/whip_slave_skill"));
		bros[1].worsenMood(0.0, "对你最近对不要虐待俘虏的训斥而感到恼火");
		bros[1].m.Talents = [];
		talents = bros[1].getTalents();
		talents.resize(this.Const.Attributes.COUNT, 0);
		talents[this.Const.Attributes.Fatigue] = 2;
		talents[this.Const.Attributes.MeleeSkill] = 1;
		talents[this.Const.Attributes.Hitpoints] = 1;
		bros[2].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[2].setTitle("博学者");
		bros[2].getBackground().m.RawDescription = "{你发现%name%正受到城市警卫的法律制裁。看起来他们要用他的手腕玩一个‘接弯刀’的游戏，直到你介入宣称他欠金铎的比他欠任何人的都多。你希望把他高价卖给的维齐尔，但没有人愿意买下它，因为他太‘博学’了，而且看上去正是那种能引发起义的威胁。对一个他这样身份的人来说不寻常的是，他确实对你怀有一点尊敬。}";
		bros[2].setPlaceInFormation(2);
		bros[2].getSkills().removeByID("trait.dumb");
		bros[2].getSkills().add(this.new("scripts/skills/traits/bright_trait"));
		bros[2].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[2].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/wooden_stick"));
		items.equip(this.new("scripts/items/helmets/oriental/nomad_head_wrap"));
		bros[2].worsenMood(0.0, "想念他的书");
		bros[3].setStartValuesEx([
			"slave_background"
		]);
		bros[3].setTitle("北方人");
		bros[3].getBackground().m.RawDescription = "{以任何标准都算不上是个友好的人，但就是枷锁的存在目的。当你碰巧碰到他时，%name%正因为一系列的犯罪而被送上了砍头台。你买下他的命作为投资，说他现在应该努力工作才能在金铎的目光中得到救赎。他对你的虔诚信仰不太有把握，但你给一位祭司掏钱来确认他确实对更崇高的存在亏欠了汗水。}";
		bros[3].setPlaceInFormation(3);
		bros[3].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[3].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/bludgeon"));
		bros[3].worsenMood(2.0, "差点被处决");
		bros[3].improveMood(2.0, "因他逃脱了处决而舒心");
		bros[3].worsenMood(0.0, "担心接下来会发生什么");
		bros[4].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[4].setTitle("逃兵");
		bros[4].getBackground().m.RawDescription = "{%name%是异端的传家宝，由一位维齐尔的牧师赠送给你。这个人在领主的军队里当了逃兵，但通过富有的关系设法避免了处决。然而，只有一种方法可以避免地狱之火，那就是通过负债感恩。他会为你工作，直到他得到救赎，而这什么时候发生完全取决于你。}";
		bros[4].setPlaceInFormation(4);
		bros[4].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[4].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/militia_spear"));
		bros[4].worsenMood(0.5, "觉得自己被诅咒了，逃离了一支军队，却在另一支军队中当负债者");
		bros[5].setStartValuesEx([
			"slave_southern_background"
		]);
		bros[5].setTitle("乞丐");
		bros[5].getBackground().m.RawDescription = "{在街上遇到%name%时，他根本没机会。作为一个乞丐，物理上很容易给他戴上镣铐，在社会上没有人会在意。金铎不关心那些不工作的人，而这人每天浪费时间不去出汗让他积累下了债务。先在债务必须被偿还，除非他想永远品尝沙漠之火的滋味。他现在看起来比你刚找到他的时候更健康，尽管他似乎从来没有为此感谢过你。}";
		bros[5].setPlaceInFormation(5);
		bros[5].getSprite("miniboss").setBrush("bust_miniboss_indebted");
		local items = bros[5].getItems();
		items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
		items.equip(this.new("scripts/items/weapons/wooden_stick"));
		this.World.Assets.m.BusinessReputation = 100;
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/supplies/rice_item"));
		this.World.Assets.getStash().add(this.new("scripts/items/misc/manhunters_ledger_item"));
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);
		this.World.Assets.m.Money = this.World.Assets.m.Money;
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

		this.countIndebted();
		this.World.State.m.Player = this.World.spawnEntity("scripts/entity/world/player_party", randomVillageTile.Coords.X, randomVillageTile.Coords.Y);
		this.World.Assets.updateLook(18);
		this.World.getCamera().setPos(this.World.State.m.Player.getPos());
		this.Time.scheduleEvent(this.TimeUnit.Real, 1000, function ( _tag )
		{
			this.Music.setTrackList([
				"music/worldmap_11.ogg"
			], this.Const.Music.CrossFadeTime);
			this.World.Events.fire("event.manhunters_scenario_intro");
		}, null);
	}

	function onInit()
	{
		this.World.Assets.m.BrothersMax = 25;
		this.World.Assets.m.BrothersMaxInCombat = 16;
		this.World.Assets.m.BrothersScaleMax = 14;
	}

	function onHired( _bro )
	{
		if (_bro.getBackground().getID() != "background.slave")
		{
			_bro.getSkills().add(this.new("scripts/skills/actives/whip_slave_skill"));
		}
		else
		{
			_bro.getSprite("miniboss").setBrush("bust_miniboss_indebted");
		}

		this.countIndebted();
	}

	function onCombatFinished()
	{
		this.countIndebted();
		return true;
	}

	function onUnlockPerk( _bro, _perkID )
	{
		if (_bro.getLevel() == 7 && _bro.getBackground().getID() == "background.slave" && _perkID == "perk.student")
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	function onUpdateLevel( _bro )
	{
		if (_bro.getLevel() == 7 && _bro.getBackground().getID() == "background.slave" && _bro.getSkills().hasSkill("perk.student"))
		{
			_bro.setPerkPoints(_bro.getPerkPoints() + 1);
		}
	}

	function onGetBackgroundTooltip( _background, _tooltip )
	{
		if (_background.getID() != "background.slave")
		{
			if (_background.getID() == "background.wildman")
			{
				_tooltip.pop();
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]经验获取"
				});
			}
			else if (_background.getID() == "background.apprentice")
			{
				_tooltip.pop();
			}
			else if (_background.getID() == "background.historian")
			{
				_tooltip.pop();
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+5%[/color]经验获取"
				});
			}
			else
			{
				_tooltip.push({
					id = 16,
					type = "text",
					icon = "ui/icons/xp_received.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]经验获取"
				});
			}
		}
		else
		{
			_tooltip.push({
				id = 16,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]经验获取"
			});
			_tooltip.push({
				id = 17,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "角色只能升到7级"
			});
			_tooltip.push({
				id = 18,
				type = "text",
				icon = "ui/icons/days_wounded.png",
				text = "如果被击倒会永久性死亡，不会以得到永久伤势为代价幸存"
			});
		}
	}

	function countIndebted()
	{
		local roster = this.World.getPlayerRoster().getAll();
		local indebted = 0;
		local nonIndebted = [];

		foreach( bro in roster )
		{
			if (bro.getBackground().getID() == "background.slave")
			{
				indebted++;
			}
			else
			{
				nonIndebted.push(bro);
			}
		}

		this.World.Statistics.getFlags().set("ManhunterIndebted", indebted);
		this.World.Statistics.getFlags().set("ManhunterNonIndebted", nonIndebted.len());
	}

});

