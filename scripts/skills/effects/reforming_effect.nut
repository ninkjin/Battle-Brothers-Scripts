this.reforming_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 1
	},
	function create()
	{
		this.m.ID = "effects.reforming";
		this.m.Name = "重塑中";
		this.m.Icon = "skills/status_effect_05.png";
		this.m.IconMini = "status_effect_05_mini";
		this.m.Overlay = "status_effect_05";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色的肉体正在重塑，他将暂时失去行动能力[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color]回合，并且无法行动。";
	}

	function addTurns( _t )
	{
		this.m.TurnsLeft += _t;
	}

	function setTurns( _t )
	{
		if (this.getContainer() != null)
		{
			this.m.TurnsLeft = _t;
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();

		if (this.m.TurnsLeft != 0)
		{
			_properties.IsStunned = true;
			actor.setActionPoints(0);

			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").setBrush(this.Const.Combat.StunnedBrush);
				actor.getSprite("status_stunned").Visible = true;
			}

			actor.setDirty(true);
		}
		else
		{
			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").Visible = false;
			}

			actor.setDirty(true);
		}
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
			local actor = this.getContainer().getActor();

			if (actor.hasSprite("status_stunned"))
			{
				actor.getSprite("status_stunned").Visible = false;
			}

			actor.setDirty(true);
		}
	}

});

