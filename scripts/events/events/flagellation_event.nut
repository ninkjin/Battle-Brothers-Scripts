this.flagellation_event <- this.inherit("scripts/events/event", {
	m = {
		Flagellant = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.flagellation";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%otherguy% 带着痛苦的表情走过来。 他手里拿着头盔，另一只手擦着额头。%SPEECH_ON%先生，呃，你应该过来看看这个。%SPEECH_OFF%你打听你要去看什么。%SPEECH_ON%我没有合适的词来形容它。 你最好亲眼来看看。%SPEECH_OFF%你低头看着你的工作－计划着未来几天的行程－但是，从这个队员脸上的表情来判断，这事可以缓一缓。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那么，让我看看。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_38.png[/img]你站起来，让他把你引到出现问题的地方。 你遇到一群队员围着某物或某人转。 你冲破人群，当你进入空地时，战队安静了下来，因为你发现 %flagellant_short% 这个苦修者昏迷不醒地躺在地上。\n\n他的背部被抽得很烂，你甚至可以看到一两根肋骨。 皮鞭上的荆棘折断了，扎进它的肉里，他的皮也随着骨骼而下垂。 幸好他已经昏倒了。 不是因为他会很痛苦，而是因为你觉得他可能不会停下来。 你命令队员们把他弄干净，给他包扎伤口，把他的自虐工具藏起来。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少他没有杀死自己。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy.getImagePath());
				this.Characters.push(_event.m.Flagellant.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury = _event.m.Flagellant.addInjury(this.Const.Injury.Flagellation);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.Flagellant.getName() + " 遭受 " + injury.getNameOnly()
						}
					];
				}
				else
				{
					_event.m.Flagellant.addLightInjury();
					this.List = [
						{
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = _event.m.Flagellant.getName() + "遭受轻伤"
						}
					];
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

		local candidates = [];

		foreach( bro in brothers )
		{
			if ((bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant") && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Flagellant = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 10;

			foreach( bro in brothers )
			{
				if (bro.getID() != this.m.Flagellant.getID())
				{
					this.m.OtherGuy = bro;
					break;
				}
			}
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"flagellant",
			this.m.Flagellant.getName()
		]);
		_vars.push([
			"flagellant_short",
			this.m.Flagellant.getNameOnly()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Flagellant = null;
		this.m.OtherGuy = null;
	}

});

