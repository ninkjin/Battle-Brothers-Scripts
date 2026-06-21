this.fear_undead_event <- this.inherit("scripts/events/event", {
	m = {
		Casualty = null
	},
	function create()
	{
		this.m.ID = "event.fear_undead";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%brother%环顾营火周围的人。然后他低头沉思了几分钟，最后爆发了%SPEECH_ON%难道就只有我一个人是正常的吗？为什么没有人因为死人再次行走而失去理智？老神在这一切中到底在哪里？他们就这样看着这场糟糕的表演吗？%SPEECH_OFF%，公司试图平息他的恐惧，但他又回到了一个沉思的沉默，思索着太多的事情，没有人愿意或者想要真正地倾听。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这对这些人来说是个损失。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Casualty.getImagePath());
				local trait = this.new("scripts/skills/traits/fear_undead_trait");
				_event.m.Casualty.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Casualty.getName() + "现在害怕亡灵"
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

		if (this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID() && this.World.Statistics.getFlags().getAsInt("LastCombatFaction") != this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID())
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
			if (bro.getBackground().getID() == "background.companion" || bro.getBackground().getID() == "background.crusader" || bro.getBackground().getID() == "background.gravedigger" || bro.getBackground().getID() == "background.graverobber" || bro.getBackground().getID() == "background.wildman")
			{
				continue;
			}

			if (bro.getLevel() <= 7 && !bro.getSkills().hasSkill("trait.fear_undead") && !bro.getSkills().hasSkill("trait.hate_undead") && !bro.getSkills().hasSkill("trait.fearless") && !bro.getSkills().hasSkill("trait.brave") && !bro.getSkills().hasSkill("trait.determined") && !bro.getSkills().hasSkill("trait.bloodthirsty"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Casualty = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 50;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brother",
			this.m.Casualty.getName()
		]);
	}

	function onClear()
	{
		this.m.Casualty = null;
	}

});

