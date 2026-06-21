this.wildman_causes_havoc_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null,
		Town = null,
		Compensation = 600
	},
	function create()
	{
		this.m.ID = "event.wildman_causes_havoc";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%城市文明是不适合像 %wildman% 的野人的，他很快就证明了这一点。\n\n显然，那该死的乡巴佬在商店里发疯了，他把整个地方弄得乱七八糟。 正如之前所想的，他只是走进来，开始拿东西，却不太了解购买商品的社会规矩。 店主拿着扫帚追赶他，想把他赶出商店。 野人从没见过像扫帚这样的怪物，于是他完全疯狂了。 从报告来看，当时相当混乱，包括野人把他的屎丢的满天飞。\n\n现在店主当着你的面要求赔偿所造成的损失。 很明显，他想要 %compensation% 的补偿。 在他身后，有几个城镇的民兵站在那里，个个眼里闪着警觉的光芒。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这不是我们自己的问题。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "好吧，战队会赔偿的。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "好吧，战队会赔偿－费用由 %wildman% 自己负担。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%townImage%你一把推开店主，并告诉他，你什么都不欠他的。 当他再次向前跳的时候，你的手灵巧地摸向你的剑鞘，店主迅速停止了他的挑衅动作。 他举起双手，一边后退一边点头。 有几个镇上的人看到了这个情况，眼神躲闪的避开你的目光。 民兵注意到了这边的情况，但他们似乎不确定是否对此采取行动。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去你店里。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "E" : 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "你拒绝支付由你的一个战士造成的损害赔偿款。");
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_01.png[/img]你去看了看商店。 The wildman truly did a number on the place. 还有他的味道…气味。 如果队伍不能非常小心地处理这个问题，那将会很糟糕。 你同意赔偿损失，这是大多数雇佣兵团不会做的。 这种善意的行为能稳定城镇秩序，不会让镇上的人因混乱逃离。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "难道要通过破坏表达善意？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "%townImage%调查损失后，你同意赔偿商人。 但这不是你的错，是野人的错。 你扣他的工资：在将来的一段时间里，这个雇佣兵的收入会减半。 而且，你会把他挣的钱拿去交给店主。 它甚至根本不够赔偿损失，但它是一个开始。 一个人很高兴，而另一个人很不高兴。\n\n如果你问那个白痴，他现在是否会重新考虑在别人的墙上涂上屎。 但是野人似乎无法理解你。 他只知道，他曾经拥有的金子已经给了别人，他看着这些的离去而悲伤和愤怒。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别那样看着我，你知道你做了什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] 克朗"
				});
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.getBaseProperties().DailyWage -= this.Math.floor(_event.m.Wildman.getDailyCost() / 4);
				_event.m.Wildman.getSkills().update();
				this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "你的一个手下在城里造成了祸患");
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_daily_money.png",
					text = _event.m.Wildman.getName() + "现在支付[color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Wildman.getDailyCost() + "[/color] 克朗每天"
				});
				_event.m.Wildman.worsenMood(2.0, "减薪了");

				if (_event.m.Wildman.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Wildman.getMoodState()],
						text = _event.m.Wildman.getName() + this.Const.MoodStateEvent[_event.m.Wildman.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_141.png[/img]当你离开小镇的时候，你听到你身后的吠声。 但这不是狗干的：你转过身去，发现有一群民兵聚集在路上，他们从家里和商店里陆续出来。 他们说商人那件事你做错了，他们不会再让你这样的人住在这个地方了。 你要么现在就把钱付清，要么他们就会用武力把钱拿走。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很遗憾，事情竟成了这样。",
					function getResult( _event )
					{
						this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationBetrayal, "你杀了一些民兵");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Militia, this.Math.rand(90, 130), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				},
				{
					Text = "好吧。我今早醒来不是为了屠杀无辜的人。",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_141.png[/img]在你们面前的，是从镇子中的软弱，谦卑，被欺压的人中拼凑出来的有力量的人矮子中的高个。 在他们的队伍中没有一个是对你有麻烦的大商人。 虽然你钦佩他们的坚韧，但你不能因为一件小事而去杀戮半个城镇。 你伸手摸向你的身后，那群武装不济的人中有几个倒抽一口冷气，结果你手里却提溜一个钱包，你把钱包丢给他们，收回手 一笔交易达成了，赔偿也支付了。 虽然有些人不太愿意放弃战斗，但是大部分镇上的人都松了一口气。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这样更好一点。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				this.World.Assets.addMoney(-_event.m.Compensation);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Compensation + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isCombatBackground() && this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(1.0, "战队在一场战斗中退缩了");
					}

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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getMoney() < this.m.Compensation)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_wildman = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
		}

		if (candidates_wildman.len() == 0)
		{
			return;
		}

		this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		this.m.Town = town;
		this.m.Score = candidates_wildman.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"compensation",
			this.m.Compensation
		]);
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.Town = null;
	}

});

