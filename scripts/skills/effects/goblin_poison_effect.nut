this.goblin_poison_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.goblin_poison";
		this.m.Name = "中毒";
		this.m.Icon = "skills/status_effect_54.png";
		this.m.IconMini = "status_effect_54_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = true;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色血管中正流淌着毒素。他视野模糊，口齿不清，需要大量的努力才能协调的移动。效果会在[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color]回合中慢慢消失。";
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
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 1 * this.m.TurnsLeft + "[/color]行动点"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 1 * this.m.TurnsLeft + "[/color]视野"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + 10 * this.m.TurnsLeft + "[/color]主动性"
			}
		];
	}

	function resetTime()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasSkill("trait.ailing"))
		{
			++this.m.TurnsLeft;
		}
	}

	function onAdded()
	{
		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);

		if (this.getContainer().hasSkill("trait.ailing"))
		{
			++this.m.TurnsLeft;
		}
	}

	function onUpdate( _properties )
	{
		_properties.ActionPoints -= 1 * this.m.TurnsLeft;
		_properties.Initiative -= 10 * this.m.TurnsLeft;
		_properties.Vision -= 1 * this.m.TurnsLeft;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

