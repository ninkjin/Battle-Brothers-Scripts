this.mountain_running_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.mountain_running";
		this.m.Title = "在山上…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_42.png[/img]在高低起伏的山脉中攀爬和急行军不仅是我们所有敌人的障碍也是对于团里面兄弟们身体素质的考验。 尽管团里面的人对于登山装备没有做好充足的准备，但是在严寒和恶劣的地形影响下他们逐渐适应这里的环境表现得比刚进山时候强－尤其是 %dude%。",
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
				local stamina = this.Math.rand(1, 3);
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
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Mountains)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		this.m.Dude = brothers[this.Math.rand(0, brothers.len() - 1)];
		this.m.Score = 20;
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

