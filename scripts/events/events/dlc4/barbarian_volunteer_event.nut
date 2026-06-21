this.barbarian_volunteer_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.barbarian_volunteer";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{与南方不同的是，在北方的“道路”上发现旅行者往往是一个需要谨慎的由头。你永远不知道接下来会遇到什么怪物或野蛮野蛮人。这次是一个大块头男人一瘸一拐地走着，旁边有一条狗。 你把剑从剑鞘中抽出一半，声音大到足以吸引他的耳朵。 那人抬头一看，突然拉了一下皮带，他的狗受惊向后一靠。 这个北方人能说一点你的语言。%SPEECH_ON%啊,战士们。我自己也是个战士。%SPEECH_OFF%你问他为什么独自一人。 他解释说，他的部落发生了争执，他将与另一个人决斗，以决定谁将取得领导权。 你问他为什么不跟这个人决斗，你问他是否害怕。 旅行者摇了摇头。%SPEECH_ON%不。这个族人是我的兄弟。 我不想杀死我的亲人。 他们给了我这个婊子作为侮辱和奖励并把我赶出了部落。 我无家可归，但如果你收留我，我一定会像其他人一样为你而战。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你已经找到了一个新的部落，朋友。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要你。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"barbarian_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "%name%在拒绝杀死他的兄弟后被他的部落放逐，之后加入了你。他会一视同仁的为你而战。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().equip(this.new("scripts/items/accessory/warhound_item"));
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.7)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.raiders")
		{
			this.m.Score = 20;
		}
		else
		{
			this.m.Score = 5;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

