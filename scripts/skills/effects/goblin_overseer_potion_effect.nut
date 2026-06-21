this.goblin_overseer_potion_effect <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "effects.goblin_overseer_potion";
		this.m.Name = "突变角膜";
		this.m.Icon = "skills/status_effect_126.png";
		this.m.IconMini = "";
		this.m.Overlay = "status_effect_126";
		this.m.Type = this.Const.SkillType.StatusEffect;
		this.m.Order = this.Const.SkillOrder.Perk;
		this.m.IsActive = false;
		this.m.IsRemovedAfterBattle = false;
		this.m.IsStacking = false;
	}

	function getDescription()
	{
		return "这个角色的眼睛已经永久性变异，现在能够侦测到气流最微弱的运动。虽然本身用处有限，但射出箭矢或弩矢的时候可以用来更好的预测弹道及更好的命中目标弱点。";
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
			},
			{
				id = 11,
				type = "text",
				icon = "ui/icons/direct_damage.png",
				text = "使用弓或弩时有额外[color=" + this.Const.UI.Color.PositiveValue + "]5%[/color]穿甲伤害"
			},
			{
				id = 12,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "再次突变会导致更长时间的疾病"
			}
		];
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.IsSharpshooter = true;
	}

	function onDeath( _fatalityType )
	{
		if (_fatalityType != this.Const.FatalityType.Unconscious)
		{
			this.World.Statistics.getFlags().set("isGoblinOverseerPotionAcquired", false);
		}
	}

	function onDismiss()
	{
		this.World.Statistics.getFlags().set("isGoblinOverseerPotionAcquired", false);
	}

});

