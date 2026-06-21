this.desert_fall_event <- this.inherit("scripts/events/event", {
	m = {
		SomeGuy = null
	},
	function create()
	{
		this.m.ID = "event.desert_fall";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_161.png[/img]{随着你走下一个沙丘的斜坡，%fallbro% 脚滑了一下开始向下滑动。 他叫着求助，手舞足蹈的往下滚着。 每一次颠簸都在加速，每一次滚动肢体都好像把他比上一次弹的更高了。 尽管沙丘的斜坡如丝顺滑，谷地的底下则充满了硬物，而那个佣兵一路剐蹭过去直到完全停下来。 他没死，但是受了点冲击，划伤，淤青，灼伤还有点羞耻。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "小心！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.SomeGuy.worsenMood(1.0, "从沙丘上滑下来时擦伤了腿");
				local injury = _event.m.SomeGuy.addInjury([
					{
						ID = "injury.bruised_leg",
						Threshold = 0.25,
						Script = "injury/bruised_leg_injury"
					}
				]);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.SomeGuy.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert || currentTile.HasRoad || this.World.Retinue.hasFollower("follower.scout"))
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
			if (bro.getSkills().hasSkill("injury.bruised_leg"))
			{
				continue;
			}

			local chance = bro.getHitpointsMax();

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
			"fallbro",
			this.m.SomeGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.SomeGuy = null;
	}

});

