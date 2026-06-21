this.hunting_season_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.hunting_season";
		this.m.Name = "狩猎季节";
		this.m.Description = "森林里满是鹿，现在是狩猎季节。鹿肉和毛皮供应充足。";
		this.m.Icon = "ui/settlement_status/settlement_effect_36.png";
		this.m.Rumors = [
			"你喜欢鹿肉吗，佣兵？你的人喜欢吗？我听说%settlement%的狩猎季节已经开始了。就是说说而已。",
			"这是一年中所有猎人都热切期待的时间。%settlement%的狩猎季节刚刚开始了！",
			"在狩猎季节以外打猎可能会使你的手被砍掉！不过没关系，因为在%settlement%的森林狩猎季很快将要开始。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 5;
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
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 2.0;
		_modifiers.FoodPriceMult *= 0.5;
	}

});

