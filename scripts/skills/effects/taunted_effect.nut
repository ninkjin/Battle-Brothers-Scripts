this.taunted_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.taunted";
		this.m.Name = "被嘲讽";
		this.m.Description = "TODO";
		this.m.Icon = "ui/perks/perk_38.png";
		this.m.IconMini = "perk_38_mini";
		this.m.Overlay = "perk_38";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
	}

	function onAdded()
	{
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

