this.hate_greenskins_event <- this.inherit("scripts/events/event", {
	m = {
		Image = "",
		Casualty = null
	},
	function create()
	{
		this.m.ID = "event.hate_greenskins";
		this.m.Title = "战斗之后…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%image%{%brother%怒吼，张开双臂，像一个被原始狂怒支配的人一样。%SPEECH_ON%该死的野蛮人！该死的绿皮族！只有当他们被允许踏上与我、我的亲人或我的孩子的亲人同样的土地时，我才算活够了！我将从他们的嘴中撕下獠牙，掠夺他们的女人，虽然我不知道他们是否有女人，如果他们真的有的话，我也不知道我是否会接近她们，但我将掠夺某些东西，然后实施一场猛烈而彻底的毁灭，以至于古老的神灵会来向我请教一些技巧！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "就是这种气势！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				local trait = this.new("scripts/skills/traits/hate_greenskins_trait");
				_event.m.Casualty.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Casualty.getName() + "现在憎恨绿皮"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 8.0)
		{
			return;
		}

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 2)
		{
			return;
		}

		if (fallen[0].Time < this.World.getTime().Days || fallen[1].Time < this.World.getTime().Days)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID() && this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getID())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && !bro.getSkills().hasSkill("trait.fear_greenskins") && !bro.getSkills().hasSkill("trait.hate_greenskins") && !bro.getSkills().hasSkill("trait.dastard") && !bro.getSkills().hasSkill("trait.craven") && !bro.getSkills().hasSkill("trait.fainthearted") && !bro.getSkills().hasSkill("trait.weasel"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 500;
	}

	function onPrepare()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") == this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID())
		{
			this.m.Image = "[img]gfx/ui/events/event_81.png[/img]";
		}
		else
		{
			this.m.Image = "[img]gfx/ui/events/event_83.png[/img]";
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brother",
			this.m.Casualty.getName()
		]);
		_vars.push([
			"image",
			this.m.Image
		]);
	}

	function onClear()
	{
		this.m.Casualty = null;
		this.m.Image = "";
	}

});

