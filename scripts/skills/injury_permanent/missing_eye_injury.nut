this.missing_eye_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_eye";
		this.m.Name = "独眼龙";
		this.m.Description = "少了一只眼睛使得准确判断距离变得困难，同时也限制了视野。";
		this.m.Icon = "ui/injury/injury_permanent_icon_03.png";
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
				id = 7,
				type = "text",
				icon = "ui/icons/ranged_skill.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]远程技能"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/vision.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-2[/color]视野"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.RangedSkillMult *= 0.5;
		_properties.Vision -= 2;
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_4");
		sprite.setBrush("permanent_injury_04");
		sprite.Visible = true;
	}

});

