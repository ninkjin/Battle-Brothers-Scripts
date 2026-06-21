this.orc_young_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.orc_young_potion";
		this.m.Name = "动能打击";
		this.m.Icon = "skills/status_effect_127.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_127";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的手腕发生了变异，使其可以缓冲相对力量的初始冲击。用更实际的说法，这能在打击敌人时削弱敌人盔甲的保护性。此外，他还能做出一些匪夷所思的手影。";
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
				icon = "ui/icons/armor_damage.png",
				text = "攻击有额外[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]破甲效率"
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
		_properties.DamageArmorMult += 0.1;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isOrcYoungPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isOrcYoungPotionAcquired", false);
	}

});

