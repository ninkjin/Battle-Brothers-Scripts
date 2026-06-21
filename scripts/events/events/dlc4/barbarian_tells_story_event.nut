this.barbarian_tells_story_event <- this.inherit("scripts/events/event", {
	m = {
		Barbarian = null
	},
	function create()
	{
		this.m.ID = "event.barbarian_tells_story";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%barbarian% 在篝火旁分享了关于北方英雄和怪物的故事。 他的对话不值得多说，因为他不是最能言善辩的，但他通过模仿和在地上画的方式把它表现得很好。 {一个故事似乎是一个强壮的战士击败一个更庞大的战士，或者甚至击败一个食人魔。 这很难说，但野蛮人做了一个吸引人的战斗演示，大家热烈鼓掌。 | 有一个故事是关于一对恋人的，他们用自己的双手，生动地展示了什么是耕耘，什么是被耕耘。 显然，被背叛和背后捅刀子是什么滋味。 你不知道是谁捅了谁，也不知道是什么时候捅的，也不知道是以什么方式捅的，但这个故事让人如坐针毡，并以掌声结束。 | 一个故事讲述的是一个友善的巨魔。 人们一想到它就倒抽一口凉气，但野蛮人却拍打着手腕，摇着手指。 这个故事，你以为，是他告诉你这一切都是真的方式，每一个字或咕哝。 一开始队员们对一只友善的怪物感到不安，但在故事的结尾，他们鼓掌和点头，似乎他们希望这是真的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Captivating.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Barbarian.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.barbarian")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Barbarian = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"barbarian",
			this.m.Barbarian.getName()
		]);
	}

	function onClear()
	{
		this.m.Barbarian = null;
	}

});

