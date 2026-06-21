this.paladins_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.paladins_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_180.png[/img]{你对这种游戏很熟悉，就像任何使得你被规则及规则制定者搞的焦头烂额的游戏一样。这一个誓言，那一个誓言。你只知道你从来没能持有小安瑟姆的头骨，而后来某些渡誓者偷走那位小伙子的圣下颚骨。离开宣誓者真是你这辈子最正确的决定，哪怕只是让你留下了那么一丁点儿理智。\n\n不幸的是，那些忠实信徒仿佛总是能闻到叛教者的味道。当你今天早上打开大门时你仿佛看到某些个恶作剧的孩子拉的两坨屎：活生生的%oathtaker1%和%oathtaker2%。前者是一位信仰单纯从未动摇过的老人，后者是一个让你想起自己的天赋优良的侍从。毫无疑问，是那个更加多愁善感的年轻小伙子发出了他的请求：宣誓者需要一位熟悉这片土地的人来帮助他们，完成任务和实现誓言。你猛地关门结果发现老人的脚卡住了门缝。他拿出一大堆金币，你的鼻子一定因为钱的味道动了起来，因为两个人都面露喜色。\n\n你现在愿意顺着他们只因时事艰难，以及雇佣兵工作能赚到不少钱，哪怕是在宗教义务的伪装之下。既然有人愿意出资让你承担这个大有赚头的任务，那也没啥不可以的。只有一个条件：你将发下团长誓言，这意味着所有的战斗和苦差都将由他人完成。丝毫没有迟疑，宣誓者们同意了，然后他们拿出了小安瑟姆的头骨展示给你。你早已与组织失去联系，但看着这个孩子无法秃秃的颅顶你还是感到心底一阵悸动。%oathtaker2%点点头。%SPEECH_ON%让我们搜寻这片土地寻找荣耀，勤于我们的责任，并且愿我们能让小安瑟姆从那些分割了他的卑鄙杂种渡誓者的手中合整回来！%SPEECH_OFF%}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "为了金钱、荣誉、和小安瑟姆！",
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
		this.m.Title = "宣誓者";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"oathtaker1",
			brothers[0].getName()
		]);
		_vars.push([
			"oathtaker2",
			brothers[1].getName()
		]);
	}

	function onClear()
	{
	}

});

