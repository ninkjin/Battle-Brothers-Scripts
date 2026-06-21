this.rooted_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rooted";
		this.m.Name = "陷在藤蔓中";
		this.m.Description = "非自然长出的茂密藤蔓将这个角色固定在了原地并阻碍了他自我保护的能力。想要挣脱，藤蔓必须被砍掉。";
		this.m.Icon = "skills/status_effect_55.png";
		this.m.IconMini = "status_effect_55_mini";
		this.m.Overlay = "status_effect_55";
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]近战防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]远程防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-35%[/color]主动性"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.MeleeDefenseMult *= 0.65;
		_properties.RangedDefenseMult *= 0.65;
		_properties.InitiativeMult *= 0.65;
	}

});

