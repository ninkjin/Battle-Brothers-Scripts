this.indomitable <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.indomitable";
		this.m.Name = "不屈不挠";
		this.m.Description = "凝聚这个角色所有身体及意志的力量从而在他的下一轮开始前变得不屈不挠。";
		this.m.Icon = "ui/perks/perk_30_active.png";
		this.m.IconDisabled = "ui/perks/perk_30_active_sw.png";
		this.m.Overlay = "perk_30_active";
		this.m.SoundOnUse = [
			"sounds/combat/indomitable_01.wav",
			"sounds/combat/indomitable_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "只受到[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]的任意伤害"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "变得免疫击晕"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "变得免疫击退和抓取"
			}
		];
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.indomitable");
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.indomitable"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/indomitable_effect"));
			return true;
		}

		return false;
	}

});

