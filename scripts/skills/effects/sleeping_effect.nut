this.sleeping_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsSleeping = 0,
		TurnApplied = 0,
		TurnsLeft = 4
	},
	function getTurnsSleeping()
	{
		return this.m.TurnsSleeping;
	}

	function getTurnApplied()
	{
		return this.m.TurnApplied;
	}

	function create()
	{
		this.m.ID = "effects.sleeping";
		this.m.Name = "睡着";
		this.m.Icon = "skills/status_effect_82.png";
		this.m.IconMini = "status_effect_82_mini";
		this.m.Overlay = "status_effect_82";
		this.m.SoundOnUse = [
			"sounds/enemies/sleeping_01.wav",
			"sounds/enemies/sleeping_02.wav",
			"sounds/enemies/sleeping_03.wav",
			"sounds/enemies/sleeping_04.wav",
			"sounds/enemies/sleeping_05.wav",
			"sounds/enemies/sleeping_06.wav",
			"sounds/enemies/sleeping_07.wav",
			"sounds/enemies/sleeping_08.wav",
			"sounds/enemies/sleeping_09.wav",
			"sounds/enemies/sleeping_10.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色已经陷入了非自然的睡眠并无法行动。他会在[color=" + this.Const.UI.Color.NegativeValue + "]" + (this.m.TurnsLeft - 1) + "[/color]轮后醒来，但也可以被盟友强行唤醒，并且在受到任何伤害时也会醒来。\n\n角色决心越高，抵抗睡意的几率就越高。";
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
				id = 9,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-100[/color]主动性"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/special.png",
				text = "可以受到梦魔的伤害"
			}
		];
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "非自然的生理功能帮助他醒来");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnApplied = this.Time.getRound();
			local actor = this.m.Container.getActor();
			this.m.Container.removeByID("effects.shieldwall");
			this.m.Container.removeByID("effects.spearwall");
			this.m.Container.removeByID("effects.riposte");
			this.m.Container.removeByID("effects.return_favor");
			local actor = this.getContainer().getActor();
			actor.getFlags().set("Sleeping", true);
			this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());

			if (this.m.SoundOnUse.len() != 0 && this.Math.rand(1, 100) <= 33)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
			}

			this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
		}
	}

	function onBeforeActivation()
	{
		++this.m.TurnsSleeping;

		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onTurnStart()
	{
		local actor = this.getContainer().getActor();
		actor.setActionPoints(0);

		if (this.m.SoundOnUse.len() != 0 && this.Math.rand(1, 100) <= 50)
		{
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
		}
	}

	function onResumeTurn()
	{
		this.onTurnStart();
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("status_stunned"))
		{
			actor.getSprite("status_stunned").Visible = false;
		}

		if (actor.hasSprite("closed_eyes"))
		{
			actor.getSprite("closed_eyes").Visible = false;
		}

		actor.getFlags().set("Sleeping", false);

		if ("setEyesClosed" in actor.get())
		{
			actor.setEyesClosed(false);
		}

		actor.setDirty(true);

		if (actor.isPlacedOnMap())
		{
		}
	}

	function onUpdate( _properties )
	{
		local actor = this.getContainer().getActor();
		_properties.IsStunned = true;
		_properties.Initiative -= 100;

		if (actor.hasSprite("status_stunned"))
		{
			actor.getSprite("status_stunned").setBrush(actor.isAlliedWithPlayer() ? "bust_sleep" : "bust_sleep_mirrored");
			actor.getSprite("status_stunned").Visible = true;

			if (actor.hasSprite("closed_eyes"))
			{
				actor.getSprite("closed_eyes").Visible = true;
			}

			if ("setEyesClosed" in actor.get())
			{
				actor.setEyesClosed(true);
			}

			actor.setDirty(true);
		}
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_damageHitpoints > 0)
		{
			this.removeSelf();
		}
	}

});

