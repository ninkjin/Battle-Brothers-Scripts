this.witchhunter_ghoul_teeth_event <- this.inherit("scripts/events/event", {
	m = {
		Witchhunter = null
	},
	function create()
	{
		this.m.ID = "event.witchhunter_ghoul_teeth";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%witchhunter% 女巫猎人带了一小瓶未知的液体来找你。%SPEECH_ON%解毒剂。%SPEECH_OFF%她解释。她拔掉软木塞，给你闻了闻。 有一股强烈的尿臭味。他点头。%SPEECH_ON%是的，它很恶心，但是你需要恶毒的人去和恶毒的人战斗，而哥布林使用毒药是一件非常恶心的事情。 但这解药会有所帮助。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Useful.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witchhunter.getImagePath());
				local stash = this.World.Assets.getStash().getItems();
				local numPelts = 0;

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.ghoul_teeth")
					{
						numPelts = ++numPelts;
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});

						if (numPelts >= 1)
						{
							break;
						}
					}
				}

				local item = this.new("scripts/items/accessory/antidote_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.witchhunter")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numPelts = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.ghoul_teeth")
			{
				numPelts = ++numPelts;

				if (numPelts >= 1)
				{
					break;
				}
			}
		}

		if (numPelts < 1)
		{
			return;
		}

		this.m.Witchhunter = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numPelts * candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"witchhunter",
			this.m.Witchhunter.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Witchhunter = null;
	}

});

