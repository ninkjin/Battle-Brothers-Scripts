this.mine_cavein_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.mine_cavein";
		this.m.Name = "矿井塌方";
		this.m.Description = "一场悲剧发生了，矿井中的其中一个塌方了。直到损伤得以修复前生产中断，同时矿工们没了养家糊口的活计。";
		this.m.Icon = "ui/settlement_status/settlement_effect_24.png";
		this.m.Rumors = [
			"我才不去地下工作，我不是臭鼹鼠！那是个该死的死亡陷阱！不久前%settlement%的一个矿井塌方了，我根本不想知道那天死了多少人…",
			"从%settlement%的矿井运来的一批矿石本应今天交接，然而到现在还没到。那边一定发生了什么事情。",
			"听说%settlement%的一个矿井发生了塌方。想象一下被活埋在岩石和泥土的深处…"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 5;
	}

	function getAddedString( _s )
	{
		return _s + "遭受" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再遭受" + this.m.Name;
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

	function onUpdateShop( _stash )
	{
		do
		{
		}
		while (_stash.removeByID("misc.uncut_gems") != null);

		do
		{
		}
		while (_stash.removeByID("misc.copper_ingots") != null);
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
		_draftList.push("miner_background");
	}

});

