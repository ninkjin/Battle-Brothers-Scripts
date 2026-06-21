this.traveling_troupe_event <- this.inherit("scripts/events/event", {
	m = {
		Entertainer = null,
		Noble = null,
		Payment = 0
	},
	function create()
	{
		this.m.ID = "event.traveling_troupe";
		this.m.Title = "在路上…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_92.png[/img]在路边露营时，一辆多彩的载重货车伴随着叮当作响的嘈杂声音隆隆驶来。 你可能不认为它是一辆特别大的车，但是大约有十五个男人和女人莫名其妙地从它的背后涌出。 彩绘的面孔、乐器、杂耍球、吞东西的长剑、喷火的酒壶，这群艺人在表演小型才艺表演，就好像你已经为他们的服务付了钱一样。 当他们结束时，他们鼓掌，跺脚，在你面前停下脚步，伸出手，脸上露出笑容。 一个白脸的哑剧演员讽刺地说。%SPEECH_ON%旅客们，你们喜欢看戏吗？ 只要付 %payment% 克朗就能让你整个晚上都很愉快！%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "当然，我们会为一场表演付钱。",
					function getResult( _event )
					{
						return "Regular";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Entertainer != null)
				{
					this.Options.push({
						Text = "%entertainerfull%，你说什么？",
						function getResult( _event )
						{
							return "Entertainer";
						}

					});
				}

				if (_event.m.Noble != null)
				{
					this.Options.push({
						Text = "你看起来好像有什么心事，%noblefull%。",
						function getResult( _event )
						{
							return "Noble";
						}

					});
				}

				this.Options.push({
					Text = "你们把贵重物品交出来怎么样？",
					function getResult( _event )
					{
						return "Robbing";
					}

				});
				this.Options.push({
					Text = "我们没事，谢谢。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Entertainer",
			Text = "[img]gfx/ui/events/event_26.png[/img]%entertainer% 向前走几步，拿起一些剧团赖以谋生的乐器。 他试着演奏他们，展示他有多么精于此道，深刻打动了这些娱乐者。 这些哑剧演员们询问他们是否可以和他一起演奏几首曲子。 他点了点头，加入了表演者的行列，上演了一场经久不衰的表演。 演出结束后，剧团深受感动，他们试着招募这个人。 你告诉他们那是不可能的，然后 %entertainer% 点头。%SPEECH_ON%我现在与 %companyname% 同行，但我很感谢你们如此欣赏我。%SPEECH_OFF%你问演出多少钱，但剧团领导摇了摇头。%SPEECH_ON%没有必要。和他一起表演十分高兴。 我们已经有一段时间没有做过这样的表演了，练习一下会对我们有好处的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Bye.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Entertainer.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(1.0, "同巡回演出团娱乐");

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
			ID = "Noble",
			Text = "[img]gfx/ui/events/event_26.png[/img]在演出开始前，%nobleman% 这个贵族站起来并询问他们是否知道一首他在宫廷时的歌。%SPEECH_ON%我小的时候，他们常唱这首歌。 我已经好几年没听到这首歌了。%SPEECH_OFF%哑剧演员，挺身而出，他咧嘴笑着，大声宣布他们知道。 他打响指，乐队的乐手们拿起了乐器。 当他们开始演奏时，曲调立刻朗朗上口。 这是个由弦乐和号角构成的编曲，旁边一个从心底和腹中唱歌的壮硕女人演奏着它。 她是一个暴风雨般的歌手，带来了暴风雨来了又去的平静和凶猛，她的歌词充满了昔日不可思议的英雄主义。\n\n 剧团演出结束后，你问他们该付多少钱。 哑剧演员摇了摇头。%SPEECH_ON%不，先生，报酬不是必须的。 已经有一段时间没有人提出这样的要求了，很高兴为大家演奏这首歌。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Beautiful.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(1.0, "同巡回演出团娱乐");

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
			ID = "Robbing",
			Text = "[img]gfx/ui/events/event_60.png[/img]你下令掠夺剧团。 这个哑剧演员，这次是成了真的哑巴，举起他的手和张开了他的嘴说“什么？”。 但当 %randombrother% 走上前一拳打在他的下巴上时，他的顽皮就消失了。 哑剧演员随着一声不敢太出声的惨叫而落下，用土涂在下巴上都做护理。\n\n战队的其余人员在掠夺剧团的载重货车寻找货物的同时把他们团团围住。 一个杂耍者的蛋被踢了，一个歌手的喉咙被 %randombrother2% 用手砍了。 吞剑者试图把他的剑藏在只有他才知道的地方，但是一个雇佣兵用一个相当痛苦的方式把剑从那里取了出来。 喷火者喝光了整瓶水，然后问你是否也想喝。 你一拳狠狠的打在他的鼻子上。\n\n 当一切结束，小丑是受伤最少的，因为痛打小丑得不到任何快乐。 被打破了嘴的哑剧演员或许能演得更好。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "从哑剧演员身上学着点，你这个恶心的混蛋。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-2);
				local item = this.new("scripts/items/helmets/jesters_hat");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/lute");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Math.rand(50, 200);
				this.World.Assets.addMoney(item);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + item + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getBackground().getID() == "background.raider")
					{
						bro.improveMood(1.0, "喜欢打巡回演出团");

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
			}

		});
		this.m.Screens.push({
			ID = "Regular",
			Text = "[img]gfx/ui/events/event_26.png[/img]你为剧团演得很好的一出戏付了钱。 小丑会讲一些笑话，杂耍者玩杂耍，有点老掉牙，但不管怎样，歌手唱歌，吞剑表演，火被“呼吸”，还有哑剧演员，好吧，他糟糕的你真希望他去死。\n\n 当一切尘埃落定，你会觉得你的钱花得值，大家也会很开心。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Thanks.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-_event.m.Payment);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Payment + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(1.0, "同巡回演出团娱乐");

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
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.Assets.getMoney() < 40 * brothers.len() + 500)
		{
			return;
		}

		local candidates_entertainer = [];
		local candidates_noble = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.juggler" || bro.getBackground().getID() == "background.minstrel")
			{
				candidates_entertainer.push(bro);
			}
			else if (bro.getBackground().getID() == "background.adventurous_noble" || bro.getBackground().getID() == "background.disowned_noble" || bro.getBackground().getID() == "background.regent_in_absentia")
			{
				candidates_noble.push(bro);
			}
		}

		if (candidates_entertainer.len() != 0)
		{
			this.m.Entertainer = candidates_entertainer[this.Math.rand(0, candidates_entertainer.len() - 1)];
		}

		if (candidates_noble.len() != 0)
		{
			this.m.Noble = candidates_noble[this.Math.rand(0, candidates_noble.len() - 1)];
		}

		this.m.Payment = 40 * brothers.len();
		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"entertainer",
			this.m.Entertainer != null ? this.m.Entertainer.getNameOnly() : ""
		]);
		_vars.push([
			"entertainerfull",
			this.m.Entertainer != null ? this.m.Entertainer.getName() : ""
		]);
		_vars.push([
			"nobleman",
			this.m.Noble != null ? this.m.Noble.getNameOnly() : ""
		]);
		_vars.push([
			"noblefull",
			this.m.Noble != null ? this.m.Noble.getName() : ""
		]);
		_vars.push([
			"payment",
			this.m.Payment
		]);
	}

	function onClear()
	{
		this.m.Entertainer = null;
		this.m.Noble = null;
		this.m.Payment = 0;
	}

});

