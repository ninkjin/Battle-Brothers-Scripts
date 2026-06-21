this.sellsword_vs_raider_event <- this.inherit("scripts/events/event", {
	m = {
		Sellsword = null,
		Raider = null
	},
	function create()
	{
		this.m.ID = "event.sellsword_vs_raider";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img]这个掠夺者，%raider%，正在篝火旁打磨他的武器。 他讲述了他的故事，他掠夺海岸地区，获得成堆的战利品的日子，他扭曲而狂放的笑声映衬在利刃被打磨锋利所产生的光亮之中。%sellsword% 这个佣兵听了一会儿并大笑起来。%SPEECH_ON%噢，小伙子，你讲的故事真不错。 这是我的：我一直在杀人，不管是在家里还是在战场上，但是男人不该这样。 你在你的船上乱跑，等着男人们离开，然后你跑过海滩，踢小男孩，强奸小女孩，从老修士那里偷东西。 你没什么好吹嘘的，掠夺者。%SPEECH_OFF%%raider% 放下他的利刃。%SPEECH_ON%我们岛上的人至少在我们中间是有荣誉的，而你会为了钱包里多几个的克朗在 %companyname% 后背捅上一刀。 再讲我过去的坏话，佣兵，我就让你的嘴巴啃泥土。%SPEECH_OFF%言语交锋只会导致：一场战斗。 刀锋一闪，鲜血四溅。 战队的其他成员在造成太大损失之前就加入进来了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不在乎你从哪里来，停止打斗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sellsword.getImagePath());
				this.Characters.push(_event.m.Raider.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury1 = _event.m.Sellsword.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury1.getIcon(),
						text = _event.m.Sellsword.getName() + " 遭受 " + injury1.getNameOnly()
					});
				}
				else
				{
					_event.m.Sellsword.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Sellsword.getName() + "遭受轻伤"
					});
				}

				_event.m.Sellsword.worsenMood(0.5, "和人打架跟 " + _event.m.Raider.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Sellsword.getMoodState()],
					text = _event.m.Sellsword.getName() + this.Const.MoodStateEvent[_event.m.Sellsword.getMoodState()]
				});

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury2 = _event.m.Raider.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury2.getIcon(),
						text = _event.m.Raider.getName() + " 遭受 " + injury2.getNameOnly()
					});
				}
				else
				{
					_event.m.Raider.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Raider.getName() + "遭受轻伤"
					});
				}

				_event.m.Raider.worsenMood(0.5, "和人打架跟 " + _event.m.Sellsword.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Raider.getMoodState()],
					text = _event.m.Raider.getName() + this.Const.MoodStateEvent[_event.m.Raider.getMoodState()]
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

		local sellsword_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 6 && bro.getBackground().getID() == "background.sellsword")
			{
				sellsword_candidates.push(bro);
				break;
			}
		}

		if (sellsword_candidates.len() == 0)
		{
			return;
		}

		local raider_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 6 && bro.getBackground().getID() == "background.raider")
			{
				raider_candidates.push(bro);
			}
		}

		if (raider_candidates.len() == 0)
		{
			return;
		}

		this.m.Sellsword = sellsword_candidates[this.Math.rand(0, sellsword_candidates.len() - 1)];
		this.m.Raider = raider_candidates[this.Math.rand(0, raider_candidates.len() - 1)];
		this.m.Score = (sellsword_candidates.len() + raider_candidates.len()) * 3;
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
			"raider",
			this.m.Raider.getName()
		]);
	}

	function onClear()
	{
		this.m.Sellsword = null;
		this.m.Raider = null;
	}

});

