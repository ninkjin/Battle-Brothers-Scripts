this.sickness_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.sickness";
		this.m.Name = "疾病";
		this.m.Description = "一场疾病使这个定居点的许多人倒下。可用的新兵更少，食物和医疗用品也很稀缺。";
		this.m.Icon = "ui/settlement_status/settlement_effect_23.png";
		this.m.Rumors = [
			"不要靠近%settlement%！一场疾病袭击了那个可怜的镇子，那里的人们像苍蝇一样死去…",
			"有一些人从%settlement%过来，但我们不得不在大门口送走他们。每个人都知道一种残酷的恶疾正在那个被诅咒的城镇蔓延。",
			"喜欢我的草药项链吗？它保护我免受最严重的恶疾的侵袭。如果你打算去%settlement%的话，你最好也入手一个。"
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
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.FoodPriceMult *= 2.0;
		_modifiers.MedicalPriceMult *= 3.0;
		_modifiers.RecruitsMult *= 0.25;
	}

});

