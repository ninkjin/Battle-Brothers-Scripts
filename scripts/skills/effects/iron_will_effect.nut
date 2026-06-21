this.iron_will_effect <- this.inherit("scripts/skills/skill", {
	m = {
		IsCountingBattle = false
	},
	function create()
	{
		this.m.ID = "effects.iron_will";
		this.m.Name = "钢铁意志";
		this.m.Icon = "skills/status_effect_92.png";
		this.m.IconMini = "status_effect_92_mini";
		this.m.Overlay = "status_effect_92";
		this.m.Type = this.Const.SkillType.StatusEffect | this.Const.SkillType.DrugEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "我感觉自己坚不可摧！好吧，感觉可能背叛了这个角色，但既然他感觉不到遭受的新旧伤势，那他在战斗结束肾上腺素消退前自然也不受其影响。";
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
				icon = "ui/icons/special.png",
				text = "不受非永久性伤势的影响"
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
		_properties.IsAffectedByInjuries = false;
	}

});

