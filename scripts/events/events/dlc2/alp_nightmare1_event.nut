this.alp_nightmare1_event <- this.inherit("scripts/events/event", {
	m = {
		Victim = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.alp_nightmare1";
		this.m.Title = "露营时…";
		this.m.Cooldown = 300.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{围着营火的士兵们正在交谈，%spiderbro%突然跳起来尖叫着。他向后弹开，被火光照亮，你可以看到一只像头盔一样大的蜘蛛附在他的靴子上！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有人把它砍掉了！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "用火烧它！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]{你刚拔出剑来，但是%otherbro%已经先你一步行动，他怒吼着让%spiderbro%站着不动。尽管他犹豫不决地站着，但是那个拿着武器的雇佣兵却挥剑太高了，直接切掉了他的脖子。失去头颅的尸体摇晃着倒下，整个战团发出惊恐和愤怒的尖叫声。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我靠！",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
				this.Characters.push(_event.m.Other.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Victim.getName() + "是死了"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Victim.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						continue;
					}

					local mood = this.Math.rand(0, 1);
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[mood],
						text = bro.getName() + this.Const.MoodStateEvent[mood]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_39.png[/img]{你冲向%otherbro%，想要梆死他，然而你的双手只是跑过他的身体，就像穿过了雾气一样，你的势头差点把你撞倒在地。%SPEECH_ON%队长，你没事吧？%SPEECH_OFF%回过头来，你看到一个状况完全良好的%spiderbro%坐在火边。远处，有一些苍白而光滑的东西从一棵树干上退后，你眨眼之间，它就不见了。你告诉士兵守好外围，然后回到你的帐篷，摇着头，捏了捏眼睛。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "仅仅是一个噩梦。",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%spiderbro%点了点头，僵硬地走向篝火，蜘蛛宝宝用着奇怪的信任之眼注视着他。他把小动物放进了火坑里，立刻着了火。一开始，你以为他已经摆脱了危险，但是燃烧的蜘蛛宝宝沿着这个男人的裤腿狂奔，将他的衣服点燃，并粘上了他的头。着火后，这个人伸出手寻找帮助。那野兽咬住了他的头，叫声戛然而止，这位雇佣兵像木板一样倒在篝火里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "把他的尸体从那里拿走！",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Victim.getName() + "是死了"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Victim.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						continue;
					}

					local mood = this.Math.rand(0, 1);
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[mood],
						text = bro.getName() + this.Const.MoodStateEvent[mood]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_39.png[/img]{你朝雇佣兵大喊让他们尽职尽责，但当你跳向篝火和%spiderbro%的时候，有阵灰烬和火花袭来。当它们消失后，你发现那个佣兵静静地坐在火边。%SPEECH_ON%啊，队长，你说什么？%SPEECH_OFF%四周看了看，你发现战团的其他成员正在聊天。当你再次回头看向%spiderbro%时，你以为看到他身后掠过一道白影，但再一看，却已经没有了。你告诉士兵们要警惕入侵者，并回到自己的帐篷。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我需要得到更多的休息。",
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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days < 20)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		foreach( i, bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				brothers.remove(i);
				break;
			}
		}

		if (brothers.len() < 3)
		{
			return;
		}

		this.m.Victim = brothers[this.Math.rand(0, brothers.len() - 1)];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Victim.getID())
			{
				other_candidates.push(bro);
			}
		}

		this.m.Other = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"spiderbro",
			this.m.Victim.getName()
		]);
		_vars.push([
			"otherbro",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Victim = null;
		this.m.Other = null;
	}

});

