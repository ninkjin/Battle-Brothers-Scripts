this.brawl_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.brawl";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你出去撒尿，刚放出来的时候，战斗的喧哗突然在你身后爆发。你夹住它，收拾好裤子，往营地走回去。在那里，你发现整个战团正在与自己作战，而不是与任何特定的敌人作战。雇佣兵们爬过装备和篝火，互相打拳击、转肘和摔滚，或者相互拍打，把对方扑倒在地上。任何人一旦摔倒，就会被踢屁股，直到其他人分散注意力去分散踢人者的注意力，然后摔倒的人跳起来，重新加入战斗。当人们慢慢意识到你在那里时，这场混乱逐渐减轻，他们开始整理队形，似乎迅速地组织起来是个解决他们粗鲁行为问题的适当办法。\n\n你摇摇头，问他们是什么引发了这场斗殴。士兵们耸耸肩。任何人都记不住。你进行点名，确认没有人死亡。然后告诉他们握手，一边盯着他们。没有什么不好的情绪可以闻出来。看来这只是一场有趣的扭打和摔交。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "没有什么比打架更好的了，嗯？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.5, "架打的很好");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 10)
		{
			return;
		}

		this.m.Score = 5;
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

