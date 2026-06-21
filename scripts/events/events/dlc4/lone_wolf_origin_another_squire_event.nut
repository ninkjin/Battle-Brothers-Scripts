this.lone_wolf_origin_another_squire_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.lone_wolf_origin_another_squire";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%squire%拍拍头，向你走来。他看上去有些犹豫不决，你催促他说出来。他叹了口气，询问为什么要雇佣%squire2%到队伍中。%SPEECH_ON%他是个侍从，我也是个侍从，难道我们都是你的侍从？%SPEECH_OFF% 你告诉这个小伙子，%squire2%曾是另一个人的侍从，但是生活发生了变化，导致他流落到这里。就所有的目的而言，他现在是个雇佣兵，%squire%仍然是你的侍从。%squire%露出微笑，但很快又去丑化了。%SPEECH_ON%等一下，这是否意味着我比侍从还像个兵？%SPEECH_OFF% 你将一本账本压在孩子的胸口上，让他去数清库存。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "想想看，我曾经孤身一人在这片土地上漫游...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Dude.worsenMood(0.5, "对他作为你的侍从的角色感到困惑");
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() < 3)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local squire;
		local other_squire;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.squire")
			{
				if (bro.getFlags().get("IsLoneWolfSquire"))
				{
					squire = bro;
				}
				else
				{
					other_squire = bro;
				}
			}
		}

		if (squire == null || other_squire == null)
		{
			return;
		}

		this.m.Dude = squire;
		this.m.Other = other_squire;
		this.m.Score = 75;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"squire",
			this.m.Dude.getNameOnly()
		]);
		_vars.push([
			"squire2",
			this.m.Other.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Other = null;
	}

});

