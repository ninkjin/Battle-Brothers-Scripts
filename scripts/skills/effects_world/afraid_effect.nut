this.afraid_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.afraid";
		this.m.Name = "害怕";
		this.m.Description = "最近的事件使这个角色害怕失去性命。要么他是对的并且近期就会翘辫子，要么这状态就会随时间消逝。";
		this.m.Icon = "skills/status_effect_52.png";
		this.m.IconMini = "status_effect_52_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
	}

	function isTreated()
	{
		return true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]决心"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "满足于充当后备"
			}
		];
	}

	function onNewDay()
	{
		if (this.Math.rand(1, 100) <= 25)
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 0.5;
		_properties.IsContentWithBeingInReserve = true;
	}

});

