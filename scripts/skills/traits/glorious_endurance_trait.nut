this.glorious_endurance_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {
		DamageReduction = 0.0
	},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.glorious";
		this.m.Name = "荣耀耐力";
		this.m.Icon = "ui/traits/trait_icon_70.png";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
	}

	function getDescription()
	{
		return "锻造于南方的竞技场，这个角色已经参加了许多战斗，并且每一击都会加强他不屈的意志和耐力。他美妙的生活方式需要很高的薪水，但他永远不会抛弃你，也不能被解雇。如果三个初始成员都死了，你的战役就结束了。";
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

		if (this.m.DamageReduction > 0.0)
		{
			ret.push({
				id = 6,
				type = "text",
				icon = "ui/icons/special.png",
				text = "只受到[color=" + this.Const.UI.Color.PositiveValue + "]" + (1.0 - this.m.DamageReduction) * 100 + "%[/color]的任意伤害"
			});
		}

		ret.push({
			id = 11,
			type = "text",
			icon = "ui/icons/special.png",
			text = "每次被击中获得5%的伤害减免，上限为25%"
		});
		return ret;
	}

	function onDamageReceived( _attacker, _damageHitpoints, _damageArmor )
	{
		if (_attacker != null && _attacker.getID() != this.getContainer().getActor().getID())
		{
			this.m.DamageReduction = this.Math.minf(0.25, this.m.DamageReduction + 0.05);
			this.m.Type = this.Const.SkillType.Trait | this.Const.SkillType.StatusEffect;
		}
	}

	function onCombatStarted()
	{
		this.m.DamageReduction = 0.0;
		this.m.Type = this.Const.SkillType.Trait;
	}

	function onCombatFinished()
	{
		this.m.DamageReduction = 0.0;
		this.m.Type = this.Const.SkillType.Trait;
	}

	function onUpdate( _properties )
	{
		_properties.DamageReceivedTotalMult *= 1.0 - this.m.DamageReduction;
	}

});

