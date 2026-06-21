this.refugees_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.refugees";
		this.m.Name = "难民";
		this.m.Description = "随着战争愈演愈烈，源源不断的难民涌入这个定居点。这给当地经济带来了压力，但也意味着为任何能提供工作的人提供了廉价的招聘机会。";
		this.m.Icon = "ui/settlement_status/settlement_effect_01.png";
		this.m.Rumors = [
			"早上好，我要出发前往%settlement%。听说有一大群难民刚到那，而我的农场需要更多的人手。",
			"据我所知，%settlement%这几天到处都是难民。要我说，那些懦夫应该留下来为他们的家园而战！",
			"乞丐，贱民，逃犯，他们都需要有个去处。据我所知，一大群这类人刚抵达%settlement%。"
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
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.RarityMult *= 0.9;
		_modifiers.FoodRarityMult *= 0.75;
		_modifiers.FoodPriceMult *= 1.25;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
		_draftList.push("refugee_background");
	}

});

