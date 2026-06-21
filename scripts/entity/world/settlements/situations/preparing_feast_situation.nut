this.preparing_feast_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.preparing_feast";
		this.m.Name = "准备盛宴";
		this.m.Description = "贵族们正在准备宴会。烹调室和厨房正在大量购买食物。";
		this.m.Icon = "ui/settlement_status/settlement_effect_29.png";
		this.m.Rumors = [
			"了不起的贵族们正在%settlement%准备一场盛宴，而我们农民却只有老粮可以啃…",
			"我叔叔在%settlement%当仆人，他告诉我他们正在准备一场盛大的宴会。不过，除非你受到了邀请，否则去那里没有意义。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 3;
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
		_modifiers.FoodRarityMult *= 0.25;
		_modifiers.FoodPriceMult *= 2.0;
	}

});

