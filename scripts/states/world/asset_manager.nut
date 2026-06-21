this.asset_manager <- {
	m = {
		Stash = null,
		OverflowItems = [],
		CampaignID = 0,
		Name = "战场兄弟",
		Banner = "banner_01",
		BannerID = 1,
		Look = 1,
		EconomicDifficulty = 1,
		CombatDifficulty = 1,
		SeedString = "",
		Origin = null,
		RestoreEquipment = [],
		Money = 0,
		Food = 0.0,
		Ammo = 0.0,
		ArmorParts = 0.0,
		Medicine = 0.0,
		FoodAdditionalDays = 0,
		FoodConsumptionMult = 1.0,
		DailyWageMult = 1.0,
		TaxidermistPriceMult = 1.0,
		TrainingPriceMult = 1.0,
		TryoutPriceMult = 1.0,
		ContractPaymentMult = 1.0,
		ArmorPartsPerArmor = 0.067,
		HitpointsPerHourMult = 1.0,
		RepairSpeedMult = 1.0,
		HiringCostMult = 1.0,
		CampingMult = 1.5,
		RosterSizeAdditionalMin = 0,
		RosterSizeAdditionalMax = 0,
		XPMult = 1.0,
		ChampionChanceAdditional = 0,
		RelationDecayGoodMult = 1.0,
		RelationDecayBadMult = 1.0,
		NegotiationAnnoyanceMult = 1.0,
		AdvancePaymentCap = 0.5,
		VisionRadiusMult = 1.0,
		AmmoMaxAdditional = 0,
		MedicineMaxAdditional = 0,
		ArmorPartsMaxAdditional = 0,
		TerrainTypeSpeedMult = [],
		IsRecoveringAmmo = false,
		IsRecoveringArmor = false,
		IsBlacksmithed = false,
		IsDisciplined = false,
		IsBrigand = false,
		IsNonFlavorRumorsOnly = false,
		IsSurvivalGuaranteed = false,
		IsShowingExtendedFootprints = false,
		BusinessReputation = 0,
		BusinessReputationRate = 1.0,
		MoralReputation = 50.0,
		Score = 0.0,
		BuyPriceMult = 1.0,
		BuyPriceTradeMult = 1.0,
		SellPriceMult = 1.0,
		SellPriceTradeMult = 1.0,
		ExtraLootChance = 0,
		FootprintVision = 1.0,
		AverageMoodState = this.Const.MoodState.Neutral,
		BrothersMax = 20,
		BrothersMaxInCombat = 12,
		BrothersScaleMax = 12,
		BrothersScaleMin = 3,
		LastDayPaid = 1,
		LastHourUpdated = 0,
		LastFoodConsumed = 0,
		IsIronman = false,
		IsExplorationMode = false,
		IsPermanentDestruction = true,
		IsCamping = false,
		IsUsingProvisions = true,
		IsConsumingAssets = true
	},
	function getCampaignID()
	{
		return this.m.CampaignID;
	}

	function getSeedString()
	{
		return this.m.SeedString;
	}

	function getName()
	{
		return this.m.Name;
	}

	function getBanner()
	{
		return this.m.Banner;
	}

	function getBannerID()
	{
		return this.m.BannerID;
	}

	function getOrigin()
	{
		return this.m.Origin;
	}

	function getEconomicDifficulty()
	{
		return this.m.EconomicDifficulty;
	}

	function getCombatDifficulty()
	{
		return this.m.CombatDifficulty;
	}

	function getDifficulty()
	{
		return this.m.CombatDifficulty;
	}

	function getStash()
	{
		return this.m.Stash;
	}

	function getOverflowItems()
	{
		return this.m.OverflowItems;
	}

	function getAverageMoodState()
	{
		return this.m.AverageMoodState;
	}

	function getMoney()
	{
		return this.m.Money;
	}

	function getFood()
	{
		return this.Math.floor(this.m.Food);
	}

	function getAmmo()
	{
		return this.Math.floor(this.m.Ammo);
	}

	function getArmorParts()
	{
		return this.Math.floor(this.m.ArmorParts);
	}

	function getMedicine()
	{
		return this.Math.floor(this.m.Medicine);
	}

	function getBusinessReputation()
	{
		return this.m.BusinessReputation;
	}

	function getMoralReputation()
	{
		return this.m.MoralReputation;
	}

	function getBuyPriceMult()
	{
		return this.m.BuyPriceMult;
	}

	function getSellPriceMult()
	{
		return this.m.SellPriceMult;
	}

	function getExtraLootChance()
	{
		return this.m.ExtraLootChance;
	}

	function getFootprintVision()
	{
		return this.m.FootprintVision;
	}

	function getBrothersMax()
	{
		return this.m.BrothersMax;
	}

	function getBrothersMaxInCombat()
	{
		return this.m.BrothersMaxInCombat;
	}

	function getBrothersScaleMax()
	{
		return this.m.BrothersScaleMax;
	}

	function getBrothersScaleMin()
	{
		return this.m.BrothersScaleMin;
	}

	function getTerrainTypeSpeedMult( _t )
	{
		return this.m.TerrainTypeSpeedMult[_t];
	}

	function isIronman()
	{
		return this.m.IsIronman;
	}

	function isExplorationMode()
	{
		return this.m.IsExplorationMode;
	}

	function isPermanentDestruction()
	{
		return this.m.IsPermanentDestruction;
	}

	function isCamping()
	{
		return this.m.IsCamping;
	}

	function isUsingProvisions()
	{
		return this.m.IsUsingProvisions;
	}

	function isConsumingAssets()
	{
		return this.m.IsConsumingAssets;
	}

	function setCamping( _c )
	{
		this.m.IsCamping = _c;
		this.World.State.getPlayer().setCamping(_c);
	}

	function setUseProvisions( _p )
	{
		this.m.IsUsingProvisions = _p;
	}

	function setConsumingAssets( _a )
	{
		this.m.IsConsumingAssets = _a;
	}

	function addScore( _s )
	{
		this.m.Score += _s;
	}

	function setMoney( _m )
	{
		this.m.Money = _m;
	}

	function setAmmo( _f )
	{
		this.m.Ammo = this.Math.min(this.Math.max(0, _f), this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo + this.m.AmmoMaxAdditional);
		this.refillAmmo();
	}

	function setArmorParts( _f )
	{
		this.m.ArmorParts = this.Math.min(this.Math.max(0, _f), this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].ArmorParts + this.m.ArmorPartsMaxAdditional);
	}

	function setMedicine( _f )
	{
		this.m.Medicine = this.Math.min(this.Math.max(0, _f), this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Medicine + this.m.MedicineMaxAdditional);
	}

	function addAmmo( _f )
	{
		this.m.Ammo = this.Math.min(this.Math.max(0, this.m.Ammo + _f), this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Ammo + this.m.AmmoMaxAdditional);
	}

	function addArmorParts( _f )
	{
		this.m.ArmorParts = this.Math.min(this.Math.max(0, this.m.ArmorParts + _f), this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].ArmorParts + this.m.ArmorPartsMaxAdditional);
	}

	function addMedicine( _f )
	{
		this.m.Medicine = this.Math.min(this.Math.max(0, this.m.Medicine + _f), this.Const.Difficulty.MaxResources[this.m.EconomicDifficulty].Medicine + this.m.MedicineMaxAdditional);
	}

	function addMoralReputation( _f )
	{
		this.m.MoralReputation = this.Math.minf(100.0, this.Math.max(0.0, this.m.MoralReputation + _f));
	}

	function addMoney( _f )
	{
		if (_f == 0)
		{
			return;
		}

		this.m.Money += _f;
		this.Sound.play(this.Const.Sound.MoneyTransaction[this.Math.rand(0, this.Const.Sound.MoneyTransaction.len() - 1)], this.Const.Sound.Volume.Inventory);

		if (_f > 0)
		{
			this.m.Score += _f * 0.01;
		}

		if (this.m.Money >= 5000)
		{
			this.updateAchievement("BackInBusiness", 1, 1);
		}

		if (this.m.Money >= 50000)
		{
			this.updateAchievement("Moneymaker", 1, 1);
		}

		if (this.m.Money >= 250000)
		{
			this.updateAchievement("DragonsHoard", 1, 1);
		}
	}

	function addBusinessReputation( _f )
	{
		this.m.BusinessReputation += this.Math.ceil(_f * this.m.BusinessReputationRate);

		if (this.m.BusinessReputation >= 1000)
		{
			this.updateAchievement("MakingAName", 1, 1);
		}

		if (this.m.BusinessReputation >= 3000)
		{
			this.updateAchievement("ManOfRenown", 1, 1);
		}

		if (this.m.BusinessReputation >= 8000)
		{
			this.updateAchievement("StuffOfLegends", 1, 1);
		}
	}

	function setCampaignSettings( _settings )
	{
		this.m.CampaignID = this.Math.max(0, this.Math.rand());
		this.m.Name = this.removeFromBeginningOfText("这个", this.removeFromBeginningOfText("这个", _settings.Name));
		this.m.Banner = _settings.Banner;
		this.m.BannerID = _settings.Banner.slice(_settings.Banner.find("_") + 1).tointeger();
		this.m.CombatDifficulty = _settings.Difficulty;
		this.m.EconomicDifficulty = _settings.EconomicDifficulty;
		this.m.IsIronman = _settings.Ironman;
		this.m.IsPermanentDestruction = _settings.PermanentDestruction;
		this.m.Origin = _settings.StartingScenario;
		this.m.IsExplorationMode = _settings.ExplorationMode;
		this.m.BusinessReputation = 0;
		this.m.SeedString = _settings.Seed;
		this.World.FactionManager.getGreaterEvil().Type = _settings.GreaterEvil;

		switch(_settings.BudgetDifficulty)
		{
		case 0:
			this.m.Money = 2500;
			this.m.Ammo = 80;
			this.m.ArmorParts = 40;
			this.m.Medicine = 30;
			break;

		case 1:
			this.m.Money = 2000;
			this.m.Ammo = 40;
			this.m.ArmorParts = 20;
			this.m.Medicine = 20;
			break;

		case 2:
			this.m.Money = 1500;
			this.m.Ammo = 20;
			this.m.ArmorParts = 10;
			this.m.Medicine = 10;
			break;
		}

		this.m.Stash.clear();
		this.m.Origin.onSpawnAssets();
		local bros = this.World.getPlayerRoster().getAll();

		foreach( bro in bros )
		{
			bro.getBackground().buildDescription(true);
			bro.m.XP = this.Const.LevelXP[bro.m.Level - 1];
			bro.m.Attributes = [];
			bro.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
			bro.getSkills().update();
		}

		this.updateFormation();

		foreach( item in this.Const.World.Assets.NewCampaignEquipment )
		{
			this.m.Stash.add(this.new(item));
		}

		this.updateFood();
	}

	function getBusinessReputationAsText()
	{
		for( local i = 1; i != this.Const.BusinessReputation.len(); i = ++i )
		{
			if (this.Const.BusinessReputation[i] > this.m.BusinessReputation)
			{
				return this.Const.Strings.BusinessReputation[i - 1];
			}
		}

		return this.Const.Strings.BusinessReputation[this.Const.Strings.BusinessReputation.len() - 1];
	}

	function getMoralReputationAsText()
	{
		return this.Const.Strings.MoralReputation[this.Math.max(0, this.Math.min(this.Const.Strings.MoralReputation.len() - 1, this.m.MoralReputation / 10))];
	}

	function getDailyMoneyCost()
	{
		local cost = 0;
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			cost = cost + bro.getDailyCost();
		}

		return cost;
	}

	function getDailyFoodCost()
	{
		local cost = 0;
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			cost = cost + bro.getDailyFood();
		}

		return cost;
	}

	function getRepairRequired()
	{
		local ret = {
			ArmorParts = 0,
			Hours = 0
		};
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local d;
			local items = bro.getItems().getAllItems();

			foreach( item in items )
			{
				if (item.getCondition() < item.getConditionMax())
				{
					d = item.getConditionMax() - item.getCondition();

					if (d > 0)
					{
						ret.ArmorParts += d * this.m.ArmorPartsPerArmor;

						if (d / this.Const.World.Assets.ArmorPerHour > ret.Hours)
						{
							ret.Hours = d / this.Const.World.Assets.ArmorPerHour;
						}
					}
				}
			}
		}

		local items = this.m.Stash.getItems();

		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			local d = 0;

			if (item.isToBeRepaired())
			{
				d = item.getConditionMax() - item.getCondition();
			}

			if (d > 0)
			{
				ret.ArmorParts += d * this.m.ArmorPartsPerArmor;

				if (d / this.Const.World.Assets.ArmorPerHour > ret.Hours)
				{
					ret.Hours = d / this.Const.World.Assets.ArmorPerHour;
				}
			}
		}

		ret.ArmorParts = this.Math.ceil(ret.ArmorParts);
		ret.Hours = this.Math.ceil(ret.Hours / (this.isCamping() ? this.m.CampingMult : 1.0) / this.m.RepairSpeedMult);
		return ret;
	}

	function getHealingRequired()
	{
		local ret = {
			MedicineMin = 0,
			MedicineMax = 0,
			DaysMin = 0,
			DaysMax = 0
		};
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local injuries = bro.getSkills().query(this.Const.SkillType.TemporaryInjury);

			if (bro.getSkills().hasSkill("injury.sickness"))
			{
				injuries.push(bro.getSkills().getSkillByID("injury.sickness"));
			}

			foreach( inj in injuries )
			{
				local ht = inj.getHealingTime();
				ret.MedicineMin += ht.Min * this.Const.World.Assets.MedicinePerInjuryDay;
				ret.MedicineMax += ht.Max * this.Const.World.Assets.MedicinePerInjuryDay;

				if (ht.Min > ret.DaysMin)
				{
					ret.DaysMin = ht.Min;
				}

				if (ht.Max > ret.DaysMax)
				{
					ret.DaysMax = ht.Max;
				}
			}
		}

		ret.MedicineMin = this.Math.ceil(ret.MedicineMin);
		ret.MedicineMax = this.Math.ceil(ret.MedicineMax);
		ret.DaysMin = this.Math.ceil(ret.DaysMin);
		ret.DaysMax = this.Math.ceil(ret.DaysMax);
		return ret;
	}

	function getAllBrotherNames()
	{
		local ret = "";
		local roster = this.World.getPlayerRoster().getAll();

		for( local i = 0; i < roster.len(); i = ++i )
		{
			if (i != 0)
			{
				if (i == roster.len() - 1)
				{
					ret = ret + " 和 ";
				}
				else
				{
					ret = ret + ", ";
				}
			}

			ret = ret + roster[i].getName();
		}

		return ret;
	}

	function removeRandomFood( _num )
	{
		local food = this.World.Assets.getFoodItems();

		if (food.len() != 0)
		{
			food = food[this.Math.rand(0, food.len() - 1)];
			food.setAmount(this.Math.max(1, food.getAmount() - _num));
		}
	}

	function clear()
	{
		this.m.Stash.clear();
		this.m.SeedString = "";
		this.m.IsCamping = false;
		this.m.IsUsingProvisions = true;
		this.resetToDefaults();
	}

	function resetToDefaults()
	{
		this.m.BrothersMax = 20;
		this.m.BrothersMaxInCombat = 12;
		this.m.BrothersScaleMax = 12;
		this.m.BrothersScaleMin = 3;
		this.m.BusinessReputationRate = 1.0;
		this.m.BuyPriceMult = 1.0;
		this.m.BuyPriceTradeMult = 1.0;
		this.m.SellPriceMult = 1.0;
		this.m.SellPriceTradeMult = 1.0;
		this.m.ExtraLootChance = 0;
		this.m.FootprintVision = 1.0;
		this.m.FoodAdditionalDays = 0;
		this.m.FoodConsumptionMult = 1.0;
		this.m.DailyWageMult = 1.0;
		this.m.TaxidermistPriceMult = 1.0;
		this.m.TrainingPriceMult = 1.0;
		this.m.TryoutPriceMult = 1.0;
		this.m.ContractPaymentMult = 1.0;
		this.m.ArmorPartsPerArmor = this.Const.World.Assets.ArmorPartsPerArmor;
		this.m.HitpointsPerHourMult = 1.0;
		this.m.RepairSpeedMult = 1.0;
		this.m.HiringCostMult = 1.0;
		this.m.CampingMult = 1.5;
		this.m.RosterSizeAdditionalMin = 0;
		this.m.RosterSizeAdditionalMax = 0;
		this.m.XPMult = 1.0;
		this.m.ChampionChanceAdditional = 0;
		this.m.RelationDecayGoodMult = 1.0;
		this.m.RelationDecayBadMult = 1.0;
		this.m.NegotiationAnnoyanceMult = 1.0;
		this.m.AdvancePaymentCap = 0.5;
		this.m.VisionRadiusMult = 1.0;
		this.m.AmmoMaxAdditional = 0;
		this.m.MedicineMaxAdditional = 0;
		this.m.ArmorPartsMaxAdditional = 0;
		this.m.TerrainTypeSpeedMult.resize(this.Const.World.TerrainFoodConsumption.len());

		for( local i = 0; i < this.m.TerrainTypeSpeedMult.len(); i = ++i )
		{
			this.m.TerrainTypeSpeedMult[i] = 1.0;
		}

		this.m.IsRecoveringAmmo = false;
		this.m.IsRecoveringArmor = false;
		this.m.IsDisciplined = false;
		this.m.IsBrigand = false;
		this.m.IsNonFlavorRumorsOnly = false;
		this.m.IsSurvivalGuaranteed = false;
		this.m.IsShowingExtendedFootprints = false;
		this.m.IsBlacksmithed = false;
		this.World.Retinue.update();

		if (this.m.Origin != null)
		{
			this.m.Origin.onInit();
		}

		if (this.World.Ambitions.hasActiveAmbition())
		{
			this.World.Ambitions.getActiveAmbition().onUpdateEffect();
		}
	}

	function create()
	{
		this.m.Stash = this.new("scripts/items/stash_container");
		this.m.Stash.resize(99);
		this.m.Stash.setID("player");
		local globalTable = this.getroottable();
		globalTable.Stash <- this.WeakTableRef(this.m.Stash);
	}

	function init()
	{
		this.m.LastFoodConsumed = this.Time.getVirtualTimeF();
		this.clear();
	}

	function destroy()
	{
		local globalTable = this.getroottable();
		delete globalTable.Stash;
		this.m.Stash.clear();
		this.m.Stash = null;
	}

	function sortFoodByFreshness( _f1, _f2 )
	{
		if (!_f1.isDesirable() && _f2.isDesirable())
		{
			return 1;
		}
		else if (_f1.isDesirable() && !_f2.isDesirable())
		{
			return -1;
		}
		else if (_f1.getBestBeforeTime() > _f2.getBestBeforeTime())
		{
			return 1;
		}
		else if (_f1.getBestBeforeTime() < _f2.getBestBeforeTime())
		{
			return -1;
		}
		else
		{
			return 0;
		}
	}

	function getFoodItems()
	{
		local items = this.m.Stash.getItems();
		local food = [];

		foreach( i, item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				food.push(item);
			}
		}

		return food;
	}

	function consumeFood()
	{
		local items = this.m.Stash.getItems();
		local food = [];

		foreach( i, item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (this.Time.getVirtualTimeF() >= item.getBestBeforeTime())
				{
					items[i] = null;
				}
				else
				{
					food.push(item);
				}
			}
		}

		if (!this.m.IsUsingProvisions)
		{
			this.m.LastFoodConsumed = this.Time.getVirtualTimeF();
			return;
		}

		food.sort(this.sortFoodByFreshness);
		local d = this.Math.maxf(0.0, this.Time.getVirtualTimeF() - this.m.LastFoodConsumed);
		this.m.LastFoodConsumed = this.Time.getVirtualTimeF();
		local eaten = d * this.getDailyFoodCost() * this.Const.World.TerrainFoodConsumption[this.World.State.getPlayer().getTile().Type] * this.m.FoodConsumptionMult * this.Const.World.Assets.FoodConsumptionMult;

		for( local i = 0; i < food.len();  )
		{
			local foodLeft = food[i].getAmount() - eaten;

			if (foodLeft <= 0)
			{
				eaten = eaten - food[i].getAmount();

				foreach( j, item in items )
				{
					if (item == food[i])
					{
						items[j] = null;
						break;
					}
				}

				food.remove(i);
				  // [136]  OP_JMP            0      8    0    0
			}
			else
			{
				food[i].setAmount(foodLeft);
				break;
			}
		}

		this.updateFood();
	}

	function update( _worldState )
	{
		if (this.World.getTime().Days > this.m.LastDayPaid && this.World.getTime().Hours > 8 && this.m.IsConsumingAssets)
		{
			this.m.LastDayPaid = this.World.getTime().Days;

			if (this.m.BusinessReputation > 0)
			{
				this.m.BusinessReputation = this.Math.max(0, this.m.BusinessReputation + this.Const.World.Assets.ReputationDaily);
			}

			this.World.Retinue.onNewDay();

			if (this.World.Flags.get("IsGoldenGoose") == true)
			{
				this.addMoney(15);
			}

			local roster = this.World.getPlayerRoster().getAll();
			local mood = 0;
			local slaves = 0;
			local nonSlaves = 0;

			if (this.m.Origin.getID() == "scenario.manhunters")
			{
				foreach( bro in roster )
				{
					if (bro.getBackground().getID() == "background.slave")
					{
						slaves = ++slaves;
					}
					else
					{
						nonSlaves = ++nonSlaves;
					}
				}
			}

			foreach( bro in roster )
			{
				bro.getSkills().onNewDay();
				bro.updateInjuryVisuals();

				if (bro.getDailyCost() > 0 && this.m.Money < bro.getDailyCost())
				{
					if (bro.getSkills().hasSkill("trait.greedy"))
					{
						bro.worsenMood(this.Const.MoodChange.NotPaidGreedy, "没有得到工资");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotPaid, "没有得到工资");
					}
				}

				if (this.m.IsUsingProvisions && this.m.Food < bro.getDailyFood())
				{
					if (bro.getSkills().hasSkill("trait.spartan"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenSpartan, "挨了饿");
					}
					else if (bro.getSkills().hasSkill("trait.gluttonous"))
					{
						bro.worsenMood(this.Const.MoodChange.NotEatenGluttonous, "挨了饿");
					}
					else
					{
						bro.worsenMood(this.Const.MoodChange.NotEaten, "挨了饿");
					}
				}

				if (this.m.Origin.getID() == "scenario.manhunters" && slaves <= nonSlaves)
				{
					if (bro.getBackground().getID() != "background.slave")
					{
						bro.worsenMood(this.Const.MoodChange.TooFewSlaves, "战团中负债者太少。");
					}
				}

				this.m.Money -= bro.getDailyCost();
				mood = mood + bro.getMoodState();
			}

			this.Sound.play(this.Const.Sound.MoneyTransaction[this.Math.rand(0, this.Const.Sound.MoneyTransaction.len() - 1)], this.Const.Sound.Volume.Inventory);
			this.m.AverageMoodState = this.Math.round(mood / roster.len());
			_worldState.updateTopbarAssets();

			if (this.m.EconomicDifficulty >= 1 && this.m.CombatDifficulty >= 1)
			{
				if (this.World.getTime().Days >= 365)
				{
					this.updateAchievement("Anniversary", 1, 1);
				}
				else if (this.World.getTime().Days >= 100)
				{
					this.updateAchievement("Campaigner", 1, 1);
				}
				else if (this.World.getTime().Days >= 10)
				{
					this.updateAchievement("Survivor", 1, 1);
				}
			}
		}

		if (this.World.getTime().Hours != this.m.LastHourUpdated && this.m.IsConsumingAssets)
		{
			this.m.LastHourUpdated = this.World.getTime().Hours;
			this.consumeFood();
			local roster = this.World.getPlayerRoster().getAll();
			local campMultiplier = this.isCamping() ? this.m.CampingMult : 1.0;

			foreach( bro in roster )
			{
				local d = bro.getHitpointsMax() - bro.getHitpoints();

				if (bro.getHitpoints() < bro.getHitpointsMax())
				{
					bro.setHitpoints(this.Math.minf(bro.getHitpointsMax(), bro.getHitpoints() + this.Const.World.Assets.HitpointsPerHour * campMultiplier * this.m.HitpointsPerHourMult));
				}
			}

			foreach( bro in roster )
			{
				if (this.m.ArmorParts == 0)
				{
					break;
				}

				local items = bro.getItems().getAllItems();
				local updateBro = false;

				foreach( item in items )
				{
					if (item.getCondition() < item.getConditionMax())
					{
						local d = this.Math.minf(this.Const.World.Assets.ArmorPerHour * campMultiplier * this.m.RepairSpeedMult, item.getConditionMax() - item.getCondition());
						item.setCondition(item.getCondition() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor);
						updateBro = true;
					}

					if (item.getCondition() >= item.getConditionMax())
					{
						item.setToBeRepaired(false);
					}

					if (this.m.ArmorParts == 0)
					{
						break;
					}
				}

				if (updateBro)
				{
					bro.getSkills().update();
				}
			}

			local items = this.m.Stash.getItems();

			foreach( item in items )
			{
				if (this.m.ArmorParts == 0)
				{
					break;
				}

				if (item == null)
				{
					continue;
				}

				if (item.isToBeRepaired())
				{
					if (item.getCondition() < item.getConditionMax())
					{
						local d = this.Math.minf(this.Const.World.Assets.ArmorPerHour * campMultiplier * this.m.RepairSpeedMult, item.getConditionMax() - item.getCondition());
						item.setCondition(item.getCondition() + d);
						this.m.ArmorParts = this.Math.maxf(0, this.m.ArmorParts - d * this.m.ArmorPartsPerArmor);
					}

					if (item.getCondition() >= item.getConditionMax())
					{
						item.setToBeRepaired(false);
					}
				}
			}

			if (this.World.getTime().Hours % 4 == 0)
			{
				this.checkDesertion();
				local towns = this.World.EntityManager.getSettlements();
				local playerTile = this.World.State.getPlayer().getTile();
				local town;

				foreach( t in towns )
				{
					if (t.getSize() >= 2 && !t.isMilitary() && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
					{
						town = t;
						break;
					}
				}

				foreach( bro in roster )
				{
					bro.recoverMood();

					if (town != null && bro.getMoodState() <= this.Const.MoodState.Neutral)
					{
						bro.improveMood(this.Const.MoodChange.NearCity, "喜爱访问" + town.getName());
					}
				}
			}

			_worldState.updateTopbarAssets();
		}
	}

	function updateAverageMoodState()
	{
		local mood = 0;
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			mood = mood + bro.getMoodState();
		}

		if (roster.len() > 0)
		{
			this.m.AverageMoodState = this.Math.round(mood / roster.len());
		}
	}

	function updateFood()
	{
		local items = this.m.Stash.getItems();
		this.m.Food = 0.0;

		foreach( item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				this.m.Food += item.getAmount();
			}
		}
	}

	function checkAmbitionItems()
	{
		local supposedToHaveStandard = this.World.Ambitions.getAmbition("ambition.battle_standard").isDone();
		local supposedToHaveSergeant = this.World.Ambitions.getAmbition("ambition.sergeant").isDone();
		local hasStandard = false;
		local hasSergeant = false;

		if (supposedToHaveStandard || supposedToHaveSergeant)
		{
			local items = this.m.Stash.getItems();

			foreach( item in items )
			{
				if (item != null)
				{
					if (item.getID() == "weapon.player_banner")
					{
						hasStandard = true;
					}
					else if (item.getID() == "accessory.sergeant_badge")
					{
						hasSergeant = true;
					}
				}
			}

			local roster = this.World.getPlayerRoster().getAll();

			foreach( bro in roster )
			{
				local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

				if (item != null && item.getID() == "weapon.player_banner")
				{
					hasStandard = true;
				}

				item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

				if (item != null && item.getID() == "accessory.sergeant_badge")
				{
					hasSergeant = true;
				}

				for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
				{
					item = bro.getItems().getItemAtBagSlot(i);

					if (item != null && item.getID() == "weapon.player_banner")
					{
						hasStandard = true;
					}
					else if (item != null && item.getID() == "accessory.sergeant_badge")
					{
						hasSergeant = true;
					}
				}
			}

			if (supposedToHaveStandard && !hasStandard)
			{
				this.World.Ambitions.getAmbition("ambition.battle_standard").setDone(false);

				foreach( bro in roster )
				{
					bro.worsenMood(this.Const.MoodChange.StandardLost, "战旗丢了");
				}
			}

			if (supposedToHaveSergeant && !hasSergeant)
			{
				this.World.Ambitions.getAmbition("ambition.sergeant").setDone(false);
			}
		}
	}

	function updateAchievements()
	{
		if (!this.hasAchievement("FieldHospital"))
		{
			local roster = this.World.getPlayerRoster().getAll();
			local numWithInjuries = 0;

			foreach( bro in roster )
			{
				if (bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
				{
					numWithInjuries = ++numWithInjuries;
				}
			}

			if (numWithInjuries >= 5)
			{
				this.updateAchievement("FieldHospital", 1, 1);
			}
		}

		if (!this.hasAchievement("BlingBling") || !this.hasAchievement("TrickedOut"))
		{
			local items = this.m.Stash.getItems();
			local numNamedItems = 0;

			foreach( item in items )
			{
				if (item != null && item.isItemType(this.Const.Items.ItemType.Named))
				{
					numNamedItems = ++numNamedItems;
				}
			}

			if (numNamedItems < 5)
			{
				local roster = this.World.getPlayerRoster().getAll();

				foreach( bro in roster )
				{
					local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

					if (item != null && item.isItemType(this.Const.Items.ItemType.Named))
					{
						numNamedItems = ++numNamedItems;
					}

					item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

					if (item != null && item != "-1" && item.isItemType(this.Const.Items.ItemType.Named))
					{
						numNamedItems = ++numNamedItems;
					}

					item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

					if (item != null && item.isItemType(this.Const.Items.ItemType.Named))
					{
						numNamedItems = ++numNamedItems;
					}

					item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

					if (item != null && item.isItemType(this.Const.Items.ItemType.Named))
					{
						numNamedItems = ++numNamedItems;
					}

					for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
					{
						item = bro.getItems().getItemAtBagSlot(i);

						if (item != null && item.isItemType(this.Const.Items.ItemType.Named))
						{
							numNamedItems = ++numNamedItems;
						}
					}
				}
			}

			if (numNamedItems >= 1)
			{
				this.updateAchievement("BlingBling", 1, 1);
			}

			if (numNamedItems >= 5)
			{
				this.updateAchievement("TrickedOut", 1, 1);
			}
		}
	}

	function checkDesertion()
	{
		if (!this.World.Events.canFireEvent())
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local hasPaymaster = this.World.Retinue.hasFollower("follower.paymaster");

		foreach( bro in roster )
		{
			if (bro.getDailyCost() == 0 || bro.getFlags().has("IsPlayerCharacter"))
			{
				continue;
			}

			if (bro.getMood() < 1.0)
			{
				local chance = (1.0 - bro.getMood()) * 100;

				if (bro.getSkills().hasSkill("trait.loyal"))
				{
					chance = chance * 0.5;
				}
				else if (bro.getSkills().hasSkill("trait.disloyal"))
				{
					chance = chance * 2.0;
				}

				if (bro.getBackground().getID() == "background.companion")
				{
					chance = chance * 0.5;
				}

				if (hasPaymaster)
				{
					chance = chance * 0.5;
				}

				if (this.Math.rand(1, 100) <= chance)
				{
					candidates.push(bro);
				}
			}
		}

		if (candidates.len() != 0)
		{
			local bro = candidates[this.Math.rand(0, candidates.len() - 1)];

			if (this.World.getPlayerRoster().getSize() > 1)
			{
				local event = this.World.Events.getEvent("event.desertion");
				event.setDeserter(bro);
				this.World.Events.fire("event.desertion", false);
			}
			else
			{
				this.World.State.showGameFinishScreen(false);
			}
		}
	}

	function refillAmmo()
	{
		if (this.m.Ammo == 0)
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local items = bro.getItems().getAllItems();

			foreach( item in items )
			{
				if (item.isItemType(this.Const.Items.ItemType.Ammo) && item.getAmmo() < item.getAmmoMax())
				{
					local a = this.Math.min(this.m.Ammo, this.Math.ceil(item.getAmmoMax() - item.getAmmo()) * item.getAmmoCost());

					if (this.m.Ammo >= a)
					{
						item.setAmmo(item.getAmmo() + this.Math.ceil(a / item.getAmmoCost()));
						this.m.Ammo -= a;
					}
				}

				if (this.m.Ammo == 0)
				{
					break;
				}
			}
		}

		if (this.World.State.getCurrentTown() != null)
		{
			this.World.State.getTownScreen().updateAssets();
		}
	}

	function consumeItems()
	{
		local items = this.m.Stash.getItems();
		local garbage = [];

		foreach( i, item in items )
		{
			if (item == null || !item.isConsumed())
			{
				continue;
			}

			item.consume();
			garbage.push(i);
		}

		garbage.reverse();

		foreach( i in garbage )
		{
			items[i] = null;
		}
	}

	function getFormation()
	{
		local ret = [];
		ret.resize(27, null);
		local roster = this.World.getPlayerRoster().getAll();

		foreach( b in roster )
		{
			ret[b.getPlaceInFormation()] = b;
		}

		return ret;
	}

	function updateFormation( considerMaxBros = false )
	{
		local NOT_IN_FORMATION = 255;
		local formation = [];
		formation.resize(27, false);
		local roster = this.World.getPlayerRoster().getAll();
		local hasUnplaced = false;
		local inCombat = 0;

		foreach( b in roster )
		{
			if (b.getPlaceInFormation() != NOT_IN_FORMATION && formation[b.getPlaceInFormation()] == false && (!considerMaxBros || inCombat < this.m.BrothersMaxInCombat))
			{
				formation[b.getPlaceInFormation()] = true;

				if (b.getPlaceInFormation() <= 17)
				{
					inCombat = ++inCombat;
				}
			}
			else
			{
				b.setPlaceInFormation(NOT_IN_FORMATION);
				hasUnplaced = true;
			}
		}

		if (hasUnplaced)
		{
			foreach( b in roster )
			{
				if (b.getPlaceInFormation() != NOT_IN_FORMATION)
				{
					continue;
				}

				local i = 0;

				if (inCombat >= this.m.BrothersMaxInCombat)
				{
					i = 18;
				}

				while (i != formation.len())
				{
					if (formation[i] == false)
					{
						b.setPlaceInFormation(i);
						formation[i] = true;

						if (i <= 17)
						{
							inCombat = ++inCombat;
						}

						break;
					}

					i = ++i;
				}
			}
		}

		if (inCombat == 0)
		{
			foreach( b in roster )
			{
				b.setPlaceInFormation(3);
				break;
			}
		}
	}

	function updateLook( _updateTo = -1 )
	{
		if (_updateTo == -1)
		{
			_updateTo = this.m.Look;
		}

		this.m.Look = _updateTo;
		_updateTo = _updateTo < 10 ? "0" + _updateTo : _updateTo;
		this.World.State.getPlayer().getSprite("body").setBrush("figure_player_" + _updateTo);
	}

	function saveEquipment()
	{
		this.m.RestoreEquipment = [];
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			if (bro.getPlaceInFormation() > 17)
			{
				continue;
			}

			local store = {
				ID = bro.getID(),
				Slots = []
			};

			for( local i = this.Const.ItemSlot.Mainhand; i <= this.Const.ItemSlot.Ammo; i = ++i )
			{
				local item = bro.getItems().getItemAtSlot(i);

				if (item != null && item != "-1")
				{
					store.Slots.push({
						Item = item,
						Slot = i
					});
				}
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && item != "-1")
				{
					store.Slots.push({
						Item = item,
						Slot = this.Const.ItemSlot.Bag
					});
				}
			}

			this.m.RestoreEquipment.push(store);
		}
	}

	function restoreEquipment()
	{
		foreach( s in this.m.RestoreEquipment )
		{
			local bro = this.Tactical.getEntityByID(s.ID);

			if (bro == null || !bro.isAlive())
			{
				continue;
			}

			local currentItems = [];
			local itemsHandled = [];
			local overflowItems = [];

			for( local i = this.Const.ItemSlot.Mainhand; i <= this.Const.ItemSlot.Ammo; i = ++i )
			{
				local item = bro.getItems().getItemAtSlot(i);

				if (item != null && item != "-1")
				{
					currentItems.push({
						Item = item,
						Slot = i
					});
					bro.getItems().unequip(item);
				}
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && item != "-1")
				{
					currentItems.push({
						Item = item,
						Slot = this.Const.ItemSlot.Bag
					});
					bro.getItems().removeFromBag(item);
				}
			}

			foreach( item in s.Slots )
			{
				local itemExists = false;

				foreach( current in currentItems )
				{
					if (current.Item.getInstanceID() == item.Item.getInstanceID())
					{
						itemExists = true;
						break;
					}
				}

				if (!itemExists)
				{
					continue;
				}

				if (item.Slot == this.Const.ItemSlot.Bag)
				{
					if (!bro.getItems().addToBag(item.Item))
					{
						overflowItems.push(item.Item);
					}

					itemsHandled.push(item.Item.getInstanceID());
				}
				else
				{
					if (!bro.getItems().equip(item.Item))
					{
						overflowItems.push(item.Item);
					}

					itemsHandled.push(item.Item.getInstanceID());
				}
			}

			foreach( item in currentItems )
			{
				if (itemsHandled.find(item.Item.getInstanceID()) != null)
				{
					continue;
				}

				if (item.Item.getCurrentSlotType() == this.Const.ItemSlot.Bag)
				{
					if (!bro.getItems().addToBag(item.Item))
					{
						overflowItems.push(item.Item);
					}
				}
				else if (!bro.getItems().equip(item.Item))
				{
					overflowItems.push(item.Item);
				}
			}

			foreach( item in overflowItems )
			{
				if (itemsHandled.find(item.getInstanceID()) != null)
				{
					continue;
				}

				if (this.m.Stash.add(item) == null)
				{
					bro.getItems().addToBag(item);
				}
			}
		}

		this.m.RestoreEquipment = [];
	}

	function getGameFinishData( _gameWon )
	{
		if (this.isIronman())
		{
			this.PersistenceManager.deleteStorage(this.getName() + "_" + this.getCampaignID());
			this.m.IsIronman = false;
		}

		local data = {
			Image = "",
			Text = "",
			Score = "" + this.getScore() + "分"
		};
		local brothers = this.World.getPlayerRoster().getAll();
		local excludedBackgrounds = [];

		if (!_gameWon || brothers.len() == 0)
		{
			data.Image = "ui/screens/game_lost.jpg";
			data.Text = "{终于结束了。\n\n乌鸦盘旋在空中，战团的人们死的死，伤的伤，终于找到了自己的归宿。\n\n%companyname% 很快就会被遗忘，但在这个世界上，佣兵从不缺少工作，总会有下一个雇佣兵团来接替他们的位置... | 乌鸦在 %companyname% 的尸体上盘旋，等待掠夺者清理完毕，它们才能落地吃喝。或许战团曾经奋战过，但它很快就会被在未来的相似团队顶替而被忘。 | 这场战斗中，战团几乎全军覆没，只有乌鸦和蠕虫会是它的未来。但在这个世界上，雇佣佣兵的工作从不稀缺，总会有下一个雇佣兵团取代他们的位置... | 这场战斗中，%companyname%几乎全军覆没。你和你的战友们已经很努力战斗了，但当你死了的时候这就不太重要了。或许这时候果断地撤退更加合适？ | 非常感谢，%companyname% 的战败让此地的蠕虫们能够享用到如此丰盛的美味。死在这里的人很快就会被遗忘，但在这个世界上，雇佣佣兵的工作从不稀缺，总会有下一个雇佣兵团来取代他们的位置... | 你望着乌鸦密布的天空，你的生命逐渐熄灭，你的垂死之身成为了飞行生物那珍贵的食物，终于，它们飞来开怀享受你的尸体。 | 你原本应该带领着 %companyname% 创造辉煌和财富。或许它们已经被找到了一些，但你现在躺在这里，这一切有何用呢？ | %companyname% 信任你带给他们荣耀、财富和女人，现在他们都死了，当然你也是。他们很快就会被所有人遗忘，但在这个世界上雇佣佣兵的需求从未减少，总有另外一个雇佣兵团来接替他们的位置... | 乌鸦开始在天空中聚集，黑色的身影弥漫着整片天空，恶心的叫声填满了耳畔。人们开始过来劫掠你和你的手下的尸体，于是你和你们的武器装备将会继续存在，完成你所不能完成的任务和召唤... | 很难说你哪里做错了。是最后关头选择顽抗而不逃跑吗？还是当你第一次拿起剑时，感受到它在手中如此顺畅？现在懊悔又有何用？\n\n%companyname%战团覆灭了，但在这个世界上，需要佣兵的工作从未缺少，总会有下一支雇佣军团来填补他们的空缺... | 一只乌鸦落在你的脚上，紧紧地盯着你，用丧钟般的目光注视着你的死亡。战团的其他成员躺在地上，掠夺者已经在搜刮他们的物品。 | 至少你们战斗勇敢，这是你在慢慢离去时告诉自己的话。\n\n战团的名字很快就会从历史上消失，但在这个世界上雇佣兵从未缺乏工作，总会有新的雇佣军团来填补他们的位置… | 你以为死亡会像睡觉一样，你从不记得入睡的时刻，睡着了就是睡着了。但这一次不同，你感受到的只有痛苦。你非常希望这一切能停止，然后它就停止了。 | 战团%companyname% 遭遇了劲敌。虽然过于也遭遇过，你以前也承认技不如人。但这不一样，你指挥下的所有士兵都为这个错误付出了生命的代价。 | 战团%companyname% 的全体战士已经陨落，一位抄写员将在一个昏暗的烛光房间里得知此事，并做下记录。这份记录将会在一次洪水中丢失，%companyname% 的所有历史也将随之消失。 | 战团%companyname% 的士兵的鲜血将被转换成抄写员的墨水，而它们的所有奋斗和痛苦都会变成历史的包袱，沉没在档案室的黑暗深处。 | 难道这是唯一的方法吗？你在人生的最后一一刻仍然在拼命回想在你到来这里之前，有没有能缓解这残酷结局的方法。 | %companyname%的尸体散落在战场上，很快将被蠕虫和乌鸦啄食，所有的武器和护甲都变得毫无意义。死在这里的人们很快就会被遗忘，但在这个世界上佣兵的需求永无止境，随时会有新的雇佣兵团代替他们的位置... | 多么可笑，你花费了这么多时间和金钱为你的士兵收集武器和盔甲，只是为了将它们全部送给一群掠夺者。你的尸体也会为乌鸦和蠕虫的食粮。恭喜你。 | %companyname%的历史将在未来几年被遗忘。在那时，酒吧老板会被问起关于雇佣兵的事情，他会停滞一下，然后，你的面容、你的名字将从他的记忆中消失。他会耸耸肩，倒满另一杯酒。 | 当你的世界渐渐失去光芒时，你希望%companyname%的名字会流传下来，人们会记得他们的行动。但他们不会。 | 当痛苦侵袭你的身体时，你只能放手，退回到自己的思想中，封锁了自己，绝望地寻找为什么要选择这种生活的任何好理由，因为现在显而易见，选择这种生活就注定了你今天的命运。 | %companyname%战团全军覆没，你的尸体也在尸体堆中，这里不再有头衔或等级。这就是命运吗？在你死后，其他人会复活吗？世界会变回过去一样吗？ | 你杀了太多人，现在终于遭到报应--夺走了%companyname%所有人的生命。很少有人会谈论你，绝对比不上天上的乌鸦这么多。这个世界上雇佣兵从未缺乏工作，总会有新的雇佣军团来填补他们的位置… | %companyname%已经被彻底消灭，掠夺者现在在尸体中挑选装备，高兴地发现了什么并喊了出来。你为他们送上了礼物，可惜这是在你的最后时刻发生的。}";
		}
		else if (this.m.BusinessReputation >= 6000 && this.World.Statistics.getFlags().get("GreaterEvilsDefeated") >= 2)
		{
			this.Music.setTrackList(this.Const.Music.Retirement4Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("LeavingALegacy", 1, 1);
			data.Image = "ui/screens/retirement_04.jpg";
			data.Text = "{你的梦想都比你都走过的生活更加现实！在你的指挥下，%companyname%不仅获得了巨大的财富、荣誉和声望，你还帮忙击败了各种几乎毁灭整个地区的邪恶，入侵，以及战争! | %companyname%是一个家喻户晓的名字。它不仅积累了财富、权力和声望，还在击败困扰整个地区的一系列危机中发挥了关键作用。文书和历史学家们会讲述战团的故事，所以即便是千年之后，人们都将知道%companyname%! | 退休后，一位文书带着一名艺术家在找你，他们为你画了一幅肖像，然后将你的言论记录在了一个非常非常长的卷轴上。看起来，由于%companyname%击败了多场危机并且积累了巨大的财富，多年之后人们都还将知晓战团的名字。 | 离开%companyname%并不容易，但你打心底明白这是正确的选择。而且时机再好不过：战团已经在整个土地上声名远扬，它已经帮忙解决了一系列的危机，并且最重要的是，它积累了史无前例的财富。 | 在你的领导下，%companyname%在整个地区获得了巨大的名声，更不用说因帮忙解决一系列威胁整个地区的危机获得的大量感激！雇佣军很少出现在历史书籍中，但你毫不怀疑文书和学者们会用尽笔墨来记录%companyname%！}";
			this.removeSuccessor(brothers);
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
			data.Text += "\n\n{前几天，一位隐士来到你的小屋问你是否知道%companyname%。你摇了摇头并假装感兴趣。那名野人说这是这片土地上最伟大的战团。你问他对此是否确定？隐士仿佛你侮辱了他一般皱起了眉头。%SPEECH_ON%我确定吗？先生，你最好坐下。让我来告诉你所有关于%companyname%的事情。首先，他们说经营这家战团的人有七英尺高，浑身都是肌肉，名字叫...%SPEECH_OFF% | 离开战团并不是能轻易做下的决定，但是你的城堡里有一个让你能在金币中游泳的房间，所以也不算太糟糕。 | 现在你每天度日都不知道如何去花你的那些钱。很多人会来拜访城堡，大小形状个不相依的妇人...一些有着奇怪的圈钱点子的奇葩...还有一大批身着斗篷，谦逊的向你寻求战争意见的贵族王子们。有些日子里，你一边在花园里砍柴，一边考虑回到战场上去。到头来，无聊才是你所遇到过的最病态且难缠的野兽。 | 几天前，有个男人来到你的城堡。他想获得帮助以成立一个佣兵团，很显然他从你的事迹中获得了灵感。你问他与多少你之外成功的佣兵交谈过。他耸了耸肩。%SPEECH_ON%到目前为止只有你一个人。%SPEECH_OFF%你向他点头。%SPEECH_ON%没错，只有我，尽管这个领域里有无数人曾和我在一起。也许是因为我很出色，但我认为真相是我很幸运。所以，如果你想获得成立佣兵战团的建议，那就是别这样做。这就是全部了。我的一个仆人会带你离开。再见了。%SPEECH_OFF% | 在照料花园时，你发现一只老鼠在啃你的一颗番茄。它被美味的味道迷住了，你轻易地捕获了这只老鼠并双手抓住。你注视着它，失败的情感蔓延在它的脸上，而它的半张嘴还依旧啃着番茄。一个仆人赶了过来。%SPEECH_ON%我可以帮你除掉它，我的主上。%SPEECH_OFF%你盯着仆人，然后又看了老鼠一眼。%SPEECH_ON%不，我想我会留下他。我需要一个朋友。%SPEECH_OFF%仆人低下头。你拍了拍他的肩膀。%SPEECH_ON%高兴点。你也是我的朋友！%SPEECH_OFF%仆人微笑了。%SPEECH_ON%谢谢你，我的主上。%SPEECH_OFF%}";
		}
		else if (this.World.Statistics.getFlags().get("GreaterEvilsDefeated") >= 1)
		{
			this.Music.setTrackList(this.Const.Music.Retirement3Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("LeavingAMark", 1, 1);
			data.Image = "ui/screens/retirement_03.jpg";
			this.removeSuccessor(brothers);

			if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.CivilWar)
			{
				data.Text = "{接管%companyname%后，你为战团和它的人员有一个设想，设想中你坐上了国王宝座，手捧金色酒杯品尝全世界最昂贵的酒。可惜这些没有实现，但你确实在贵族内战中将战团引领上了巅峰。\n\n这样的斗争在贵族中是不可避免的，而你充分利用了战争为%companyname%赚取了声名和财富。当然，战斗的残酷也让你认识到战士的生活是短暂且不可预测的。当事情平定下来后，你意识到对贵族来说，你是谁以及你在战争中扮演什么角色根本毫不重要。你只是一个小小的齿轮，永远只是一个小小的齿轮。认真思考过这一点后，你决定退休，并在尽可能让战团保持在最佳状态后离开了。 | 当你接管%companyname%时，你真正相信你可以把它带向辉煌。这些目标可能有些过于高远，但至少你成功地打造了一个极有声望的战团。随着贵族不可避免地滑向战争，你对战团服务受欢迎的程度并不惊讶。战争证明了自己就如你所曾见的那边残酷和恐怖，但这次至少你能带着多到不知道该怎么花的钱离开。\n\n带着你的一堆金币退休后，你让依旧幸存的佣兵中最勇敢的那名来接管战团。战团直到今天仍然非常成功。}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{一名雇佣兵能在离开这一行时依旧没少零件实在太少见了，但你就做到了这一点。虽然身心健康很重要，但最让你感到满意的便是那一大堆克朗，让你每晚都能安稳入眠。据你最后听到的消息，贵族们正一路争吵地走向另一场战争，但你毫不在乎。 | 身心依旧健康，你平静的慢慢度过余生，几个月来最糟糕的事情不过是一个不知从哪块野地冒出来隐士偷走了你的柴火。这正是你一直想要的生活，你感到非常满足。}";
			}
			else if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.Greenskins)
			{
				data.Text = "{当你接手%companyname%时，你没有预见到历史会以最糟糕的方式重演自己。群雄乱战只是你听到过的故事，但看到它再次上演——一场大规模的绿皮兽人入侵——在你自己的生命中历历在目。而你已经做好准备迎接这场战斗。\n\n尽管这个团队不太可能在世界历史上有太多的提及，但你毫不怀疑它在击败绿色野蛮人方面起到了至关重要的作用。否则的话，你有一个巨大的金币堆来证明什么呢？\n\n正是在那堆金币上，你决定退休，把这支队伍交给最好的人。 | 群雄乱战，那是历史学家称之为人类全面对抗庞大的绿皮兽人的伟大冲突。你认为这些故事已经是过时的，但从东方地平线涌来的野蛮人部队证明了相反的事实。这一次，兽人学会了在整个土地上入侵，而不是在一处地方。尽管他们有了新的策略，但人类世界却有了新的武器：%companyname%。\n\n也许这只是你自己的骄傲在说话，但你真的相信你战团的贪婪活动在扭转局面中起到了至关重要的作用。随着绿皮族的被击败，你发现自己有了一堆金币来退休，并把战团的指挥权交给了最优秀的人。}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{有些夜晚，你突然从梦中惊醒，头上满是汗水，狂战士的咆哮逐渐消失在未完成的梦境中。这些噩梦不会离开你，证明它们是你所获得的财富的最终代价。虽然%companyname%做得很好，但你有时会想是否最好还是由你来领导它。在你“安定”的退休生活中，你发现你可以掌控和击杀的恐惧与隐藏在你最大的恐惧之处的恐惧截然不同。 | 你现在的日子是花时间修剪花园、杀兔子。偶尔，你会听到%companyname%的消息，听到它的成功故事，但令人遗憾的是，偶尔会听到其中一个兄弟牺牲的消息。这些故事是一种喜闻乐见的慰藉，可以让你暂时放下连日来赶兔子的工作。你曾经花了很多时间在战斗中，从未意识到收获季节和这些该死的咬食怪物之间发生的战争。}";
			}
			else if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.Undead)
			{
				data.Text = "{你曾经以为自己了解了这个世界的残酷。当你接手了%companyname%时，你相信你可以确保将战团带向财富和荣誉。但从坟墓里爬出来的亡者扼杀了这种天真的幻想。但你很快适应了这种情况，并认真寻找那些支付最高的合同以应对这种奇怪而超现实的威胁。最终，不死大军被打回了它们来的地方。\n\n克朗、荣誉、声望，一切都已经获得。你决定退休，将战团托付给最好的人。 | 当你接管%companyname%时，你不可能预见到它在打败大批不死者入侵者中的关键作用。然而，对于死者的不同赏金证明非常有利可图，而在这场大恶魔之后赚到的一大堆金子，你决定退休。%companyname%留给了你最信任的成员照顾。}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{如今，你花了很多时间纠结是否应该给你的小木屋加一层或者这是否会带来太多的工作。你当然可以支付别人来帮忙，但是请别人帮忙总感觉有点奇怪。就%companyname%来说，你听说它一直很出色。 | 你整天都在和邻居调情。 她已经结婚了，但这正是让它变得更有趣的原因。警长来找过你，询问你新的嗜好。这就是现在你生活中最激烈的戏剧。虽然不像是躲避兽人或将不死灵魂归还坟墓，但却有着自己独特的乐趣。你并不怀念旧的生活。相反，你可以愉快地坐下来听关于%companyname%的趣闻。}";
			}
			else if (this.World.FactionManager.getGreaterEvil().LastType == this.Const.World.GreaterEvilType.HolyWar)
			{
				data.Text = "{指挥着%companyname%，你认为它可能会扮演佣兵的角色，添加一些强盗行径。然而你没有意识到整个世界都会陷入宗教纷争之中。当北方和南方因他们的信仰狂热而对抗时，你带领战团取得了丰厚的回报。如果古老神明的信徒请求你的援助，你带来了来自北方山脉的强大力量。如果吉尔德的人请求你的鼎力相助，你带来了阳光。 | 据说人越虔诚，神越人性化。当北方和南方宗教的裂缝爆发时，各种宗教骗子涌入圣殿。这些神圣的人将自己的灵魂神化，将战争的效用磨利，仿佛是神自己命令战争一样。也许是的，但最终你只关心%companyname%自身的利益。吉尔德？古老的神明？你在乎的只有自己的腰包，在所有这些神圣的胡言乱语结束时，它们确实很鼓盈。}";
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += "\n\n{很少有佣兵团幸存下来，甚至没有几个出现在历史记录中。但你相信%companyname%通过在圣战中的行动，很可能已经会被载入史册。这个想法令你感到好笑，因为一两句话真的可以说出你所做和经历的一切吗？ | 随着从%companyname%的退休，你终于有足够的时间来思考这些古神和吉尔德。也许其中一种有些不为人知的真相？也许它们都真正的神？或者，你谨慎地权衡着这些想法，也许两者都是虚无而不存在的。但似乎这些信仰都不是唯一的。宗教的起义似乎无处不在，毫无疑问这些都是宗教战争的残留物，而就在前几天，第三个主要的参与者到来了，你对他已经非常了解了：达夫库尔的门徒。当他宣扬黑暗和神秘的思想时，你关上了门。也许下次再说吧。你有木头要劈，还有一个抽屉的袜子要整理。}";
			}
		}
		else if (this.m.BusinessReputation >= 1100 && this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			this.Music.setTrackList(this.Const.Music.Retirement2Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("ABitterEnd", 1, 1);
			data.Image = "ui/screens/retirement_02.jpg";

			if (this.Math.rand(1, 100) <= 25)
			{
				data.Text = "你把%companyname%重建得非常出色。你努力让战团的队伍充实起来，并更加努力地让战团的名字重新在整个土地上变得重要起来。当你最终退休时，你让%highestbravery_bro% 掌管战团，并祝他好运。\n\n在他的领导下，%companyname%取得了足够好的成绩，在战事频发的地区活跃。\n\n然后，在你离开几个月后，贵族间的争斗升级了。 %highestbravery_bro% 毫不犹豫地抓住这个机会，借着战事掠夺财宝，但其他人则选择了走另一条路。";
				this.removeSuccessor(brothers);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
				data.Text += "贵族们打着自己危险的战争游戏，但是%highestbravery_bro%没有预料到即将发生的事情。在战争中取得了一些成功的小冲突之后，%companyname% 发现他们被置于对抗更多敌人的不利境地，没有任何逃脱的可能，也没有援军来支援他们。他们最后沦为了战争的牺牲品，贵族将他们用作弃子来吸引敌人，然后再对其他地方发动袭击。毕竟，佣兵很容易被替换，死去的人也不再需要报酬。这场战斗对战争来说并不重要，但对该战团却是灾难性的失败，从此再难恢复。\n\n战争还持续了两年，但当战争结束时，很少还记得'%companyname%'这个名字了...";
			}
			else
			{
				data.Text = "{在将%companyname%在领域中建立显著名声之后，领主们会互相竞标以获取你们的服务。他们不仅是为了你们为他们而战，还因为他们最起码不必与你作对！大量的克朗滚滚而来，你相信战团没有你也会做得很好，现在似乎是适当的时候放下武器，开始过一种远离战争和杀戮的生活。\n\n不幸的是，太受欢迎是有代价的。战团不断签下战时合同，随着时间的推移，战团逐渐被耗尽殆尽。兄弟们开始离开，以免成为下一个认为自己最懂如何指挥雇佣兵的贵族的牺牲品。 | 你在离开战团后，在山区过上寻求更安宁的生活，你听说%companyname%在贵族中变得越来越受欢迎。随着每场战争，伯爵和男爵都会寻求战团的服务。然而，这样的普及是有代价的。每一次新的冲突、每一次新的战争，都不是没有代价的。战团的实力逐渐衰减，人数不断减少，要么是因为伤亡，要么是因为像你一样及时离开而离开。你最后听说战团几乎被一位贵族指挥官用于正面进攻摧毁。 | 当你接手%companyname%的时候，它只是一小撮挣扎求生的人。现在，它更像是一个活跃的商业冒险。但是，杀戮的生意从来不是你人生中的目标。有了足够的钱，你退休了，将战团交给了你最信任的人之一%successor%。\n\n不幸的是，你的继承者并没有保护好士兵的本领。你最后听说他们不断地接受合同，不顾自己的安全，追求越来越多的克朗。这种对金钱的侵略性追求最终导致了战团在贵族的战斗中被摧毁。尽管%companyname%的声誉很高，但是一位贵族男爵毫不犹豫地将其作为诱饵吸引更庞大的力量。值得庆幸的是，在这场战斗之前，还有一些人设法退休了。}";
				this.removeSuccessor(brothers);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, true);
				data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
				data.Text += "\n\n{但这对于佣兵来说只是生意罢了。有人成功了，有人失败了。没有哪个战团能永存，至少极少数会被载入史册。你打算养老安度晚年，希望那些在出卖军队中幸存下来的人也能这样。 | 这就是雇佣军的生活。有人获胜，有人失败。嗯，大多数人只会失败。你试图将过去拋在脑后，继续过着平静的生活。 | 现在就是佣兵的生活。关于雇佣军的唯一稳定之处就是理解并非所有人都能活着离开。每个人在签约时都知道这一点，你也包括在内。你很幸运，但其他人没有。这就是事实。你打算过着尽可能好的日子，不仅为了自己，也为了那些没有活下来的人。}";
			}
		}
		else
		{
			this.Music.setTrackList(this.Const.Music.Retirement1Tracks, this.Const.Music.CrossFadeTime);
			this.updateAchievement("EarlyRetirement", 1, 1);
			data.Image = "ui/screens/retirement_01.jpg";
			data.Text = "{没有了你的领导，%companyname% 很快就解散了。每个人都走自己的路，但对于一个唯一真正的天赋是战斗的人来说，他还能做什么呢？ | 在你退休后不久，%companyname% 就解散了。新的领导在签约方面做出了糟糕的选择，也证明了自己在指挥战斗方面更糟。当谋生与赢得战斗是你的事业时，战团在你离开后不久失败并不那么令人惊讶。 | 没有了你的领导，%companyname%获得了一系列糟糕的合同，最终导致了战团的解散。 | 你决定在那之前退役，这样它就不会像其他人一样伴随着剑和可怕的惨叫声消散。其中一名兄弟接任了你的职位，但他们虽然是优秀的佣兵，但在战斗和领导之间有着天壤之别。%companyname% 遭受了一系列糟糕的合同和更糟糕的战斗，最终导致了它的灭亡。 | 你的退休决定对你和%companyname%来说都很不容易。他们迫切地争取你留下。但是时机已经到了，于是你走了。其中一名佣兵接任了团队的领袖，但是成为一名优秀的战士并不一定能使你成为一个伟大的领导者，因此该战团很快就解散了。 | 佣兵们试图让你留下，但你觉得是时候完全退出战斗了。最后，%companyname% 的新指挥官被愚弄成了一份可怕的合同。钱不对头，而战斗本身很快就变得不利。这个错误发生后不久，战团完全解散了。}";
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
			data.Text += this.addBrotherEnding(brothers, excludedBackgrounds, false);
			data.Text += "\n\n{你没有从其他人那里得到消息，但你现在已经退休了，你的储蓄正在减少…… | 现在你坐在肮脏的地方，只有一支小蜡烛的光芒为你作伴，你开始后悔自己的决定。事情对你来说并不顺利，留下的人的故事让你非常困扰。 | 现在你坐在一个小屋里，周围是一群睡着了的陌生人，为了保暖而拥挤在一起。你用微弱的烛光注视着%companyname%的破旧纹章。指尖不停地轻弹，回忆着美好的记忆，以克服这种新的贫困，直到有人咳嗽声响，灯光熄灭。 | 现在你坐在一个酒馆的地下室里，和一些无家可归的乞丐和流浪汉睡在一起，他们没有钱租一间房子。你想回到佣兵界，但是没有钱，你必须从底层开始工作，很可能要在一些无能的指挥官的麾下当士兵。死于贫困或死于无能，这似乎是你现在的选择。 | 现在你独自坐在一家酒馆里，把最后的硬币投入一只酒角里。当你喝完这杯酒，一个高大的男人走进了酒吧。他的裤子、肩膀和胸部都缀满了皮革护甲，银色的制服上有一个镶金的武器。他挺直身体，双手插着腰，环顾四周。%SPEECH_ON%你们哪个人渴望为金钱而杀？我正在寻找佣兵。我只要你会挥动一把剑，不怕别人挥动剑。%SPEECH_OFF%你喝完你的饮料，佣兵转向你，仿佛他已经知道你是谁，也知道你的能力。 | 很难找到其他人的消息。几个月后，你放弃了想要找到他们在哪里或者他们怎么样的尝试。相反，每晚都在想为什么你第一次做出这个选择，看着你的储蓄慢慢减少，对内心的疑虑和思考进行抗争。}";
		}

		data.Text += "\n\n";
		data.Text = this.buildGameFinishText(data.Text);
		return data;
	}

	function addBrotherEnding( _brothers, _excludedBackgrounds, _isPositive )
	{
		local removeIndex;
		local candidates = [];

		foreach( i, bro in _brothers )
		{
			if (_excludedBackgrounds.find(bro.getBackground().getID()) != null)
			{
				continue;
			}

			if (_isPositive && bro.getBackground().getGoodEnding() != null)
			{
				candidates.push({
					Index = i,
					Bro = bro
				});
			}
			else if (!_isPositive && bro.getBackground().getBadEnding() != null)
			{
				candidates.push({
					Index = i,
					Bro = bro
				});
			}
		}

		if (candidates.len() == 0)
		{
			return "";
		}

		local bro = candidates[this.Math.rand(0, candidates.len() - 1)];
		_brothers.remove(bro.Index);
		_excludedBackgrounds.push(bro.Bro.getBackground().getID());
		local villages = this.World.EntityManager.getSettlements();
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoblehouse",
				nobleHouses[this.Math.rand(0, nobleHouses.len() - 1)].getName()
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomtown",
				villages[this.Math.rand(0, villages.len() - 1)].getNameOnly()
			],
			[
				"name",
				bro.Bro.getNameOnly()
			]
		];

		if (_isPositive)
		{
			return "\n\n" + this.buildTextFromTemplate(bro.Bro.getBackground().getGoodEnding(), vars);
		}
		else
		{
			return "\n\n" + this.buildTextFromTemplate(bro.Bro.getBackground().getBadEnding(), vars);
		}
	}

	function removeSuccessor( _brothers )
	{
		local highest_bravery = 0;
		local highest_bravery_bro;

		foreach( i, bro in _brothers )
		{
			if (bro.getCurrentProperties().getBravery() > highest_bravery)
			{
				highest_bravery = bro.getCurrentProperties().getBravery();
				highest_bravery_bro = i;
			}
		}

		_brothers.remove(highest_bravery_bro);
	}

	function buildGameFinishText( _text )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local villages = this.World.EntityManager.getSettlements();
		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local text;
		local vars = [
			[
				"SPEECH_ON",
				"\n\n[color=#bcad8c]\""
			],
			[
				"SPEECH_OFF",
				"\"[/color]\n\n"
			],
			[
				"companyname",
				this.World.Assets.getName()
			],
			[
				"randomname",
				this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)]
			],
			[
				"randomnoblehouse",
				nobleHouses[this.Math.rand(0, nobleHouses.len() - 1)].getName()
			],
			[
				"randomnoble",
				this.Const.Strings.KnightNames[this.Math.rand(0, this.Const.Strings.KnightNames.len() - 1)]
			],
			[
				"randomtown",
				villages[this.Math.rand(0, villages.len() - 1)].getNameOnly()
			]
		];

		if (brothers.len() != 0)
		{
			local brother1 = this.Math.rand(0, brothers.len() - 1);
			local brother2 = this.Math.rand(0, brothers.len() - 1);

			if (brothers.len() >= 2)
			{
				while (brother1 == brother2)
				{
					brother2 = this.Math.rand(0, brothers.len() - 1);
				}
			}

			brother1 = brothers[brother1].getName();
			brother2 = brothers[brother2].getName();
			local highest_bravery = 0;
			local highest_bravery_bro;

			foreach( bro in brothers )
			{
				if (bro.getCurrentProperties().getBravery() > highest_bravery)
				{
					highest_bravery = bro.getCurrentProperties().getBravery();
					highest_bravery_bro = bro;
				}
			}

			vars.extend([
				[
					"randombrother",
					brother1
				],
				[
					"randombrother2",
					brother2
				],
				[
					"highestbravery_bro",
					highest_bravery_bro.getName()
				],
				[
					"successor",
					highest_bravery_bro.getName()
				]
			]);
		}

		return this.buildTextFromTemplate(_text, vars);
	}

	function getScore()
	{
		local s = this.m.Score;
		local namedItems = 0;
		local legendaryItems = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null)
			{
				s = s + item.getValue() * 0.002;

				if (item.isItemType(this.Const.Items.ItemType.Named))
				{
					namedItems = ++namedItems;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Legendary) && item.getID() != "armor.head.fangshire")
				{
					legendaryItems = ++legendaryItems;
				}
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			s = s + bro.getLevel() * 4;
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item != null)
			{
				s = s + item.getValue() * 0.002;

				if (item.isItemType(this.Const.Items.ItemType.Named))
				{
					namedItems = ++namedItems;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Legendary))
				{
					legendaryItems = ++legendaryItems;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (item != null)
			{
				s = s + item.getValue() * 0.002;

				if (item.isItemType(this.Const.Items.ItemType.Named))
				{
					namedItems = ++namedItems;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Legendary))
				{
					legendaryItems = ++legendaryItems;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

			if (item != null)
			{
				s = s + item.getValue() * 0.002;

				if (item.isItemType(this.Const.Items.ItemType.Named))
				{
					namedItems = ++namedItems;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Legendary) && item.getID() != "armor.head.fangshire")
				{
					legendaryItems = ++legendaryItems;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null)
			{
				s = s + item.getValue() * 0.002;

				if (item.isItemType(this.Const.Items.ItemType.Named))
				{
					namedItems = ++namedItems;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Legendary))
				{
					legendaryItems = ++legendaryItems;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null)
			{
				s = s + item.getValue() * 0.002;

				if (item.isItemType(this.Const.Items.ItemType.Named))
				{
					namedItems = ++namedItems;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Legendary))
				{
					legendaryItems = ++legendaryItems;
				}
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null)
				{
					s = s + item.getValue() * 0.002;

					if (item.isItemType(this.Const.Items.ItemType.Named))
					{
						namedItems = ++namedItems;
					}
					else if (item.isItemType(this.Const.Items.ItemType.Legendary))
					{
						legendaryItems = ++legendaryItems;
					}
				}
			}
		}

		s = s + 25 * namedItems;
		s = s + 100 * legendaryItems;
		s = s + (this.getBusinessReputation() - 100) * 0.25;

		if (this.World.Statistics.getFlags().has("GreaterEvilsDefeated") && this.World.Statistics.getFlags().get("GreaterEvilsDefeated") >= 1)
		{
			s = s * this.Math.pow(1.25, this.World.Statistics.getFlags().get("GreaterEvilsDefeated"));
		}

		s = s / this.Math.maxf(10.0, this.World.getTime().Days);
		return this.Math.max(0, this.Math.round(s * 10));
	}

	function onSerialize( _out )
	{
		_out.writeU16(this.m.Stash.getCapacity());
		this.m.Stash.onSerialize(_out);
		_out.writeI32(this.m.CampaignID);
		_out.writeString(this.m.Name);
		_out.writeString(this.m.Banner);
		_out.writeU8(this.m.BannerID);
		_out.writeU8(this.m.Look);
		_out.writeU8(this.m.EconomicDifficulty);
		_out.writeU8(this.m.CombatDifficulty);
		_out.writeBool(this.m.IsIronman);
		_out.writeBool(!this.m.IsPermanentDestruction);
		_out.writeString(this.m.Origin.getID());
		_out.writeString(this.m.SeedString);
		_out.writeF32(this.m.Money);
		_out.writeF32(this.m.Ammo);
		_out.writeF32(this.m.ArmorParts);
		_out.writeF32(this.m.Medicine);
		_out.writeU32(this.m.BusinessReputation);
		_out.writeF32(this.m.MoralReputation);
		_out.writeF32(this.m.Score);
		_out.writeU16(this.m.LastDayPaid);
		_out.writeU8(this.m.LastHourUpdated);
		_out.writeF32(this.m.LastFoodConsumed);
		_out.writeBool(this.m.IsCamping);
		_out.writeBool(this.m.IsExplorationMode);
	}

	function onDeserialize( _in )
	{
		this.m.Stash.resize(_in.readU16());
		this.m.Stash.onDeserialize(_in);

		if (this.m.OverflowItems.len() != 0)
		{
			foreach( item in this.m.OverflowItems )
			{
				this.m.Stash.add(item);
			}

			this.m.OverflowItems = [];
		}

		this.m.CampaignID = _in.readI32();
		this.m.Name = _in.readString();
		this.m.Banner = _in.readString();
		this.m.BannerID = _in.readU8();
		this.m.Look = _in.readU8();
		this.m.EconomicDifficulty = _in.readU8();
		this.m.CombatDifficulty = _in.readU8();
		this.m.IsIronman = _in.readBool();
		this.m.IsPermanentDestruction = !_in.readBool();

		if (_in.getMetaData().getVersion() >= 46)
		{
			this.m.Origin = _in.readString();
			this.m.Origin = this.Const.ScenarioManager.getScenario(this.m.Origin);
		}

		if (this.m.Origin == null)
		{
			this.m.Origin = this.Const.ScenarioManager.getScenario("scenario.tutorial");
		}

		if (_in.getMetaData().getVersion() >= 41)
		{
			this.m.SeedString = _in.readString();
		}
		else
		{
			_in.readI32();
			this.m.SeedString = "未知的";
		}

		if (_in.getMetaData().getVersion() < 64 && this.m.Origin != null && this.m.Origin.getID() == "scenario.manhunters")
		{
			this.m.Stash.add(this.new("scripts/items/misc/manhunters_ledger_item"));
		}

		this.m.Money = _in.readF32();
		this.m.Ammo = this.Math.max(0, _in.readF32());
		this.m.ArmorParts = this.Math.max(0, _in.readF32());
		this.m.Medicine = this.Math.max(0, _in.readF32());
		this.m.BusinessReputation = _in.readU32();
		this.m.MoralReputation = _in.readF32();
		this.m.Score = _in.readF32();
		this.m.LastDayPaid = _in.readU16();
		this.m.LastHourUpdated = _in.readU8();
		this.m.LastFoodConsumed = _in.readF32();
		this.m.IsCamping = _in.readBool();
		this.updateAverageMoodState();
		this.updateFood();
		this.updateFormation();
		this.m.IsExplorationMode = _in.readBool();
		this.m.Origin.onInit();
	}

};

