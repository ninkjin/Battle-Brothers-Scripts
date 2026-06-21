this.swallowed_whole_effect <- this.inherit("scripts/skills/skill", {
	m = {
		Name = ""
	},
	function setName( _n )
	{
		this.m.Name = _n;
	}

	function getName()
	{
		return "吞下了" + this.m.Name;
	}

	function create()
	{
		this.m.ID = "effects.swallowed_whole";
		this.m.Name = "吞噬";
		this.m.Icon = "skills/status_effect_72.png";
		this.m.IconMini = "status_effect_72_mini";
		this.m.Overlay = "status_effect_72";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

});

