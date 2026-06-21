this.early_access_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.early_access_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_80.png[/img]你沐浴在早晨凉爽的空气中。随着太阳缓缓升起，你人生的新篇章也开始了。多年来，你以微薄的报酬做着刀口舔血的工作，终于攒下足够的克朗去组建一支你自己的雇佣兵战团。追随你的有%bro1%，%bro2%和%bro3%，你曾肩并肩与他们在同一个盾墙中战斗。你现在是他们的指挥官了，%companyname%的领导者。\n\n当你在各地旅行时，你应该在乡村和城市雇佣新人来填补你的队伍。许多愿意效力的人可能以前从未拿起过武器。可能是他们别无选择，可能是他们贪恋容易入手的战利品。他们中的大部分都会死在战场上。但是不要气馁。这就是雇佣兵的生活，当你来到下一个村子的时，总是会有新人热切的想要开始一段新的生活。\n\n这片土地目前很危险。强盗和抢劫者埋伏在路边，野兽在黑暗的森林中游荡，兽人部落在文明的边界之外躁动不安。甚至有传言说由于黑魔法作祟，死人从坟墓里爬起来再次行走在人间。不论你是在这片土地上的各个村庄和城市中签订合同，或是独力探险并掠夺，都有机会赚大钱。\n\n你的手下都在等待你发号施令。他们现在的生死都是为了%companyname%。",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "万岁！",
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
		this.m.Title = "" + this.World.Assets.getName();
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"bro1",
			brothers[0].getName()
		]);
		_vars.push([
			"bro2",
			brothers[1].getName()
		]);
		_vars.push([
			"bro3",
			brothers[2].getName()
		]);
	}

	function onClear()
	{
	}

});

