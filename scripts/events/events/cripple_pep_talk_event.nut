this.cripple_pep_talk_event <- this.inherit("scripts/events/event", {
	m = {
		Cripple = null,
		Veteran = null
	},
	function create()
	{
		this.m.ID = "event.cripple_pep_talk";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]%cripple% 这个瘸子问 %veteran% 是怎么做到的。 老兵挑了挑眉毛。%SPEECH_ON%做什么？%SPEECH_OFF%瘸子四处击打周围的灌木丛，这时候他摇头晃脑。%SPEECH_ON%你知道，这个事。战斗。 每次我走出战场的时候，我都觉得自己做不到，就好像我把你们都拖下水了。%SPEECH_OFF%%veteran% 笑了笑。%SPEECH_ON%噢，我明白你的意思了。 瘸子不适合做佣兵。 但你就这点出息么？ 就当自己是个瘸子？或者说你是男人么？ 你可以选择让你的摇摆不定和笨拙来定义你是谁，或者走自己的路，尽管它可能是曲折的和蹒跚的。%SPEECH_OFF%一直点着头，%cripple%的脸开始容光焕发。%SPEECH_ON%你是对的。虽然我不能完全成为自己想要的样子，但那个稚嫩的我已经死了，我以后会比所有人都努力的！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "说得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cripple.getImagePath());
				this.Characters.push(_event.m.Veteran.getImagePath());
				local resolve = this.Math.rand(1, 3);
				local fatigue = this.Math.rand(1, 3);
				local initiative = this.Math.rand(1, 3);
				_event.m.Cripple.getBaseProperties().Bravery += resolve;
				_event.m.Cripple.getBaseProperties().Stamina += fatigue;
				_event.m.Cripple.getBaseProperties().Initiative += initiative;
				_event.m.Cripple.getSkills().update();
				this.List = [
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Cripple.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
					},
					{
						id = 17,
						icon = "ui/icons/fatigue.png",
						text = _event.m.Cripple.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + fatigue + "[/color] 最大疲劳"
					},
					{
						id = 17,
						icon = "ui/icons/initiative.png",
						text = _event.m.Cripple.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] 主动性"
					}
				];
				_event.m.Cripple.improveMood(2.0, "受到激励，来自 " + _event.m.Veteran.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cripple.getMoodState()],
					text = _event.m.Cripple.getName() + this.Const.MoodStateEvent[_event.m.Cripple.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local cripple_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 3 && bro.getBackground().getID() == "background.cripple")
			{
				cripple_candidates.push(bro);
			}
		}

		if (cripple_candidates.len() == 0)
		{
			return;
		}

		local veteran_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 5)
			{
				veteran_candidates.push(bro);
			}
		}

		if (veteran_candidates.len() == 0)
		{
			return;
		}

		this.m.Cripple = cripple_candidates[this.Math.rand(0, cripple_candidates.len() - 1)];
		this.m.Veteran = veteran_candidates[this.Math.rand(0, veteran_candidates.len() - 1)];
		this.m.Score = cripple_candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cripple",
			this.m.Cripple.getNameOnly()
		]);
		_vars.push([
			"veteran",
			this.m.Veteran.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Cripple = null;
		this.m.Veteran = null;
	}

});

