this.direwolf_high <- this.inherit("scripts/entity/tactical/enemies/direwolf", {
	m = {},
	function getName()
	{
		return "狂暴恐狼";
	}

	function create()
	{
		this.direwolf.create();
	}

	function onInit()
	{
		this.direwolf.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.FrenziedDirewolf);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		b.DamageTotalMult = 1.25;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		local head_frenzy = this.getSprite("head_frenzy");
		head_frenzy.setBrush(this.getSprite("head").getBrush().Name + "_frenzy");
		this.m.Skills.add(this.new("scripts/skills/perks/perk_overwhelm"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_relentless"));
	}

});

