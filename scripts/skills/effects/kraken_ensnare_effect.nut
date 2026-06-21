this.kraken_ensnare_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Mode = 0,
		LastRoundApplied = 0,
		SpriteScaleBackup = 1.0,
		OnRemoveCallback = null,
		OnRemoveCallbackData = null,
		ParentID = null
	},
	function setOnRemoveCallback( _c, _d )
	{
		this.m.OnRemoveCallback = _c;
		this.m.OnRemoveCallbackData = _d;
	}

	function setMode( _f )
	{
		this.m.Mode = _f;
	}

	function setParentID( _p )
	{
		this.m.ParentID = _p;
	}

	function create()
	{
		this.m.ID = "effects.kraken_ensnare";
		this.m.Name = "被缠住";
		this.m.Description = "这个角色被一只巨大的触手缠住了，正被不断拉近一个准备将其整个吞下的血盆大口。";
		this.m.Icon = "skills/status_effect_95.png";
		this.m.IconMini = "status_effect_95_mini";
		this.m.Overlay = "status_effect_95";
		this.m.SoundOnUse = [
			"sounds/enemies/dlc2/krake_choke_01.wav",
			"sounds/enemies/dlc2/krake_choke_02.wav",
			"sounds/enemies/dlc2/krake_choke_03.wav",
			"sounds/enemies/dlc2/krake_choke_04.wav",
			"sounds/enemies/dlc2/krake_choke_05.wav"
		];
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
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
				text = this.m.Mode == 0 ? this.getDescription() : "这个角色被一只巨大的触手缠住了，正被不断拉近一个准备将其整个吞下的血盆大口。这个触手仿佛要将人勒断一样缠绕的越来越紧，导致每回合失去[color=" + this.Const.UI.Color.NegativeValue + "]10[/color]生命值"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]无法移动[/color]"
			},
			{
				id = 9,
				type = "text",
				icon = "ui/icons/action_points.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]无法使用技能[/color]"
			}
		];
	}

	function applyDamage()
	{
		if (this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_95", this.getContainer().getActor().getTile());

			if (this.m.SoundOnUse.len() != 0)
			{
				this.Sound.play(this.m.SoundOnUse[this.Math.rand(0, this.m.SoundOnUse.len() - 1)], this.Const.Sound.Volume.RacialEffect * 1.0, this.getContainer().getActor().getPos());
			}

			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = this.Math.rand(10, 15);
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
		}
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();
		local sprite1 = actor.getSprite("status_rooted");
		local sprite2 = actor.getSprite("status_rooted_back");
		this.m.SpriteScaleBackup = sprite1.Scale;
		sprite1.Scale = 1.0;
		sprite2.Scale = 1.0;
		actor.getAIAgent().addBehavior(this.new("scripts/ai/tactical/behaviors/ai_drag"));
		this.getContainer().add(this.new("scripts/skills/actives/kraken_move_ensnared_skill"));
		this.Tactical.TurnSequenceBar.pushEntityBack(this.getContainer().getActor().getID());

		if (this.m.ParentID != null)
		{
			this.Tactical.TurnSequenceBar.pushEntityBack(this.m.ParentID);
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("status_rooted").Scale = this.m.SpriteScaleBackup;
		actor.getSprite("status_rooted_back").Scale = this.m.SpriteScaleBackup;
		actor.getAIAgent().removeBehavior(this.Const.AI.Behavior.ID.Drag);
		this.getContainer().removeByID("actives.kraken_move_ensnared");

		if (this.m.OnRemoveCallback != null && !this.Tactical.Entities.isCombatFinished())
		{
			this.m.OnRemoveCallback(this.m.OnRemoveCallbackData);
		}
	}

	function onDeath( _fatalityType )
	{
		if (this.m.OnRemoveCallbackData != null)
		{
			this.m.OnRemoveCallbackData.LoseHitpoints = false;
		}

		this.onRemoved();
	}

	function onUpdate( _properties )
	{
		_properties.IsRooted = true;
		_properties.IsAbleToUseSkills = false;
		_properties.InitiativeForTurnOrderAdditional = -100;
	}

	function onTurnEnd()
	{
		if (this.m.Mode != 0)
		{
			this.applyDamage();
		}
	}

	function onWaitTurn()
	{
		if (this.m.Mode != 0)
		{
			this.applyDamage();
		}
	}

});

