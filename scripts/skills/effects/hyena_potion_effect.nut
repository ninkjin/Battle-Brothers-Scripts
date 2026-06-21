this.hyena_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.hyena_potion";
		this.m.Name = "皮下凝血";
		this.m.Icon = "skills/status_effect_143.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_143";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "当这个角色的皮肤破损时会分泌一种能极大加快该部位凝血速度的物质。就结果而言，尽管任然会有一些失血，但出血伤口构成的危害要小了许多。";
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
				text = "受到的流血伤害减少[color=" + this.Const.UI.Color.NegativeValue + "]50%[/color]"
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

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isHyenaPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isHyenaPotionAcquired", false);
	}

});

