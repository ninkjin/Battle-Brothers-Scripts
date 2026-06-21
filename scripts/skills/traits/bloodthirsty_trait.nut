this.bloodthirsty_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.bloodthirsty";
		this.m.Name = "嗜血";
		this.m.Icon = "ui/traits/trait_icon_42.png";
		this.m.Description = "这个角色对他的敌人过度暴力和残忍。一个对手死了还不够好，他的头需要被插在桩子上。";
		this.m.Titles = [
			"屠夫",
			"疯子",
			"残暴者"
		];
		this.m.Excluded = [
			"trait.weasel",
			"trait.fainthearted",
			"trait.hesistant",
			"trait.craven",
			"trait.insecure",
			"trait.craven",
			"trait.paranoid",
			"trait.fear_beasts",
			"trait.fear_undead",
			"trait.fear_greenskins",
			"trait.teamplayer"
		];
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
				icon = "ui/icons/special.png",
				text = "所有的击杀都是必死击杀(如果武器允许)。"
			}
		];
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		_properties.FatalityChanceMult = 1000.0;
	}

});

