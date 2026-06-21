this.disowned_noble_vs_deserter_event <- this.inherit("scripts/events/event", {
	m = {
		Deserter = null,
		Disowned = null
	},
	function create()
	{
		this.m.ID = "event.disowned_noble_vs_deserter";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{叛逃者 %deserter%和%disowned%被剥夺的贵族在篝火边相互凝视。由于营地缺乏罗曼蒂克，这种情况通常会引发一场恶战，但两个人却突然开始微笑。%deserter%伸出一根手指。%SPEECH_ON%你是在西部指挥%randomname%的征召兵，对吧？%SPEECH_OFF%被剥夺的贵族大笑着拍了拍自己的膝盖。%SPEECH_ON%混账。我知道你很眼熟！你这个小叛逃者，你知道我们找了你多久吗？整整一周！我们抓到了其他人，但你却逃脱了。%SPEECH_OFF%叛逃者笑了。%SPEECH_ON%看看我们现在，竟在为同一家雇佣兵战团而战！这有什么可能性呢？顺便问一下，你抓到的那些家伙怎么处理的？%SPEECH_OFF%%disowned%耸了耸肩。%SPEECH_ON%哦，当然是吊死了。事实上，这让我想起了一个老把戏......好吧，就说，那些都是老黄历！%SPEECH_OFF%%deserter%看着篝火发呆了一会儿，然后抬起头。%SPEECH_ON%哈哈，是啊。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是一个小小的世界，至少对于被流放者来说是这样。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Deserter.getImagePath());
				this.Characters.push(_event.m.Disowned.getImagePath());
				_event.m.Deserter.getFlags().add("reminiscedWithDisowned");
				_event.m.Disowned.getFlags().add("reminiscedWithDeserter");
				_event.m.Disowned.improveMood(1.0, "缅怀往事");

				if (_event.m.Disowned.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Disowned.getMoodState()],
						text = _event.m.Disowned.getName() + this.Const.MoodStateEvent[_event.m.Disowned.getMoodState()]
					});
				}

				local attack_boost = this.Math.rand(1, 3);
				_event.m.Disowned.getBaseProperties().MeleeSkill += attack_boost;
				_event.m.Disowned.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + attack_boost + "[/color] 近战技能"
				});
				_event.m.Deserter.improveMood(1.0, "缅怀往事");

				if (_event.m.Deserter.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Deserter.getMoodState()],
						text = _event.m.Deserter.getName() + this.Const.MoodStateEvent[_event.m.Deserter.getMoodState()]
					});
				}

				local resolve_boost = this.Math.rand(2, 4);
				_event.m.Deserter.getBaseProperties().Bravery += resolve_boost;
				_event.m.Deserter.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Deserter.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] 决心"
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
		local deserter_candidates = [];
		local disowned_candidates = [];

		foreach( bro in brothers )
		{
			if ((bro.getBackground().getID() == "background.disowned_noble" || bro.getBackground().getID() == "background.regent_in_absentia") && !bro.getFlags().has("reminiscedWithDeserter"))
			{
				disowned_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.deserter" && !bro.getFlags().has("reminiscedWithDisowned"))
			{
				deserter_candidates.push(bro);
			}
		}

		if (disowned_candidates.len() == 0 || deserter_candidates.len() == 0)
		{
			return;
		}

		this.m.Deserter = deserter_candidates[this.Math.rand(0, deserter_candidates.len() - 1)];
		this.m.Disowned = disowned_candidates[this.Math.rand(0, disowned_candidates.len() - 1)];
		this.m.Score = 3 * disowned_candidates.len() + 3 * deserter_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"deserter",
			this.m.Deserter.getNameOnly()
		]);
		_vars.push([
			"disowned",
			this.m.Disowned.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Deserter = null;
		this.m.Disowned = null;
	}

});

