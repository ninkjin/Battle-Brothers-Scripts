this.monolith_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.monolith_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_101.png[/img]{从远处看去，黑色的方尖碑就像一座从地面倾斜的黑色塔楼。上空的天空毫无瑕疵，就像云和鸟儿绕过了某座看不见的山。一种麻木已经落在了这片腹地上，大地既不衰弱也不生长，一片残酷的沉寂使得这里无生命之苦更加难以忍受。冒险家们去过那里，但没有一个人回来。他们死亡的传说一直在堆积，一直到他们的缺席把整个方尖碑笼罩起来，给它裹上了一层可怕的恐惧和威胁，没有人敢靠近。\n\n但现在，%companyname%就像钢剑上的蚂蚁一样来到方尖碑的前面。在这里，你会发现这个建筑物根本就没有建在地上：方尖碑休息在一个废弃采石场的坑里。道路和小径像一些巨大的中空地下孔眼一样蜿蜒向深处。满是泥土的无数桶悬挂在每个间隙上，像节日之夜上的无火灯笼。更多的绳索固定着桥梁的框架，曾经的人行道板早已垮塌。还有更多的丝带像一大群人一样缠绕在方尖碑周围，似乎是要推倒它，或者纠正它的倾斜。在这个废弃坑洞的底部是方尖碑的基座，但对你来说这只是一个猜测。它看起来好像永远都在向地下和下面的未知世界降下。铲子和鹤嘴锄散落在它的黑曜石墙上，金属上仍然沾着土壤。%randombrother%对这个场景点点头。%SPEECH_ON%看起来挖掘的人被打断了。%SPEECH_OFF%这个人的话传到了采石场之外，变得如此清晰，以至于你都可以看到它们。回头看，你会发现沉默本身已经跟随着你，但即使在坑边，它也很沉思而不紧张。进入采石场的决定让你的心情沉重。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "进去。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "撤退。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_101.png[/img]{在采石场深处绕过一个长长的弯道，你发现了一系列被挖成的走廊。你举起一只拳头，战团停止前进。%randombrother%问怎么了。你把手指放在嘴唇上。\n\n你轻轻地走近其中一根绳子，它挂在这一层和矿坑底部之间。装满土壤的水桶因为你的突然出现而晃动。升降水桶的滑轮早已被生锈腐蚀。你抽出剑，砍断了绳子。绑在绳子上的桶像一条鞭子般抽回，坠落到地面上，在岩石上左右晃动，最后以金属声响和一片尘土落地。于是，寂静被打破了。\n\n憔悴的矿工们从下面的走廊里涌出来，漆黑的矿工和挖掘工如同返回一些未完成工作的地方，满脚泥污，穿着破烂的衬衫和靴子、披着披巾。你试着数它们的数量，但当一群装甲士兵和这支队伍里的其他人排成队伍追了过来时，你的注意力被分散了，持枪持盾、持矛的士兵是最危险的。\n\n在采石场逃跑毫无意义，这片土地上没有可以逃去的地方。当你回头看那些男人时，他们已经开始拔出武器。%randombrother%点了点头。%SPEECH_ON%跟您到底，队长。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "坚持到底！",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setAttackable(true);
							this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
						}

						this.World.Events.showCombatDialog(true, true, true);
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

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

