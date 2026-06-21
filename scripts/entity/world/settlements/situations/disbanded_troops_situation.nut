this.disbanded_troops_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.disbanded_troops";
		this.m.Name = "解散的军队";
		this.m.Description = "随着一场当地冲突的解决，许多被征召的部队和他们的武器都不再被需要。这是个买廉价货或者雇佣有经验的新人的好时机。";
		this.m.Icon = "ui/settlement_status/settlement_effect_30.png";
		this.m.Rumors = [
			"常备军很昂贵，我的朋友。我听说在%settlement%有一整个团被解散了。肯定会有一些老兵还在那里徘徊，急切的想要赚钱。",
			"我年轻的时候当过兵，并且我喜欢当兵，甚至包括行军。但当我的单位被解散时，我不知道自己接下来到底该怎么办。据我所知，现在他们现在在%settlement%又解散了一个团。",
			"我很担心我的侄女；一整个单位在%settlement%解散了，就在她住的地方附近。如果那些畜生不尽快找到工作，一定会发生糟糕的事情！"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 4;
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
		_modifiers.PriceMult *= 0.9;
		_modifiers.RecruitsMult *= 1.25;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("deserter_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("militia_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("sellsword_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("retired_soldier_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("squire_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
		_draftList.push("hedge_knight_background");
	}

});

