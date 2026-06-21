this.merchant_of_jugs_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.merchant_of_jugs";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_171.png[/img]{一个孤独的商人牵着骆驼拉的载重货车走了过来。 不小的瓶瓶罐罐在他货车底部磕磕碰碰，每一个的开口上系着根干草绳连在一起。 他在骆驼上弓起身并把腿摆向它的一边，他的靴子轻叩马镫。%SPEECH_ON%你好，旅行者，我祝你通往硬币的道路更加的金光闪耀。 我的已经是了，尽管我们的相逢恐怕恰巧在一个我的闪光数量上不多的时刻。 我只剩下了一点货物，都是些喝的。 50克朗一罐。有兴趣吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们出150克朗要所有罐子。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "50克朗，我们就买一个。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们没事。",
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
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_171.png[/img]{你与商人交换了他所有的货物，他非常乐意地答应了。他离开时，他的骆驼已经空了，但却似乎已经从运输重物中恢复了活力。这些水罐中的饮料是水和其他添加剂的混合物，这将确保持久的美味口感。在这片地狱般的荒漠中，这是一种令人耳目一新的饮料。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "清爽可口！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-150);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]150[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				for( local i = 0; i < 3; i = ++i )
				{
					foreach( bro in brothers )
					{
						if (this.Math.rand(1, 100) <= 33)
						{
							bro.improveMood(1.0, "喝到清爽的饮料");

							if (bro.getMoodState() > this.Const.MoodState.Neutral)
							{
								this.List.push({
									id = 10,
									icon = this.Const.MoodStateIcon[bro.getMoodState()],
									text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
								});
							}
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_171.png[/img]{商人点了点头，你用克朗换了一个罐子。 尽管只有一罐饮料，在这酷热的沙漠里也能提供些许清爽的闲暇。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "清爽可口！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-50);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]50[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(1.0, "喝到清爽的饮料");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 150)
		{
			return;
		}

		this.m.Score = 10;
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

