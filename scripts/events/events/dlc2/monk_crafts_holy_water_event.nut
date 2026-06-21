this.monk_crafts_holy_water_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null
	},
	function create()
	{
		this.m.ID = "event.monk_crafts_holy_water";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{%monk%那位谦虚的僧侣手拿一只瓶子进入您的帐篷。这个瓶子顶部盖有一个树皮塞子和一个绿植花环，叶子下垂挂着浆果。瓶中有一种金色液体晃动着。无论是任何光线，它似乎都能捕捉并旋转它。他递给你瓶子。%SPEECH_ON%圣水，用来对抗那些再次行走的亡者。%SPEECH_OFF%你问这是否是神的礼物。他点点头。你问他这是否确实是来自于古老神的礼物，他皱起嘴巴。%SPEECH_ON%不完全是。寺庙知道如何制作，但这是一个古老的秘方，受到死亡的惩罚来加以保护。%SPEECH_OFF%当然了。你感谢这位承担风险做出贡献的人，并让他把它放在库存中。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "即使是圣人也有交易的技俩。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				local item = this.new("scripts/items/tools/holy_water_item");
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_monk = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk")
			{
				candidates_monk.push(bro);
			}
		}

		if (candidates_monk.len() == 0)
		{
			return;
		}

		this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Monk = null;
	}

});

