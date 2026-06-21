this.gladiator_origin_vs_anatomist_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Gladiator = null
	},
	function create()
	{
		this.m.ID = "event.gladiator_origin_vs_anatomist";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{你看到解剖学家%anatomist%和角斗士%gladiator%一起坐在篝火旁。他俩似乎不太适合交谈，很快后者便愤怒地站起来。%SPEECH_ON%增强？你觉得我会使用增强剂？你这个愚蠢、棍形的、拔花的、追尸的傻瓜！我的肌肉是由汗水和鲜血组成的！没有痛苦，就没有收获！%SPEECH_OFF% 角斗士踢了一堆灰尘到解剖学家身上，愤怒地离开了。%anatomist%清理干净自己，然后拿出一堆笔记。他说这个实验对象正在经历一些愤怒的情绪。你问他是否暗地里对角斗士做了什么。%anatomist%猛地合上笔记本。%SPEECH_ON%队长！我绝对没有这样做！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个异常简洁的回答，解剖师%anatomist%……",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Gladiator.getImagePath());
				_event.m.Anatomist.getFlags().set("IsExperimentingOnGladiator", true);
				_event.m.Gladiator.getFlags().set("IsJuiced", true);
				_event.m.Gladiator.getBaseProperties().Hitpoints += 1;
				_event.m.Gladiator.getBaseProperties().Bravery += 1;
				_event.m.Gladiator.getBaseProperties().Stamina += 1;
				_event.m.Gladiator.getBaseProperties().Initiative += 1;
				_event.m.Gladiator.getBaseProperties().MeleeSkill += 1;
				_event.m.Gladiator.getBaseProperties().RangedSkill += 1;
				_event.m.Gladiator.getBaseProperties().MeleeDefense += 1;
				_event.m.Gladiator.getBaseProperties().RangedDefense += 1;
				_event.m.Gladiator.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 生命值"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 疲劳"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 主动性"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 近战技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_skill.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 近战防御"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.Gladiator.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程防御"
				});
				_event.m.Gladiator.worsenMood(0.5, "被指控使用了人工强化药物。");

				if (_event.m.Gladiator.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Gladiator.getMoodState()],
						text = _event.m.Gladiator.getName() + this.Const.MoodStateEvent[_event.m.Gladiator.getMoodState()]
					});
				}

				_event.m.Anatomist.improveMood(0.5, "实验关于" + _event.m.Gladiator.getName() + "正在顺利推进。");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
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

		if (this.World.Assets.getOrigin().getID() != "scenario.gladiators")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local gladiator_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && !bro.getFlags().has("IsExperimentingOnGladiator"))
			{
				anatomist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.gladiator" && bro.getFlags().get("IsPlayerCharacter") && !bro.getFlags().has("IsJuiced"))
			{
				gladiator_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0 || gladiator_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Gladiator = gladiator_candidates[this.Math.rand(0, gladiator_candidates.len() - 1)];
		this.m.Score = 3 * anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
		_vars.push([
			"gladiator",
			this.m.Gladiator.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Gladiator = null;
	}

});

