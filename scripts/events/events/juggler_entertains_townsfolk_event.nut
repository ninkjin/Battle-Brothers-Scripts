this.juggler_entertains_townsfolk_event <- this.inherit("scripts/events/event", {
	m = {
		Juggler = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.juggler_entertains_townsfolk";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_92.png[/img]当人们在 %townname% 里闲逛着想找点事做时，%juggler% 这个杂耍者主动承担起了提供娱乐的任务。 他拿起酒店广告的卷轴，把它折成一个有角的纸帽子。 他把它戴在头上，一溜烟钻进一群农民中间，向他们要杂耍的道具。 他们扔给他各种各样的东西，从胡萝卜到刀子，甚至在人提议为他提供一个婴儿，在被孩子的妈妈赏耳光之前，一个男人真的这么干了。 无论掷向他的是啥东西，杂耍者也能很轻松地随着身体的扭动和旋转把东西抛向空中，他的双脚在两只手之间交替，把东西重新踢回空中。 它如灵动的诗歌一般，同时也是城市被压迫者的福音。 你会有这样一种感觉，那就是在这一天，这个杂耍者很好地提升了 %companyname% 的形象。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色，很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());

				if (_event.m.Town.isSouthern())
				{
					_event.m.Town.getOwner().addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "你的一个队员取悦了群众。");
				}
				else
				{
					_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "你的一个手下为镇民献上了娱乐");
				}

				_event.m.Juggler.improveMood(2.0, "玩杂耍娱乐镇民");

				if (_event.m.Juggler.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Juggler.getMoodState()],
						text = _event.m.Juggler.getName() + this.Const.MoodStateEvent[_event.m.Juggler.getMoodState()]
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

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.juggler")
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

		this.m.Juggler = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = candidates.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"juggler",
			this.m.Juggler.getNameOnly()
		]);
		_vars.push([
			"town",
			this.m.Town.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Juggler = null;
		this.m.Town = null;
	}

});

