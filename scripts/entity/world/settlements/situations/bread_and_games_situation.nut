this.bread_and_games_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.bread_and_games";
		this.m.Name = "面包和游戏";
		this.m.Description = "市议会为安排了一段让每个人都吃喝玩乐的时间，以使人民高兴。食物和饮料很容易获得，角斗士们蜂拥而至，而竞技场的战斗也比平时报酬更高。";
		this.m.Icon = "ui/settlement_status/settlement_effect_39.png";
		this.m.Rumors = [
			"赞美英明的%settlement%议会！吃的，喝的，玩的应有尽有！",
			"见识过著名的南方游戏吗？去%settlement%亲眼看看庆典的辉煌吧！",
			"一年来所有的辛苦工作都是为了什么？我会告诉你：吃的，喝的，玩的！我要去%settlement%参加，你也应该去。"
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
		_modifiers.FoodRarityMult *= 1.5;
		_modifiers.FoodPriceMult *= 0.9;
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

