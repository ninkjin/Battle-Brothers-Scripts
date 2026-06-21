this.fish_caught_event <- this.inherit("scripts/events/event", {
	m = {
		Fisherman = null
	},
	function create()
	{
		this.m.ID = "event.hunt_food";
		this.m.Title = "在途中…";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_52.png[/img]{在一条河边停了下来时，看来 %fisherman% 要去干他的老本行并抓到了几条鱼！ | 你来到一片水域，停下来和几个当地人谈论周围的风土人情。%fisherman% 这个曾经的渔夫抓住机会去逮了几条大马哈鱼和其他水生动物。 | 在沿河行军的时候，%fisherman% 这个曾经的渔夫，沿着河岸奔跑并抓了一桶龙虾！ 放在锅里煮，可以做成美味的食物。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "今晚吃鱼！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Fisherman.getImagePath());
				local food = this.new("scripts/items/supplies/dried_fish_item");
				this.World.Assets.getStash().add(food);
				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + food.getAmount() + "[/color] 条鱼"
					}
				];
				_event.m.Fisherman.improveMood(0.5, "钓到一些鱼");

				if (_event.m.Fisherman.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Fisherman.getMoodState()],
						text = _event.m.Fisherman.getName() + this.Const.MoodStateEvent[_event.m.Fisherman.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Shore)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.fisherman")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Fisherman = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = candidates.len() * 15;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fisherman",
			this.m.Fisherman.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Fisherman = null;
	}

});

