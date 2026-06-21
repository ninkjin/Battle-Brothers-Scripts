this.no_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.none";
		this.m.Duration = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "战队做得很好，我们只需要保持下去！\n（没有野心）";
		this.m.RewardTooltip = null;
	}

	function getButtonTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "header",
				text = "没有野心"
			},
			{
				id = 2,
				type = "text",
				text = "现在不选择野心。 三天后你会被要求再次选择。"
			}
		];
		return ret;
	}

});

