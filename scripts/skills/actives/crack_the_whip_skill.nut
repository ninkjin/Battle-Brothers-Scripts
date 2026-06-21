this.crack_the_whip_skill <- this.inherit("scripts/skills/skill", {
	m = {
		IsUsed = false
	},
	function create()
	{
		this.m.ID = "actives.crack_the_whip";
		this.m.Name = "抽鞭子";
		this.m.Description = "";
		this.m.Icon = "skills/active_162.png";
		this.m.IconDisabled = "skills/active_162.png";
		this.m.Overlay = "active_162";
		this.m.SoundOnUse = [
			"sounds/combat/whip_01.wav",
			"sounds/combat/whip_02.wav",
			"sounds/combat/whip_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 10;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function isUsable()
	{
		if (this.m.IsUsed)
		{
			return false;
		}

		if (!this.skill.isUsable() || this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			return false;
		}

		local actors = this.Tactical.Entities.getInstancesOfFaction(this.getContainer().getActor().getFaction());

		foreach( a in actors )
		{
			if (a.getType() == this.Const.EntityType.BarbarianUnhold || a.getType() == this.Const.EntityType.BarbarianUnholdFrost)
			{
				return true;
			}
		}

		return false;
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getType() != this.Const.EntityType.BarbarianUnhold && a.getType() != this.Const.EntityType.BarbarianUnholdFrost)
			{
				continue;
			}

			a.setWhipped(true);
			this.spawnIcon("status_effect_106", a.getTile());
		}

		this.m.IsUsed = true;
		return true;
	}

	function onTurnStart()
	{
		this.m.IsUsed = false;
	}

});

