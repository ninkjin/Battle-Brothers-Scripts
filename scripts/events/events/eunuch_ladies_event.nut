this.eunuch_ladies_event <- this.inherit("scripts/events/event", {
	m = {
		Eunuch = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.eunuch_ladies";
		this.m.Title = "在%town%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_85.png[/img]关于 %eunuch% 这个太监的事情传开了。 显然，他和几个队员去了镇上的妓院。 妓女和队员们一开始都取笑这个太监，但他只要求和最有经验的女人待五分钟。 两分钟后她出来了，关于 %eunuch% 床上功夫的传言爆炸式的传开了。\n\n现在，半个城镇，更准确地说是半个城镇的妇女，都在高度赞扬 %companyname% 并希望它再次光临此地。%eunuch% 自己给你一个眼色和一个微笑。 你注意到他嘴唇周围长满了疣状物。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个被埋没的天才。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Eunuch.getImagePath());

				if (_event.m.Town.isSouthern())
				{
					_event.m.Town.getOwner().addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "你的一个手下在女士们中享有盛名");
				}
				else
				{
					_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "你的一个手下在女士们中享有盛名");
				}

				_event.m.Eunuch.improveMood(1.5, "和女士友好相处，在 " + _event.m.Town.getName());

				if (_event.m.Eunuch.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Eunuch.getMoodState()],
						text = _event.m.Eunuch.getName() + this.Const.MoodStateEvent[_event.m.Eunuch.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getBackground().getID() == "background.eunuch")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		this.m.Eunuch = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = candidates.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"eunuch",
			this.m.Eunuch.getNameOnly()
		]);
		_vars.push([
			"town",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Eunuch = null;
		this.m.Town = null;
	}

});

