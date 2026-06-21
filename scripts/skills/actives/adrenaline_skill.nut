this.adrenaline_skill <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.adrenaline";
		this.m.Name = "肾上腺素";
		this.m.Description = "感受肾上腺素在血管中的奔涌，并抓住机会在敌人之前行动。";
		this.m.Icon = "ui/perks/perk_37_active.png";
		this.m.IconDisabled = "ui/perks/perk_37_active_sw.png";
		this.m.Overlay = "perk_37_active";
		this.m.SoundOnUse = [
			"sounds/combat/perfect_focus_01.wav"
		];
		this.m.SoundVolume = 0.5;
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 1;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local ret = [
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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "让这个角色在下个回合的轮次中处于首位"
			}
		];
		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.adrenaline");
	}

	function onUse( _user, _targetTile )
	{
		if (!this.getContainer().hasSkill("effects.adrenaline"))
		{
			this.m.Container.add(this.new("scripts/skills/effects/adrenaline_effect"));
			return true;
		}

		return false;
	}

});

