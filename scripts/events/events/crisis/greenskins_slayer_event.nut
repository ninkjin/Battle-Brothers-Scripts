this.greenskins_slayer_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_slayer";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]在行军途中，%companyname% 偶遇一个人。他全副武装，看上去相当有骑士风范，除了一个特征：脖子上挂着一条骨头项链。 每走一步，它就以病态又空虚地弄响着他的盔甲。 你小心地对待这个陌生人和他的骨骼装饰，以免他用你的鸡鸡做皮带，用你的胸脯做盘子…%SPEECH_ON%晚上好，佣兵。%SPEECH_OFF%这个战士挥挥手。对这个人来说，有一种看不见的重量，就好像被死亡之气或者受害者的灵魂包围着。 他点头，继续说。%SPEECH_ON%你似乎是那种细皮嫩肉的人，我最愿意加入这种人。%SPEECH_OFF%%randombrother% 与你交换了一个眼神，耸耸肩。 他低声说他漠不关心。%SPEECH_ON%如果他有问题，我们可以对付他。%SPEECH_OFF%The man shakes his head.%SPEECH_ON%噢，我没有问题。 我只想杀死兽人和哥布林。 你还需要知道什么？ 一旦这些绿皮被处理好了，我就离开你了。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "你不妨加入我们。",
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
					Text = "不了，谢谢，我们没事。",
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
					"orc_slayer_background"
				]);
				_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/hate_greenskins_trait"));
				local necklace = this.new("scripts/items/accessory/special/slayer_necklace_item");
				necklace.m.Name = _event.m.Dude.getNameOnly() + "的项链";
				_event.m.Dude.getItems().equip(necklace);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isGreenskinInvasion())
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 3000)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 10;
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

