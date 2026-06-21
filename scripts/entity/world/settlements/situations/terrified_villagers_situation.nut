this.terrified_villagers_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.terrified_villagers";
		this.m.Name = "惊恐的村民";
		this.m.Description = "这里的村民被未知的恐怖所惊骇。街上能找到的潜在新兵更少，人们对陌生人的态度也更差。";
		this.m.Icon = "ui/settlement_status/settlement_effect_09.png";
		this.m.Rumors = [
			"死去的人并不是真的死了，有时候他们会回来纠缠活着的人！你不相信我？你自己去%settlement%看看吧！",
			"你看起来像个能干的剑客！我听说在%settlement%附近死者开始再次行走。可能只是鬼话，但受惊吓的人往往会为了再次感到安全而付高价。"
		];
	}

	function onUpdate( _modifiers )
	{
		_modifiers.BuyPriceMult *= 1.25;
		_modifiers.SellPriceMult *= 0.75;
		_modifiers.RecruitsMult *= 0.5;
	}

});

