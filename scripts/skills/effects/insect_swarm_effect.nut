this.insect_swarm_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 3
	},
	function create()
	{
		this.m.ID = "effects.insect_swarm";
		this.m.Name = "虫群";
		this.m.Icon = "skills/status_effect_57.png";
		this.m.IconMini = "status_effect_57_mini";
		this.m.Overlay = "status_effect_57";
		this.m.SoundOnUse = [
			"sounds/status/insect_swarm_effect_01.wav",
			"sounds/status/insect_swarm_effect_02.wav",
			"sounds/status/insect_swarm_effect_03.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "上千个黑苍蝇绕着这个角色嗡嗡作响，试图从盔甲上的每个小缝隙里爬进去，再钻进人体上每个可能的孔里。这个可怕的诅咒让战斗变得基本不可能，还会持续[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.TurnsLeft + "[/color]回合。";
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
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]近战技能"
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]远程技能"
			},
			{
				id = 12,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]近战防御"
			},
			{
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]远程防御"
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]主动性"
			}
		];
	}

	function resetTime()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "非自然的生理功能使他逼退了虫群");
			}

			return;
		}

		this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
	}

	function addSprite( _n, _brush, _insert = false )
	{
		local actor = this.getContainer().getActor();
		local sprite;

		if (!_insert)
		{
			sprite = actor.addSprite("insects_" + (_n < 10 ? "0" + _n : _n));
		}
		else
		{
			sprite = actor.insertSprite("insects_" + (_n < 10 ? "0" + _n : _n));
		}

		sprite.setBrush(_brush);
		sprite.Rotation = this.Math.rand(0, 359);
		actor.setSpriteRenderToTexture("insects_" + (_n < 10 ? "0" + _n : _n), false);
	}

	function onAdded()
	{
		if (this.getContainer().getActor().getCurrentProperties().IsResistantToAnyStatuses && this.Math.rand(1, 100) <= 50)
		{
			if (!this.getContainer().getActor().isHiddenToPlayer())
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(this.getContainer().getActor()) + "非自然的生理功能使他逼退了虫群");
			}

			this.removeSelf();
		}
		else
		{
			this.m.TurnsLeft = this.Math.max(1, 3 + this.getContainer().getActor().getCurrentProperties().NegativeStatusEffectDuration);
			this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
			local actor = this.getContainer().getActor();
			this.addSprite(1, "bust_flies_01");
			this.addSprite(2, "bust_flies_02");
			this.addSprite(3, "bust_flies_03");
			this.addSprite(4, "bust_flies_04");
			this.addSprite(5, "bust_flies_05");
			this.addSprite(6, "bust_flies_06");
			this.addSprite(7, "bust_flies_07");
			this.addSprite(8, "bust_flies_08");
			this.addSprite(9, "bust_flies_09", true);
			this.addSprite(10, "bust_flies_10", true);
			this.addSprite(11, "bust_flies_04", true);
			this.addSprite(12, "bust_flies_05", true);
			this.addSprite(13, "bust_flies_06", true);
			this.addSprite(14, "bust_flies_08");
			this.addSprite(15, "bust_flies_05");
			actor.setSpriteOffset("insects_14", this.createVec(-20, 0));
			actor.setSpriteOffset("insects_15", this.createVec(10, 0));
		}
	}

	function onTurnStart()
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
	}

	function onTargetMissed( _skill, _targetEntity )
	{
		this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkillMult *= 0.5;
		_properties.RangedSkillMult *= 0.5;
		_properties.MeleeDefenseMult *= 0.5;
		_properties.RangedDefenseMult *= 0.5;
		_properties.InitiativeMult *= 0.5;
	}

	function onTurnEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.removeSprite("insects_01");
		actor.removeSprite("insects_02");
		actor.removeSprite("insects_03");
		actor.removeSprite("insects_04");
		actor.removeSprite("insects_05");
		actor.removeSprite("insects_06");
		actor.removeSprite("insects_07");
		actor.removeSprite("insects_08");
		actor.removeSprite("insects_09");
		actor.removeSprite("insects_10");
		actor.removeSprite("insects_11");
		actor.removeSprite("insects_12");
		actor.removeSprite("insects_13");
		actor.removeSprite("insects_14");
		actor.removeSprite("insects_15");
	}

});

