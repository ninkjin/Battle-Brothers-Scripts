this.missing_ear_injury <- this.inherit("scripts/skills/injury_permanent/permanent_injury", {
	m = {},
	function create()
	{
		this.permanent_injury.create();
		this.m.ID = "injury.missing_ear";
		this.m.Name = "一只耳";
		this.m.Description = "幸运的是，少一只耳朵并不会对这个角色造成太大妨碍。但这看起来确实很恶心。";
		this.m.Icon = "ui/injury/injury_permanent_icon_01.png";
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
				icon = "ui/icons/initiative.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color]主动性"
			}
		];
		this.addTooltipHint(ret);
		return ret;
	}

	function onUpdate( _properties )
	{
		_properties.InitiativeMult *= 0.9;
	}

	function onApplyAppearance()
	{
		local sprite = this.getContainer().getActor().getSprite("permanent_injury_2");
		sprite.setBrush("permanent_injury_02");
		sprite.Visible = true;
	}

});

