this.rallied_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.rallied";
		this.m.Name = "被集结";
		this.m.Description = "你可以改变一切！一位鼓舞人心的领袖集结了这个角色，使得他凝聚了自身所有力量并继续前进。一个角色每轮只能被集结一次，并且不能在被集结的同时去集结他人。";
		this.m.Icon = "skills/status_effect_56.png";
		this.m.IconMini = "status_effect_56_mini";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = true;
	}

	function onTurnEnd()
	{
		this.removeSelf();
	}

});

