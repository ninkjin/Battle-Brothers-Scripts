this.greenskins_slayer_leaves_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_slayer_leaves";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]%orcslayer% 向你走来。%SPEECH_ON%好吧，我想就这样了。没有那么多的兽人和哥布林可以杀了。 我向你道别，佣兵。%SPEECH_OFF%你问他打算做什么。 他脱下盔甲，放在你面前的地上。%SPEECH_ON%我家人的仇已经报了。%SPEECH_OFF%既然他那明显的恶魔已经安息了，你点头祝他一切顺利。他笑着说。%SPEECH_ON%开玩笑的。我没有家庭。 我杀了那些混蛋，因为我喜欢听他们的哀嚎，但我的心已经不在那里了。 代我向其他人问好。%SPEECH_OFF%这个兽人杀手，或者说曾经的兽人杀手，离开了战队。",
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
		if (this.World.FactionManager.isGreenskinInvasion())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() == 1)
		{
			return;
		}

		local slayer;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.orc_slayer")
			{
				slayer = bro;
				break;
			}
		}

		if (slayer == null)
		{
			return;
		}

		this.m.Dude = slayer;
		this.m.Score = 100;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"orcslayer",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

