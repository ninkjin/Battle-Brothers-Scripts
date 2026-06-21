this.smoke_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.smoke";
		this.m.Name = "烟雾笼罩";
		this.m.Icon = "skills/status_effect_117.png";
		this.m.IconMini = "status_effect_117_mini";
		this.m.Overlay = "status_effect_117";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色被层层浓烟所笼罩。在不停的时隐时现中，他们可以自由移动并忽略任何控制区域。";
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
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]远程技能"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color]远程防御"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "不受控制区域影响"
			}
		];
	}

	function onNewRound()
	{
		local tile = this.getContainer().getActor().getTile();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
	}

	function onUpdate( _properties )
	{
		local tile = this.getContainer().getActor().getTile();

		if (tile.Properties.Effect == null || tile.Properties.Effect.Type != "smoke")
		{
			this.removeSelf();
		}
		else
		{
			_properties.RangedSkillMult *= 0.5;
			_properties.RangedDefenseMult *= 2.0;
		}
	}

});

