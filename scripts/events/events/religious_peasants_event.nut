this.religious_peasants_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null
	},
	function create()
	{
		this.m.ID = "event.religious_peasants";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_59.png[/img]森林一直以来都是人类的天然避难所－生于荒野之人，亦渴望还于荒野。 就像这会儿你们发现的一大堆人，一个失魂者组成的部落，对与他们渐行渐远的文明毫不关心，打起宗教的旗号，胸怀崇高的信仰，手执真理的圣典。 他们看上去穷得几乎到了行为艺术的境界，活像一群打算融入底层平民的伟大国王。 你就坐在那看着他们失魂落魄，摇摇晃晃，沙沙作响地走过，中空的木珠发出咔嚓咔嚓的声音，他们低声呢喃，声音沙哑而刺耳。 他们就这么继续走下去，都懒得抬眼看你们一眼。",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "咱们去看看他们要去哪。",
					function getResult( _event )
					{
						if (_event.m.Monk != null)
						{
							local r = this.Math.rand(1, 3);

							if (r == 1)
							{
								return "B";
							}
							else if (r == 2)
							{
								return "C";
							}
							else
							{
								return "F";
							}
						}
						else
						{
							local r = this.Math.rand(1, 2);

							if (r == 1)
							{
								return "B";
							}
							else
							{
								return "C";
							}
						}
					}

				},
				{
					Text = "最好还是别管他们了。",
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
			Text = "[img]gfx/ui/events/event_03.png[/img]出于好奇，你叫上你的人去询问他们要去哪。 领头的人慢悠悠地转向你，他的目光从包裹严实的披肩下的阴影中射出。 他慢慢拉下斗篷，你看见他的头上刻满了宗教仪式留下的疤痕。 他身后的人们也如法效仿，就像一排被混乱而狂嚣的风吹倒的扑克牌。%SPEECH_ON%去来世觐见达库尔吧！%SPEECH_OFF%其中一个人突然咆哮出声，那整群人毫无征兆地向你们冲了过来。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];

						for( local i = 0; i < 25; i = ++i )
						{
							local unit = clone this.Const.World.Spawn.Troops.Cultist;
							unit.Faction <- this.Const.Faction.Enemy;
							properties.Entities.push(unit);
						}

						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_12.png[/img]{显然，这景象对你们来说可不常见，出于好奇，你向那群疲惫不堪的旅者喊了一声。 你的话刚一出口，那一整群人便瞬间停下，直挺挺地立正。 他们的斗篷从他们头上解开并落下，他们的教典、拐杖和宗教用具整齐划一地脱手落地。 那些人环顾四周，圆睁的双眼比先前多了些生气。 其中一人突然尖叫起来。之后是又一个。很快他们所有人都开始惨叫，其中有些人蜷缩在地上，捂着耳朵，好像要让他们自己嘴里发出的刺耳嚎叫安静下来，而另一些人则跪在地上围成一圈，伸出双臂，乞求着答案。\n\n 你的短短一句话似乎打破了一个长期占据着他们思想，让他们穷苦，饥饿，疯狂，并控制着他们到达这里的咒语。 他们一点一点地被一个邪恶的高位存在所摆布，而现在，他们又感受到那操纵着他们命运的力量，以及让人保持自我的理智一点点地消逝。 不幸的是，你没法去问他们是什么人，或者什么东西对他们做出这一切了，因为有些人倒下死了，而另一些人则赤裸着奔进了森林。 | 这么奇怪的景象当然引起了你们的好奇，但就在你刚张嘴吐字的瞬间，那一整群僧侣便瞬间直挺挺地立正，他们的衣服突然脱落，配饰则发出咔哒咔哒的声音，声音整齐得好像一扇被摔上的门。 他们扔下手中的东西开始尖叫。 这场合唱无比刺耳。 他们一个接一个地倒下，要么用枯瘦的膝盖跪在地上，要么在饥饿的痛苦中抓着肚子。\n\n %randombrother% 走上前来，摇着头。%SPEECH_ON%他们是被诅咒了吗？怎么会这样？%SPEECH_OFF%你永远也得不到这个问题的答案，因为那些人就在短短一分钟内死得一干二净，死状看上去不比高山上刚刚解冻的干尸强上多少。 那个诅咒一定是强迫他们进行着这场朝圣之旅，榨取他们生命的同时又以一丝超凡的邪恶维持着他们躯体的存活。 尽管这些人全都死了，但你并不后悔将他们从如此恶毒的诅咒中解脱出来。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "愿他们安息。",
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
					if (bro.getSkills().hasSkill("trait.superstitious") || this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(0.5, "目睹了可怕的诅咒");

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
			ID = "F",
			Text = "[img]gfx/ui/events/event_59.png[/img]出于对这些人将要前往何处的好奇，你张开了嘴，但僧侣 %monk% 上前一步打断了你。 他走到队伍前面的人面前，和他低声交谈起来。 过程中交杂着许多次点头，低语和其他长期沉湎于超脱人间漫宿之外事物的人会做出的动作。 最后，他走了回来。%SPEECH_ON%他们正在进行一场朝圣之旅，而现在我们的名字将会随着他们一同旅行。 会有好多人听说它的。%SPEECH_OFF%你称赞僧侣干的很出色。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我们都是些该下地狱的人，但是他们并不知道…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.World.Assets.addMoralReputation(1);
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				_event.m.Monk.improveMood(1.0, "帮助宣传了战队");

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
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Monk = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Monk = null;
	}

});

