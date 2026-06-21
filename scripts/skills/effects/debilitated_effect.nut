this.debilitated_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.debilitated";
		this.m.Name = "被削弱";
		this.m.Description = "TODO";
		this.m.Icon = "ui/perks/perk_34.png";
		this.m.IconMini = "perk_34_mini";
		this.m.Overlay = "perk_34";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		_properties.DamageTotalMult *= 0.5;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

