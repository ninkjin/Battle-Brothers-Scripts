this.collectors_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.collectors";
		this.m.Name = "收藏家";
		this.m.Description = "有几个寻求异国奇货的收藏家来到镇上。出售野兽战利品能获得不错的收益。";
		this.m.Icon = "ui/settlement_status/settlement_effect_46.png";
		this.m.Rumors = [
			"你们是野兽猎人吗？我听说在%settlement%出现了一些奇怪的人，并且正在购买所有他们遇到的奇特的野兽战利品。",
			"看到这颗狗牙了吗？我打算把它卖到%settlement%，我听说那里对动物部件付的钱很多。",
			"似乎各种野兽杀手还有翻弄尸体的家伙都聚集在了%settlement%。我听说是为了出售野兽战利品。在我听起来有点像巫术。"
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
		_modifiers.BeastPartsPriceMult *= 2.0;
		_modifiers.RecruitsMult *= 1.25;
	}

	function onUpdateDraftList( _draftList )
	{
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");
		_draftList.push("witchhunter_background");

		if (this.Const.DLC.Unhold)
		{
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
			_draftList.push("beast_hunter_background");
		}

		if (this.Const.DLC.Paladins)
		{
			_draftList.push("anatomist_background");
			_draftList.push("anatomist_background");
			_draftList.push("anatomist_background");
			_draftList.push("anatomist_background");
			_draftList.push("anatomist_background");
		}
	}

});

