this.giant_tree_in_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null
	},
	function create()
	{
		this.m.ID = "event.giant_tree_in_forest";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]你穿过一道茂密的灌木丛，被眼前的景象所震惊。 若是把眼前的这个东西仅仅叫做一棵树或许对它是一种冒犯。 这周围的林木都朝着中心弯下腰，似是在向这树中的宗主表示敬意，那巨木粗壮的根系暴露在地面上，每一根分叉都足有你的腰那么粗，其头顶绿茵遮天蔽日，你甚至无法分清这是白天还是夜晚。\n\n 你走到树干旁边，用手掌轻轻抚过树皮，但又立刻停下来，因为你意识到此时的行为或许与无知顽童闯进肃穆教堂一般无异。僧侣 %monk% 背着手慢悠悠地走过来。%SPEECH_ON%这是一棵有灵的神树。 其根系洞穿我们脚下的厚土，联通神灵的领域。 据说神灵也曾侧耳聆听尘世众生，不过现在…现在的事谁又说得清楚呢。%SPEECH_OFF%你盯着这个人，他的站姿格外矜持，于是你问他对这棵树是否畏惧。 他微笑着摇摇头。%SPEECH_ON%我对它怀有敬意，就像一个人面对着汪洋大海，那阴郁深沉的洋面下掩藏着不知多少值得畏惧的东西，但水手无论如何都还在航行。 要是连大海都变得温顺驯良，人们又何必对它怀有敬畏之心呢？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fascinating.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Monk.improveMood(2.0, "亲眼看见一棵神树");

				if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 6)
			{
				return false;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local monk_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				monk_candidates.push(bro);
			}
		}

		if (monk_candidates.len() == 0)
		{
			return;
		}

		this.m.Monk = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Monk = null;
	}

});

