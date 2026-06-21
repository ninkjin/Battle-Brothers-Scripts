this.dazed_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2
	},
	function create()
	{
		this.m.ID = "effects.dazed";
		this.m.Name = "茫然";
		this.m.Icon = "skills/status_effect_87.png";
		this.m.IconMini = "status_effect_87_mini";
		this.m.Overlay = "status_effect_87";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色受到了如此沉重的打击，感到头晕目眩喘不上气。会在[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color]轮后消退。";
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
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]伤害"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/fatigue.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]最大疲劳"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-25%[/color]主动性"
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
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(actor) + "非自然的生理功能帮助他摆脱茫然");
			}

			this.removeSelf();
		}
		else if (!this.m.Container.getActor().getCurrentProperties().IsImmuneToDaze)
		{
			this.m.TurnsLeft = this.Math.max(1, 2 + actor.getCurrentProperties().NegativeStatusEffectDuration);
		}
		else
		{
			this.m.IsGarbage = true;
		}
	}

	function onRefresh()
	{
		this.m.TurnsLeft = this.Math.max(1, 2 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		this.spawnIcon("status_effect_87", this.getContainer().getActor().getTile());
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

		if (!actor.getCurrentProperties().IsImmuneToDaze)
		{
			_properties.DamageTotalMult *= 0.75;
			_properties.InitiativeMult *= 0.75;
			_properties.StaminaMult *= 0.75;

			if (actor.hasSprite("status_stunned") && !this.getContainer().hasSkill("effects.stunned"))
			{
				actor.getSprite("status_stunned").setBrush("bust_dazed");
				actor.getSprite("status_stunned").Visible = true;
				actor.setDirty(true);
			}
		}
		else
		{
			this.removeSelf();
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

