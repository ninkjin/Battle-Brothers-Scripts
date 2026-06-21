this.taunt_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.taunt";
		this.m.Name = "嘲讽";
		this.m.Description = "这个角色已经引起了附近的对手的注意，并且比起其他潜在目标更容易受到攻击。";
		this.m.Icon = "ui/perks/perk_38.png";
		this.m.IconMini = "perk_38_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onUpdate( _properties )
	{
		_properties.TargetAttractionMult *= 1.0 + this.Math.minf(1.5, this.getContainer().getActor().getCurrentProperties().Bravery * 0.015);
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

