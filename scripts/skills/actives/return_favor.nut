this.return_favor <- this.inherit("scripts/skills/skill", {
	m = {
		IsSpent = false
	},
	function create()
	{
		this.m.ID = "actives.return_favor";
		this.m.Name = "以牙还牙";
		this.m.Description = "利用你高超的战斗技能采取防御姿态，并尝试失能任何攻击你且你能够得到的人。";
		this.m.Icon = "ui/perks/perk_31_active.png";
		this.m.IconDisabled = "ui/perks/perk_31_active_sw.png";
		this.m.Overlay = "perk_31_active";
		this.m.SoundOnUse = [
			"sounds/combat/return_favor_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 30;
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
				text = "获得[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]的几率击晕任何近战攻击此角色但没能命中的对手(抗性和免疫依旧生效)。"
			}
		];
		return ret;
	}

	function isUsable()
	{
		return !this.m.IsSpent && this.skill.isUsable();
	}

	function onUse( _user, _targetTile )
	{
		if (!this.m.IsSpent)
		{
			this.m.Container.add(this.new("scripts/skills/effects/return_favor_effect"));
			this.m.IsSpent = true;
			return true;
		}

		return false;
	}

	function onTurnStart()
	{
		this.m.IsSpent = false;
	}

});

