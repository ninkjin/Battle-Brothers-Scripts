this.anatomists_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.anatomists_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_181.png[/img]{你一开始以为他们是赏金猎人，但他们迅速做出纠正，声称他们是‘研究人员’，而不是‘穷追人员’。当你还一头雾水的时候，他们解释说他们其实是‘解剖学家’，不过这也没起到多大帮助。在因此烦躁后，他们说你是个‘聊天黑洞’，你自豪地反馈说你明白‘聊天’这个词是什么意思，不过他们都笑了并说你听错了，他们的意思是鸡同鸭讲。感觉到他们在当面嘲笑你，你拔出了你的剑，而这时他们则把双手高举到半空，每只手都拿着装满克朗的钱包。\n\n又深入谈了一会儿，你明白了他们是一群对尸体有着强烈兴趣的书呆子。既然你很擅长制造尸体，他们觉得雇你帮他们制造尸体非常合适。你需要去各地旅行，雇佣一批强大的雇佣兵，然后帮助这帮怪人完成他们的科学研究。你唯一的要求就是如果你不幸死掉他们不得对你的身体做啥奇奇怪怪的勾当。这些解剖学家面带温暖的笑容做出保证说他们绝不会对有生意往来的人做出这种事。他们每个人都笑得仿佛他们从死人那学会的怎么笑，不过你也只好相信他们。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "转念一想，你们同样必须承诺在我还活着的时候也别碰我的身体。",
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
		this.m.Title = "解剖学家";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

