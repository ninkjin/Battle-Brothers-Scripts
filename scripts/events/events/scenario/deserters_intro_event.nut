this.deserters_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.deserters_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_88.png[/img]{穿着破旧的老靴子远征。天降大雪？战斗。倾盆大雨？战斗。被重骑兵冲锋？拿上你的长矛。战斗。战斗。一直在战斗。但再简单的人也会难以忍受。申请一双袜子，却被告知去偷平民的。申请一份更好的餐食，结果饭被倒在了地上。\n\n士兵的生活方式并不会困扰你。杀戮也不会困扰你，死亡的威胁也不会困扰你。贵族们的不尊重，那些‘勇敢地’把你扔进绞肉机的尉官们的不负责任，才是削弱了你意志的原因。此外还有无聊。日复一日无尽的无聊。\n\n讽刺的是在你和其他三个逃兵逃离营地的当天，他们给士兵们开了一顿大餐。他们称之为对胜利的庆祝。你的盘子里面装满了食物。这些是本属于那天死去的人们的口粮。但是你吃了那些食物，并且吃了个精光。之后你拿起你的包，去守夜，然后就溜了。为了策划出逃，其他三个逃兵选举你带头并听从你的命令。\n\n你会开辟一条佣兵之路，至少得到的报酬会和受到的痛苦相匹配。但首先，你必须设法到别的地方去，因为如果你在这里呆太久，绞架肯定是你的人生归宿。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们的命运掌握在自己手中。",
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
		this.m.Title = "逃兵";
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

