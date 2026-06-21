this.witch_burnings_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.witch_burnings";
		this.m.Name = "焚烧女巫";
		this.m.Description = "一个火热的场面，焚烧女巫引来观众，观众引来食品摊。然后，镇上肯定会有很多女巫猎人…";
		this.m.Icon = "ui/settlement_status/settlement_effect_32.png";
		this.m.Rumors = [
			"昨天来了一些女巫猎人。他们没有找到他们要找的东西，之后就去了%settlement%。",
			"据我所知，他们在%settlement%发现了一个女巫，将要把她送进火堆。这么一想，也许我该举报前几天在市场上打败我的那个老泼妇，她肯定是个女巫！"
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
		_settlement.resetRoster(true);
	}

	function onRemoved( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodRarityMult *= 1.35;
		_modifiers.FoodPriceMult *= 1.15;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
	}

});

