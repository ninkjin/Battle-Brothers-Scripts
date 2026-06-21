this.ceremonial_season_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.ceremonial_seasonn";
		this.m.Name = "祭典时节";
		this.m.Description = "在祭典时节中，神殿会消耗大量的熏香。熏香的需求和价格现在史无前例的高。";
		this.m.Icon = "ui/settlement_status/settlement_effect_44.png";
		this.m.Rumors = [
			"每年的这个时候，%settlement%的神殿就像着火的窝棚一样冒烟！我想知道他们从哪里弄来的那些熏香…",
			"如果你是一个虔诚的人，你或许该考虑去%settlement%烧香和祈祷。"
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
	}

	function onUpdate( _modifiers )
	{
		_modifiers.IncensePriceMult *= 1.5;
	}

});

