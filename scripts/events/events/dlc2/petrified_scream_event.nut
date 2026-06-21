this.petrified_scream_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.petrified_scream";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_12.png[/img]{几个士兵急匆匆地冲进你的帐篷，每个人都睁大了眼睛，满头大汗。他们冲动地退避彼此的触碰，或者猛烈地反击。你问这是怎么回事，他们解释说就好像一群鸟争抢一块面包那样。需要解释一下，但听起来好像这个迷信地叫做“石化的尖叫”的神器一直在让士兵们做噩梦。你告诉士兵们这件物品在库存中，没有危害。士兵们悄悄地离开。\n\n你回到地图上，发现一些黑色东西藏在纸张下面。你掀起纸页，发现了阿尔普的死亡面具，嘴张得大得吓人。你盯着面具看，能听到它里面有什么东西，发出像掷骰子一样的牙齿咔嚓声，它的两侧似乎在震动，给它的肌肉泛起了一个起泡的外观。你耸了耸肩，笑着把它扔在地图上当纸铅。该死的东西要是像这样一直被士兵们移来移去，肯定会丢失。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你怎么老是把那个放错地方？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.fearless") || bro.getSkills().hasSkill("trait.brave"))
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.paranoid") || bro.getSkills().hasSkill("trait.dastard") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.mad") || this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(0.75, "担心带着一个能吓得人尖叫的神器");

						if (bro.getMoodState() <= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local items = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.petrified_scream")
			{
				items = ++items;
				break;
			}
		}

		if (items == 0)
		{
			return;
		}

		this.m.Score = items * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

