this.addict_steals_potion_event <- this.inherit("scripts/events/event", {
	m = {
		Addict = null,
		Other = null,
		Item = null
	},
	function create()
	{
		this.m.ID = "event.addict_steals_potion";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你去查看库存，却发现%addict%半垂不挂地躺在一个桶里，四肢悬在桶外，他的肚子上收集了许多小瓶。他用昏暗、红肿的眼睛盯着你，抱着他的眼窝，就像所有的血液都涌到那里一样。你问他到底发生了什么，%addict%只是微笑着说。%SPEECH_ON%做吧，队长，做你必须做的事情。因为我已经赢了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我只希望你能及时康复。",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "现在需要停止，%addict%。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 33 ? "C" : "D";
					}

				},
				{
					Text = "够了。我要把这个该死的恶魔从你身上赶出来！",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Item.getIcon(),
					text = "你失去了 " + this.Const.Strings.getArticle(_event.m.Item.getName()) + _event.m.Item.getName()
				});
				local items = this.World.Assets.getStash().getItems();

				foreach( i, item in items )
				{
					if (item == null)
					{
						continue;
					}

					if (item.getID() == _event.m.Item.getID())
					{
						items[i] = null;
						break;
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_38.png[/img]{你们把%addict%带到了一个临时的鞭刑柱前。他瘫软地躺在木头上，手指张开，不停地拧动着。他的眼神像在追逐蝴蝶，当%otherbrother%用鞭子抽打他时，他带着茫然的表情。\n\n起初，鞭打似乎无济于事，即使鞭子呼啸着抽在他的背上，也只残留了一道道红斑。但几次抽打之后，他渐渐清醒，开始尖叫。你扭过头问他是否愿意戒毒，他急忙点头。你让他再次挨鞭子，然后问他同样的问题，他再次点头。又来一轮的鞭打、问题和回答，这样不断重复着，直到他崩溃，不管以前的烦恼如何，都已经不复存在。}",
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
				this.Characters.push(_event.m.Addict.getImagePath());
				_event.m.Addict.addLightInjury();
				this.List = [
					{
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Addict.getName() + "受到损伤"
					}
				];
				_event.m.Addict.getSkills().removeByID("trait.addict");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_29.png",
					text = _event.m.Addict.getName() + "不再上瘾"
				});
				_event.m.Addict.worsenMood(2.5, "被你命令鞭打了");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Addict.getMoodState()],
					text = _event.m.Addict.getName() + this.Const.MoodStateEvent[_event.m.Addict.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Addict.getID())
					{
						continue;
					}

					if (!bro.getBackground().isOffendedByViolence() || bro.getLevel() >= 7)
					{
						continue;
					}

					bro.worsenMood(1.0, "我对你下达的命令感到愤怒。" + _event.m.Addict.getName() + "鞭打");

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
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你从酒桶里拉出%addict%并将他摔倒在地。他在那里摇摇晃晃，好像大地是一道楼梯，他向下看到顶层。%SPEECH_ON%喂，先生，小心点，下面的路越来越陡峭了！%SPEECH_OFF%起初，你想踢他的屁股，但最终放弃了。你蹲下来坐在他旁边，等着他翻身仰望云霄。时间过去了一会儿，%addict%闭上嘴唇，你能看到他的眼睛恢复了清明。%SPEECH_ON%我有问题，先生。%SPEECH_OFF%你点了点头，告诉他要减少药剂的使用量，因为你无法信任他在这种状态下。如果他对当卖剑手有问题，如果这就是他变成这样的原因，那没关系，但这确实是一个问题。他再次闭上嘴唇点头。%SPEECH_ON%谢谢你，先生。我会尽力解决自己的问题，把事情理顺的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "说得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				_event.m.Addict.getSkills().removeByID("trait.addict");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_62.png",
					text = _event.m.Addict.getName() + "不再上瘾"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你将%addict%从桶里拖了出来，把他摔到了地上。他在那里摇摇晃晃，仿佛地球是一架楼梯，他正在看着上面的悬崖。%SPEECH_ON%喂，先生，小心点，这只是往下，一直往下！%SPEECH_OFF%一开始你想踢他的屁股，但还是放弃了。你蹲下身子，坐在那个人旁边，他翻了个身，看着云彩。过了一会儿，他转过头来。%SPEECH_ON%你要帮我？%SPEECH_OFF%你点了点头，说你是的，但%addict%只是微笑着摇了摇头。%SPEECH_ON%我不是在和你说话，我是在和你说话！%SPEECH_OFF%他指着你身后的桶，当你回头看的时候，那个人已经站起来向前冲了过去。%SPEECH_ON%这个胖老头想跟我搞聪明啊！%SPEECH_OFF%佣兵扑向桶，它从上到下裂开了，里面的一些物品散落开来并碎了。几个佣兵跑过来把这个人带走，与此同时，你正在数着失去了什么。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Goddammit.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				local items = this.World.Assets.getStash().getItems();
				local candidates = [];

				foreach( i, item in items )
				{
					if (item == null || item.isItemType(this.Const.Items.ItemType.Legendary) || item.isItemType(this.Const.Items.ItemType.Named))
					{
						continue;
					}

					if (item.isItemType(this.Const.Items.ItemType.Misc))
					{
						candidates.push(i);
					}
				}

				if (candidates.len() != 0)
				{
					local i = candidates[this.Math.rand(0, candidates.len() - 1)];
					this.List.push({
						id = 10,
						icon = "ui/items/" + items[i].getIcon(),
						text = "你失去了 " + items[i].getName()
					});
					items[i] = null;
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_addict = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.addict"))
			{
				candidates_addict.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.player"))
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_addict.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		local items = this.World.Assets.getStash().getItems();
		local candidates_items = [];

		foreach( item in items )
		{
			if (item == null)
			{
				continue;
			}

			if (item.getID() == "misc.potion_of_knowledge" || item.getID() == "misc.antidote" || item.getID() == "misc.snake_oil" || item.getID() == "accessory.recovery_potion" || item.getID() == "accessory.iron_will_potion" || item.getID() == "accessory.berserker_mushrooms" || item.getID() == "accessory.cat_potion" || item.getID() == "accessory.lionheart_potion" || item.getID() == "accessory.night_vision_elixir")
			{
				candidates_items.push(item);
			}
		}

		if (candidates_items.len() == 0)
		{
			return;
		}

		this.m.Addict = candidates_addict[this.Math.rand(0, candidates_addict.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Item = candidates_items[this.Math.rand(0, candidates_items.len() - 1)];
		this.m.Score = candidates_addict.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"addict",
			this.m.Addict.getName()
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
		_vars.push([
			"item",
			this.Const.Strings.getArticle(this.m.Item.getName()) + this.m.Item.getName()
		]);
	}

	function onClear()
	{
		this.m.Addict = null;
		this.m.Other = null;
		this.m.Item = null;
	}

});

