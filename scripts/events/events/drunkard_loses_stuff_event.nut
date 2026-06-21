this.drunkard_loses_stuff_event <- this.inherit("scripts/events/event", {
	m = {
		Drunkard = null,
		OtherGuy = null,
		Item = null
	},
	function create()
	{
		this.m.ID = "event.drunkard_loses_stuff";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]当昨晚清点存货时，%drunkard% 多喝了一点酒，结果丢失了 %item%！\n\n你已经把叫带到你身边，而这个摇摇晃晃站着的男人仍然散发着酒气。 当他试图为自己辩解时候，他打了个嗝，但他所能做的就是倒在地上，变成一个酒鬼。 他一个劲儿地笑，但你看不出有啥可笑的。%otherguy% 问你该怎么处置这个家伙。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "每个人都会犯错。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "罚他打扫茅厕一个月作为惩罚！",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "如果他不戒酒，我会强迫他戒掉。拿鞭子来。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 75 ? "D" : "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Drunkard.getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Item.getIcon(),
					text = "你失去了 " + this.Const.Strings.getArticle(_event.m.Item.getName()) + _event.m.Item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]酒鬼仰面朝天，漫无目的地望着天空。 你看到他眼中的泪水，他掩面，试图掩盖他的羞耻。 关于他和他的过去，有一些你不知道的东西，也许是某些事情首先导致他喝酒。 你不可能因为一些人为不可控因素而惩罚他。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让他滚出我的视线。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Drunkard.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]你拿起一把刷子，一个水桶，和一团缠在棍子上的硬羊毛。%SPEECH_ON%罚你刷马桶。一个月。%SPEECH_OFF%酒鬼睁大眼睛望着你，像是在恳求。%SPEECH_ON%先生，求你。我－嗝－没有…这些人，先生，他们－嗝－…%SPEECH_OFF%你抬起手，打断他。 那人试图站直身子，身子却在摇晃。 掰着指关节，你解释另一种选择。%SPEECH_ON%如果你不想承担这些责任，我们可以用鞭子加速惩罚你。 你更喜欢哪一个？%SPEECH_OFF%令人惊讶的是，这个酒鬼确实花了一些时间来思考这个问题，他的眉毛时而扬，时而降，他的鬼脸从嘴的一边传递另一边，深刻的意识到没有办法逃避。 最后，他同意了两种选择中最臭的那个。 你很震惊地看到这个选择居然花了这么长时间，你会开始怀疑战队的待遇到底有多糟糕。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让他滚出我的视线。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Drunkard.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_38.png[/img]那人是被迫酗酒的，所以你打算逼他戒酒。 你下令鞭打。 几个能打的兄弟把酒鬼拖走了。 他不停地打嗝呻吟，头不停地晃动，似乎不知道发生了什么。 他们把他吊在树下，把他的衣服从背上扯下来。 挨了几下鞭子后，酒鬼意识到自己受到了惩罚，不由自主地大哭起来。 他以一种因酗酒和痛苦而变得模糊的语言乞求怜悯，就像一个在噩梦中为自由而战的人。 有一件事是肯定的：他再也不会犯这个错误了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这会让他长记性的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Drunkard.getImagePath());
				_event.m.Drunkard.addLightInjury();
				this.List = [
					{
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Drunkard.getName() + "受到损伤"
					}
				];
				_event.m.Drunkard.getSkills().removeByID("trait.drunkard");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_29.png",
					text = _event.m.Drunkard.getName() + "不再是个酒鬼"
				});
				_event.m.Drunkard.worsenMood(2.5, "被你命令鞭打了");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
					text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Drunkard.getID())
					{
						continue;
					}

					if (!bro.getBackground().isOffendedByViolence() || bro.getLevel() >= 7)
					{
						continue;
					}

					bro.worsenMood(1.0, "你的命令让人感到愤慨" + _event.m.Drunkard.getName() + "鞭打");

					if (bro.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_38.png[/img]那人是被迫酗酒的，所以你打算逼他戒酒。 你下令鞭打。 几个能打的队员把酒鬼拖走了。 他不停地打嗝呻吟，头不停地晃动，似乎不知道发生了什么。 他们把他吊在树下，把他的衣服从背上扯下来。 挨了几下鞭子后，酒鬼意识到自己受到了惩罚，不由自主地大哭起来。 他以一种因酗酒和痛苦而变得模糊的语言乞求怜悯，就像一个在噩梦中为自由而战的人。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这会让他长记性的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Drunkard.getImagePath());
				_event.m.Drunkard.addLightInjury();
				this.List = [
					{
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Drunkard.getName() + "受到损伤"
					}
				];
				_event.m.Drunkard.worsenMood(2.5, "被你命令鞭打了");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Drunkard.getMoodState()],
					text = _event.m.Drunkard.getName() + this.Const.MoodStateEvent[_event.m.Drunkard.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Drunkard.getID())
					{
						continue;
					}

					if (!bro.getBackground().isOffendedByViolence() || bro.getLevel() >= 7 || bro.getBackground().getID() == "background.flagellant")
					{
						continue;
					}

					bro.worsenMood(1.0, "你的命令让人感到愤慨" + _event.m.Drunkard.getName() + "鞭打");

					if (bro.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.drunkard"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local items = this.World.Assets.getStash().getItems();
		local hasItem = false;

		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			if (item.isItemType(this.Const.Items.ItemType.Legendary))
			{
				continue;
			}

			if (item.isItemType(this.Const.Items.ItemType.Weapon) || item.isItemType(this.Const.Items.ItemType.Shield) || item.isItemType(this.Const.Items.ItemType.Armor) || item.isItemType(this.Const.Items.ItemType.Helmet))
			{
				hasItem = true;
				break;
			}
		}

		if (!hasItem)
		{
			return;
		}

		this.m.Drunkard = candidates[this.Math.rand(0, candidates.len() - 1)];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Drunkard.getID())
			{
				other_candidates.push(bro);
			}
		}

		if (other_candidates.len() == 0)
		{
			return;
		}

		this.m.OtherGuy = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;
	}

	function onPrepare()
	{
		local items = this.World.Assets.getStash().getItems();
		local candidates = [];

		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			if (item.isItemType(this.Const.Items.ItemType.Legendary) || item.isIndestructible())
			{
				continue;
			}

			if (item.isItemType(this.Const.Items.ItemType.Weapon) || item.isItemType(this.Const.Items.ItemType.Shield) || item.isItemType(this.Const.Items.ItemType.Armor) || item.isItemType(this.Const.Items.ItemType.Helmet))
			{
				candidates.push(item);
			}
		}

		this.m.Item = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.World.Assets.getStash().remove(this.m.Item);
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"drunkard",
			this.m.Drunkard.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
		_vars.push([
			"item",
			this.Const.Strings.getArticle(this.m.Item.getName()) + this.m.Item.getName()
		]);
	}

	function onClear()
	{
		this.m.Drunkard = null;
		this.m.OtherGuy = null;
		this.m.Item = null;
	}

});

