this.aging_swordmaster_paycut_event <- this.inherit("scripts/events/event", {
	m = {
		Swordmaster = null
	},
	function create()
	{
		this.m.ID = "event.aging_swordmaster_paycut";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_17.png[/img]%swordmaster% 进入你的帐篷。 你挥手让他坐到你桌子对面的椅子上。 他坐得很慢，很虚弱，你担心他站起来要花两倍的时间。 他双手合十，胳膊肘搭在桌子上，嘴里嘟囔着，不停地挪动着身子，似乎无法找到慰藉，让你无所适从。 他的嘴唇是干的，他的脸皮是皱的。 他的头上有斑痕，甚至鼻子和耳朵周围的头发都是灰色的。\n\n 你经常有时间和 %swordmaster% 交流，所以你问他想说什么。%SPEECH_ON%这可能听起来很奇怪，但我认为无论如何这都是需要说的，它会让我晚上睡得更好。 我很坦率地告诉你：我已经不是你很久以前雇用的那个人了。 你知道的。我知道。 有些队员也知道这一点，但他们像好人一样尊重人。%SPEECH_OFF%你同意，但不要点头。 相反，你应该问这个男人到底想说什么。%SPEECH_ON%我希望降低我的工资。 现在不要拒绝，你没必要骗我。 我要打个对折。 钱从来都不是问题。 这些克朗可以用来帮助武装这些人，甚至可以给他们更好的报酬。 神明们知道，年轻人总是需要多用一两克朗。%SPEECH_OFF%你还没来得及说一个字，那人就以惊人的速度跳了起来。 他点了点头，开心地笑了笑，然后大声嚷嚷起来。%SPEECH_ON%我同意你的决定，好心的先生。 我需要减薪！%SPEECH_OFF%你哈哈大笑，这个人离开了你的帐篷，像他进来的时候一样迅速。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他是一个值得尊敬的人，一如既往。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				_event.m.Swordmaster.getBaseProperties().DailyWage -= _event.m.Swordmaster.getDailyCost() / 2;
				_event.m.Swordmaster.getSkills().update();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Swordmaster.getName() + "现在被支付" + _event.m.Swordmaster.getDailyCost() + "克朗每天"
				});
				_event.m.Swordmaster.getFlags().add("aging_paycut");
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getBackground().getID() == "background.swordmaster" && !bro.getFlags().has("aging_paycut") && !bro.getSkills().hasSkill("trait.old"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Swordmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = this.m.Swordmaster.getLevel();
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"swordmaster",
			this.m.Swordmaster.getName()
		]);
	}

	function onClear()
	{
		this.m.Swordmaster = null;
	}

});

