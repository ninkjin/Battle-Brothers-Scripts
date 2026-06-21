this.messenger_vs_houndmaster_event <- this.inherit("scripts/events/event", {
	m = {
		Messenger = null,
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.messenger_vs_houndmaster";
		this.m.Title = "露营时…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%messenger% 和 %houndmaster% 坐在营火边分享着故事。这个信使大笑着。%SPEECH_ON%让我告诉你我第一次送信的情况。 我走到这个有漂亮护城河的城堡前。 在水里最危险的东西是睡莲和肥青蛙。 从吊桥上走过并且到达对岸，信在手里面，我当时非常兴奋。 我到达这里并且我听到了什么？ 闪闪－闪闪！躲躲－躲躲！ 一只杂种狗从狗窝里跑了出来，露出牙齿，耳朵被挺立起来。 我当时被吓傻了该死的，我当时接下这个工作的时候可没想到会遇上这样的事情当那只杂种试图吃掉我的脚的时候我爬上了鸡笼。 最终，那位大人出来了那条狗就像什么事都没发生那样坐在了旁边。 这个贵族大笑着并且接过我送来的信。 他说，“你没有看到那个标志？”我说，呃没有先生，我现在马上就离开。 当我离开的时候，他们把吊桥拉起来显示出了它的底部并且你不知道那上面是什么，哦在那上面画着一个大大的“小心狗”的警告！%SPEECH_OFF%%houndmaster% 突然大笑起来。%SPEECH_ON%你上班的第一天，还不赖。 但是我会让你知道，%companyname% 的狗不会伤害你！ 我会训练好他们！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不幸的送信员。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Messenger.getImagePath());
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				_event.m.Messenger.improveMood(1.0, "建立友谊与 " + _event.m.Houndmaster.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Messenger.getMoodState()],
					text = _event.m.Messenger.getName() + this.Const.MoodStateEvent[_event.m.Messenger.getMoodState()]
				});
				_event.m.Houndmaster.improveMood(1.0, "建立友谊与 " + _event.m.Messenger.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Houndmaster.getMoodState()],
					text = _event.m.Houndmaster.getName() + this.Const.MoodStateEvent[_event.m.Houndmaster.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local messenger_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.messenger")
			{
				messenger_candidates.push(bro);
			}
		}

		if (messenger_candidates.len() == 0)
		{
			return;
		}

		local houndmaster_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.houndmaster")
			{
				houndmaster_candidates.push(bro);
			}
		}

		if (houndmaster_candidates.len() == 0)
		{
			return;
		}

		this.m.Messenger = messenger_candidates[this.Math.rand(0, messenger_candidates.len() - 1)];
		this.m.Houndmaster = houndmaster_candidates[this.Math.rand(0, houndmaster_candidates.len() - 1)];
		this.m.Score = (messenger_candidates.len() + houndmaster_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"messenger",
			this.m.Messenger.getNameOnly()
		]);
		_vars.push([
			"houndmaster",
			this.m.Houndmaster.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Messenger = null;
		this.m.Houndmaster = null;
	}

});

