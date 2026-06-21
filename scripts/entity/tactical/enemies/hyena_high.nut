this.hyena_high <- this.inherit("scripts/entity/tactical/enemies/hyena", {
	m = {},
	function getName()
	{
		return "狂暴鬣狗";
	}

	function create()
	{
		this.hyena.create();
		this.m.IsHigh = true;
	}

	function onInit()
	{
		this.hyena.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FrenziedHyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local body = this.getSprite("body");
		body.setBrush("bust_hyena_0" + this.Math.rand(4, 6));
		local head = this.getSprite("head");
		head.setBrush("bust_hyena_0" + this.Math.rand(4, 6) + "_head");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
	}

});

