this.houndmaster_tames_wolf_event <- this.inherit("scripts/events/event", {
	m = {
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.houndmaster_tames_wolf";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_143.png[/img]当你穿行在大雪覆盖着的北方王国荒僻之地时，训兽师 %houndmaster% 准备与一个跟在战队之后行动的生物成为朋友：一只狼。 驯兽师频繁地留在后卫中，伏低身子，双手放在身边，连续好几分钟盯着那只独狼不放。 但是在今天，通过使用一些吃剩的肉，他成功地引诱那只狼走进了营地的中央。 现在他蹲在它的身边，因为它那强壮又充满肌肉的身体，支楞着的敏锐耳朵，连着一个饥饿地蠕动着的胃的危险的犬齿而显得那么矮小。\n\n 其他的伙计们都站在他们的武器旁边。 一个人对驯兽师叫喊着让他快停下这危险的行为。 一些人说，狼可以嗅出恐惧的味道。 另一些人则在对它扔石头。 这只狼躲避着，但是没有任何回应。 哈哈大笑着，驯兽师吹了一声口哨“叮！”，指了指一个方向。 狼站起身来朝前跑去，叼起了石头然后把它带给了他。 他摸了摸兽毛。%SPEECH_ON%看到没，简单地训练之后，就像一只狗一样。 只是大了一些，快了一些，强壮了一些而已。当然，也更聪明了。%SPEECH_OFF%它看了看你。 那只狼低低地躺着，就像一个人在鞠躬一样。%houndmaster% 又笑了笑。%SPEECH_ON%看到没？它还知道我们这些人里老大是谁。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一只聪明的野兽。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/wolf_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Houndmaster.improveMood(2.0, "设法驯服了一只狼");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Houndmaster.getMoodState()],
					text = _event.m.Houndmaster.getName() + this.Const.MoodStateEvent[_event.m.Houndmaster.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
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
			if (bro.getLevel() >= 5 && bro.getBackground().getID() == "background.houndmaster")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 6;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"houndmaster",
			this.m.Houndmaster.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Houndmaster = null;
	}

});

