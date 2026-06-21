this.fisherman_vs_farmer_event <- this.inherit("scripts/events/event", {
	m = {
		Fisherman = null,
		Farmer = null
	},
	function create()
	{
		this.m.ID = "event.fisherman_vs_farmer";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%farmhand% 和 %fisherman% 正在进行一场扳手腕比赛。 这一切都是很有趣的，显然是由一场关于渔夫和农夫谁更重要，谁的食物最好，谁在陆地上行走，谁在海洋里游泳的争论产生的。 渔夫打了一个带咸味的长嗝，并为一些失踪已久的鲸唱起了赞歌，他用尽最后一点力气，压倒了 %farmhand%的手臂。 两个人都站起来，拍拍彼此的肩膀。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们中没有人天生就是雇佣兵。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Fisherman.getImagePath());
				this.Characters.push(_event.m.Farmer.getImagePath());
				_event.m.Fisherman.getFlags().increment("ParticipatedInStrengthContests", 1);
				_event.m.Farmer.getFlags().increment("ParticipatedInStrengthContests", 1);
				_event.m.Fisherman.improveMood(1.0, "建立友谊与 " + _event.m.Farmer.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Fisherman.getMoodState()],
					text = _event.m.Fisherman.getName() + this.Const.MoodStateEvent[_event.m.Fisherman.getMoodState()]
				});
				_event.m.Farmer.improveMood(1.0, "建立友谊与 " + _event.m.Fisherman.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Farmer.getMoodState()],
					text = _event.m.Farmer.getName() + this.Const.MoodStateEvent[_event.m.Farmer.getMoodState()]
				});

				if (_event.m.Fisherman.getTitle() == "")
				{
					local titles = [
						"壮汉",
						"骄傲者",
						"渔夫",
						"手腕王",
						"鱼"
					];
					_event.m.Fisherman.setTitle(titles[this.Math.rand(0, titles.len() - 1)]);
					this.List.push({
						id = 10,
						icon = "ui/icons/special.png",
						text = _event.m.Fisherman.getNameOnly() + " 现在被称为 " + _event.m.Fisherman.getName()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]%farmhand% 和 %fisherman% 正在进行一场扳手腕比赛。 这一切都是很有趣的，显然是由一场关于渔夫和农夫哪个更重要，谁的食物最好之类的争论产生的。 随着对他父亲耕种土地历史的长篇大论，%farmhand% 把最后的力气都用在了压住 %fisherman% 的手臂上。 两个人都站起来，拍拍彼此的肩膀。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们中没有人天生就是雇佣兵。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Farmer.getImagePath());
				this.Characters.push(_event.m.Fisherman.getImagePath());
				_event.m.Fisherman.getFlags().increment("ParticipatedInStrengthContests", 1);
				_event.m.Farmer.getFlags().increment("ParticipatedInStrengthContests", 1);
				_event.m.Fisherman.improveMood(1.0, "建立友谊与 " + _event.m.Farmer.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Fisherman.getMoodState()],
					text = _event.m.Fisherman.getName() + this.Const.MoodStateEvent[_event.m.Fisherman.getMoodState()]
				});
				_event.m.Farmer.improveMood(1.0, "建立友谊与 " + _event.m.Fisherman.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Farmer.getMoodState()],
					text = _event.m.Farmer.getName() + this.Const.MoodStateEvent[_event.m.Farmer.getMoodState()]
				});

				if (_event.m.Farmer.getTitle() == "")
				{
					local titles = [
						"壮汉",
						"骄傲者",
						"农夫",
						"手腕王",
						"草"
					];
					_event.m.Farmer.setTitle(titles[this.Math.rand(0, titles.len() - 1)]);
					this.List.push({
						id = 10,
						icon = "ui/icons/special.png",
						text = _event.m.Farmer.getNameOnly() + " 现在被称为 " + _event.m.Farmer.getName()
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local fisherman_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 4 && bro.getBackground().getID() == "background.fisherman")
			{
				fisherman_candidates.push(bro);
			}
		}

		if (fisherman_candidates.len() == 0)
		{
			return;
		}

		local farmer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 4 && bro.getBackground().getID() == "background.farmhand")
			{
				farmer_candidates.push(bro);
			}
		}

		if (farmer_candidates.len() == 0)
		{
			return;
		}

		this.m.Fisherman = fisherman_candidates[this.Math.rand(0, fisherman_candidates.len() - 1)];
		this.m.Farmer = farmer_candidates[this.Math.rand(0, farmer_candidates.len() - 1)];
		this.m.Score = (fisherman_candidates.len() + farmer_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"farmhand",
			this.m.Farmer.getNameOnly()
		]);
		_vars.push([
			"fisherman",
			this.m.Fisherman.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		if (this.Math.rand(0, 1) == 0)
		{
			return "A";
		}
		else
		{
			return "B";
		}
	}

	function onClear()
	{
		this.m.Farmer = null;
		this.m.Fisherman = null;
	}

});

