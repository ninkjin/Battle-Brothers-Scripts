this.cultist_origin_armor_event <- this.inherit("scripts/events/event", {
	m = {
		Tailor = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_armor";
		this.m.Title = "露营时…";
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]{紧急情况影响了 %randomcultist%。他从聚会的营火旁站起来，大步跨过营地，退到帐篷里。 就是在那里，你看到他在工作，他的轮廓和影子在疯狂地抖动。 他不只是在那里：一些不明的曲线影子在他身边来来回回，达到了黑暗的极致，黑暗的触手，鞭笞和击打，使之配得上他的仪式所拥有的能量。 然后他就完事了，在他把什么东西拉到灯光之前，他的影子轮廓向前倒去。\n\n 他离开帐篷的速度和进入帐篷时一样匆忙，但这次他手里拿着一件皮革胸甲。他把它扔在地上。%SPEECH_ON%他即将降临到我们，兄弟们。%SPEECH_OFF%胸甲上有独特的切口，这些切口被排列成条状，对不相信的人来说，毫无意义。 对你来说，它不过是达库尔的一种语言。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "达库尔即将降临。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Tailor.getImagePath());
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson"))
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				local item = this.new("scripts/items/armor/cultist_leather_robe");
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numItems = 0;

		foreach( item in stash )
		{
			if (item != null && (item.getID() == "armor.body.padded_leather" || item.getID() == "armor.body.padded_surcoat" || item.getID() == "armor.body.rugged_surcoat" || item.getID() == "armor.body.thick_tunic" || item.getID() == "armor.body.blotched_gambeson"))
			{
				numItems = ++numItems;
			}
		}

		if (numItems == 0)
		{
			return;
		}

		this.m.Tailor = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numItems * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"randomcultist",
			this.m.Tailor.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Tailor = null;
	}

});

