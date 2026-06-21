this.ball_on_roof_event <- this.inherit("scripts/events/event", {
	m = {
		Surefooted = null,
		Other = null,
		OtherOther = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.ball_on_roof";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 140.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]战队遇到一个小男孩，他爬上了一棵树，爬到了树枝的边缘。 他伸手去拿一个卡在他家屋顶上的球。 没有一个家长能帮助他。 当他看到你时，他问你是否可以帮忙拿球。似乎非常简单。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我想我们能够帮助他。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 70)
						{
							return "Good";
						}
						else
						{
							return "Bad";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Surefooted != null)
				{
					this.Options.push({
						Text = "%surefooted%，你步伐沉稳。 帮他一把。",
						function getResult( _event )
						{
							return "Surefooted";
						}

					});
				}

				this.Options.push({
					Text = "我们没时间做这个。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "[img]gfx/ui/events/event_97.png[/img]你派 %otherbrother% 去尝试取回球。 他把 %otherother% 当做梯子，爬上屋顶，拿到了玩具。 男孩欣喜若狂，他脸上的笑容甚至温暖了你们最愤世嫉俗的雇佣兵。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们是乐善好施的好佣兵。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Other.improveMood(1.0, "帮助一个小男孩");

				if (_event.m.Other.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_97.png[/img]你派 %otherbrother% 去尝试取回球。 他爬上树，跳过树枝落在屋顶上。 任务完成后，他把球扔给孩子。 不幸的是，男孩放开了树枝，试图抓住球。 他从树枝上滑下来跌到地上，足足有十五英尺高。 他落地时的冲击力使整个战队都战战兢兢。 当你检查他的时候，你发现他并没有动，而且他的背部已经变了形。%otherother% 对那个仍然震惊地站在屋顶上的白痴大喊大叫。%SPEECH_ON%你到底怎么想的？你个白痴！%SPEECH_OFF%这个雇佣兵从屋顶上爬了下来。 他看了看孩子，然后紧张地环顾四周。%SPEECH_ON%好吧他，呃，他拿到了球。 让我们离开这个鬼地方吧。 我们的…在这儿的工作已经完成了。%SPEECH_OFF%真他妈是个糟糕的情况。 你和你的战队在他家长回来之前迅速离开现场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "没人看到这些。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				this.Characters.push(_event.m.OtherOther.getImagePath());
				_event.m.Other.worsenMood(1.5, "不小心把一个小男孩弄残废了");

				if (_event.m.Other.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Surefooted",
			Text = "[img]gfx/ui/events/event_97.png[/img]%surefooted% 清了清嗓子，迈步向前。%SPEECH_ON%我会成为你的英雄，孩子。%SPEECH_OFF%他张开双臂，孩子跳了进去。 那个男孩被安放在一边，佣兵用手指着地面。%SPEECH_ON%呆在这里。%SPEECH_OFF%这个步伐沉稳的佣兵轻易地爬上树，跳到屋顶。 他捡起球，用手指旋转，然后像龙卷风一样旋转着离开屋檐，用脚趾着地，像女人那样优雅。 孩兴奋地拍手拿走了玩具，连战队里最愤世嫉俗的人都被他的快乐所温暖。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "露了一手。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Surefooted.getImagePath());
				_event.m.Surefooted.improveMood(1.5, "他的才华给每个人留下了深刻的印象");

				if (_event.m.Surefooted.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Surefooted.getMoodState()],
						text = _event.m.Surefooted.getName() + this.Const.MoodStateEvent[_event.m.Surefooted.getMoodState()]
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

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_surefooted = [];
		local candidates_other = [];

		foreach( b in brothers )
		{
			if (b.getSkills().hasSkill("trait.sure_footing"))
			{
				candidates_surefooted.push(b);
			}
			else if (b.getSkills().hasSkill("trait.player"))
			{
				candidates_other.push(b);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_surefooted.len() != 0)
		{
			this.m.Surefooted = candidates_surefooted[this.Math.rand(0, candidates_surefooted.len() - 1)];
		}

		do
		{
			this.m.OtherOther = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		while (this.m.OtherOther == null || this.m.OtherOther.getID() == this.m.Other.getID());

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
		_vars.push([
			"otherother",
			this.m.OtherOther.getName()
		]);
		_vars.push([
			"surefooted",
			this.m.Surefooted != null ? this.m.Surefooted.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Other = null;
		this.m.OtherOther = null;
		this.m.Surefooted = null;
		this.m.Town = null;
	}

});

