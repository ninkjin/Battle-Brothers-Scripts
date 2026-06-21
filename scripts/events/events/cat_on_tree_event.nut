this.cat_on_tree_event <- this.inherit("scripts/events/event", {
	m = {
		Archer = null,
		Ratcatcher = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.cat_on_tree";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]你发现一个男孩和一个女孩在向一棵树上看。 女孩举起双手。%SPEECH_ON%好吧，在那里待到死吧！ 我才不在乎呢！%SPEECH_OFF%那个男孩发现了你，询问你是否可以帮他们把猫从树上弄下来。 抬头一看，你确实发现一只猫趴在树枝上，正在晒太阳。",
			Image = "",
			List = [],
			Options = [],
			function start( _event )
			{
				if (_event.m.Archer != null)
				{
					this.Options.push({
						Text = "%archerfull%，试着用箭把它射下来？",
						function getResult( _event )
						{
							if (this.Math.rand(1, 100) <= 70)
							{
								return "ArrowGood";
							}
							else
							{
								return "ArrowBad";
							}
						}

					});
				}

				if (_event.m.Ratcatcher != null)
				{
					this.Options.push({
						Text = "%ratcatcherfull% 有锦囊妙计。",
						function getResult( _event )
						{
							return "Ratcatcher";
						}

					});
				}

				this.Options.push({
					Text = "这真不是我们的问题。",
					function getResult( _event )
					{
						return "F";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "ArrowGood",
			Text = "[img]gfx/ui/events/event_97.png[/img]%archer% 搭上弓并且在向树上瞄准时伸出了舌头。 女孩和男孩似乎不喜欢这个主意，他们用手捂住眼睛。 弓箭手松开了箭，打在猫的树枝上咔嚓一响，折断了树枝，猫像玩魔棒游戏一样侧着身子从树上滚下来。 当它着地时，男孩和女孩猛冲上去。 他们抚摸着它，感谢你给他们解决麻烦。 那个女孩温柔地拥抱那只猫。%SPEECH_ON%终于，我们有东西吃了！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "等下，什么？",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Archer.getBaseProperties().RangedSkill += 1;
				_event.m.Archer.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Archer.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程技能"
				});
			}

		});
		this.m.Screens.push({
			ID = "ArrowBad",
			Text = "[img]gfx/ui/events/event_97.png[/img]%archer% 做好准备，搭上弓瞄准。 这只猫发出咕噜咕噜的声音，向下盯着弓手拉弓，显得视死如归。 闭上一只眼睛，弓箭手让箭飞起来。 没有什么值得大惊小怪的。 这只猫像玩魔棒游戏一样从树上滚了下来，落在了地上，一根箭射入它头的一半处。 女孩蹲下身子，盯着在箭尖下抽搐的猫头。 她抬头看着你，似乎是你射的那一箭。%SPEECH_ON%那是我的朋友。%SPEECH_OFF%你告诉她你很抱歉，她会找到更多的朋友。 至于那个男孩，他把猫的大脑装进口袋，然后把猫的尸体扛在肩上。他显得很阴郁。%SPEECH_ON%至少我们现在有东西吃了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "安息吧，小猫咪。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Archer.worsenMood(1.0, "不小心射中了一只小女孩的宠物猫");

				if (_event.m.Archer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer.getMoodState()],
						text = _event.m.Archer.getName() + this.Const.MoodStateEvent[_event.m.Archer.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Ratcatcher",
			Text = "[img]gfx/ui/events/event_97.png[/img]%ratcatcher% snaps his fingers.%SPEECH_ON%唔哦，我有个主意！你们两个小鬼等一会儿。%SPEECH_OFF%捕鼠者从口袋里掏出一只老鼠，你根本都想不到他会这么做。 他鼓唇弄舌就像喵喵叫的猫一样，把小老鼠举起来。 猫注意到了，竖起了耳朵。%SPEECH_ON%是的，这就对了，小猫咪，下来吧，午餐时间到了。%SPEECH_OFF%捕鼠者把小老鼠拿到嘴唇边，并低声细语。%SPEECH_ON%不，不是的，呵呵。%SPEECH_OFF%当猫下来时，%ratcatcher% 把他的朋友向外放一点。 老鼠开始在他的手上刮来刮去，也许是不相信它的主人能留住它。 但是，当猫扑向食物时，捕鼠者把老鼠装进口袋，然后迅速地把猫抓起来。 当他把猫递过去时，孩子们鼓掌欢呼。 甚至有些人也对这家伙像猫一样的反应能力印象深刻！",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "大师级的表演！",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Ratcatcher.getImagePath());
				_event.m.Ratcatcher.getBaseProperties().Initiative += 2;
				_event.m.Ratcatcher.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Ratcatcher.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 主动性"
				});
				_event.m.Ratcatcher.improveMood(1.0, "他的敏捷给大家留下了深刻印象");

				if (_event.m.Ratcatcher.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Ratcatcher.getMoodState()],
						text = _event.m.Ratcatcher.getName() + this.Const.MoodStateEvent[_event.m.Ratcatcher.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_97.png[/img]你直截了当地告诉孩子们他们应该找条狗并让我们走。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "反正这只猫也不愿做你们的朋友。",
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
		local candidates_archer = [];
		local candidates_ratcatcher = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword")
			{
				candidates_archer.push(bro);
			}
			else if (bro.getBackground().getID() == "background.ratcatcher")
			{
				candidates_ratcatcher.push(bro);
			}
		}

		if (candidates_archer.len() == 0 && candidates_ratcatcher.len() == 0)
		{
			return;
		}

		if (candidates_archer.len() != 0)
		{
			this.m.Archer = candidates_archer[this.Math.rand(0, candidates_archer.len() - 1)];
		}

		if (candidates_ratcatcher.len() != 0)
		{
			this.m.Ratcatcher = candidates_ratcatcher[this.Math.rand(0, candidates_ratcatcher.len() - 1)];
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
			"archer",
			this.m.Archer != null ? this.m.Archer.getNameOnly() : ""
		]);
		_vars.push([
			"archerfull",
			this.m.Archer != null ? this.m.Archer.getName() : ""
		]);
		_vars.push([
			"ratcatcher",
			this.m.Ratcatcher != null ? this.m.Ratcatcher.getNameOnly() : ""
		]);
		_vars.push([
			"ratcatcherfull",
			this.m.Ratcatcher != null ? this.m.Ratcatcher.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Archer = null;
		this.m.Ratcatcher = null;
		this.m.Town = null;
	}

});

