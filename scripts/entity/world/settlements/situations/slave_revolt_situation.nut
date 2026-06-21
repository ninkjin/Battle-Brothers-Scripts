this.slave_revolt_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.slave_revolt";
		this.m.Name = "奴隶起义";
		this.m.Description = "负债者，也就是城邦的奴隶阶层，举起了武器来反抗他们的主人！负债者很难找到，武器和盔甲已从市场上被一扫而光。";
		this.m.Icon = "ui/settlement_status/settlement_effect_40.png";
		this.m.Rumors = [
			"%settlement%那边的奴隶拿起了武器，转而开始当土匪和打劫。我琢磨他们还自称无垢者还是什么的。那边当然会有些工作给你这样的雇佣兵干。",
			"有消息说%settlement%的奴隶们正在造反。一场像样的起义可以掀翻他们整个城市，我希望是这样。"
		];
		this.m.IsStacking = false;
	}

	function getAddedString( _s )
	{
		return _s + "有一个" + this.m.Name;
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
		_modifiers.RecruitsMult *= 0.75;
		_modifiers.RarityMult *= 0.5;
	}

	function onUpdateDraftList( _draftList )
	{
		for( local i = _draftList.len() - 1; i >= 0; i = --i )
		{
			if (_draftList[i] == "slave_background" || _draftList[i] == "slave_southern_background")
			{
				_draftList.remove(i);
			}
		}
	}

});

