this.holywar_neutral_nomads_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null
	},
	function create()
	{
		this.m.ID = "event.holywar_neutral_nomads";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_170.png[/img]{你遇到一群游牧民。 尽管战争惨烈的持续着，他们没有把你当做威胁。 一个人用饮品与可以遮阳的伞欢迎你，你接受了。%SPEECH_ON%我希望你的旅途坦荡，逐币者。 你和我们沙丘旅者有一些相似，特别在作为入侵者这件事上。 南北之间的恩怨我们没必要掺和进去。%SPEECH_OFF%他喝下他自己的饮料点头说道。%SPEECH_ON%不过我想你已经在冲突中赚了不少钱。 我的一些同胞会因此把你当做镀金者最忠实的信徒的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "你不追随你同胞的信仰？",
					function getResult( _event )
					{
						return "B";
					}

				});

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "%wildmanfull% 在那干什么呢？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "在你死后，我会赚得更多。",
					function getResult( _event )
					{
						return "C";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_170.png[/img]{游牧民笑了。%SPEECH_ON%在信仰问题上，人怎么可能有共识呢？%SPEECH_OFF%他卷起他的杯子和伞。%SPEECH_ON%我听说在北方有像我们一样的野人。%SPEECH_OFF%你咬住嘴唇，尽力忍住不漏笑。%SPEECH_ON%我们有些人进入森林逃离了文明，没错。 但是他们更加…不寻常，特别是对比你和你的族群的时候。 他们不太像你。%SPEECH_OFF%点着头，游牧民给与了你一份礼物。%SPEECH_ON%或许我是错的，只是你从没有听从过他们。%SPEECH_OFF%他握成拳头击打了下胸口，游牧民们便重新上路了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "谢谢你的盛情款待。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/supplies/dates_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(0.5, "喜欢游牧民的好客");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_170.png[/img]{你喝完了饮料并告知和他一起的时间非常有趣。 他伸出手向你握手时你的剑刺穿了他。 战队的其他人也加入进来，战斗如同你的好客般短暂。 游牧民们没有什么值钱的东西，但是没人会知道你在这里做了什么，本身他们也不大可能在意。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "带上我们能用的任何东西。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-2);
				local money = 150;
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
				local item = this.new("scripts/items/supplies/dates_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/supplies/rice_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.worsenMood(0.75, "不喜欢你杀害和抢劫你的主人");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_170.png[/img]{%wildman% 野人凑上来到伞下。 游牧民盯着他，野人也盯着游牧民。 你问他们彼此是否认识。游牧民笑道。%SPEECH_ON%不，但是的。我们有相似的灵魂。 我可以从他的眼中看到。%SPEECH_OFF%野人大笑着发出了咕哝声，之后便转身离开了。 当你看回游牧民时他握着一把镀金的匕首。%SPEECH_ON%宝藏，黄金，这些闪亮而引人注目的东西，他们对我而言毫无价值。 我在维齐尔的一个卫兵身上找到了这个。 我们为了水和食物杀了他及他护送的商队，我认为这是最重要的东西。 拿走这个匕首吧，当做是我的一个礼物。%SPEECH_OFF%你收下了它，但是警告他如果他像对维齐尔的人一般伏击你，你或许会用这把匕首对抗他。游民点头说。%SPEECH_ON%依然，这是我的礼物。 如果事态发展成如此讽刺的情景，我觉得死亡也是一件乐事。 在沙漠中有很多糟的多的死法，朋友。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "谢谢你的慷慨。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				local item = this.new("scripts/items/weapons/oriental/qatal_dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(0.5, "喜欢游牧民的好客");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
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

		if (!this.World.FactionManager.isHolyWar())
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.manhunters" || this.World.Assets.getOrigin().getID() == "scenario.gladiators" || this.World.Assets.getOrigin().getID() == "scenario.southern_quickstart")
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 6)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_wildman = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
		}

		if (candidates_wildman.len() != 0)
		{
			this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getNameOnly() : ""
		]);
		_vars.push([
			"wildmanfull",
			this.m.Wildman != null ? this.m.Wildman.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Wildman = null;
	}

});

