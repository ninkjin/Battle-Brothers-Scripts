this.rich_veins_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.rich_veins";
		this.m.Name = "丰富的矿脉";
		this.m.Description = "一些幸运的矿工找到了一条特别丰富的矿脉！在其耗尽之前，矿产和金属的开采量都将大大增加，但定居点的物价也上涨了。";
		this.m.Icon = "ui/settlement_status/settlement_effect_33.png";
		this.m.Rumors = [
			"他们在%settlement%找到了一个主矿脉。我自己也在矿井里工作了几十年，对此我能做出的全部表示就是严重的咳嗦。",
			"%settlement%那些幸运的混蛋们在矿井里发现了一个新矿脉。他们挖出来的东西商队都来不及运走。",
			"我听说%settlement%的矿井最近产量惊人。如果你在做生意的话，这是个不错的赚钱方法。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 4;
	}

	function getAddedString( _s )
	{
		return _s + "有" + this.m.Name;
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
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.MineralRarityMult = 1.5;
	}

});

