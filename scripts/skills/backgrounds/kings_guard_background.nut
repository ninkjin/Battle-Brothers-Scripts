this.kings_guard_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.kings_guard";
		this.m.Name = "国王护卫";
		this.m.Icon = "ui/backgrounds/background_59.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "当你在北方荒野中发现快要冻死的%name%时，你以为他是一个简单的平民。但事实证明，他是一个真正的国王护卫，不仅在头衔上也在行动上。他像保护他的主君免受外界侵害的一切那样战斗。谢天谢地，在那段时间'主君'恰好是你。最后一次听说他去了南方王国，正在保护一个试图推翻当地维齐尔的新兴游牧国王。";
		this.m.BadEnding = "你从来没有真正弄清楚%name%在加入%companyname%之前所'护卫'的是哪个国王，但现在并不重要了。在你突然退休后，国王护卫自己前往了南方沙漠。他在服侍一位维齐尔了一段时间，但未能保护维齐尔免受一个妃子的毒药侵害。作为惩罚，%name%的装备被融化在了一口锅中，然后倒进了他喉咙里。";
		this.m.HiringCost = 0;
		this.m.DailyCost = 30;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onAdded()
	{
		this.character_background.onAdded();
		local actor = this.getContainer().getActor();
		actor.setTitle("国王护卫");
	}

});

