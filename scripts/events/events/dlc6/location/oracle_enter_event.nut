this.oracle_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.oracle_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_152.png[/img]{进入神谕所的前厅就好像走入他人的梦境。 男人和女人无精打采的在柱子周围来回移动，鞋子擦过石头的细微摩擦声充斥着空气，以及黯淡而阴沉的阴影通过建筑弯曲的穹顶投射在它奇怪的大厅里，不论白天还是黑夜都如同月光下一般。\n\n不同信仰的人们来到神谕所都带有一丝敬畏。 没有人知道哪些圣职者曾经居住在这里，亦或者他们袍子的颜色。 尽管有诸多秘密，许多人相信通过在神谕所入睡可以看到自己的未来。 一个值得尊敬的信仰，虽然你觉得这些超凡的意义必须通过忠实信徒的手脚才能到达很讽刺。 眼下，破败拥挤的帐篷城趴在神谕所的边缘。 对于那些自认为逃离了凡世的难民而言真是一个暮气沉沉的结局。}",
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

