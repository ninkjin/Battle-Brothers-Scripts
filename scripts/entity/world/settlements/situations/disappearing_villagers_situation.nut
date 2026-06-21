this.disappearing_villagers_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.disappearing_villagers";
		this.m.Name = "消失的村民";
		this.m.Description = "村民不断从这个镇子中消失，使每个人都很紧张。街上的潜在新兵变少，人们对陌生人的态度也变差。";
		this.m.Icon = "ui/settlement_status/settlement_effect_11.png";
		this.m.Rumors = [
			"在听说那边有人失踪后，我就取消了%settlement%之行。远离麻烦当目前为止对我很管用！",
			"我的邻居%randomname%大约一周前去了%settlement%，从那以后就再也没有听到过他的消息。我只希望他没出啥意外，你知道的，强盗和怪物什么的到处游荡…",
			"邪恶的力量在这个世界上很强大。他们躲在树林里，山里，阴影里，而有时人们会一下消失的无影无踪。现在在%settlement%这些又发生了。"
		];
	}

	function getAddedString( _s )
	{
		return _s + "现在有" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再有" + this.m.Name;
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RecruitsMult *= 0.5;
	}

});

