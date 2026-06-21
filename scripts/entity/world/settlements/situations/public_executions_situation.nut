this.public_executions_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.public_executions";
		this.m.Name = "公开处决";
		this.m.Description = "一场公开处决是不容错过的，它可以为一整家人提供娱乐。食物和饮料在这种场合供给充足，但商人也可能试图占观众的便宜。";
		this.m.Icon = "ui/settlement_status/settlement_effect_14.png";
		this.m.Rumors = [
			"一大群人正赶往%settlement%观看盛大的展出！男人，女人，年轻人，都在前去观看即将到来的处决！",
			"我听说他们在%settlement%附近抓了一些强盗，正把他们送上斩首台。他们活该，在路上伏击穷人…",
			"现如今我们穷人没有什么好享受的，但是一场优秀的绞刑总是受欢迎的。这里在秋天以后就再没有过，但根据%randomname%跟我说的，他们在%settlement%正在绞死一些人。"
		];
		this.m.IsStacking = false;
		this.m.ValidDays = 2;
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
		_modifiers.FoodRarityMult *= 1.35;
		_modifiers.FoodPriceMult *= 1.15;
	}

});

