this.ghost_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.ghost";
		this.m.Name = "非实体";
		this.m.Description = "";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onBeingAttacked( _attacker, _skill, _properties )
	{
		local dist = _attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile());

		if (dist >= 2)
		{
			_properties.MeleeDefense += (dist - 1) * 10;
			_properties.RangedDefense += (dist - 1) * 10;
		}
	}

});

