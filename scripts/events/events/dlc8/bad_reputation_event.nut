this.bad_reputation_event <- this.inherit("scripts/events/event", {
	m = {
		Superstitious = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.bad_reputation";
		this.m.Title = "在途中…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{一些誓言守护者向你递来一张纸条。上面写有%companyname%的名字，一张相当滑稽且不成比例的你的画像，以及对你卑微性格的几个精选描述。看来你在这个世界上的声誉远没有你想象中那么高大。%SPEECH_ON%我们必须改变这种情况，队长! 人们把誓言守护者看成这样是对我们，特别是对年轻安瑟姆的极大侮辱！%SPEECH_OFF% 你同意了。 | 当战团扎营时，一些誓言守护者正议论%companyname%的声誉。%SPEECH_ON%年轻安瑟姆不会满意我们被世界看到的方式，我们应该设立一个行为标准！%SPEECH_OFF% 你同意了，但修复誓言守护者的荣誉可能需要一些时间。 | 年轻安瑟姆创立了誓言守护者，相信他们应该是荣誉，美德和品德的典范，这些元素已经消失在世界的视野中。不幸的是，你一直难以保持这些理想，导致%companyname%的声誉降低了一点。一些人正义地抱怨，即使他们没有公开抱怨，这些问题仍然明显地消耗着士气。你认为最好尽快开始修补%companyname%的声誉，以免士兵们对其最终目的失去信心。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会领导得更好。",
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
					if (bro.getBackground().getID() == "background.paladin")
					{
						bro.worsenMood(1.0, "对于战团恶劣的声誉感到不满意。");
					}
					else if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(0.5, "对于战团恶劣的声誉感到不满意。");
					}

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

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		if (this.World.Assets.getMoralReputation() >= 40.0)
		{
			return;
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

