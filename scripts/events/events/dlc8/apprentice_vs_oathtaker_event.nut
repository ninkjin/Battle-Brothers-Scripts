this.apprentice_vs_oathtaker_event <- this.inherit("scripts/events/event", {
	m = {
		Apprentice = null,
		Oathtaker = null
	},
	function create()
	{
		this.m.ID = "event.apprentice_vs_oathtaker";
		this.m.Title = "露营时…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{%apprentice%学徒坐在篝火旁边，%oathtaker%誓言者开始审视他。学徒回以困惑的表情。%SPEECH_ON%怎么了？%SPEECH_OFF%誓言者咧嘴笑了。%SPEECH_ON%年轻的安瑟姆，第一位誓言者，就像你一样是一个学徒。他漫游四方，寻求知识，找到了最终之路。你甚至看起来和他一模一样。%SPEECH_OFF%学徒温暖地微笑着。看来这种与死去的誓言者有关的联结理论已经鼓舞了学徒。但就你而言，年轻的安瑟姆的头骨看起来和%apprentice%完全不一样。鼻子太大，额头太高，第一位誓言者的牙齿无懈可击，而%apprentice%看起来就像用大锤清洁牙齿一样。但也许当他也成为一个受到不动摇信仰的人关心的闪闪发光的头骨的时候，%apprentice%会更具备这一身份的特点。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不希望那种情况发生。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				this.Characters.push(_event.m.Oathtaker.getImagePath());
				local resolveBoost = this.Math.rand(1, 3);
				_event.m.Apprentice.getBaseProperties().Bravery += resolveBoost;
				_event.m.Apprentice.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] 决心"
				});
				_event.m.Apprentice.getFlags().add("learnedFromOathtaker");
				_event.m.Apprentice.improveMood(1.0, "学习 " + _event.m.Oathtaker.getName());
				_event.m.Oathtaker.improveMood(0.5, "教授了" + _event.m.Apprentice.getName() + "某些东西");

				if (_event.m.Apprentice.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local apprentice_candidates = [];
		local teacher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.apprentice" && !bro.getFlags().has("learnedFromOathtaker"))
			{
				apprentice_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.paladin")
			{
				teacher_candidates.push(bro);
			}
		}

		if (apprentice_candidates.len() == 0 || teacher_candidates.len() == 0)
		{
			return;
		}

		this.m.Apprentice = apprentice_candidates[this.Math.rand(0, apprentice_candidates.len() - 1)];
		this.m.Oathtaker = teacher_candidates[this.Math.rand(0, teacher_candidates.len() - 1)];
		this.m.Score = (apprentice_candidates.len() + teacher_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"apprentice",
			this.m.Apprentice.getNameOnly()
		]);
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Apprentice = null;
		this.m.Oathtaker = null;
	}

});

