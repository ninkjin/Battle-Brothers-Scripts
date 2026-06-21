this.withered_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.withered";
		this.m.Name = "凋零";
		this.m.Icon = "skills/status_effect_123.png";
		this.m.IconMini = "status_effect_123_mini";
		this.m.Overlay = "status_effect_123";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色的身体素质被黑暗魔法凋零到了老人的程度。效果会在[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color]回合中慢慢消失。";
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
				id = 11,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.TurnsLeft * 25 + "%[/color]伤害"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.TurnsLeft * 25 + "%[/color]主动性"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.TurnsLeft * 25 + "%[/color]最大疲劳"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-" + this.m.TurnsLeft * 5 + "[/color]每回合疲劳恢复"
			}
		];
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local statusResisted = actor.getCurrentProperties().IsResistantToAnyStatuses ? this.Math.rand(1, 100) <= 50 : false;
		statusResisted = statusResisted || actor.getCurrentProperties().IsResistantToPhysicalStatuses ? this.Math.rand(1, 100) <= 33 : false;

		if (statusResisted)
		{
			if (!actor.isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "非自然的生理功能帮助他迅速从凋零中恢复");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_123", this.getContainer().getActor().getTile());
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.DamageTotalMult *= 1.0 - this.m.TurnsLeft * 0.25;
		_properties.InitiativeMult *= 1.0 - this.m.TurnsLeft * 0.25;
		_properties.StaminaMult *= 1.0 - this.m.TurnsLeft * 0.25;
		_properties.FatigueRecoveryRate -= this.m.TurnsLeft * 5;

		if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
		{
			actor.getSprite("status_stunned").setBrush("bust_withered");
			actor.getSprite("status_stunned").Visible = true;
			actor.setDirty(true);
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

