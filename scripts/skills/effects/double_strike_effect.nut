this.double_strike_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TimeAdded = 0
	},
	function create()
	{
		this.m.ID = "effects.double_strike";
		this.m.Name = "双重打击！";
		this.m.Icon = "skills/status_effect_01.png";
		this.m.IconMini = "status_effect_01_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "在刚刚完成了一次命中后，这个角色准备好进行更强大的后续攻击！下一次攻击将造成[color=" + this.Const.UI.Color.PositiveValue + "]+20%[/color]对单个目标的额外伤害。如果有多个目标被击中，只有第一个被击中的会受到额外伤害。如果攻击未命中，此效果会被浪费。";
	}

	function onAdded()
	{
		this.m.TimeAdded = this.Time.getVirtualTimeF();
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_targetEntity == null)
		{
			return;
		}

		if (!this.m.IsGarbage && this.m.TimeAdded + 0.1 < this.Time.getVirtualTimeF() && !_targetEntity.isAlliedWith(this.getContainer().getActor()))
		{
			_properties.DamageTotalMult *= 1.2;
			this.removeSelf();
		}
	}

});

