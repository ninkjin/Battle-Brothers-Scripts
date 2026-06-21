this.broken_wagon_in_swamp_event <- this.inherit("scripts/events/event", {
	m = {
		Butcher = null
	},
	function create()
	{
		this.m.ID = "event.broken_wagon_in_swamp";
		this.m.Title = "在途中…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_09.png[/img]沼泽对于旅行者来说不是安全的地方。 从没完没了的雾霾和树木弯曲的方式来判断，毫无疑问，这里是恶魔出没的地方。 至少这一带的德鲁伊们好像是这么说的。 你所能找到的只是几匹淹死在泥里的马和一辆撞坏的载重货车，车轮和车座上沾满了泥浆。%randombrother% 仔细地检查残害，并努力尝试找到一些物品。%SPEECH_ON%好吧，有一些东西。不知道是谁不久前把它扔在这。 可能是被每天在这里出没的什么恐怖生物吓到了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "仍然能用。",
					function getResult( _event )
					{
						if (_event.m.Butcher != null)
						{
							return "Butcher";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
				local amount = this.Math.rand(5, 15);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 工具和补给"
				});
			}

		});
		this.m.Screens.push({
			ID = "Butcher",
			Text = "[img]gfx/ui/events/event_14.png[/img]%SPEECH_ON%先生，等一下。%SPEECH_OFF%队伍中的屠夫，%butcher%，说道。 他继续前进，开始切割马的尸体。 他切下一堆块状物，用大叶子包裹起来，用一点泥土和盐把它们弄干，然后递过来。%SPEECH_ON%没理由丢下我们还能用的东西。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你确定这还能吃？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				local item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				item = this.new("scripts/items/supplies/strange_meat_item");
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
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Swamp)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.butcher")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Butcher = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 9;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"butcher",
			this.m.Butcher != null ? this.m.Butcher.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Butcher = null;
	}

});

