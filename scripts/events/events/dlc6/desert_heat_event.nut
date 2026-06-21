this.desert_heat_event <- this.inherit("scripts/events/event", {
	m = {
		SomeGuy = null
	},
	function create()
	{
		this.m.ID = "event.desert_heat";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_161.png[/img]{%heatbro% 倒向沙地上，一只腿发软，刚挺直另一只腿就发软了。 你回头看他时正好看到他翻白眼瘫倒下去。 战队赶来帮他，给他水和遮蔽。 他又抡手又扭腰的恢复过来，但是炎热已经造成了伤害。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "保持水分！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local effect = this.new("scripts/skills/effects_world/exhausted_effect");
				_event.m.SomeGuy.getSkills().add(effect);
				_event.m.SomeGuy.worsenMood(1.0, "体验中暑");
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.SomeGuy.getName() + "是筋疲力尽的"
				});
				this.Characters.push(_event.m.SomeGuy.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert || this.World.Retinue.hasFollower("follower.scout"))
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 5)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local lowestChance = 9000;
		local lowestBro;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.exhausted"))
			{
				continue;
			}

			local chance = bro.getFatigueMax();

			if (bro.getSkills().hasSkill("trait.strong"))
			{
				chance = chance + 20;
			}

			if (bro.getSkills().hasSkill("trait.tough"))
			{
				chance = chance + 20;
			}

			if (bro.getSkills().hasSkill("trait.lucky"))
			{
				chance = chance + 20;
			}

			if (bro.m.Ethnicity == 1)
			{
				chance = chance + 20;
			}

			if (chance < lowestChance)
			{
				lowestChance = chance;
				lowestBro = bro;
			}
		}

		if (lowestBro == null)
		{
			return;
		}

		this.m.SomeGuy = lowestBro;
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"heatbro",
			this.m.SomeGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.SomeGuy = null;
	}

});

