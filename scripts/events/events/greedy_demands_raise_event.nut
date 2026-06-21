this.greedy_demands_raise_event <- this.inherit("scripts/events/event", {
	m = {
		Greedy = null
	},
	function create()
	{
		this.m.ID = "event.greedy_demands_raise";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%bro% 带着一小卷纸走进你的帐篷。 他把纸摊开，一一列举了他加入以来杀过的东西。 你问他这是什么意思。 他把那张纸按在你的办公桌上，回答。%SPEECH_ON%补偿我。从现在开始提高工资。每天 %newpay% 克朗。%SPEECH_OFF% | %bro% 想要更高的工资，每天 %newpay% 克朗，而不是现在的 %oldpay% 克朗，他的理由是在加入之后杀了不少敌人，都是为了 %companyname%。\n\n说实话，杀敌众多对你来说是个说得过去的理由，你或许会考虑给他涨工资。 | 看来，%bro% 想涨工资了，因为他为你杀了不少敌人。 你告诉他，这些都不是为了你个人的利益，只是你付钱让他这么做。他点头。%SPEECH_ON%好吧，那我希望现在你能多给我点。每天 %newpay% 克朗。%SPEECH_OFF% | %bro% 认为自己对战队的服务没有得到公平的报酬。 他要求更高的工资，每天 %newpay% 克朗，而不是现在的 %oldpay% 克朗，理由是他精通于做一位雇佣兵。 | %bro% 向你要求更高的工资，每天 %newpay% 克朗，而不是现在的 %oldpay% 克朗，他认为自己已经向大家证明了自己的实力，在 %companyname%。\n\n他给出的理由合情合理，只是你不知道自己究竟愿不愿意多给点钱。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好，这是你应得的。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "你只会得到我们已经商定的那些，而不是更多。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Greedy.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_64.png[/img]{你同意了 %bro%的条件。 他无疑十分高兴，这一天平淡的过去了。 | %bro%的要求并不高，于是你也就同意每天多给他几块钱。 他和你握了手。 很坚定，但又没那么热情。 | %bro% 紧张的等待你的回答。 你叫他放松，因为你已经同意了他的要求。 他发出一声舒缓的叹息。%SPEECH_ON%谢谢你，先生。我还以为我得用，呃。%SPEECH_OFF%你挑挑眉毛。%SPEECH_ON%这不是在威胁我吧。%SPEECH_OFF%他尴尬地笑笑，摇头。%SPEECH_ON%不，当然不是了！%SPEECH_OFF% | 你告诉 %bro% 工资要涨，只要他为你做一件事：跳一支舞。%SPEECH_ON%一支胜利的舞？%SPEECH_OFF%你耸耸肩。%SPEECH_ON%跳什么舞都行。%SPEECH_OFF%他举起双手，甩了几下。 你笑了出来。%SPEECH_ON%杀多少人也没有这个管用啊。%SPEECH_OFF%他笑笑。%SPEECH_ON%谢谢你，先生。%SPEECH_OFF% | 你同意给 %bro% 涨工资了。%SPEECH_ON%太感谢了。%SPEECH_OFF%那人挑了挑眉。%SPEECH_ON%别管那些礼节了。 咱们干这行是杀人的，不是围着它跳舞。%SPEECH_OFF%你点头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你的功劳！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Greedy.getImagePath());
				_event.m.Greedy.getBaseProperties().DailyWage += 8;
				_event.m.Greedy.improveMood(2.0, "收到加薪");
				_event.m.Greedy.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Greedy.getName() + "现在被支付" + _event.m.Greedy.getDailyCost() + "克朗每天"
				});

				if (_event.m.Greedy.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Greedy.getMoodState()],
						text = _event.m.Greedy.getName() + this.Const.MoodStateEvent[_event.m.Greedy.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_64.png[/img]{你拒绝了 %bro%的要求。 他抿着嘴唇，握紧拳头，点了一下头，然后走出帐篷。 虽然一个字也没说，不过你明白了他的意思：他不开心了。 | 拒绝了 %bro%的要求，他一下就愤怒了。%SPEECH_ON%去你的吧。 我还是会帮你打仗，不过你可想好了，别想让我出死力气！%SPEECH_OFF%你点头，不过告诉他如果他不拼死作战的话，终究还是免不了一死，所以说这于你没有损失。 | %bro% 的要求被你拒绝后，他很明显颤抖了一下。%SPEECH_ON%好吧，我知道这地方是怎么运作的了。 我们替你出生入死。 这都不管你啥事，是这样吧？ 我们就是你棋盘上的小卒子，你的工具。 好吧。没关系。%SPEECH_OFF%他转身走了。 你感觉他话里有刺。 | 你告诉 %bro% 你不同意他对他应该得到多少报酬的估计。 他骂了几句脏话，声音估计“很大”。等骂完了，他点头。%SPEECH_ON%没关系。我明白，你得挣钱。 不过也希望你能明白，我也得挣钱。%SPEECH_OFF% | %bro% 要求加薪，但你坚决不同意。%SPEECH_ON%我们之前商量好了给你多少钱，就是多少。%SPEECH_OFF%他点头，慢慢走出你的帐篷。%SPEECH_ON%听你的，先生。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不可能事事都如愿的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Greedy.getImagePath());
				_event.m.Greedy.worsenMood(this.Math.rand(2, 3), "被拒绝加薪");

				if (_event.m.Greedy.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Greedy.getMoodState()],
						text = _event.m.Greedy.getName() + this.Const.MoodStateEvent[_event.m.Greedy.getMoodState()]
					});

					if (_event.m.Greedy.getMoodState() == this.Const.MoodState.Angry)
					{
						if (!_event.m.Greedy.getSkills().hasSkill("trait.loyal") && !_event.m.Greedy.getSkills().hasSkill("trait.disloyal"))
						{
							local trait = this.new("scripts/skills/traits/disloyal_trait");
							_event.m.Greedy.getSkills().add(trait);
							this.List.push({
								id = 10,
								icon = trait.getIcon(),
								text = _event.m.Greedy.getName() + "变得不忠诚"
							});
						}
						else if (_event.m.Greedy.getSkills().hasSkill("trait.loyal"))
						{
							_event.m.Greedy.getSkills().removeByID("trait.loyal");
							this.List.push({
								id = 10,
								icon = "ui/traits/trait_icon_39.png",
								text = _event.m.Greedy.getName() + "不再忠诚"
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Retinue.hasFollower("follower.paymaster"))
		{
			return;
		}

		if (this.World.Assets.getMoney() < 4000)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() < 8)
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.greedy"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Greedy = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro",
			this.m.Greedy.getName()
		]);
		_vars.push([
			"oldpay",
			this.m.Greedy.getDailyCost()
		]);
		_vars.push([
			"newpay",
			this.m.Greedy.getDailyCost() + 8
		]);
	}

	function onClear()
	{
		this.m.Greedy = null;
	}

});

