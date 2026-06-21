this.brawler_vs_brawler_event <- this.inherit("scripts/events/event", {
	m = {
		Brawler1 = null,
		Brawler2 = null
	},
	function create()
	{
		this.m.ID = "event.brawler_vs_brawler";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]当你和男人们围坐在火堆旁时，一场火焰边的讨论开始变得有些喧嚣。%brawler% 这个打手站起来，指着自己的胸膛，发出一声爽朗的笑声。%SPEECH_ON%你？你觉得你能摆平我么？%SPEECH_OFF%另一个打手，%brawler2%，一跃而起。%SPEECH_ON%摆平你？我能让你躺地上，你个娘娘腔的蠢货！%SPEECH_OFF%哪怕是最轻微的暗示，说 %brawler%的拳头不是由能把人的下巴震碎的砖块构成的，都会引发一场凶残的打斗。 两个打手彼此抓住对方，绕着圈挥拳相向。 每一拳都异常猛烈。 当然没有人能承受这么大的伤害后还能站起来，但在这里，你正在目睹他俩这么干。 你命令队员们阻止这场争斗。\n\n%brawler% 捏着一个鼻孔，从另一个鼻孔里喷出血来。他耸耸肩。%SPEECH_ON%刚才只是小打小闹，先生。%SPEECH_OFF%把肩膀复位后，%brawler2% 点头。%SPEECH_ON%是啊，不打不成交。%SPEECH_OFF%你看到这两个人握手，拍拍对方的肩膀，互相祝贺对方的拳头有多狠。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是一种让队伍团结的方式。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler1.getImagePath());
				this.Characters.push(_event.m.Brawler2.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury1 = _event.m.Brawler1.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury1.getIcon(),
						text = _event.m.Brawler1.getName() + " 遭受 " + injury1.getNameOnly()
					});
				}
				else
				{
					_event.m.Brawler1.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Brawler1.getName() + "遭受轻伤"
					});
				}

				_event.m.Brawler1.improveMood(2.0, "建立友谊与 " + _event.m.Brawler2.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Brawler1.getMoodState()],
					text = _event.m.Brawler1.getName() + this.Const.MoodStateEvent[_event.m.Brawler1.getMoodState()]
				});

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury2 = _event.m.Brawler2.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury2.getIcon(),
						text = _event.m.Brawler2.getName() + " 遭受 " + injury2.getNameOnly()
					});
				}
				else
				{
					_event.m.Brawler2.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Brawler2.getName() + "遭受轻伤"
					});
				}

				_event.m.Brawler2.improveMood(2.0, "建立友谊与 " + _event.m.Brawler1.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Brawler2.getMoodState()],
					text = _event.m.Brawler2.getName() + this.Const.MoodStateEvent[_event.m.Brawler2.getMoodState()]
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

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.brawler")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		local idx = this.Math.rand(0, candidates.len() - 1);
		this.m.Brawler1 = candidates[idx];
		candidates.remove(idx);
		idx = this.Math.rand(0, candidates.len() - 1);
		this.m.Brawler2 = candidates[idx];
		this.m.Score = candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brawler",
			this.m.Brawler1.getNameOnly()
		]);
		_vars.push([
			"brawler2",
			this.m.Brawler2.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Brawler1 = null;
		this.m.Brawler2 = null;
	}

});

