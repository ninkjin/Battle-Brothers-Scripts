this.perk_quick_hands <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "perk.quick_hands";
		this.m.Name = this.Const.Strings.PerkName.QuickHands;
		this.m.Description = "也许可以换这个试试？这个角色有拥有快手特技，并且此回合仍可以免费交换一个物品。";
		this.m.Icon = "ui/perks/perk_39.png";
		this.m.Type = this.Const.SkillType.Perk | this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk | this.Const.SkillOrder.Any;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsHidden = false;
	}

	function onUpdate( _properties )
	{
		if (this.getContainer().getActor().isPlayerControlled() && this.getContainer().getActor().isPlacedOnMap() && this.getContainer().getActor().getItems().m.ActionCost == 0)
		{
			this.m.IsHidden = false;
		}
		else
		{
			this.m.IsHidden = true;
		}
	}

	function onCombatStarted()
	{
		this.skill.onCombatStarted();

		if (this.getContainer().getActor().isPlayerControlled())
		{
			this.m.IsHidden = false;
		}
	}

	function onCombatFinished()
	{
		this.skill.onCombatFinished();
		this.m.IsHidden = true;
	}

});

