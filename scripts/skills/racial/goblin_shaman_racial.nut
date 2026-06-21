this.goblin_shaman_racial <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "racial.goblin_shaman";
		this.m.Name = "萨满";
		this.m.Description = "TODO";
		this.m.Icon = "";
		this.m.Type = this.Const.SkillType.Racial | this.Const.SkillType.Perk;
		this.m.Order = this.Const.SkillOrder.Last;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = true;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isPlacedOnMap() && this.Time.getRound() <= 1 && !this.Tactical.State.isScenarioMode() && !this.World.getTime().IsDaytime)
		{
			_properties.InitiativeForTurnOrderAdditional += 100;
		}
	}

});

