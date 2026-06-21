this.wildman_testing_money_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null,
		OtherGuy = null,
		Item = null
	},
	function create()
	{
		this.m.ID = "event.wildman_testing_money";
		this.m.Title = "露营时…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_04.png[/img]你发现野人 %wildman% 把他的克朗堆成塔。 他嘴角微微向后一咧，突然间向前冲去，撞倒了塔就像一个小孩一样。 硬币散去的同时，发出大笑声。 一个大人像小孩一样玩钱真是太怪了。 也许那个野人不知道克朗的可爱之处？ 如果是这样，也许…也许你可以把它们拿回来？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看他是否愿意用这些换成别的东西。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "最好离那个野人和他的克朗远一点。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.getFlags().set("IsConceptionOfMoneyTested", true);
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_04.png[/img]你蹲下来。%SPEECH_ON%嗨，%wildman% 介意我拿一个吗？%SPEECH_OFF%你双眼盯着野人，小心翼翼地拿走一枚硬币。 他耸耸肩，咕噜着好像在说“它是你的”。 你拿走了另一枚克朗。然后再一枚。 那野人瞪着你，但是你缓缓从身后拿出一根绑着皱巴巴蝴蝶结的棍子。 野人的目光牢牢的被它吸引。 当他不由自主地伸出手去触碰棍子时，你缩回棍子，摇摇头。 你指了指那堆克朗，再指了指棍子。%SPEECH_ON%我一个换你一堆这很公平，你同意吗？%SPEECH_OFF%野人看了看那堆克朗精明的就像一个会计一样仔细思考，但是你知道他的内心要远比表现出来的混乱的多。 突然，他咆哮着把他的克朗往前一推，然后拿走棍子。 貌似交易结束了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一切顺利。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				local money = 10 * _event.m.Wildman.getDaysWithCompany();
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]你蹲下来看着那堆乱糟糟的克朗。%SPEECH_ON%这真美啊，哏？%SPEECH_OFF%野人哼了一下，想把你赶走。 你反抗了一下，并拿走了一枚克朗。 他松了松指骨，扭了扭脖子，发出嘎达噶达的声音。 怒视着你，慢慢地，你放下硬币，从身后拿出一根顶部缠有绳子的棍子。 野人的目光柔和下来，结实的棍子对于那个蓬头垢面的野人来说如此的精巧迷人。 你提议把它给他以换取克朗。 他拿走了棍子。 你拿走了克朗。\n\n 但当野人玩弄绳子时，它脱落了，并被风吹走。 他大声叫着，然后恶狠狠地盯着你，你站在那里，双手试图抓住所有的克朗。 野人在尖叫。你不得不把克朗放下，撒腿就跑。 你们身后发生了各种各样的混乱－工具和武器都被打破了，兄弟们都在逃命，被野人包围的一群可怜的人完全陷入了混乱－但是你们不敢看。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也许我们不该那么做。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.worsenMood(1.0, "做了一笔差劲的生意");

				if (_event.m.Wildman.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Wildman.getMoodState()],
						text = _event.m.Wildman.getName() + this.Const.MoodStateEvent[_event.m.Wildman.getMoodState()]
					});
				}

				local injury = _event.m.OtherGuy.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.OtherGuy.getName() + " 遭受 " + injury.getNameOnly()
				});

				if (_event.m.Item != null)
				{
					this.World.Assets.getStash().remove(_event.m.Item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + _event.m.Item.getIcon(),
						text = "你失去了 " + this.Const.Strings.getArticle(_event.m.Item.getName()) + _event.m.Item.getName()
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.wildman" && !bro.getFlags().get("IsConceptionOfMoneyTested"))
			{
				candidates.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		this.m.Wildman = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.OtherGuy = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates.len() * 3;
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

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Item = candidates[this.Math.rand(0, candidates.len() - 1)];
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.OtherGuy = null;
		this.m.Item = null;
	}

});

