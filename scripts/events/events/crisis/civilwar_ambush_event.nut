this.civilwar_ambush_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_ambush";
		this.m.Title = "在途中…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]森林隐藏着许多东西，它是掠食者和野蛮人的天然胜地。 但是你很清楚这一点，你知道如何在这种气候下发现最不自然的阴影。 你很快就意识到这里不仅仅是树，只要在灌木丛中猛击一下，你就能用弓把一个小男孩拉出来。 他大声呼救，增援部队随着最美妙的旋律如歌鸟般到来：十几个人从暗处冒了出来，但连队已经做好了准备，拔出武器，一字排开。\n\n 一位老人走上前来，举起双手。%SPEECH_ON%等等，这里没有暴力的必要。%SPEECH_OFF%他亲自来找你，用一种沉默的、学者般的语气解释发生的事情。 一小群农民正准备伏击随时会来的 %noblehouse% 的士兵。 他说，如果你帮忙，你会得到一份奖励。 如果不来帮忙，请让开。",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "让我们帮助这些农民吧。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们必须警告士兵们。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "我们没有时间做这些。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_10.png[/img]他们是农民，衣衫褴褛，看上去像是来这里找树叶穿衣服的。 但是这样脆弱的弓却有着坚硬的手，他们很擅长把箭射到他们找不到的目标上。 这些是森林里的人。 相信这次伏击会成功，你选择加入他们。\n\n 你没有等太久，就看到 %noblehouse% 的士兵开始往那边走。 他们吵闹，令人讨厌，有些人放屁，抱怨他们错误地吃了蘑菇。\n\n 一个大约只有你一半大小的孩子射了第一箭。 他的箭在两根树枝间划过，领头的侦察兵跪倒在地。 如狂风一样，看不见的箭矢飞进了士兵的纵队，他们的目标如此准确，以至于目标们悄无声息地死去。 一些士兵设法缩短了距离，举起了刀剑和盾牌，但是在这的 %companyname% 拦下了他们。 不一会儿，敌方队伍就全军覆没了。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "一切顺利。 我们把货物分了吧。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_87.png[/img]你的人和杂七杂八的杀人犯们一起去摸尸体。 一场关于谁该拿盾牌的混战爆发了。 你解释说盾牌存在的唯一原因是你的人上前杀死了它的主人。 农民头子点头同意你的观点。 他呼吁你的队伍应该把较重的装备拿走，因为你们的人对这些东西肯定使用起来更加熟练。\n\n 当你分配货物时，一个弓箭手走上前来。%SPEECH_ON%我想他们中有一个逃走了。 那里有脚印，但他一定比他死去的战友们聪明一点，因为他折了回来，把这些痕迹盖得很好。%SPEECH_OFF%就在你以为可以逍遥法外的时候…",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "除了那个逃走的人，一切都很顺利。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationOffense, "伏击了他们的一些人");
				this.World.Assets.addMoralReputation(-1);
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationFavor, "帮助伏击 " + _event.m.NobleHouse.getName());
				local item;
				local banner = _event.m.NobleHouse.getBanner();
				local r;
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/arming_sword");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/morning_star");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/military_pick");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/billhook");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				r = this.Math.rand(1, 4);

				if (r == 1)
				{
					item = this.new("scripts/items/shields/faction_wooden_shield");
					item.setFaction(banner);
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/shields/faction_kite_shield");
					item.setFaction(banner);
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/armor/mail_shirt");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/armor/basic_mail_shirt");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_94.png[/img]你告诉农民你不想参与他们的战争，但你没有置身事外。\n\n 一旦农民们走远了，你就找到了 %noblehouse% 的士兵并且把这些即将发生的麻烦告诉了他。 军官不会相信你，除非你把他带到农民那里，指出来，或者更确切地说，指出他们在这条或那条树枝后面鬼鬼祟祟地徘徊着的细长影子。\n\n 回到队伍中，你组织一次进攻。 很简单，你绕过埋伏然后从后面突袭。 老人、绝望的人和天真的男孩都被依次杀害。 他们没有预料到会发生这样的事，但在最混乱的时候，几乎可以肯定有人逃脱了，并且把你的背叛说了出去。 你从战场上收集了一些货物，并从 %noblehouse% 的手下那里收集了一些善意。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "所以当地人可能听说了这些事情，但又有什么关系？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationFavor, "救了他们的一些人");
				_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationOffense, "杀了一些他们的人");
				local money = this.Math.rand(200, 400);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local item;
				local r = this.Math.rand(1, 5);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/pitchfork");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/short_bow");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/hunting_bow");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/militia_spear");
				}
				else if (r == 5)
				{
					item = this.new("scripts/items/shields/wooden_shield");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();

		if (playerTile.Type != this.Const.World.TerrainType.Forest && playerTile.Type != this.Const.World.TerrainType.LeaveForest && playerTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() >= 3)
			{
				continue;
			}

			local d = playerTile.getDistanceTo(t.getTile());

			if (d < bestDistance)
			{
				bestDistance = d;
				bestTown = t;
			}
		}

		if (bestTown == null || bestDistance > 10)
		{
			return;
		}

		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local candidates = [];

		foreach( h in nobleHouses )
		{
			if (h.getID() != bestTown.getOwner().getID())
			{
				candidates.push(h);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.NobleHouse = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = bestTown;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
		_vars.push([
			"town",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
		this.m.Town = null;
	}

});

