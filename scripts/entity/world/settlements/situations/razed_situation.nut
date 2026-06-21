this.razed_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.razed";
		this.m.Name = "被夷平";
		this.m.Description = "这个地方被夷为平地。它的许多居民遭到杀害，任何贵重物品都被掠走了。";
		this.m.Icon = "ui/settlement_status/settlement_effect_10.png";
		this.m.Rumors = [
			"从几英里外就可以看到烟柱。%settlement%曾经所在的地方现在只剩下一片燃烧的瓦砾。",
			"大批难民从%settlement%涌来。他们声称它的大部分都被烧成了白地！这怎么会是真的？",
			"%settlement%已不复存在，只剩下焦黑的的残骸在冒烟和阴燃…怎么会这样？"
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
		_modifiers.SellPriceMult *= 0.5;
		_modifiers.BuyPriceMult *= 2.0;
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 0.25;
		_modifiers.RarityMult *= 0.25;
	}

});

