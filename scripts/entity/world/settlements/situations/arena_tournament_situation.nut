this.arena_tournament_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.arena_tournament";
		this.m.Name = "锦标赛";
		this.m.Description = "一场大型比赛将在竞技场举行。进入它赢得非凡的奖品！";
		this.m.Icon = "ui/settlement_status/settlement_effect_45.png";
		this.m.Rumors = [
			"你看起来像个能干的战士。%settlement% 的竞技场正在举办一场比赛，你肯定还可以进入！",
			"喝了这杯酒，我就直奔 %settlement% 去看伟大的竞技场比赛！全年最佳娱乐节目！",
			"我听说今年 %settlement% 竞技场比赛奖励更加丰厚了！"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 5;
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
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
		_draftList.push("gladiator_background");
	}

});

