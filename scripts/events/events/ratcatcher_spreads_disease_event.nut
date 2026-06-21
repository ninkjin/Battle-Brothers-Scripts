this.ratcatcher_spreads_disease_event <- this.inherit("scripts/events/event", {
	m = {
		Ratcatcher = null
	},
	function create()
	{
		this.m.ID = "event.ratcatcher_spreads_disease";
		this.m.Title = "露营时…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_18.png[/img]%ratcatcher% 证明了他和他以前的职业名副其实：很显然他在跟着你的战队东奔西走的时候也在一直围捕老鼠。 而今晚，它们全都逃走了。 有些食物在事后不得不被扔掉，还有一些人生病了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我喉咙好痒，一句话都说不出来！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Ratcatcher.getImagePath());
				local food = this.Math.rand(8, 18);
				this.World.Assets.removeRandomFood(food);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_food.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + food + "[/color] 军粮"
					}
				];
				local brothers = this.World.getPlayerRoster().getAll();
				local lowestChance = 9000;
				local lowestBro;
				local applied = false;

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Ratcatcher.getID())
					{
						continue;
					}

					local chance = bro.getHitpoints() + 20;

					if (bro.getSkills().hasSkill("trait.strong"))
					{
						chance = chance + 20;
					}

					if (bro.getSkills().hasSkill("trait.tough"))
					{
						chance = chance + 20;
					}

					if (chance < lowestChance)
					{
						lowestChance = chance;
						lowestBro = bro;
					}
					
					if (this.Math.rand(1, 100) > chance)
					{
						applied = true;
						local effect = this.new("scripts/skills/injury/sickness_injury");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + "生病了"
						});
					}
				}

				if (!applied && lowestBro != null)
				{
					local effect = this.new("scripts/skills/injury/sickness_injury");
					lowestBro.getSkills().add(effect);
					this.List.push({
						id = 10,
						icon = effect.getIcon(),
						text = lowestBro.getName() + "生病了"
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getFood() < 30)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.ratcatcher")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Ratcatcher = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"ratcatcher",
			this.m.Ratcatcher.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Ratcatcher = null;
	}

});

