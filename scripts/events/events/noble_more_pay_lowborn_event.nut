this.noble_more_pay_lowborn_event <- this.inherit("scripts/events/event", {
	m = {
		Noble = null,
		Lowborn = null
	},
	function create()
	{
		this.m.ID = "event.noble_more_pay_lowborn";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img] %noble% 突然进入你的帐篷。 他穿着盔甲佩戴着武器。 他看起来是精心打扮过之后来的似乎很重视这次会面的而且他确实站得很端正。 你问他想要什么，他昂着头眼睛直视前方。%SPEECH_ON%我注意到 %lowborn% 得到的报酬比我多。 尽管我对他个人没有什么意见，但是我想要指出他除了行走的双脚以外没有任何与生俱来的东西。 一个出身卑贱的人不可能比一个出身高贵的人挣得多。 我们贵族应该得到更多。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我保证你的工资不低于他。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们用经验和技巧挣取报酬，而不是出身。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们降低你的工资怎么样？",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				this.Characters.push(_event.m.Lowborn.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_64.png[/img]你不一定同意他的看法，但同时你也能看到拒绝这个请求可能会导致一些前所未见的问题。在花名册上划上几笔，你给 %noble% 分配了更高的工资，并告诉他下一个发薪日将会提高他的工资。 那个人终于将眼睛转向你并且向你深深的鞠了一躬。%SPEECH_ON%你做了一个正确的决定。%SPEECH_OFF%他转过身来保持着那副高傲的身姿大步走了出去。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "同工同酬会维持和平。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.Noble.getBaseProperties().DailyWage += this.Math.max(0, _event.m.Lowborn.getDailyCost() - _event.m.Noble.getDailyCost());
				_event.m.Noble.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Noble.getName() + "现在被支付" + _event.m.Noble.getDailyCost() + "克朗每天"
				});
				_event.m.Noble.improveMood(1.0, "得到加薪");

				if (_event.m.Noble.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Noble.getMoodState()],
						text = _event.m.Noble.getName() + this.Const.MoodStateEvent[_event.m.Noble.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_64.png[/img]你叫那个人看着你。 他慢慢地把目光转向你的。 在他的注视下，你解释了现在的情况。%SPEECH_ON%我关注的是经验和战斗技巧，而不是你在签署合同之前的身份。 我不在意你之前是个牧羊人还是其他什么的，只要你会挥剑战斗我就给你报酬，如果你的经验和战斗技巧远比其他人高超我可以向你保证，你绝对会比别人得到的更多！ 你还有什么不明白的地方？%SPEECH_OFF%%noble% 似乎受到了极大的侮辱脸颊不断抽动。 他咬着牙说。%SPEECH_ON%没有，先生。%SPEECH_OFF%你挥了挥手腕，示意让他离开。 他匆忙地离开了，他原本笔直的站姿瞬间就垮了下来。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "如果你想获取更多报酬，那就证明你自己有那份实力。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.Noble.worsenMood(2.0, "不满意一个出身低贱的人");

				if (_event.m.Noble.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Noble.getMoodState()],
						text = _event.m.Noble.getName() + this.Const.MoodStateEvent[_event.m.Noble.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_64.png[/img]你从椅子上站起来，对着那个看着你的这位成员喝骂。 他会如同刚才说的那样所以你也要向他解释他将会遭遇上面样的状况。%SPEECH_ON%%lowborn% 通过自己的努力把自己从原来的泥潭中拉出来向这个世界证明自己的实力。 你是出身高贵没错，但是在这里出身没有任何用处不是吗？ 所以从今天开始思考一下为什么你的工资被降低了。 你想要获得加薪的权力？证明自己。%SPEECH_OFF%贵族因为你的决定开始动摇了。 他张了嘴张嘴想说些什么，但你很快举起手来制止了他。%SPEECH_ON%别再说了。离开我的视线。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "出去！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				_event.m.Noble.getBaseProperties().DailyWage -= _event.m.Noble.getDailyCost() / 2;
				_event.m.Noble.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Noble.getName() + "现在被支付" + _event.m.Noble.getDailyCost() + "克朗每天"
				});
				_event.m.Noble.worsenMood(2.0, "被队长羞辱了");
				_event.m.Noble.worsenMood(2.0, "不满意一个出身低贱的人");
				_event.m.Noble.worsenMood(2.0, "减薪了");

				if (_event.m.Noble.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Noble.getMoodState()],
						text = _event.m.Noble.getName() + this.Const.MoodStateEvent[_event.m.Noble.getMoodState()]
					});
				}

				if (!_event.m.Noble.getSkills().hasSkill("trait.greedy"))
				{
					local trait = this.new("scripts/skills/traits/greedy_trait");
					_event.m.Noble.getSkills().add(trait);
					this.List.push({
						id = 10,
						icon = trait.getIcon(),
						text = _event.m.Noble.getName() + "变得贪婪"
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 500)
		{
			return;
		}

		if (this.World.Retinue.hasFollower("follower.paymaster"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local lowestPay = 1000;
		local lowestNoble;

		foreach( bro in brothers )
		{
			if (bro.getDailyCost() < lowestPay && bro.getBackground().isNoble())
			{
				lowestNoble = bro;
				lowestPay = bro.getDailyCost();
			}
		}

		if (lowestNoble == null)
		{
			return;
		}

		local lowborn_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getDailyCost() > lowestPay && bro.getBackground().isLowborn())
			{
				lowborn_candidates.push(bro);
			}
		}

		if (lowborn_candidates.len() == 0)
		{
			return;
		}

		this.m.Noble = lowestNoble;
		this.m.Lowborn = lowborn_candidates[this.Math.rand(0, lowborn_candidates.len() - 1)];
		this.m.Score = 7 + (lowestNoble.getSkills().hasSkill("trait.greedy") ? 9 : 0);
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noble",
			this.m.Noble.getName()
		]);
		_vars.push([
			"lowborn",
			this.m.Lowborn.getName()
		]);
	}

	function onClear()
	{
		this.m.Noble = null;
		this.m.Lowborn = null;
	}

});

