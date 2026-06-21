this.warehouse_burned_down_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.warehouse_burned_down";
		this.m.Name = "仓库烧毁";
		this.m.Description = "仓库最近发生的一场火灾造成了严重的损失。火灾中幸存下来的货物现在以高价出售。";
		this.m.Icon = "ui/settlement_status/settlement_effect_21.png";
		this.m.Rumors = [
			"昨晚看见地平线上的烟了吗？他们说是%settlement%的一个大仓库被烧成了平地。",
			"我听说在%settlement%点燃仓库的纵火犯被抓住了，当场就把他吊死在了树上，但他们要花很长时间才能重新建起仓库。"
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
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 1.05;
		_modifiers.RarityMult *= 0.5;
	}

});

