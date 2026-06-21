this.abducted_children_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.abducted_children";
		this.m.Name = "儿童被拐";
		this.m.Description = "这个定居点的孩子们正在不断的失踪。不信任和恐惧统治着街道，并慢慢毒害着社区。";
		this.m.Icon = "ui/settlement_status/settlement_effect_34.png";
		this.m.Rumors = [
			"有传言说在%settlement%孩子们从婴儿床上消失得无影无踪，想象一下父母的恐惧…",
			"我奶奶给我讲过一个故事，说女巫拐走孩子是为了他们纯洁的血液。而现在在%settlement%，孩子们就像故事里那样失踪了。",
			"永远不要和女巫达成交易！一个在%settlement%的亲戚几年前这样做了，现在他的孩子失踪了。"
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
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RecruitsMult *= 0.5;
	}

});

