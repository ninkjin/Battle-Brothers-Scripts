this.glorious_resolve_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.glorious";
		this.m.Name = "荣耀决心";
		this.m.Icon = "ui/traits/trait_icon_72.png";
		this.m.Description = "锻造于南方的竞技场，这个角色与人还有野兽都战斗过，并且打破他的决心需要巨大的付出。他美妙的生活方式需要很高的薪水，但他永远不会抛弃你，也不能被解雇。如果三个初始成员都死了，你的战役就结束了。";
		this.m.Order = this.Const.SkillOrder.Trait - 1;
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
				id = 11,
				type = "text",
				icon = "ui/icons/special.png",
				text = "每个失败的士气检定都有第二次机会重新掷骰"
			}
		];
	}

	function onUpdate( _properties )
	{
		_properties.RerollMoraleChance = 100;
	}

});

