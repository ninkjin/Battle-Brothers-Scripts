this.mad_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.mad";
		this.m.Name = "疯狂";
		this.m.Icon = "ui/traits/trait_icon_76.png";
		this.m.Description = "这个角色凝视了深渊，深渊凝视了回来，把他变的疯疯癫癫。他经常嘴里念叨些胡言乱语，并且他神秘的思维已经完全无法被同僚和敌人所掌握了。";
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
				icon = "ui/icons/bravery.png",
				text = "每次士气检定随机[color=" + this.Const.UI.Color.PositiveValue + "]+15[/color]或[color=" + this.Const.UI.Color.NegativeValue + "]-15[/color]决心"
			},
			{
				id = 10,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "免疫恐惧和精神控制"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.MoraleCheckBraveryMult[this.Const.MoraleCheckType.MentalAttack] *= 1000.0;
	}

});

