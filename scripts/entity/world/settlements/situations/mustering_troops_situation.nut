this.mustering_troops_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.mustering_troops";
		this.m.Name = "召集部队";
		this.m.Description = "在这个定居点召集作战部队的命令已经被下达。装备和新兵供应不足，但在这里出售武器和盔甲可以赚些快钱。";
		this.m.Icon = "ui/settlement_status/settlement_effect_35.png";
		this.m.Rumors = [
			"又一个该死的贵族正在%settlement%把年轻人征进一个团。啊，为什么我要跟你谈这个，佣兵？你也好不到哪去！",
			"如果我是一个满载着武器和盔甲的商人，我当然知道该在哪把它们全卖掉。他们在正%settlement%召集部队，并且一定会付出高价。可惜，我既不是商人也没有武器。",
			"我仅仅是在路过，差点没逃过%settlement%的强征入伍。他们想强迫我为什么领主而战，但我说可算了吧，才不要。我要去更南边碰碰运气。"
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
		_settlement.resetRoster(false);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.PriceMult *= 1.25;
		_modifiers.RecruitsMult *= 0.5;
		_modifiers.RarityMult *= 0.5;
	}

});

