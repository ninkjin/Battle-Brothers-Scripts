this.caravan_hand_cart_event <- this.inherit("scripts/events/event", {
	m = {
		CaravanHand = null
	},
	function create()
	{
		this.m.ID = "event.caravan_hand_cart";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_55.png[/img]你偶然发现曾经的商队成员，%caravanhand%，正在摆弄战队的载重货车。 他把一块木板固定住，用大头钉把它钉在滚轴上。 然后，只要轻轻一拉，木板就可以落在载重货车的腹部。 相当巧妙。这样你就可以在载重货车上装更多东西了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得不错。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.CaravanHand.getImagePath());
				this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 9);
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "你的仓库空间增加了"
				});
				_event.m.CaravanHand.improveMood(1.0, "改进了战队的货车");

				if (_event.m.CaravanHand.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.CaravanHand.getMoodState()],
						text = _event.m.CaravanHand.getName() + this.Const.MoodStateEvent[_event.m.CaravanHand.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.Ambitions.getAmbition("ambition.cart").isDone() && this.World.Retinue.getInventoryUpgrades() == 0)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getBackground().getID() == "background.caravan_hand")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.CaravanHand = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"caravanhand",
			this.m.CaravanHand.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.CaravanHand = null;
	}

});

