this.trained_effect <- this.inherit("scripts/skills/injury/injury", {
	m = {
		XPGainMult = 1.0
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "effects.trained";
		this.m.Name = "训练经历";
		this.m.Description = "这个角色最近有幸向经验丰富的战士学习并一起训练，他已经学到了知识，现在需要在战场上应用以完成习的部分，从而将其完全掌握并消化。";
		this.m.Icon = "skills/status_effect_62.png";
		this.m.Type = this.m.Type | this.Const.SkillType.StatusEffect;
		this.m.IsHealingMentioned = false;
		this.m.IsTreatable = false;
		this.m.IsContentWithReserve = false;
		this.m.HealingTimeMin = 2;
		this.m.HealingTimeMax = 2;
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
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+" + (this.m.XPGainMult * 100 - 100) + "%[/color]经验获取"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);
		_properties.XPGainMult *= this.m.XPGainMult;
	}

	function onSerialize( _out )
	{
		this.injury.onSerialize(_out);
		_out.writeU8(this.m.HealingTimeMin);
		_out.writeU8(this.m.HealingTimeMax);
		_out.writeF32(this.m.XPGainMult);
		_out.writeString(this.m.Icon);
	}

	function onDeserialize( _in )
	{
		this.injury.onDeserialize(_in);
		this.m.HealingTimeMin = _in.readU8();
		this.m.HealingTimeMax = _in.readU8();
		this.m.XPGainMult = _in.readF32();
		this.m.Icon = _in.readString();
	}

});

