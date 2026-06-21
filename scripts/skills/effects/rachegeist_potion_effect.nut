this.rachegeist_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rachegeist_potion";
		this.m.Name = "幽鬼灵光";
		this.m.Icon = "skills/status_effect_153.png";
		this.m.IconMini = "status_effect_153_mini";
		this.m.Overlay = "status_effect_153";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色之前摄入了一种物质，这种现在已经流淌在他血管的物质能产生一个动能场。这个场随着他们的健康状况恶化而变得更加强大，最终会产生蓝色波光并对他们打出或受到的任何攻击产生显著影响。他同样声称独自一人时总是听到几乎无法察觉也不曾断绝的耳语声，但这可能只是迷信。";
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
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+25%[/color]伤害，前提生命值低于[color=" + this.Const.UI.Color.NegativeValue + "]50%[/color]"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "只受到[color=" + this.Const.UI.Color.PositiveValue + "]75%[/color]的任意伤害，前提生命值低于[color=" + this.Const.UI.Color.NegativeValue + "]50%[/color]"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "再次突变会导致更长时间的疾病"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (actor.getHitpoints() < actor.getHitpointsMax() / 2)
		{
			_properties.DamageTotalMult *= 1.25;
			_properties.DamageReceivedTotalMult *= 0.75;
		}
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isRachegeistPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isRachegeistPotionAcquired", false);
	}

});

