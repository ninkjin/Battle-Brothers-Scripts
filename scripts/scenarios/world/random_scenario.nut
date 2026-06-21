this.random_scenario <- this.inherit("scripts/scenarios/world/starting_scenario", {
	m = {},
	function create()
	{
		this.m.ID = "scenario.random";
		this.m.Name = "随机";
		this.m.Description = "[p=c][img]gfx/ui/events/event_74.png[/img][/p][p]以随机起源开始战役。多么令人兴奋啊！[/p]";
		this.m.Difficulty = 0;
		this.m.Order = 900;
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

});

