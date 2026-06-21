this.rookie_gets_hurt_event <- this.inherit("scripts/events/event", {
	m = {
		Rookie = null
	},
	function create()
	{
		this.m.ID = "event.rookie_gets_hurt";
		this.m.Title = "战后…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_22.png[/img]战斗结束后，你发现 %noncombat% 跪在地上，身体随着他护理自己的伤口而来回颤抖。 你听见一阵介于低沉抽泣与放声大哭之间的哭声。 你走近他，问他他还好吗。 他摇摇头，解释说这是他第一次经历真正的血腥搏杀。 这种事不是他所期望的，而他也不确定他能否继续坚持下去。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别在那抱怨了！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 30 ? "B" : "C";
					}

				},
				{
					Text = "没人能站在这里还不害怕的。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "D" : "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_22.png[/img]你告诉那名雇佣兵像个爷们一样振作起来。 当他停下来，忍住哭泣时，你第二次向他说了同样的话。 这一次，他伸出一条腿，迈出一只脚，稳住了自己。 凭着发自内心的勇气，他设法重新站了起来。 他的衣服上沾满了血，脸上全是泥巴和血污，还有一场血战会在人身上留下的其他东西。 但他的眼中显露出了他以前没有的决心。 他向你点头，然后走回去和其他人会合。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只有钢铁才能铸就钢铁。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.improveMood(1.0, "听取了一场激励人心的谈话");
				_event.m.Rookie.getBaseProperties().Bravery += 3;
				_event.m.Rookie.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Rookie.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] 决心"
					}
				];

				if (_event.m.Rookie.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_22.png[/img]不幸的是，告诉这个人“忍着点”并没有什么用。 他转过身来，脸上全是血和其他战斗留下的痕迹，他的嘴唇在他还没说出一个字之前就颤抖起来，他又跪在了地上。 你问他是不是想被战队开除，他摇头否认。 他解释说他会好起来的。 你点头走开了，但毫无疑问，自己这种缺乏决心的表现已经深深伤害了这个人的自尊心。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他将在战斗中得到锻炼，不然就会在战斗中丧命。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.getBaseProperties().Bravery -= 3;
				_event.m.Rookie.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Rookie.getName() + "失去 [color=" + this.Const.UI.Color.NegativeEventValue + "]-3[/color] 决心"
					}
				];
				_event.m.Rookie.worsenMood(1.0, "对自己失去信心");

				if (_event.m.Rookie.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_22.png[/img]他环顾四周，看着尸体，看着土地，看着天空。 他点头站了起来。 在回营地之前，他为你说的话向你表示感谢。%SPEECH_ON%谢谢你，队长。我会干得更好去隐藏我的恐惧的。%SPEECH_OFF%你点头回敬他一个简洁的微笑，然后把拳头放在胸前。%SPEECH_ON%把恐惧埋在心底，别让其他人发现。 战胜秘诀的一半就是让你的敌人以为你要比他们更加凶残。 没人能做到无所畏惧，但暂时假装英勇无畏并没有那么难。%SPEECH_OFF%他再次点头，然后转身回到营地，这次，他的头抬得比以前更高了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就是这种气势！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.improveMood(1.0, "听取了一场激励人心的谈话");
				_event.m.Rookie.getBaseProperties().Bravery += 2;
				_event.m.Rookie.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Rookie.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
					}
				];

				if (_event.m.Rookie.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_22.png[/img]那人转向你，泪水划开了他脸颊上的血迹。 他摇摇头，问为什么只有他在外面哭。 你耸耸肩，问他是否想要离开战队。 他又摇了摇头。%SPEECH_ON%我会做得更好的。我只是…我只是需要些时间，就这样。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他将在战斗中得到锻炼，不然就会在战斗中丧命。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Rookie.getImagePath());
				_event.m.Rookie.worsenMood(1.0, "认识到了成为一名雇佣兵意味着什么");

				if (_event.m.Rookie.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Rookie.getMoodState()],
						text = _event.m.Rookie.getName() + this.Const.MoodStateEvent[_event.m.Rookie.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 8.0)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() == 1 && bro.getBackground().getID() != "background.slave" && !bro.getBackground().isCombatBackground() && bro.getPlaceInFormation() <= 17 && bro.getLifetimeStats().Battles >= 1)
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 1)
		{
			return;
		}

		this.m.Rookie = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 500;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noncombat",
			this.m.Rookie.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Rookie = null;
	}

});

