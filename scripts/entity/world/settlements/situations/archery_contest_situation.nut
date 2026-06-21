this.archery_contest_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.archery_contest";
		this.m.Name = "弓术比赛";
		this.m.Description = "弓术比赛引来了任何善于用弓的人。也许是一个找对应类型的新兵的好时机。";
		this.m.Icon = "ui/settlement_status/settlement_effect_31.png";
		this.m.Rumors = [
			"如果你是一个熟练的弓箭手，你可能会想去参加%settlement%的那个大型竞赛，然后来上那么几发！",
			"你知道吗？我自己曾经是远近最好的弓箭手，我发誓！直到一头该死的驴子踩了我的手。否则的话，我现在就应该在%settlement%参加箭术比赛了…",
			"最近几天任何熟练的弓箭手都在前往%settlement%参加什么比赛。要我想，他们中的大多数都是偷猎者和其他渣滓。"
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

	function onUpdate( _modifiers )
	{
		_modifiers.RecruitsMult *= 1.25;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("hunter_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("poacher_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");

		if (this.Const.DLC.Unhold)
		{
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
		}
	}

});

