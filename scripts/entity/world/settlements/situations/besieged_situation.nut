this.besieged_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.besieged";
		this.m.Name = "被围困";
		this.m.Description = "这个地方目前或直到最近一直被敌人围困！它遭受了破坏，补给不足并且有许多人丧生。";
		this.m.Icon = "ui/settlement_status/settlement_effect_13.png";
		this.m.Rumors = [
			"石块和火箭乱飞，热油被倒下，人们饥饿并死亡，那就是围城。你可以亲自去%settlement%仔细见识一下。",
			"我年轻时曾在%randomnoble%的军队服役。最糟糕的是我们参与的一场围城，持续了几个月。很遗憾现在在%settlement%又发生了一样的事情。",
			"你听说了吗？%settlement%被围困了！那里的穷人将深受其害。"
		];
		this.m.IsStacking = false;
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
		_settlement.resetRoster(false);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.0;
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 0.5;
		_modifiers.RarityMult *= 0.5;
	}

});

