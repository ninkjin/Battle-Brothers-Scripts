this.kids_and_dead_merchant_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight = null
	},
	function create()
	{
		this.m.ID = "event.kids_and_dead_merchant";
		this.m.Title = "在路上…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]你发现有个孩子脖子上戴着一个相当华丽的项链。 这个项链压得他头都抬不起来，但是这小小的不适并没有影响到他脸上的笑容。%randombrother% 将这个孩子推倒在地并且拿走了这个项链。%SPEECH_ON%你是从哪里拿到他的小鬼？%SPEECH_OFF%小孩开始嚎啕大哭，并且不断尝试去拿回那条项链，但是这小孩只有三英尺高并且也没有惊人的弹跳力。%SPEECH_ON%嘿，那是我的！还给我！%SPEECH_OFF%另外一个孩子出现你们一下就看到了他手上那足够遮盖两个手指的大戒指。 好的。已经足够了。将团队成员分散出去寻找线索最后在齐人高的杂草堆上方发现了吊死的商人。 他的脸因为骨折已经变得酱紫并且坑坑洼洼。 这似乎表明他是在被洗劫完之后被杀害的。\n\n 一群人数大概在四十到五十的年轻人从树梢上面出现，每一个人都在把弄手里的石头。 他们的领头，是一个红色头发并且在袖子上纹有花纹的小矮子，他站了出来为你们想要什么。 你告诉他你想要这个商人的货物。这个领头开始大笑。%SPEECH_ON%哦是这样吗？ 我给你十秒钟的时间重新考虑这个选择，会给你们十秒钟的，所以快点杂种！%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们要拿回那些货物。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.HedgeKnight != null)
				{
					this.Options.push({
						Text = "你有什么要说的，%hedgeknight%？",
						function getResult( _event )
						{
							return "HedgeKnight";
						}

					});
				}

				this.Options.push({
					Text = "撤退，伙计们。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_97.png[/img]尽管你面前有一堆威胁着你的小鬼，但这些货物是被命令要带回去的。 这个带头指挥的小家伙与其说是拥有强烈攻击欲望的鹰倒不如说是一只只会嗷嗷叫等死的病猫。%SPEECH_ON%拿下他们！扔！扔！扔扔！%SPEECH_OFF%他的命令一被下达，树梢上的孩子们开始向你们投掷石头。 佣兵们聚集在一起，举起盾牌像一只乌龟一样，缓慢但是坚定的朝那群小鬼移动。 现场的状况变得相当滑稽，就像玩贝壳游戏的人把他的杯子往球上面罩过去一样，但最后团里面的人成功的拿到了商人的货物并且开始离开这块是非之地，期间还要小心来自四面八方的偷袭。 那个领头的小矮子向你挥舞着拳头。 而你回应了根指头然后回到那条来时的路上仔细地看了看商人的货物。%randombrother% 看着这份战利品尽管他的脑袋上被檫出了条伤痕。%SPEECH_ON%天哪，伙计。我见过的军队都没有这么凶猛。 我为将来不得不与这些少男少女们交锋的人默哀。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "从那些小混蛋手上拿到这些可真不容易。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Math.rand(50, 200);
				this.World.Assets.addMoney(item);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + item + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " 遭受 " + injury.getNameOnly()
							});
						}
						else
						{
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + "遭受轻伤"
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "HedgeKnight",
			Text = "[img]gfx/ui/events/event_35.png[/img]%hedgeknight% 走上前去并且举起他的武器。 他朝那群孩子挥舞了几下武器。%SPEECH_ON%唉，所以你想当小土匪或英雄还是一堆臭狗屎？ 好吧，这很好。没有问题。 但是我想看看谁会丢出第一块石头。 他，还是她，这样做的人会知道惹我生气是什么下场。 在你们其他人都看过之后，我会杀了你们很多人。 并且你们的脚印这么明显我会跟着它们回到你们的家，找到你们的亲人，砍下他们的脑袋。%SPEECH_OFF%这个野骑士怒目而视。%SPEECH_ON%所以，你们谁想投出第一块石头呢？%SPEECH_OFF%负责这群人的小伙子举起手然后说道。%SPEECH_ON%让这些人走。 我们有比和这些路人争吵更有意义的事情做。%SPEECH_OFF%嘿，那是明智之举。 有了像在这种情况能够隐忍的才智这个红头发的小鬼许有一天能够带领一个团队得到巨大的财富。 但今天这些还是你的。 你带上商人的货物转身离开。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "小刺头。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.Math.rand(50, 200);
				this.World.Assets.addMoney(item);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + item + "[/color] 克朗"
				});
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

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_hedgeknight = [];

		foreach( b in brothers )
		{
			if (b.getBackground().getID() == "background.hedge_knight")
			{
				candidates_hedgeknight.push(b);
			}
		}

		if (candidates_hedgeknight.len() != 0)
		{
			this.m.HedgeKnight = candidates_hedgeknight[this.Math.rand(0, candidates_hedgeknight.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hedgeknight",
			this.m.HedgeKnight != null ? this.m.HedgeKnight.getNameOnly() : ""
		]);
		_vars.push([
			"hedgeknighfull",
			this.m.HedgeKnight != null ? this.m.HedgeKnight.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.HedgeKnight = null;
	}

});

