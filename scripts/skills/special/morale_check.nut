this.morale_check <- this.inherit("scripts/skills/skill", {
	function create()
	{
		this.m.ID = "special.morale.check";
		this.m.Name = "士气检定";
		this.m.Icon = "skills/status_effect_02.png";
		this.m.IconMini = "status_effect_02_mini";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsHidden = true;
		this.m.IsSerialized = false;
	}

	function getTooltip()
	{
		switch(this.m.Container.getActor().getMoraleState())
		{
		case this.Const.MoraleState.Confident:
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "我们会胜利的！这个角色相信胜利将属于他。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]近战技能"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]远程技能"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]近战防御"
				},
				{
					id = 14,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]远程防御"
				}
			];
			return ret;

		case this.Const.MoraleState.Wavering:
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "啊哦。这个角色摇摆不定，不确定这场战斗最终会对他有利。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]决心"
				},
				{
					id = 12,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]近战技能"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]远程技能"
				},
				{
					id = 14,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]近战防御"
				},
				{
					id = 15,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]远程防御"
				}
			];
			return ret;

		case this.Const.MoraleState.Breaking:
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "我们赢不了！这个角色的士气正在崩溃，他已经离逃离战场不远了。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]决心"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]近战技能"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]远程技能"
				},
				{
					id = 14,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]近战防御"
				},
				{
					id = 15,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-20%[/color]远程防御"
				}
			];
			return ret;

		case this.Const.MoraleState.Fleeing:
			local ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "快逃命啊！这个角色已经失去冷静，正惊慌失措地逃离战场。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/bravery.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]决心"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/melee_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]近战技能"
				},
				{
					id = 13,
					type = "text",
					icon = "ui/icons/ranged_skill.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]远程技能"
				},
				{
					id = 14,
					type = "text",
					icon = "ui/icons/melee_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]近战防御"
				},
				{
					id = 15,
					type = "text",
					icon = "ui/icons/ranged_defense.png",
					text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]远程防御"
				},
				{
					id = 16,
					type = "text",
					icon = "ui/icons/special.png",
					text = "在回合末尾行动"
				}
			];
			return ret;
		}
	}

	function onUpdate( _properties )
	{
		this.m.IsHidden = this.m.Container.getActor().getMoraleState() == this.Const.MoraleState.Steady;
		this.m.Name = this.Const.MoraleStateName[this.m.Container.getActor().getMoraleState()];

		switch(this.m.Container.getActor().getMoraleState())
		{
		case this.Const.MoraleState.Confident:
			this.m.Icon = "skills/status_effect_14.png";
			this.m.IconMini = "status_effect_14_mini";
			_properties.MeleeSkillMult *= 1.1;
			_properties.RangedSkillMult *= 1.1;
			_properties.MeleeDefenseMult *= 1.1;
			_properties.RangedDefenseMult *= 1.1;
			break;

		case this.Const.MoraleState.Wavering:
			this.m.Icon = "skills/status_effect_02_c.png";
			this.m.IconMini = "status_effect_02_c_mini";
			_properties.BraveryMult *= 0.9;
			_properties.MeleeSkillMult *= 0.9;
			_properties.RangedSkillMult *= 0.9;
			_properties.MeleeDefenseMult *= 0.9;
			_properties.RangedDefenseMult *= 0.9;
			break;

		case this.Const.MoraleState.Breaking:
			this.m.Icon = "skills/status_effect_02_b.png";
			this.m.IconMini = "status_effect_02_b_mini";
			_properties.BraveryMult *= 0.8;
			_properties.MeleeSkillMult *= 0.8;
			_properties.RangedSkillMult *= 0.8;
			_properties.MeleeDefenseMult *= 0.8;
			_properties.RangedDefenseMult *= 0.8;
			break;

		case this.Const.MoraleState.Fleeing:
			this.m.Icon = "skills/status_effect_02_a.png";
			this.m.IconMini = "status_effect_02_a_mini";
			_properties.BraveryMult *= 0.7;
			_properties.MeleeSkillMult *= 0.7;
			_properties.RangedSkillMult *= 0.7;
			_properties.MeleeDefenseMult *= 0.7;
			_properties.RangedDefenseMult *= 0.7;
			_properties.InitiativeForTurnOrderAdditional -= 1000;
			break;
		}
	}

});

