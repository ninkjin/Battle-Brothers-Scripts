this.addict_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.addict";
		this.m.Name = "上瘾";
		this.m.Icon = "ui/traits/trait_icon_62.png";
		this.m.Description = "这个角色已经对某些物质上瘾。如果不定期摄入，他可能会出现戒断症状。";
		this.m.Excluded = [];
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
			}
		];
		local time = 0.0;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		local isAffected = time - this.getContainer().getActor().getFlags().get("PotionLastUsed") >= 5.0 * this.World.getTime().SecondsPerDay;

		if (isAffected)
		{
			ret.push({
				id = 11,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]决心"
			});
			ret.push({
				id = 12,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]近战技能"
			});
			ret.push({
				id = 13,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]远程技能"
			});
			ret.push({
				id = 14,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]近战防御"
			});
			ret.push({
				id = 15,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]远程防御"
			});
		}
		else
		{
			ret.push({
				id = 10,
				type = "text",
				icon = "ui/icons/special.png",
				text = "目前没有影响，因为过去5日内摄入了药物"
			});
		}

		return ret;
	}

	function onAdded()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("eye_rings"))
		{
			actor.getSprite("eye_rings").Visible = true;
		}
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();

		if (actor.hasSprite("eye_rings"))
		{
			actor.getSprite("eye_rings").Visible = false;
		}
	}

	function onUpdate( _properties )
	{
		local time = 0.0;

		if (("State" in this.World) && this.World.State != null && this.World.State.getCombatStartTime() != 0)
		{
			time = this.World.State.getCombatStartTime();
		}
		else
		{
			time = this.Time.getVirtualTimeF();
		}

		local isAffected = time - this.getContainer().getActor().getFlags().get("PotionLastUsed") >= 7.0 * this.World.getTime().SecondsPerDay;

		if (isAffected)
		{
			_properties.BraveryMult *= 0.9;
			_properties.MeleeSkillMult *= 0.9;
			_properties.RangedSkillMult *= 0.9;
			_properties.MeleeDefenseMult *= 0.9;
			_properties.RangedDefenseMult *= 0.9;
		}
	}

});

