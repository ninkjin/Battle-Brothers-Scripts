this.traumatized_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.traumatized";
		this.m.Name = "精神创伤";
		this.m.Description = "这个角色已经去过了死后世界。见识到自己生命的有限，经历了垂死和回归，留下的只是一个已然破碎的人。";
		this.m.Icon = "ui/injury/injury_permanent_icon_13.png";
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
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-40%[/color]决心"
			},
			{
				id = 7,
				type = "text",
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]主动性"
			},
			{
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "总是满足于充当后备"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.BraveryMult *= 0.6;
		_properties.InitiativeMult *= 0.7;
		_properties.IsContentWithBeingInReserve = true;
	}

	function onApplyAppearance()
	{
	}

});

