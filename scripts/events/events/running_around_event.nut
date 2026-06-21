this.running_around_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.running_around";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{走走路，跑跑步，打打仗，操操逼，都是些有益身心健康的事情。 在大陆上四处旅行的时间锻炼了你战团成员的精气与活力。 你甚至看见过一个脸皮厚的雇佣兵弯腰走进池塘里，像个傻缺一样欣赏自己的倒影。 | 在大陆上来回奔走锻炼了战队成员的体力。 一个在原地跑步，把一根手指抵在脖子上。 他声称他的心率根本没有升高。 另一个兄弟说那家伙连数数都不知道。 跑步的那个佣兵停了下来。%SPEECH_ON%Oh. 你说得对。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这一切都是值得的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local bro = _event.m.Dude;
				this.Characters.push(bro.getImagePath());
				local stamina = this.Math.rand(1, 1);
				bro.getBaseProperties().Stamina += stamina;
				bro.getSkills().update();
				this.List.push({
					id = 17,
					icon = "ui/icons/fatigue.png",
					text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] 最大疲劳"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		this.m.Dude = brothers[this.Math.rand(0, brothers.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dude",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

