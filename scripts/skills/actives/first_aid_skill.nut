this.first_aid_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Item = null
	},
	function setItem( _i )
	{
		this.m.Item = this.WeakTableRef(_i);
	}

	function create()
	{
		this.m.ID = "actives.first_aid";
		this.m.Name = "急救";
		this.m.Description = "通过对伤口施加压力并进行临时包扎防止自己流血致死。不能恢复生命值。无法在卷入近战时使用。";
		this.m.Icon = "ui/perks/perk_55_active.png";
		this.m.IconDisabled = "ui/perks/perk_55_active_sw.png";
		this.m.Overlay = "perk_55_active";
		this.m.SoundOnUse = [
			"sounds/combat/first_aid_01.wav",
			"sounds/combat/first_aid_02.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsIgnoredAsAOO = true;
		this.m.ActionPointCost = 6;
		this.m.FatigueCost = 5;
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
				text = "移除流血状态效果"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "移除流血中的动脉割伤裂、颈静脉割伤和颈部划伤伤势"
			}
		];

		if (this.Tactical.isActive() && this.getContainer().getActor().getTile().hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()))
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]无法使用，因为此角色已卷入近战[/color]"
			});
		}

		local isQualified = this.getContainer().getActor().getSkills().hasSkill("effects.bleeding");

		if (!isQualified)
		{
			local skill = this.getContainer().getActor().getSkills().getSkillByID("injury.cut_artery");
			isQualified = skill != null && skill.isFresh();
		}

		if (!isQualified)
		{
			local skill = this.getContainer().getActor().getSkills().getSkillByID("injury.cut_throat");
			isQualified = skill != null && skill.isFresh();
		}

		if (!isQualified)
		{
			local skill = this.getContainer().getActor().getSkills().getSkillByID("injury.grazed_neck");
			isQualified = skill != null && skill.isFresh();
		}

		if (!isQualified)
		{
			ret.push({
				id = 5,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]只能在流血时使用[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		if (!this.Tactical.isActive())
		{
			return false;
		}

		local tile = this.getContainer().getActor().getTile();
		return this.skill.isUsable() && !tile.hasZoneOfControlOtherThan(this.getContainer().getActor().getAlliedFactions()) && this.onVerifyTarget(tile, tile);
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		if (!this.skill.onVerifyTarget(_originTile, _targetTile))
		{
			return false;
		}

		local target = _targetTile.getEntity();

		if (target.getSkills().hasSkill("effects.bleeding"))
		{
			return true;
		}

		local skill;
		skill = target.getSkills().getSkillByID("injury.cut_artery");

		if (skill != null && skill.isFresh())
		{
			return true;
		}

		skill = target.getSkills().getSkillByID("injury.cut_throat");

		if (skill != null && skill.isFresh())
		{
			return true;
		}

		skill = target.getSkills().getSkillByID("injury.grazed_neck");

		if (skill != null && skill.isFresh())
		{
			return true;
		}

		return false;
	}

	function onUse( _user, _targetTile )
	{
		local target = _targetTile.getEntity();
		this.spawnIcon("perk_55", _targetTile);

		while (target.getSkills().hasSkill("effects.bleeding"))
		{
			target.getSkills().removeByID("effects.bleeding");
		}

		local skill;
		skill = target.getSkills().getSkillByID("injury.cut_artery");

		if (skill != null && skill.isFresh())
		{
			target.getSkills().remove(skill);
		}

		skill = target.getSkills().getSkillByID("injury.cut_throat");

		if (skill != null && skill.isFresh())
		{
			target.getSkills().remove(skill);
		}

		skill = target.getSkills().getSkillByID("injury.grazed_neck");

		if (skill != null && skill.isFresh())
		{
			target.getSkills().remove(skill);
		}

		if (this.m.Item != null && !this.m.Item.isNull())
		{
			this.m.Item.removeSelf();
		}

		this.updateAchievement("FirstAid", 1, 1);
		return true;
	}

});

