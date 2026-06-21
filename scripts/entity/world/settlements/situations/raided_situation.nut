this.raided_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.raided";
		this.m.Name = "被掠夺";
		this.m.Description = "这地方最近被掠夺了！它遭受了破坏，失去了宝贵的货物和补给，也有人失去了性命。";
		this.m.Icon = "ui/settlement_status/settlement_effect_08.png";
		this.m.Rumors = [
			"你是一名掠夺者吗？当然，看起来和闻起来都像！是你的人在%settlement%烧杀掳掠的吗？要我说，快滚出这里，我们可不想你们这种人在身边！",
			"从%settlement%过来的人们说那里遭受了掠夺。可怜的家伙们，但我们又能怎么办？我们自己也没什么。应该是领主来保护他们！",
			"现在确实是危险的时代，佣兵。我刚得到消息说%settlement%不到两个晚上前被掠夺然后洗劫一空。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 4;
	}

	function getAddedString( _s )
	{
		return _s + "有" + this.m.Name;
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
		_modifiers.RecruitsMult *= 0.5;
		_modifiers.RarityMult *= 0.5;
	}

});

