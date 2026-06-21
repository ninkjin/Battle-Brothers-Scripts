this.meteorite_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.meteorite_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_154.png[/img]{一场大灾害在世界上的认知中总是来自大地她本身。 火山，洪水，地震，瘟疫，这些事物为所有人所恐惧。 没有警告的突发事件能够顷刻间粉碎最伟大的王国并扯下最伟大的国王们的王袍。\n\n你面前巨大的陨石坑不仅赤裸裸的反衬出你的渺小，还有你渺小的尺度：最愚蠢的人也看得出来陨石坑中心的巨大石头来自上面。 Perhaps very far above. 北方人相信这象征着旧神之间伟大战争的尾声。 这是一座山字面意义上的被神祗们用来当做武器，像一块石头一样被投石机抛出，落地时的巨大威力有如末日降临，以至于让天堂之战都因为恐怖而终止。 南方人则将它看做镀金者的“烈焰之泪”。 俯视着一个没有人的世界，神陷入了深深的悲伤而哭泣。 一开始他害怕他摧毁了下面的一切，但是当他看到人类从火中崛起并以尘为甲时。 And it is then that He knew Man, living in every corner of the earth, was His chosen beings, and Man knew Him.\n\n不论如何，陨石坑从世界各地吸引着追随者与信徒。 这里存在这一种互不相迫的友善共识，尽管在宗教战争时这一不成文的规矩通常是作废的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们的命运将再次引领我们来到这里。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

