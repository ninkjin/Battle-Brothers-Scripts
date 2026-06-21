this.conquered_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.conquered";
		this.m.Name = "被征服";
		this.m.Description = "这个地方最近被征服了。许多人丧生，幸存者不得不忍受征服者夺取战利品。定居点的大部分依旧受损，人们的情绪也很低落。";
		this.m.Icon = "ui/settlement_status/settlement_effect_02.png";
		this.m.Rumors = [
			"我听说%settlement%最近被征服了。'新领主同样操蛋'就是我的一贯说法…",
			"征服新土地是贵族的游戏。我听说他们刚刚洗劫了%settlement%。",
			"哦，嘿，佣兵！你参与了围攻%settlement%吗？好吧，真他妈的恭喜你。你杀了多少人？你强奸了多少人？"
		];
		this.m.IsStacking = false;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
	}

	function onUpdate( _modifiers )
	{
		_modifiers.SellPriceMult *= 0.9;
		_modifiers.BuyPriceMult *= 1.1;
		_modifiers.RarityMult *= 0.6;
		_modifiers.FoodRarityMult *= 0.9;
	}

});

