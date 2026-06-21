this.shieldwall <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.shieldwall";
		this.m.Name = "盾墙";
		this.m.Description = "在下一个轮次开始前，盾牌被举起到了防护姿态的高度。肩并肩使用盾墙的盟友们可以重叠他们的盾牌来进一步提升防护。";
		this.m.Icon = "skills/active_15.png";
		this.m.IconDisabled = "skills/active_15_sw.png";
		this.m.Overlay = "active_15";
		this.m.SoundOnUse = [
			"sounds/combat/shieldwall_01.wav",
			"sounds/combat/shieldwall_02.wav",
			"sounds/combat/shieldwall_03.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.NonTargeted;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 20;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local p = this.getContainer().getActor().getCurrentProperties();
		local item = this.getContainer().getActor().getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);
		local mult = 1.0;
		local proficiencyBonus = 0;

		if (this.getContainer().getActor().getCurrentProperties().IsSpecializedInShields)
		{
			mult = mult * 1.25;
		}

		if (this.getContainer().getActor().getCurrentProperties().IsProficientWithShieldSkills)
		{
			proficiencyBonus = 5;
		}

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
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "获得[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getMeleeDefense() * mult + proficiencyBonus) + "[/color]近战防御，持续1回合"
			},
			{
				id = 5,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "获得[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.Math.floor(item.getRangedDefense() * mult + proficiencyBonus) + "[/color]远程防御，持续1回合"
			},
			{
				id = 6,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "每有一名同样使用盾墙的相邻盟友，获得额外[color=" + this.Const.UI.Color.PositiveValue + "]+5[/color]对抗任意攻击的防御"
			}
		];
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.shieldwall");
	}

	function onAfterUpdate( _properties )
	{
		this.m.FatigueCostMult = _properties.IsProficientWithShieldWall || _properties.IsProficientWithShieldSkills ? this.Const.Combat.WeaponSpecFatigueMult : 1.0;
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		this.m.Container.add(this.new("scripts/skills/effects/shieldwall_effect"));

		if (!_user.isHiddenToPlayer())
		{
			this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_user) + "使用盾墙");
		}

		return true;
		return false;
	}

	function onRemoved()
	{
		this.m.Container.removeByID("effects.shieldwall");
	}

});

