this.gambler_vs_other_event <- this.inherit("scripts/events/event", {
	m = {
		DumbGuy = null,
		Gambler = null
	},
	function create()
	{
		this.m.ID = "event.gambler_vs_other";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]{%gambler% 和 %nongambler% 浑身是伤地走过来。 看起来他们打了一架。 不过既然俩人都还好好地喘着气儿，你并不想知道出了什么事，但他们还是告诉你了。\n\n很显然，这个赌徒为了赢钱耍了些不那么光明正大的小伎俩。 你问他们这事儿有没有涉及到战队的资金。他们说没有。 你问他们还来找你干嘛。 | 一场牌局竟是如此收场，%nongambler% 从凳子上跳起来掀了桌子，指着 %gambler% 一通大骂。这个以前的职业赌棍却顾左右而言它。 这怎么可能，谁能一下赢走那么多钱，但是当他的手举起来假装困惑时，几张“多余的”纸牌却从他袖子里溜了出来。 The ensuing battle is amusing, but you put a stop to it before anyone gets seriously hurt.}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "都省点力气吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gambler.getImagePath());
				this.Characters.push(_event.m.DumbGuy.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.Gambler.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Gambler.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.Gambler.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Gambler.getName() + " 遭受 " + injury.getNameOnly()
					});
				}

				if (this.Math.rand(1, 100) <= 50)
				{
					_event.m.DumbGuy.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.DumbGuy.getName() + "遭受轻伤"
					});
				}
				else
				{
					local injury = _event.m.DumbGuy.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.DumbGuy.getName() + " 遭受 " + injury.getNameOnly()
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

		local gambler_candidates = [];
		local dumb_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gambler")
			{
				gambler_candidates.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.bright"))
			{
				dumb_candidates.push(bro);
			}
		}

		if (gambler_candidates.len() == 0 || dumb_candidates.len() == 0)
		{
			return;
		}

		this.m.DumbGuy = dumb_candidates[this.Math.rand(0, dumb_candidates.len() - 1)];
		this.m.Gambler = gambler_candidates[this.Math.rand(0, gambler_candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"nongambler",
			this.m.DumbGuy.getName()
		]);
		_vars.push([
			"gambler",
			this.m.Gambler.getName()
		]);
	}

	function onClear()
	{
		this.m.DumbGuy = null;
		this.m.Gambler = null;
	}

});

