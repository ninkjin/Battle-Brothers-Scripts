this.herbs_along_the_way_event <- this.inherit("scripts/events/event", {
	m = {
		Volunteer = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.herbs_along_the_way";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%在朝你的目的地进发的时候，%volunteer% 手里拿着一把草药向你跑来。 现在你知道这个傻蛋一点也不了解植物和野生动物，但他似乎非常执着地想要试一试它们。 大概什么“听说”草药的精华中蕴含着神奇的魔力。 这个话题引起了战队里其他的伙伴的注意。 不久之后，为了队伍里的兄弟的身体，一些人开始要求尝试一下这些“药物”。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "它们看起来不错，有没有人想来试试的？",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "C" : "B";
					}

				},
				{
					Text = "{最好别碰运气。 | 你们这些笨蛋只会毒死自己。}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%似乎这些草药不仅没有危害，甚至在处理兄弟们身上一些麻烦的疾病时很有效。%volunteer%的感冒好多了，%otherguy% 的胃痛也减轻了不少。 在你自己尝试的时候，你甚至看见了一个小东西扭动着从你的大拇指中钻出来。神奇！",
			Image = "",
			List = [],
			Options = [
				{
					Text = "真奇妙！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local amount = this.Math.rand(5, 12);
				this.World.Assets.addMedicine(amount);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_medicine.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 医疗用品"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_18.png[/img]一个伙计开始呕吐起来，而另一个开始拉肚子。 尝试这种草药似乎是一个错误的决定。%volunteer% 勇敢地吃下了大量的这种奇怪的植物，然后，这么说吧，你看见他又吐又泄地排出来的东西多得吓人，“人的身体里能容纳这么多东西吗？”,搞不懂。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Ewww.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local effect = this.new("scripts/skills/injury/sickness_injury");
				_event.m.Volunteer.getSkills().add(effect);
				this.List = [
					{
						id = 10,
						icon = effect.getIcon(),
						text = _event.m.Volunteer.getName() + "生病了"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.Swamp)
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
			if (bro.getHitpoints() > 20 && !bro.getSkills().hasSkill("injury.sickness") && !bro.getSkills().hasSkill("trait.bright") && !bro.getSkills().hasSkill("trait.hesitant"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Volunteer = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = 10;

			do
			{
				local bro = brothers[this.Math.rand(0, brothers.len() - 1)];

				if (bro.getID() != this.m.Volunteer.getID())
				{
					this.m.OtherGuy = bro;
				}
			}
			while (this.m.OtherGuy == null);
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		local currentTile = this.World.State.getPlayer().getTile();
		local image;

		if (currentTile.Type == this.Const.World.TerrainType.Swamp)
		{
			image = "[img]gfx/ui/events/event_09.png[/img]";
		}
		else
		{
			image = "[img]gfx/ui/events/event_25.png[/img]";
		}

		_vars.push([
			"volunteer",
			this.m.Volunteer.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
		_vars.push([
			"image",
			image
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Volunteer = null;
		this.m.OtherGuy = null;
	}

});

