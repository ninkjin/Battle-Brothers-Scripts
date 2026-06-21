this.weakened_heart_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.weakened_heart";
		this.m.Name = "心脏衰弱";
		this.m.Description = "过去遭受的伤势导致这个角色心脏衰弱，严重降低了他的体质。";
		this.m.Icon = "ui/injury/injury_permanent_icon_14.png";
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
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-30%[/color]生命值"
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
		_properties.HitpointsMult *= 0.7;
		_properties.IsContentWithBeingInReserve = true;
	}

	function onApplyAppearance()
	{
	}

});

