this.fell_down_well_event <- this.inherit("scripts/events/event", {
	m = {
		Strong = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.fell_down_well";
		this.m.Title = "在路上…";
		this.m.Cooldown = 150.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_91.png[/img]一个女人从小路旁边的树林里跳出来。%SPEECH_ON%噢，感谢上帝，我的祈祷应验了！ 请，快过来！我爷爷掉到井里了！%SPEECH_OFF%她转身匆匆离去，好像你已经答应帮她了。%otherbrother% 瞥了你一眼，并耸耸肩。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我想我们能够帮助她。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
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
				if (_event.m.Strong != null)
				{
					this.Options.push({
						Text = "%strongbrother%，你很强壮。 帮她一下。",
						function getResult( _event )
						{
							return "Strong";
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
			Text = "[img]gfx/ui/events/event_91.png[/img]你觉得值得花时间去看看。 老人正在修理井口，那是一个用来盖住井口的木制框架，但是破损了一部分，使老人跌落井中。 盯着井里，你发现那个老人也盯着你。 他挥了挥手。%SPEECH_ON%啊，这里，伙计们。我有点麻烦。 我确实糗了，我现在还在寻思…%SPEECH_OFF%嗯,对的。%otherbrother% 扔下一根绳子，老人把它系在自己身上。 你和佣兵把女人的爷爷拉上地面。 他和你握手，衷心地感谢你。%SPEECH_ON%他妈的，真高兴你来帮忙，我差点大小便失禁了。 让我告诉你，这不是我第一次下井。 五年前我就干修理井口这个活了，因为井口经常破裂，你知道的。 它不是真正的井口，我们叫它井口是因为我们很懒。 那时候我们叫它…好吧，很好，我真的忘了。 我想现在一个“井口”是有意义的，因为我的脑袋不舒服！ 喂！还有它。 我当年可真有魅力，你看，我很少有机会练习。 我的妻子十年前就去世了，而上一个老婆二十年前就离开了我！ 我说的是冬天，因为那是她离开我的时候，在冬天。 那是一个残酷的时刻，我让她帮忙砍柴，免得我们都冻僵了。 她说她不会一边照顾孩子一边干那些蠢事。 我和她还有第二个妻子都有孩子。 一共五个。一个死了。死于麻疹。 另一个失踪了，所以他可能已经死了。 我试着让自己诚实，但你知道，还是有希望的。 如果在关键时刻能在森林里找到一个陌生人来救我，那么也许我的儿子能在与绿皮的战斗中幸存了下来。 不过我没有他的消息了。 我不时地向古老神明们祈祷，甚至向那个达库尔祈祷。 你知道达库尔？ 我不知道这是怎么回事。 有一次，一个额头上有一道伤疤的人从我身边走过，他说他会给我指点黑暗之路。 我说我每次小睡都会看到黑暗。 这个伤痕累累的家伙说有一天我不会醒来，我说很好！哈！ 然后这个伤痕累累的混蛋就开始生我的气…%SPEECH_OFF%当他喋喋不休的时候，你四处寻找 %otherbrother%，却发现他从女人的家里走了出来，女人自己也带着一点…她脸上有明显的红晕。 你召回你的佣兵，在老头子用最冗长、单调的谈话砍掉你的脑袋之前离开。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "居然没人过来救我。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(2);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Other.improveMood(2.0, "得到一些爱");

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
			Text = "[img]gfx/ui/events/event_91.png[/img]当木制井口破裂时，老人正在修理。 不幸的是，当井口破裂时，如果你站在井口上，只有一个地方可以去：向下。 非常，非常深。 当你从井的边缘往下看时，你可以看到老人正漂浮，在某种意义上说已经没命了。%otherbrother% 悄悄靠近你，用手捂着嘴，不让别人听见他说的话。%SPEECH_ON%呃，他不动了。%SPEECH_OFF%这是一个非常专业的观察。 你把老人的死告诉那位女士。 她噘起嘴唇，让你们把尸体清理掉，并直截了当地解释了她的理由。%SPEECH_ON%我们毕竟不能喝他的尸水。%SPEECH_OFF%足够正确。%otherbrother% 设法用绳子把尸体吊起来，它的四肢像白毛巾一样松散地垂着。 他问她是否也需要你把它埋了。 那个女人擦了擦眼泪，摇了摇头。%SPEECH_ON%不。我要亲自埋葬他，明天还要去哭坟，然后继续生活。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，好的。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Strong",
			Text = "[img]gfx/ui/events/event_91.png[/img]你觉得值得花时间去看看。 井口是一个用来盖住井口的木制框架，现在已经破裂。 很明显，老人当时正在修理，所以他跌落进了井里。他抬头看着你。%SPEECH_ON%啊，这里，伙计们。我有点麻烦。 我确实糗了，我现在还在寻思…%SPEECH_OFF%嗯，对的。%strongbrother% 系下一根绳子。 老人把它绑在自己身上。 你和佣兵把女人的爷爷拉上地面。 他和你握手，衷心地感谢你。%SPEECH_ON%他妈的，真高兴你来帮忙，我差点大小便失禁了。%SPEECH_OFF%你和那个老家伙聊了一会儿，了解了他的很多情况。 过了一会儿，你意识到 %strongbrother% 不见了。 就在你想开始找他的时候，他从女人的家里走了出来。 她紧贴着他的胸肌，一阵卿卿我我。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很快就会有一些强壮的小伙子在这一带游荡，毫无疑问…",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(2);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Strong.getImagePath());
				_event.m.Strong.improveMood(2.0, "得到一些爱");

				if (_event.m.Strong.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Strong.getMoodState()],
						text = _event.m.Strong.getName() + this.Const.MoodStateEvent[_event.m.Strong.getMoodState()]
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

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_strong = [];
		local candidates_other = [];

		foreach( b in brothers )
		{
			if (b.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (b.getSkills().hasSkill("trait.strong"))
			{
				candidates_strong.push(b);
			}
			else
			{
				candidates_other.push(b);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_strong.len() != 0)
		{
			this.m.Strong = candidates_strong[this.Math.rand(0, candidates_strong.len() - 1)];
		}

		this.m.Score = 10;
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
			"strongbrother",
			this.m.Strong != null ? this.m.Strong.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Other = null;
		this.m.Strong = null;
	}

});

