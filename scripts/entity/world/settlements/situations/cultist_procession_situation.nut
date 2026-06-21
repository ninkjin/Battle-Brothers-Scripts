this.cultist_procession_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.cultist_procession";
		this.m.Name = "邪教徒游行";
		this.m.Description = "有一大批邪教徒正在穿过城市；源源不断的人流似乎凭空出现，并慢慢地沿着主要道路前进。他们衣着暗淡，摇着铃铛，单调地吟唱着达库尔的名字。";
		this.m.Icon = "ui/settlement_status/settlement_effect_37.png";
		this.m.Rumors = [
			"我刚看到最令人毛骨悚然的游行队伍经过%settlement%！蒙面的人影，鞭打着自己的后背，直到他们都血淋淋的…",
			"%settlement%到处都是奇怪的邪教徒，他们肯定在干啥坏事！要我说，应该有人把女巫猎人送那边去！",
			"它醒了！沉睡的野兽即将从长达一个世纪的沉睡中醒来！去%settlement%，我的教友也会这么跟你说！达库尔将会降临！"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 2;
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

	function onRemoved( _settlement )
	{
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
		_draftList.push("cultist_background");
	}

});

