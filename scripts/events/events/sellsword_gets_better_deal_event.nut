this.sellsword_gets_better_deal_event <- this.inherit("scripts/events/event", {
	m = {
		Sellsword = null,
		Amount = 0,
		OldPay = 0
	},
	function create()
	{
		this.m.ID = "event.sellsword_gets_better_deal";
		this.m.Title = "露营时…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]在清点库存时，%sellsword% 加入进来，盲目地选择这把剑或那把盾。 你放下你的羽毛笔，问他发生了什么事，因为他肯定不会在这里算计任何东西。 他解释说，另一个战队想用他做剑士－而且他们愿意付更多的钱。 你问他多少钱，他举起手来表示。%SPEECH_ON%他们说 %newpay% 克朗一天。%SPEECH_OFF%他跟你一天才赚 %pay% 克朗。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我懂了，是时候分道扬镳了。",
					function getResult( _event )
					{
						_event.m.Sellsword.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.Sellsword);
						return 0;
					}

				},
				{
					Text = "我一定有办法说服你的。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= _event.m.Sellsword.getLevel() * 10 ? "B" : "C";
					}

				},
				{
					Text = "那我就出和他们一致的价格。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img] 你转过身，交叉双臂，用靴子顶着板条箱。 望着远方，你告诉 %sellsword% 战队已经经历了很多，每个人，尤其是你自己，都不愿意看到他离开。 他在这里有第二个家，就是 %companyname%，这在雇佣兵的世界里是很少见的。 他要去的地方并不能保证他能得到什么。 你知道的，因为你经历过。 你也曾站在他的立场上，你坚持这样的立场离开了。而且为此悔恨。\n\n佣兵看着地面，仔细琢磨着你的话。 最后他点了点头，同意留下来。 你告诉他，他做了正确的选择。 那人转过身去，轻拍了一下箭袋，然后走开了。%SPEECH_ON%可能需要重新填满它。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴你和我们在一起。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
				_event.m.Sellsword.getFlags().add("convincedToStayWithCompany");
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_16.png[/img] 你转过身，交叉双臂，用靴子顶着板条箱。 望着远方，你告诉 %sellsword% 战队已经经历了很多，每个人，尤其是你自己，都不愿意看到他离开。 He has a second family here with the %companyname% and that's a rare treat in the mercenary world. 他要去的地方并不能保证他能得到什么。 你知道的，因为你经历过。 你也曾站在他的立场上，你坚持这样的立场离开了。而且为此悔恨。\n\n 佣兵看着地面，仔细琢磨着你的话。 最后，他摇了摇头，噘起嘴唇，带着“对不起”的表情。 你告诉他，他做了一个错误的选择，但是他不这么认为。 那人转过身去，轻拍了一下箭袋，然后走开了。%SPEECH_ON%可能需要重新填满它。%SPEECH_OFF%箭确实有点少，但你满脑子想的都是如何替换像他这样的好剑手。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个奇耻大辱。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Sellsword.getName() + "离开了" + this.World.Assets.getName()
				});
				_event.m.Sellsword.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Sellsword.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Sellsword);
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img] 你摇头叹息。这个男人点了点头，准备离开，但你阻止了他。 你得付这笔钱，这样他才能留下。 %companyname% 不能承受失去他这样的人。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好人并不廉价。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
				_event.m.Sellsword.getBaseProperties().DailyWage += _event.m.Amount;
				_event.m.Sellsword.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Sellsword.getName() + "现在被支付" + _event.m.Sellsword.getDailyCost() + "克朗每天"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Retinue.hasFollower("follower.paymaster"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 4 && bro.getLevel() <= 9 && this.Time.getVirtualTimeF() - bro.getHireTime() > this.World.getTime().SecondsPerDay * 25.0 && bro.getBackground().getID() == "background.sellsword" && !bro.getFlags().has("convincedToStayWithCompany"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Sellsword = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Amount = this.Math.rand(5, 15);
		this.m.OldPay = this.m.Sellsword.getDailyCost();
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"sellsword",
			this.m.Sellsword.getName()
		]);
		_vars.push([
			"newpay",
			this.m.OldPay + this.m.Amount
		]);
		_vars.push([
			"pay",
			this.m.OldPay
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Sellsword = null;
		this.m.Amount = 0;
		this.m.OldPay = 0;
	}

});

