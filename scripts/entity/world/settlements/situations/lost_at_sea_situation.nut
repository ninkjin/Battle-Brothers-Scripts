this.lost_at_sea_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.lost_at_sea";
		this.m.Name = "海难";
		this.m.Description = "一艘载着渔民的船在一场暴风雨中消失在了大海里。新鲜的鱼和自愿的新兵都很罕见。";
		this.m.Icon = "ui/settlement_status/settlement_effect_18.png";
		this.m.Rumors = [
			"他们再也没有从海上回来…想到%settlement%那些死去的可怜人，我不禁发抖。",
			"%settlement%的那些少妇们真操蛋，哭哭啼啼。我去那卖我的猪，但她们只是嚎啕大哭，一个男的都找不到。是什么船在海上失踪了还是什么，一头猪也没卖出去就打道回府了。",
			"航海一直是一种危险的职业，所以我才远离了水。我可以说时机正好，否则%settlement%那艘失踪的船上可能就有我。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 4;
	}

	function getAddedString( _s )
	{
		return _s + "现在有" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再有" + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.5;
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 0.5;
	}

});

