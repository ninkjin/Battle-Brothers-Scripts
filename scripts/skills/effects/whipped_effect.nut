this.whipped_effect <- this.inherit("scripts/skills/skill", {
	m = {
		TurnsLeft = 2,
		Level = 0
	},
	function create()
	{
		this.m.ID = "effects.whipped";
		this.m.Name = "被鞭策";
		this.m.Icon = "skills/status_effect_121.png";
		this.m.IconMini = "status_effect_121_mini";
		this.m.Overlay = "status_effect_121";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.VeryLast;
		this.m.IsActive = false;
		this.m.IsStacking = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function getDescription()
	{
		return "这个角色刚刚通过一个苦痛的提醒想起了他应该为自己的主人做些什么。这还会持续" + this.m.TurnsLeft + "回合。";
	}

	function getTooltip()
	{
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
				id = 10,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (9 + this.m.Level) + "[/color]近战技能"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (9 + this.m.Level) + "[/color]远程技能"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (9 + this.m.Level) + "[/color]决心"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (9 + this.m.Level) + "[/color]主动性"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/melee_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0 + this.m.Level) + "[/color]近战防御"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/ranged_defense.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (0 + this.m.Level) + "[/color]远程防御"
			}
		];
	}

	function setLevel( _l )
	{
		this.m.Level = _l;
	}

	function onAdded()
	{
		this.m.TurnsLeft = 2;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush("bust_slave_whipped");
		actor.setDirty(true);
	}

	function onRefresh()
	{
		this.m.TurnsLeft = 2;
	}

	function onRemoved()
	{
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").resetBrush();
		actor.setDirty(true);
	}

	function onUpdate( _properties )
	{
		_properties.MeleeSkill += 9 + this.m.Level;
		_properties.RangedSkill += 9 + this.m.Level;
		_properties.MeleeDefense += 0 + this.m.Level;
		_properties.RangedDefense += 0 + this.m.Level;
		_properties.Bravery += 9 + this.m.Level;
		_properties.Initiative += 9 + this.m.Level;
		local actor = this.getContainer().getActor();
		actor.getSprite("status_sweat").setBrush(this.m.TurnsLeft > 1 ? "bust_slave_whipped" : "bust_slave_whipped_expiring");
		actor.setDirty(true);
	}

	function onRoundEnd()
	{
		if (--this.m.TurnsLeft <= 0)
		{
			this.removeSelf();
		}
	}

});

