this.recovery_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsCountingBattle = false
	},
	function create()
	{
		this.m.ID = "effects.recovery_potion";
		this.m.Name = "强化体力";
		this.m.Icon = "skills/status_effect_89.png";
		this.m.IconMini = "status_effect_89_mini";
		this.m.Overlay = "status_effect_89";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "我可以坚持一整晚！得益于一瓶被委婉称为'回春药水'的混合各种机能强化物质的药水，这个角色的心脏在狂飙，他的体力得到了强化且不会轻易疲惫。还有，这里咋这么热？";
	}

	function getTooltip()
	{
		local ret = [
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
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+4[/color]每回合疲劳恢复"
			},
			{
				id = 7,
				type = "hint",
				icon = "ui/icons/action_points.png",
				text = "会在1场战斗之后消失"
			}
		];
		return ret;
	}

	function onCombatStarted()
	{
		this.m.IsCountingBattle = true;
	}

	function onCombatFinished()
	{
		if (!this.m.IsCountingBattle)
		{
			return;
		}

		this.removeSelf();
	}

	function onUpdate( _properties )
	{
		_properties.FatigueRecoveryRate += 4;
	}

});

