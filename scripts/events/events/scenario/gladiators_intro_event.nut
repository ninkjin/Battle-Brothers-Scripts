this.gladiators_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.gladiators_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_147.png[/img]{杀死一个人本是小事一桩，然而不熟练却能使肉体坚韧：凶手们在街上被捉住，扼紧喉咙，拉住臂膀，钳住双手，尖叫着为什么他们的受害者没有死。母亲的遗产被毁了，一遍又一遍的用火钩击打她的丈夫，而他在火星熄灭后仍能喘气。一个无聊的维齐尔搞不清为啥他的拷打者对付一个罪犯那么费劲，而那个被弄疯的人在被割下某个最重要的附属物时依旧在嘲笑他们。\n\n但是对于角斗士来说，一个人不仅仅是一个人，他还是一个武器的使用者。剑，斧，矛，三叉戟等等。当你越过这些显而易见的防护后，他仅仅是最熟悉不过的肉体，解决他不是为了斗争而是为了娱乐。娱乐！在比赛里和各色肤色的人们竞争，以及人群的狂欢。这些都是你喜爱的事物。让哲学家们继续谈论事物生死存亡的本质吧。当你把剑猛插进某些蠢货的脖子中时，不仅有鲜血喷涌到了你的锋刃之上，亦有人群喷涌出对你的成就的欢呼赞美之声！这是世界上最美妙的声音！追随而来的女人们，如此热辣令人苦恼，她们甚至不等你清理掉粘上的内脏就要开干？荣耀啊。\n\n但是这也一样渐渐变得枯燥。已经有多少场战斗？你数不清了。有多少挑战？你一个都说不出来。一个都没有！%g1%，%g2%，还有%g3%都同意：是你太优秀了。如果要你说实话，他们也很优秀。不过你们四个都同意：你们应该离开竞技场在整个世界塑造冠军之魂。\n\n角斗士们多少有一些奢侈的癖好，特别是香薰浴和刻有他们名字的珠宝首饰，所以在离开舒适的城邦之后，请准备好为他们每人付一大笔钱以支撑他们奢侈的生活方式。正是如此，你的三个坚实有力但不总是伟大的战斗伙伴将展示他们的战斗力，而你也将面临一项新的挑战：学习如何管理战士(达不到你们水平的)和他们的需求。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "应该是小事一桩。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "角斗士";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"g1",
			brothers[0].getName()
		]);
		_vars.push([
			"g2",
			brothers[1].getName()
		]);
		_vars.push([
			"g3",
			brothers[2].getName()
		]);
	}

	function onClear()
	{
	}

});

