this.peddler_deal_event <- this.inherit("scripts/events/event", {
	m = {
		Peddler = null
	},
	function create()
	{
		this.m.ID = "event.peddler_deal";
		this.m.Title = "在路上…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%peddler% 向你走来，用手摩擦着后颈，紧张地扯着衬衫的前襟。 他提出了一个建议：让他带一些货物去城镇里卖，就像他过去经常做的那样。\n\n唯一一个问题就是他还没有货物－他得去附近港口城镇里的当地人那里购买。 现在他只需要一些起始资金来购买货物。 总计大概500克朗。 自然，作为合作伙伴，如果一切正常进行，你能得到其中的一部分利益。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "算我一个！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "B" : "C";
					}

				},
				{
					Text = "你现在是个雇佣兵了。 是时候把过去抛在身后了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_04.png[/img]你把克朗递给 %peddler%，他收下并离开了。\n\n几个小时之后，小贩手里拿着一个小密码箱跑了过来。 他脸上的笑容是那么地明显，甚至在跑来的时候还情不自禁地挥舞了一下拳头。 当他停下来准备说话的时候，不由得大口喘息起来。 你拍了拍他的肩膀，告诉他慢慢来。 恢复过来后，他递给你一大把硬币，说这是你的分红。\n\n在你还没来得及说话的时候，他已经小跑着离开了，因他的成功而心驰目眩。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "和你一起做生意很愉快。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
				local money = this.Math.rand(100, 400);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得[color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
				_event.m.Peddler.getBaseProperties().Bravery += 1;
				_event.m.Peddler.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Peddler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				_event.m.Peddler.improveMood(2.0, "兜售商品牟利");

				if (_event.m.Peddler.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Peddler.getMoodState()],
						text = _event.m.Peddler.getName() + this.Const.MoodStateEvent[_event.m.Peddler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]%peddler% 离开了，而你转向别的工作。\n\n几个小时后，你走出帐篷，看见了一个佝偻着身子的身影慢慢向你走来。 他看起来像是小贩。 他两手空空，紧皱着的眉头回到了你的身边。 当他走进时，你注意到了他身上一块块的淤青。 他解释道：虽然他成功从他的渠道买到了货物，但是镇子里的居民似乎对他的销售策略不太认可。\n\n所有投资的钱都没了，而 %peddler% 则走向帐篷去治疗他的伤势。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "But...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
				this.World.Assets.addMoney(-500);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] 克朗"
					}
				];
				_event.m.Peddler.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Peddler.getName() + "遭受轻伤"
				});
				_event.m.Peddler.worsenMood(2, "他的计划失败了，损失了一大笔钱");

				if (_event.m.Peddler.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Peddler.getMoodState()],
						text = _event.m.Peddler.getName() + this.Const.MoodStateEvent[_event.m.Peddler.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 1000)
		{
			return;
		}

		if (!this.World.State.isCampingAllowed())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 1)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.peddler")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Peddler = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"peddler",
			this.m.Peddler.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Peddler = null;
	}

});

