this.headbutt_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.headbutt";
		this.m.Name = "头锤";
		this.m.Description = "";
		this.m.Icon = "skills/active_195.png";
		this.m.IconDisabled = "skills/active_195.png";
		this.m.Overlay = "active_195";
		this.m.SoundOnHit = [
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_01.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_02.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_03.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_hit_04.wav"
		];
		this.m.SoundOnMiss = [
			"sounds/enemies/dlc6/sand_golem_headbutt_miss_01.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_miss_02.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_miss_03.wav",
			"sounds/enemies/dlc6/sand_golem_headbutt_miss_04.wav"
		];
		this.m.SoundOnHitDelay = 0;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.OffensiveTargeted;
		this.m.Delay = 0;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = true;
		this.m.IsStacking = false;
		this.m.IsAttack = true;
		this.m.IsRanged = false;
		this.m.IsIgnoredAsAOO = false;
		this.m.IsShowingProjectile = true;
		this.m.IsDoingForwardMove = true;
		this.m.InjuriesOnBody = this.Const.Injury.BluntBody;
		this.m.InjuriesOnHead = this.Const.Injury.BluntHead;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 15;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
		this.m.MaxLevelDifference = 1;
		this.m.ChanceSmash = 50;
	}

	function onUpdate( _properties )
	{
		this.m.DirectDamageMult = 0.5;
	}

	function onUse( _user, _targetTile )
	{
		return this.attackEntity(_user, _targetTile.getEntity());
	}

});

