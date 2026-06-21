this.caravan_guard_vs_raider_event <- this.inherit("scripts/events/event", {
	m = {
		CaravanHand = null,
		Raider = null
	},
	function create()
	{
		this.m.ID = "event.caravan_guard_vs_raider";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]虽然你期望你雇佣的人会抛弃过去的生活，但有时情况并非如此。 似乎 %caravanhand% 和 %raider%彼此非常熟悉：商队成员在曾经在某种没有胜利者的战斗中亲自对付过掠夺者。 现在，他们试图完成他们很久以前就开始的事情，他们在地上打作一团，挥拳和肘击着对方，向对方的眼睛和脸颊吐口水。 你亲自把他们分开，把他们推到两边并让他们清楚他们现在是佣兵，不是敌人。 你强迫他们握手，他们听从了。 商队成员点头。%SPEECH_ON%身手不错，%raider%。%SPEECH_OFF%掠夺者也点头，擦去一点从鼻子里流出的血。%SPEECH_ON%你比我想象中的要强壮。%SPEECH_OFF%两个人一起去接受治疗，像个男人一样，他们的过节很容易抛之脑后。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "世界真小…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.CaravanHand.getImagePath());
				this.Characters.push(_event.m.Raider.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.CaravanHand.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.CaravanHand.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.CaravanHand.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.CaravanHand.getName() + " 遭受 " + injury.getNameOnly()
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.Raider.addLightInjury();
					this.List.push({
						id = 11,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Raider.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.Raider.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Raider.getName() + " 遭受 " + injury.getNameOnly()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_06.png[/img]你希望你雇佣的人放下他们的旧生活，但有时事情并不是这样。看起来%caravanhand%和%raider%很熟：他们曾经在某种战斗中个人打过交道，这场战斗没有胜者。现在他们想完成早先开始的事情，两个人在地上打来打去，挥舞拳头和肘部，需要的话还会吐一些口水。你亲自把他们分开，明确告诉他们他们现在是佣兵，而不是敌人。你强迫他们握手，他们也这样做了。押运队员点了点头。%SPEECH_ON%打的不错，%raider%。%SPEECH_OFF%游牧民向他点了点头，擦去了从鼻子流出来的一点血。%SPEECH_ON%你比我记忆中的强壮。%SPEECH_OFF%两个人一起去疗伤了，像男人一样，他们的困扰就这样轻易地留在了身后。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "世界真小…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.CaravanHand.getImagePath());
				this.Characters.push(_event.m.Raider.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.CaravanHand.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.CaravanHand.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.CaravanHand.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.CaravanHand.getName() + " 遭受 " + injury.getNameOnly()
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.Raider.addLightInjury();
					this.List.push({
						id = 11,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Raider.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.Raider.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Raider.getName() + " 遭受 " + injury.getNameOnly()
					});
				}
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

		local candidates_caravan = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 7 && bro.getBackground().getID() == "background.caravan_guard" && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates_caravan.push(bro);
			}
		}

		if (candidates_caravan.len() == 0)
		{
			return;
		}

		local candidates_raider = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 7 && (bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.nomad") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates_raider.push(bro);
			}
		}

		if (candidates_raider.len() == 0)
		{
			return;
		}

		this.m.CaravanHand = candidates_caravan[this.Math.rand(0, candidates_caravan.len() - 1)];
		this.m.Raider = candidates_raider[this.Math.rand(0, candidates_raider.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onDetermineStartScreen()
	{
		if (this.m.Raider.getBackground().getID() == "background.raider")
		{
			return "A";
		}
		else
		{
			return "B";
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"caravanhand",
			this.m.CaravanHand.getName()
		]);
		_vars.push([
			"raider",
			this.m.Raider.getName()
		]);
	}

	function onClear()
	{
		this.m.CaravanHand = null;
		this.m.Raider = null;
	}

});

