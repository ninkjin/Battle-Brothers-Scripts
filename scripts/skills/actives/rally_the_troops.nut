this.rally_the_troops <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "actives.rally_the_troops";
		this.m.Name = "集结";
		this.m.Description = "集合！利用此角色振奋人心的决心集结附近逃跑的盟友，并使得每个人都能越过极限更进一步。一个角色每轮只能被集结一次。";
		this.m.Icon = "ui/perks/perk_42_active.png";
		this.m.IconDisabled = "ui/perks/perk_42_active_sw.png";
		this.m.Overlay = "perk_42_active";
		this.m.SoundOnUse = [
			"sounds/combat/rally_the_troops_01.wav"
		];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.Any;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsVisibleTileNeeded = false;
		this.m.ActionPointCost = 5;
		this.m.FatigueCost = 25;
		this.m.MinRange = 1;
		this.m.MaxRange = 1;
	}

	function getTooltip()
	{
		local bravery = this.Math.max(0, this.Math.floor(this.getContainer().getActor().getCurrentProperties().getBravery() * 0.4));
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
				text = "进行一次士气检定来集结4格距离内的溃逃队友，附带[color=" + this.Const.UI.Color.PositiveValue + "]+" + bravery + "[/color]来自此角色的决心奖励"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "进行一次士气检定来振奋4格内士气低于镇定状态的队友，附带[color=" + this.Const.UI.Color.PositiveValue + "]+" + bravery + "[/color]来自此角色的决心奖励，但每格距离会降低[color=" + this.Const.UI.Color.NegativeValue + "]-10[/color]"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/special.png",
				text = "移除4格距离内队友的睡眠状态效果"
			}
		];

		if (this.getContainer().hasSkill("effects.rallied"))
		{
			ret.push({
				id = 9,
				type = "text",
				icon = "ui/tooltips/warning.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]在自己被集结的同一轮不能再集结其他人[/color]"
			});
		}

		return ret;
	}

	function isUsable()
	{
		return this.skill.isUsable() && !this.getContainer().hasSkill("effects.rallied");
	}

	function onUse( _user, _targetTile )
	{
		local myTile = _user.getTile();
		local bravery = this.Math.floor(_user.getCurrentProperties().getBravery() * 0.4);
		local actors = this.Tactical.Entities.getInstancesOfFaction(_user.getFaction());

		foreach( a in actors )
		{
			if (a.getID() == _user.getID())
			{
				continue;
			}

			if (myTile.getDistanceTo(a.getTile()) > 4)
			{
				continue;
			}

			if (a.getFaction() == _user.getFaction() && !a.getSkills().hasSkill("effects.rallied"))
			{
				a.getSkills().removeByID("effects.sleeping");

				if (a.getMoraleState() >= this.Const.MoraleState.Steady)
				{
					continue;
				}

				local difficulty = bravery;
				local distance = a.getTile().getDistanceTo(myTile) * 10;
				local morale = a.getMoraleState();

				if (a.getMoraleState() == this.Const.MoraleState.Fleeing)
				{
					a.checkMorale(this.Const.MoraleState.Wavering - this.Const.MoraleState.Fleeing, difficulty, this.Const.MoraleCheckType.Default, "status_effect_56");
				}
				else
				{
					a.checkMorale(1, difficulty - distance, this.Const.MoraleCheckType.Default, "status_effect_56");
				}

				if (morale != a.getMoraleState())
				{
					a.getSkills().add(this.new("scripts/skills/effects/rallied_effect"));
				}
			}
		}

		this.getContainer().add(this.new("scripts/skills/effects/rallied_effect"));
		return true;
	}

});

