this.indomitable_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.indomitable";
		this.m.Name = "不屈不挠";
		this.m.Icon = "ui/perks/perk_30.png";
		this.m.IconMini = "perk_30_mini";
		this.m.Overlay = "perk_30";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色已经凝聚了自己所有身体及意志的力量从而在自己的下一轮开始前变得不屈不挠。";
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
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "只受到[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]的任意伤害"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "免疫击晕"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "免疫击退和抓取"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 0.5;
		_properties.IsImmuneToStun = true;
		_properties.IsImmuneToKnockBackAndGrab = true;
		_properties.TargetAttractionMult *= 0.5;
	}

	function onTurnStart()
	{
		this.removeSelf();
	}

});

