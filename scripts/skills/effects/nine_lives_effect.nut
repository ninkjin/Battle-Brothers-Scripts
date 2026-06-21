this.nine_lives_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.nine_lives";
		this.m.Name = "九命猫";
		this.m.Description = "这个角色似乎有九条命！刚刚经历了与死亡的近距离接触后，此角色在自己的下一轮开始前求生意志将特别强烈。";
		this.m.Icon = "ui/perks/perk_07.png";
		this.m.IconMini = "perk_07_mini";
		this.m.Overlay = "perk_07";
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]近战防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]远程防御"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]决心"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]主动性"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MeleeDefense += 15;
		_properties.RangedDefense += 15;
		_properties.Bravery += 15;
		_properties.Initiative += 15;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

