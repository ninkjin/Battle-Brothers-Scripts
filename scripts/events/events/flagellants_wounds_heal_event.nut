this.flagellants_wounds_heal_event <- this.inherit("scripts/events/event", {
	m = {
		Flagellant = null
	},
	function create()
	{
		this.m.ID = "event.flagellants_wounds_heal";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]%flagellant% 这个苦修者被发现盘腿坐在篝火前。 只有他一个人，尝试拯救着那些危险地扑向火焰的飞蛾。 他感觉到你的存在，就叫你过去。 你坐在他旁边，他对你微笑。%SPEECH_ON%自从加入你的战队，我已经变成一个更好的人。%SPEECH_OFF%你点头，他当然也点头了。他继续道。%SPEECH_ON%我为神流了很多血，但我的伤口…现在它们只是伤疤。 我感觉比以前更强壮了。%SPEECH_OFF%你再次点头，但很快问他是否会停止伤害自己。 这个男人的眼睛凝视着烧红的灰烬。 他摇摇头表示否定。%SPEECH_ON%我会为神明们流血，直到他们不再说话。%SPEECH_OFF%你大声地疑惑着，问神明们是否对他说过话。 那人不假思索，又摇了摇头。%SPEECH_ON%他们还没有开口，所以我要流血，直到他们的沉默被打破，或者直到我在永远的宁静中加入他们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "所以时间会治愈所有的创伤，就这样。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Flagellant.getImagePath());
				local hitpoints = this.Math.rand(4, 6);
				_event.m.Flagellant.getBaseProperties().Hitpoints += hitpoints;
				_event.m.Flagellant.getSkills().update();
				_event.m.Flagellant.getFlags().add("wounds_scarred_over");
				this.List = [
					{
						id = 17,
						icon = "ui/icons/health.png",
						text = _event.m.Flagellant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] 生命值"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate_flagellant = [];

		foreach( bro in brothers )
		{
			if (bro.getFlags().has("wounds_scarred_over"))
			{
				continue;
			}

			if (bro.getLevel() < 6)
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				candidate_flagellant.push(bro);
			}
		}

		if (candidate_flagellant.len() == 0)
		{
			return;
		}

		this.m.Flagellant = candidate_flagellant[this.Math.rand(0, candidate_flagellant.len() - 1)];
		this.m.Score = candidate_flagellant.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"flagellant",
			this.m.Flagellant.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Flagellant = null;
	}

});

