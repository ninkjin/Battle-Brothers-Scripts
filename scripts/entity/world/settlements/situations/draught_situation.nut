this.draught_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.draught";
		this.m.Name = "干旱";
		this.m.Description = "一股意料之外的热浪烧毁了许多当地的农作物。食物变得更少同时价格变得更高。";
		this.m.Icon = "ui/settlement_status/settlement_effect_16.png";
		this.m.Rumors = [
			"据我所知，%settlement%正遭受严重的干旱。那边的人生活一直很艰难，但这次更可怕。",
			"如果你确实跟看上去的一样鲁莽，你可以考虑在%settlement%卖食物赚点快钱。一场严重的干旱使人们挨饿，所以他们为了果腹会愿意支付一切。",
			"哦，孩子，我以前在%settlement%当过求雨师，但那些傻瓜把我赶走了！现在，无可否认，那个村子正遭受着一场旱灾，但这难道不是更需要依靠我的理由吗？要我说都是傻瓜！"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 7;
	}

	function getAddedString( _s )
	{
		return _s + "正遭受" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再遭受" + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 0.5;
		_modifiers.FoodPriceMult *= 2.0;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
		_draftList.push("farmhand_background");
	}

});

