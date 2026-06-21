this.high_spirits_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.high_spirits";
		this.m.Name = "兴高采烈";
		this.m.Description = "这里的人兴致很高，很乐意和你们做生意。";
		this.m.Icon = "ui/settlement_status/settlement_effect_05.png";
		this.m.Rumors = [
			"我今天刚从%settlement%过来，衣服上还沾着路上的灰尘。那边的人心情肯定很好，就是不知道为什么…",
			"不用给我拿杯子，我在%settlement%参加庆祝的时候就已经喝醉了。他们当然知道如何玩得开心！",
			"传言说%settlement%的镇民刚取回一件重要的圣物。"
		];
		this.m.IsStacking = false;
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
	}

	function onUpdate( _modifiers )
	{
		_modifiers.SellPriceMult *= 1.05;
		_modifiers.BuyPriceMult *= 0.95;
		_modifiers.RarityMult *= 1.1;
	}

});

