this.moving_sands_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.moving_sands";
		this.m.Name = "流沙";
		this.m.Description = "城市周围地区到处都是成群的大蛇，有些更是特别巨大。贸易受到影响，商品变得稀缺和昂贵。";
		this.m.Icon = "ui/settlement_status/settlement_effect_42.png";
		this.m.Rumors = [
			"有消息说，在去%settlement%的路上，商人们被流沙整个吞没了。但谁会相信这种胡话？",
			"你怕蛇吗？最近在%settlement%附近发现了不少，有的像我的胳膊那么长，有的像一整个商人的货车那么长！"
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

	function onAdded( _settlement )
	{
		_settlement.removeSituationByID("situation.safe_roads");
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.85;
	}

});

