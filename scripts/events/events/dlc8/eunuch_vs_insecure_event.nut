this.eunuch_vs_insecure_event <- this.inherit("scripts/events/event", {
	m = {
		Eunuch = null,
		Insecure = null
	},
	function create()
	{
		this.m.ID = "event.eunuch_vs_insecure";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{太监%eunuch%和明显不自信的雇佣兵%insecure%坐在一起聊天。太监摇了摇头。%SPEECH_ON%你的胆怯对我毫无意义，%insecure%。看看我。我甚至没有作为男人唯一的理由。当风吹过我的裤子时，我只感觉到裤子碰到我的大腿。你知道这有多奇怪吗？但是你见到我抱怨吗？没有。当一半的战团去当地的妓院做爱的时候，你见到我坐在角落里哭吗？当然不是!%SPEECH_OFF%%insecure%点点头。%SPEECH_ON%你知道吗，你这个没鸟鸡鸡的混蛋，你说的对。如果你能对着空气拍打而感到高兴，那么我就可以不这么害怕和拘谨了。%SPEECH_OFF%那个不自信的雇佣兵起身离开了。%eunuch%皱起了嘴唇。%SPEECH_ON%拍打空气？这个蠢材告诉我他在拍打空气？喂！喂！我会让你爱上你的妈妈！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不要让他的不安全感影响到你，%eunuch%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Insecure.getImagePath());
				this.Characters.push(_event.m.Eunuch.getImagePath());
				_event.m.Insecure.getSkills().removeByID("trait.insecure");
				this.List = [
					{
						id = 10,
						icon = "ui/traits/trait_icon_03.png",
						text = _event.m.Insecure.getName() + "不再是不安全的。"
					}
				];
				_event.m.Eunuch.worsenMood(1.0, "被轻视了。");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Eunuch.getMoodState()],
					text = _event.m.Eunuch.getName() + this.Const.MoodStateEvent[_event.m.Eunuch.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local eunuch_candidates = [];
		local insecure_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() != "background.eunuch" && bro.getSkills().hasSkill("trait.insecure"))
			{
				insecure_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.eunuch" && bro.getLevel() >= 4 && !bro.getSkills().hasSkill("trait.insecure"))
			{
				eunuch_candidates.push(bro);
			}
		}

		if (insecure_candidates.len() == 0 || eunuch_candidates.len() == 0)
		{
			return;
		}

		this.m.Eunuch = eunuch_candidates[this.Math.rand(0, eunuch_candidates.len() - 1)];
		this.m.Insecure = insecure_candidates[this.Math.rand(0, insecure_candidates.len() - 1)];
		this.m.Score = 5 * insecure_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"eunuch",
			this.m.Eunuch.getNameOnly()
		]);
		_vars.push([
			"insecure",
			this.m.Insecure.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Eunuch = null;
		this.m.Insecure = null;
	}

});

