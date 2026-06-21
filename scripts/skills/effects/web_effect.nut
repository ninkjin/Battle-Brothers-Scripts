this.web_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.web";
		this.m.Name = "陷在蛛网中";
		this.m.Description = "一张又大又粘的蛛网将这个角色固定在了原地并阻碍了他自我保护的能力，也阻碍他在打击中投入真正的力量。想要挣脱，网必须被割开。";
		this.m.Icon = "skills/status_effect_80.png";
		this.m.IconMini = "status_effect_80_mini";
		this.m.Overlay = "status_effect_80";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]无法移动[/color]"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]织网蛛攻击造成的穿甲伤害将会翻倍[/color]"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]伤害"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]近战防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]远程防御"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]主动性"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.DamageTotalMult *= 0.5;
		_properties.MeleeDefenseMult *= 0.5;
		_properties.RangedDefenseMult *= 0.5;
		_properties.InitiativeMult *= 0.5;
		_properties.TargetAttractionMult *= 1.5;
	}

});

