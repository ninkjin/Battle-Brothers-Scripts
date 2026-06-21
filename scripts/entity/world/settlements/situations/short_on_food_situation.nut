this.short_on_food_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.short_on_food";
		this.m.Name = "食物短缺";
		this.m.Description = "最近的事件使这个地方缺少食物。由于人们处于饥饿的边缘，食物很难找到，价格也在上涨。";
		this.m.Icon = "ui/settlement_status/settlement_effect_04.png";
		this.m.Rumors = [
			"我听说%settlement%的男男女女都在挨饿，除了土什么都没得吃。我想我再也不会抱怨我的霉粮汤了！",
			"有个农夫今天刚从%settlement%过来。讲述了被宰杀的牛，被烧毁的田地和空荡荡的储藏室的故事。他自己看起来就像个活骷髅！"
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
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.5;
		_modifiers.FoodPriceMult *= 3.0;
	}

});

