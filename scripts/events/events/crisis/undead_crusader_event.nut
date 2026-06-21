this.undead_crusader_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_crusader";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]一个穿着盔甲的人挡住了你的去路。 你把手放在你的剑上，命令他讲明他的意图，与此同时，你要密切注意是否有埋伏。 陌生人向前走了一步，摘下了头盔。%SPEECH_ON%我是 %crusader%，一个来自无名烈焰之地的战士。 我站在邪恶诡计的山上。 我杀死了德文格勒的怪物。 我在雪尔斯塔亚给灵魂带来了安宁。 当古人的喻示的时候，我虔诚倾听。 所以我来到了这里。%SPEECH_OFF%你把手从剑上拿下来，向他请教古人。 他点头继续说。%SPEECH_ON%在人类之前，古人是所有事物的宗主，他们建立了一个疆域远超人类的帝国。 所有这些混乱只是他们毁灭的碎片。 一个人可能会死，但一个帝国不会。 一个帝国会逐渐衰落，它认为自己亏欠的东西也会随之衰落。%SPEECH_OFF%十字军战士戴上头盔，举起他的剑。%SPEECH_ON%古代帝国在坟墓里骚动。 我想帮你平息它。 我想为你效劳，雇佣兵。%SPEECH_OFF%",
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
						return 0;
					}

				},
				{
					Text = "不了，谢谢，我们没事。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"crusader_background"
				]);
				_event.m.Dude.getSkills().add(this.new("scripts/skills/traits/hate_undead_trait"));
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isUndeadScourge())
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
		_vars.push([
			"crusader",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

