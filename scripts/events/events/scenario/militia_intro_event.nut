this.militia_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.militia_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_141.png[/img]{追捕土匪。抵御掠夺者。诱捕攻击农场的狼群。这些全是民兵的工作。而如果继续问的话，能回答的也跟着增加。所有的这一切只是为了确保你们的家园%home%安全。\n\n当一名贵族召见你后，你和你的临时战士们被带上了高出生贵族们之间的战场。你不知道他们的名字也不知道他们的目标，你只知道其中一个把你和你的手下征集起来带向了战场。就这样你们参了战。不幸的是，一个低出生的人就算拿着矛和盾也比起对战斗有所顾虑的平民好不了多少。你的民兵团当时被派去阻挡一支敌人的骑士队伍，但己方弓箭手同时降下了漫天箭雨，不止射中骑士也射中了平民。\n\n在这场战斗过后你和你的手下永远逃离了这片战场。你们作为佣兵武装起自己，并彼此发起血誓你们永远不会让一个高出生的人加入战团。一群普普通通的人组成的佣兵团，仅此而已。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们是自己的领主。",
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
		this.m.Title = "平民民兵";
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"home",
			this.World.Flags.get("HomeVillage")
		]);
	}

	function onClear()
	{
	}

});

