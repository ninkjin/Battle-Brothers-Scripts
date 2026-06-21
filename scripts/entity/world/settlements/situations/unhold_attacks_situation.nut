this.unhold_attacks_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.unhold_attacks";
		this.m.Name = "巨魔袭击";
		this.m.Description = "大块头的巨魔在这片地区被目击和听闻。镇上的居民害怕离开定居点附近。";
		this.m.Icon = "ui/settlement_status/settlement_effect_26.png";
		this.m.Rumors = [
			"一位旅行商人告诉我，从%settlement%过来的路上有巨大的脚印。不管是什么野兽的留下脚印，当然决斗绝对都不想碰到。",
			"前几天我在%settlement%时，一群猎人失踪了。他们在追捕某种巨人…",
			"有没有听说过巨魔？一只脚就能踩下整个货车的巨大怪物！我听说%settlement%附近有人目击。"
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
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.SellPriceMult *= 0.9;
		_modifiers.RarityMult *= 0.9;
		_modifiers.RecruitsMult *= 0.75;
	}

});

