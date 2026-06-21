this.mutated_gladiator_annoys_others_event <- this.inherit("scripts/events/event", {
	m = {
		Gladiator = null
	},
	function create()
	{
		this.m.ID = "event.mutated_gladiator_annoys_others";
		this.m.Title = "露营时…";
		this.m.Cooldown = 65.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{自从角斗士%gladiator%服用了解剖学家的一种好奇药物，这名地下赛斗士就一直在不停地展示自己的肌肉。许多人对这个铜色、闪闪发光、过度肌肉化的男人感到恼火，因为他要求其他佣兵和他一对一进行裸体搏斗比赛。当他不在争夺grabass的比赛时，他在做锻炼，每次做完都会尖叫，仿佛他正在进行一场激烈的战斗。希望他的生命中的这个阶段很快就会结束。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少他感觉有精力...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
				_event.m.Gladiator.getFlags().set("PumpedAboutMutations", true);
				_event.m.Gladiator.getBaseProperties().Hitpoints += 1;
				_event.m.Gladiator.getBaseProperties().Bravery += 1;
				_event.m.Gladiator.getBaseProperties().Stamina += 1;
				_event.m.Gladiator.getBaseProperties().Initiative += 1;
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
				_event.m.Gladiator.improveMood(0.5, "感觉比以往任何时候都好。");

				if (_event.m.Gladiator.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Gladiator.getMoodState()],
						text = _event.m.Gladiator.getName() + this.Const.MoodStateEvent[_event.m.Gladiator.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Gladiator.getID())
					{
						continue;
					}

					bro.worsenMood(1.0, "烦恼于" + _event.m.Gladiator.getName() + "的恶作剧");

					if (bro.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
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

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local gladiator_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gladiator" && !bro.getSkills().hasSkill("injury.sickness") && !bro.getFlags().has("PumpedAboutMutations") && bro.getFlags().getAsInt("ActiveMutations") > 0)
			{
				gladiator_candidates.push(bro);
			}
		}

		if (gladiator_candidates.len() == 0)
		{
			return;
		}

		this.m.Gladiator = gladiator_candidates[this.Math.rand(0, gladiator_candidates.len() - 1)];
		this.m.Score = 3 * gladiator_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gladiator",
			this.m.Gladiator.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Gladiator = null;
	}

});

