this.collector_wants_trophy_event <- this.inherit("scripts/events/event", {
	m = {
		Peddler = null,
		Reward = 0,
		Item = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.collector_wants_trophy";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_01.png[/img]{逛城镇市场时，一位身穿丝绸的男子走到了你身边。他脸上挂着比镶钻更闪的笑容，每个手指上都戴着闪光的戒指。 | 当你观察当地市场的商品时，一个陌生人走了过来。他腰间挂着各种奇怪的液体，牙齿中大多是奇怪的木材。 | 没有一次到市场不被奇怪的家伙引起骚扰的行程。这次是一个脸很大的男人，他的嘴巴像熊捕鼠器一样带着锯齿，他的脸颊高高挺起，像是要做成货架一样。除了他的容貌之外，他挥舞着自己的体重，像他是一个有权有势的人物。}%SPEECH_ON%{啊，佣兵，我发现你有一些有趣的战利品。你把那个%trophy%卖给我吧，我给你%reward%克朗。 | 你有一个有趣的战利品，%trophy%。我会给你%reward%克朗，轻松的赚钱！ | 嗯，我发现你是那种冒险类型。你不可能得到%trophy%，除非你很有诡计。我有一些金子，我会给你%reward%克朗，换取那个小玩意儿。}%SPEECH_OFF%你正在考虑那个男人的offer。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Deal.",
					function getResult( _event )
					{
						if (_event.m.Peddler != null)
						{
							return "Peddler";
						}
						else
						{
							this.World.Assets.addMoney(_event.m.Reward);
							local stash = this.World.Assets.getStash().getItems();

							foreach( i, item in stash )
							{
								if (item != null && item.getID() == _event.m.Item.getID())
								{
									stash[i] = null;
									break;
								}
							}

							return 0;
						}
					}

				},
				{
					Text = "这可不行。",
					function getResult( _event )
					{
						if (_event.m.Peddler != null)
						{
							return "Peddler";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Peddler",
			Text = "[img]gfx/ui/events/event_01.png[/img]{[%peddler%]走上前，把你按回去，就像你是一个随机的顾客而不是战团队长。他对买家大喊大叫，扬起一只手，买家也回应着，像两只狗互相吠叫，这一切都是如此之快，有如另一种语言般含糊不清。一分钟后，小贩回来了。%SPEECH_ON%好了，他现在出价%reward%克朗。我要去看看一些锅碗瓢盆，祝你好运。%SPEECH_OFF%他拍拍你的肩膀走开了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Deal.",
					function getResult( _event )
					{
						this.World.Assets.addMoney(_event.m.Reward);
						local stash = this.World.Assets.getStash().getItems();

						foreach( i, item in stash )
						{
							if (item != null && item.getID() == _event.m.Item.getID())
							{
								stash[i] = null;
								break;
							}
						}

						return 0;
					}

				},
				{
					Text = "这可不行。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
				_event.m.Reward = this.Math.floor(_event.m.Reward * 1.33);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local candidates_items = [];

		foreach( item in stash )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Crafting) && item.getValue() >= 400)
			{
				candidates_items.push(item);
			}
		}

		if (candidates_items.len() == 0)
		{
			return;
		}

		this.m.Item = candidates_items[this.Math.rand(0, candidates_items.len() - 1)];
		this.m.Reward = this.m.Item.getValue();
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_peddler = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.peddler")
			{
				candidates_peddler.push(bro);
			}
		}

		if (candidates_peddler.len() != 0)
		{
			this.m.Peddler = candidates_peddler[this.Math.rand(0, candidates_peddler.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"peddler",
			this.m.Peddler != null ? this.m.Peddler.getName() : ""
		]);
		_vars.push([
			"reward",
			this.m.Reward
		]);
		_vars.push([
			"trophy",
			this.m.Item.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Peddler = null;
		this.m.Reward = 0;
		this.m.Item = null;
		this.m.Town = null;
	}

});

