this.kings_guard_2_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.kings_guard_2";
		this.m.Title = "在路上…";
		this.m.Cooldown = 9999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img]{你发现 %guard% 展示了不可思议的灵巧程度。 他看起来一点也不像那个被野蛮人遗弃在冰天雪地里的冻僵的人。 看到你，他点头走过来，低声说。%SPEECH_ON%我很高兴你信任我，队长。 也许你是出于好心，但我需要给你看样东西。%SPEECH_OFF%他拿出一个你已经听过很多次，但从未见过的徽章：它是国王的护卫的徽章，它是如此的真实以至于这不可能是一场闹剧。 这个人对你微笑。%SPEECH_ON%我想我很健康，准备像侍奉我的君主一样侍奉你。%SPEECH_OFF%这些土地上的国王早已倒台，取而代之的是争吵不休的领主和贵族。 如果这个人能像为国王那样为你而战，那么 %companyname% 一定会前途光明。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我很高兴我们在正确的时间遇到你。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				local bg = this.new("scripts/skills/backgrounds/kings_guard_background");
				bg.m.IsNew = false;
				_event.m.Dude.getSkills().removeByID("background.cripple");
				_event.m.Dude.getSkills().add(bg);
				_event.m.Dude.getBackground().m.RawDescription = "他发现 %name% 在北方冻得半死。 在你的帮助下，前国王的护卫恢复了力量，现在为你而战。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.improveMood(1.0, "重新成为昔日的自己");

				if (_event.m.Dude.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Dude.getMoodState()],
						text = _event.m.Dude.getName() + this.Const.MoodStateEvent[_event.m.Dude.getMoodState()]
					});
				}

				_event.m.Dude.getBaseProperties().MeleeSkill += 12;
				_event.m.Dude.getBaseProperties().MeleeDefense += 7;
				_event.m.Dude.getBaseProperties().RangedDefense += 7;
				_event.m.Dude.getBaseProperties().Hitpoints += 15;
				_event.m.Dude.getBaseProperties().Stamina += 10;
				_event.m.Dude.getBaseProperties().Initiative += 10;
				_event.m.Dude.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.Dude.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] 近战防御"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.Dude.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+7[/color] 远程防御"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Dude.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+12[/color] 近战技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Dude.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] 最大疲劳"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Dude.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+10[/color] 主动性"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.Dude.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+15[/color] 生命值"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidate;

		foreach( bro in brothers )
		{
			if (bro.getDaysWithCompany() >= 30 && bro.getFlags().get("IsKingsGuard"))
			{
				candidate = bro;
				break;
			}
		}

		if (candidate == null)
		{
			return;
		}

		this.m.Dude = candidate;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"guard",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

