this.hyena <- this.inherit("scripts/entity/tactical/actor", {
	m = {
		IsHigh = false
	},
	function isHigh()
	{
		return this.m.IsHigh;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.Hyena;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Hyena.XP;
		this.m.BloodSplatterOffset = this.createVec(0, 0);
		this.m.DecapitateSplatterOffset = this.createVec(-10, -25);
		this.m.DecapitateBloodAmount = 1.0;
		this.m.ConfidentMoraleBrush = "icon_confident_orcs";
		this.m.ExcludedInjuries = [
			"injury.fractured_hand",
			"injury.crushed_finger",
			"injury.fractured_elbow",
			"injury.smashed_hand",
			"injury.broken_arm",
			"injury.cut_arm_sinew",
			"injury.cut_arm",
			"injury.split_hand",
			"injury.pierced_hand",
			"injury.pierced_arm_muscles",
			"injury.burnt_hands"
		];
		this.actor.create();
		this.m.Sound[this.Const.Sound.ActorEvent.DamageReceived] = [
			"sounds/enemies/dlc6/hyena_hurt_01.wav",
			"sounds/enemies/dlc6/hyena_hurt_02.wav",
			"sounds/enemies/dlc6/hyena_hurt_03.wav",
			"sounds/enemies/dlc6/hyena_hurt_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Death] = [
			"sounds/enemies/dlc6/hyena_death_01.wav",
			"sounds/enemies/dlc6/hyena_death_02.wav",
			"sounds/enemies/dlc6/hyena_death_03.wav",
			"sounds/enemies/dlc6/hyena_death_04.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Flee] = [
			"sounds/enemies/dlc6/hyena_flee_01.wav",
			"sounds/enemies/dlc6/hyena_flee_02.wav",
			"sounds/enemies/dlc6/hyena_flee_03.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Idle] = [
			"sounds/enemies/dlc6/hyena_idle_01.wav",
			"sounds/enemies/dlc6/hyena_idle_02.wav",
			"sounds/enemies/dlc6/hyena_idle_03.wav",
			"sounds/enemies/dlc6/hyena_idle_04.wav",
			"sounds/enemies/dlc6/hyena_idle_05.wav",
			"sounds/enemies/dlc6/hyena_idle_06.wav",
			"sounds/enemies/dlc6/hyena_idle_07.wav",
			"sounds/enemies/dlc6/hyena_idle_08.wav",
			"sounds/enemies/dlc6/hyena_idle_09.wav",
			"sounds/enemies/dlc6/hyena_idle_10.wav",
			"sounds/enemies/dlc6/hyena_idle_11.wav",
			"sounds/enemies/dlc6/hyena_idle_12.wav",
			"sounds/enemies/dlc6/hyena_idle_13.wav",
			"sounds/enemies/dlc6/hyena_idle_14.wav",
			"sounds/enemies/dlc6/hyena_idle_15.wav",
			"sounds/enemies/dlc6/hyena_idle_16.wav",
			"sounds/enemies/dlc6/hyena_idle_17.wav",
			"sounds/enemies/dlc6/hyena_idle_18.wav",
			"sounds/enemies/dlc6/hyena_idle_19.wav",
			"sounds/enemies/dlc6/hyena_idle_20.wav",
			"sounds/enemies/dlc6/hyena_idle_21.wav",
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_21.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Attack] = [
			"sounds/enemies/werewolf_idle_01.wav",
			"sounds/enemies/werewolf_idle_02.wav",
			"sounds/enemies/werewolf_idle_03.wav",
			"sounds/enemies/werewolf_idle_05.wav",
			"sounds/enemies/werewolf_idle_06.wav",
			"sounds/enemies/werewolf_idle_07.wav",
			"sounds/enemies/werewolf_idle_08.wav"
		];
		this.m.Sound[this.Const.Sound.ActorEvent.Move] = [
			"sounds/enemies/werewolf_fatigue_01.wav",
			"sounds/enemies/werewolf_fatigue_02.wav",
			"sounds/enemies/werewolf_fatigue_03.wav",
			"sounds/enemies/werewolf_fatigue_04.wav",
			"sounds/enemies/werewolf_fatigue_05.wav",
			"sounds/enemies/werewolf_fatigue_06.wav",
			"sounds/enemies/werewolf_fatigue_07.wav"
		];
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] = 0.6;
		this.m.SoundVolume[this.Const.Sound.ActorEvent.Move] = 0.6;
		this.m.SoundPitch = this.Math.rand(95, 110) * 0.01;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/hyena_agent");
		this.m.AIAgent.setActor(this);
	}

	function playAttackSound()
	{
		if (this.Math.rand(1, 100) <= 50)
		{
			this.playSound(this.Const.Sound.ActorEvent.Attack, this.Const.Sound.Volume.Actor * this.m.SoundVolume[this.Const.Sound.ActorEvent.Attack] * (this.Math.rand(75, 100) * 0.01), this.m.SoundPitch * 1.15);
		}
	}

	function playSound( _type, _volume, _pitch = 1.0 )
	{
		this.actor.playSound(_type, _volume, _pitch);
	}

	function onDeath( _killer, _skill, _tile, _fatalityType )
	{
		if (_tile != null)
		{
			local flip = this.Math.rand(0, 100) < 50;
			local decal;
			this.m.IsCorpseFlipped = flip;
			local body = this.getSprite("body");
			local head = this.getSprite("head");
			decal = _tile.spawnDetail("bust_hyena_01_body_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
			decal.Color = body.Color;
			decal.Saturation = body.Saturation;
			decal.Scale = 0.95;

			if (_fatalityType != this.Const.FatalityType.Decapitated)
			{
				decal = _tile.spawnDetail(head.getBrush().Name + "_dead", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Color = head.Color;
				decal.Saturation = head.Saturation;
				decal.Scale = 0.95;
			}
			else if (_fatalityType == this.Const.FatalityType.Decapitated)
			{
				local layers = [
					head.getBrush().Name + "_dead"
				];
				local decap = this.Tactical.spawnHeadEffect(this.getTile(), layers, this.createVec(0, 0), 0.0, "bust_hyena_head_bloodpool");
				decap[0].Color = head.Color;
				decap[0].Saturation = head.Saturation;
				decap[0].Scale = 0.95;
			}

			if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Arrow)
			{
				decal = _tile.spawnDetail("bust_hyena_01_body_dead_arrows", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}
			else if (_skill && _skill.getProjectileType() == this.Const.ProjectileType.Javelin)
			{
				decal = _tile.spawnDetail("bust_hyena_01_body_dead_javelin", this.Const.Tactical.DetailFlag.Corpse, flip);
				decal.Scale = 0.95;
			}

			this.spawnTerrainDropdownEffect(_tile);
			this.spawnFlies(_tile);
			local corpse = clone this.Const.Corpse;
			corpse.CorpseName = "一只鬣狗";
			corpse.IsHeadAttached = _fatalityType != this.Const.FatalityType.Decapitated;
			_tile.Properties.set("Corpse", corpse);
			this.Tactical.Entities.addCorpse(_tile);

			if (_killer == null || _killer.getFaction() == this.Const.Faction.Player || _killer.getFaction() == this.Const.Faction.PlayerAnimals)
			{
				local n = 1 + (!this.Tactical.State.isScenarioMode() && this.Math.rand(1, 100) <= this.World.Assets.getExtraLootChance() ? 1 : 0);

				for( local i = 0; i < n; i = ++i )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						local r = this.Math.rand(1, 100);
						local loot;

						if (r <= 60)
						{
							loot = this.new("scripts/items/misc/hyena_fur_item");
						}
						else
						{
							loot = this.new("scripts/items/misc/acidic_saliva_item");
						}

						loot.drop(_tile);
					}
					else if (this.Math.rand(1, 100) <= 33)
					{
						local loot = this.new("scripts/items/supplies/strange_meat_item");
						loot.drop(_tile);
					}
				}

				if (this.isKindOf(this, "hyena_high") && this.Math.rand(1, 100) <= 20)
				{
					local loot = this.new("scripts/items/loot/sabertooth_item");
					loot.drop(_tile);
				}
			}
		}

		this.actor.onDeath(_killer, _skill, _tile, _fatalityType);
	}

	function onInit()
	{
		this.actor.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Hyena);
		b.IsAffectedByNight = false;
		b.IsImmuneToDisarm = true;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.ActionPointCosts = this.Const.DefaultMovementAPCost;
		this.m.FatigueCosts = this.Const.DefaultMovementFatigueCost;
		this.addSprite("socket").setBrush("bust_base_beasts");
		local body = this.addSprite("body");
		body.setBrush("bust_hyena_0" + this.Math.rand(1, 3));

		if (this.Math.rand(0, 100) < 90)
		{
			body.varySaturation(0.2);
		}

		if (this.Math.rand(0, 100) < 90)
		{
			body.varyColor(0.05, 0.05, 0.05);
		}

		local head = this.addSprite("head");
		head.setBrush("bust_hyena_0" + this.Math.rand(1, 3) + "_head");
		head.Color = body.Color;
		head.Saturation = body.Saturation;
		local injury = this.addSprite("injury");
		injury.Visible = false;
		injury.setBrush("bust_hyena_injured");
		local body_blood = this.addSprite("body_blood");
		body_blood.Visible = false;
		this.addDefaultStatusSprites();
		this.getSprite("status_rooted").Scale = 0.54;
		this.setSpriteOffset("status_rooted", this.createVec(0, 0));
		this.m.Skills.add(this.new("scripts/skills/actives/hyena_bite_skill"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_backstabber"));
		this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
	}

});

