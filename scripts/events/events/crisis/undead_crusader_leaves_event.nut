this.undead_crusader_leaves_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_crusader_leaves";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]%crusader% 这个十字军战士接近你的时候脱掉了他的盔甲，把头盔塞进了他的肘窝里。%SPEECH_ON%你好，先生，我得跟战队说再见了。 亡灵被打败后，我的任务就完成了。%SPEECH_OFF%你去和他握手，但他只是把头盔和武器递给你。%SPEECH_ON%你比我更需要它们。 我的战斗生涯结束了。 和你一起经历它们进入黄昏是一种乐趣。 代我向其他人问好。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "再会！",
					function getResult( _event )
					{
						_event.m.Dude.getItems().transferToStash(this.World.Assets.getStash());
						_event.m.Dude.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.Dude);
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Dude.getName() + "离开了" + this.World.Assets.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() == 1)
		{
			return;
		}

		local crusader;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.crusader")
			{
				crusader = bro;
				break;
			}
		}

		if (crusader == null)
		{
			return;
		}

		this.m.Dude = crusader;
		this.m.Score = 100;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"crusader",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

