this.teamplayer_trait <- this.inherit("scripts/skills/traits/character_trait", {
	m = {},
	function create()
	{
		this.character_trait.create();
		this.m.ID = "trait.teamplayer";
		this.m.Name = "团队精神";
		this.m.Icon = "ui/traits/trait_icon_58.png";
		this.m.Description = "这个角色总是向他战友宣告他的意图。事实上他根本学不会闭嘴，这不管怎样都减少了事故发生的几率。";
		this.m.Titles = [];
		this.m.Excluded = [
			"trait.cocky",
			"trait.bloodthirsty",
			"trait.drunkard",
			"trait.dumb",
			"trait.impatient"
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
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]几率不会造成友方伤害"
			}
		];
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.isAttack() && _targetEntity != null && _targetEntity.getID() != this.getContainer().getActor().getID() && _targetEntity.getFaction() == this.getContainer().getActor().getFaction())
		{
			_properties.MeleeSkillMult *= 0.5;
			_properties.RangedSkillMult *= 0.5;
		}
	}

});

