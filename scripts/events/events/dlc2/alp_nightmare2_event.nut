this.alp_nightmare2_event <- this.inherit("scripts/events/event", {
	m = {
		Addict = null,
		Other = null,
		Item = null
	},
	function create()
	{
		this.m.ID = "event.alp_nightmare2";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
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
						return "E";
					}

				},
				{
					Text = "现在需要停止，%addict%。",
					function getResult( _event )
					{
						return "D";
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
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_38.png[/img]{你们把%addict%押到了临时的鞭刑柱边。他无力地倚靠在木头上，指尖散开着，还不停地捏着和握着。他看起来像在追蝴蝶，当%otherbrother%用鞭子狠狠地抽打他时，他带着那种缺席的神情。\n\n起初，鞭打没有任何效果，即使它扫过那人的背部，留下了新月形的血痕。但几次鞭打之后，他清醒了过来开始尖叫。你走过去面对他，问他是否愿意戒掉他的瘾。他急忙点头。你让他再次挨鞭子，并再次询问。他又点点头。再一次的鞭打，再一次的问题，再一次的答案。最后，%otherbrother%收紧鞭子，将它卷起来。%SPEECH_ON%他死了，长官。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "什么？让我看看！",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				this.Characters.push(_event.m.Other.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Addict.getName() + "是死了"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Addict.getID() || bro.getID() == _event.m.Other.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						continue;
					}

					local mood = this.Math.rand(0, 1);
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[mood],
						text = bro.getName() + this.Const.MoodStateEvent[mood]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_39.png[/img]{你冲上前去，想抬起那个人的头，只发现那是一只系在长矛上的陶罐。退后一步，你撞到了%addict%，他正在整理库存。%SPEECH_ON%队长，你还好吧？%SPEECH_OFF%你点点头，询问他药水的存货情况。他笑了笑%。%SPEECH_ON%已经全都统计清楚了。我要再数一遍吗？%SPEECH_OFF%你叫他去数其他的东西，然后去帐篷里喝一杯。转身时，一道苍白的身影从箱子边上飘了出来。你拔出剑，追了过去，只发现是一张在风中飘荡的布片。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可能我只是需要休息。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_39.png[/img]{你将%addict%从木桶里拉出来，将他扔到地上。他迅速翻了个身，用清晰的声音喊道%SPEECH_ON%队长，你怎么了？%SPEECH_OFF%这不是%addict%，而是%otherbrother%。当你转身时，你看到%addict%在磨刀。一个苍白的身影在远处移动，但当你眨眼时，它就消失了。你让%otherbrother%站起来，并告诉他要小心强盗。他恭敬地点点头，可能感觉到你有点不对劲，也可能不想因一个错误而与你对抗。你回到帐篷里喝酒。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也许我该睡觉了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你让那个人走了，但是当你转过身去的时候，你听到了玻璃破裂的声音和那个人的喉咙发出的咕噜声。你回过头来，发现%addict%弯下腰，脖子上挂着绞肉机，正在从露出来的喉咙里挑玻璃。你冲过去帮他止血，手感受到他的喉咙像一条搁浅的鱼一样撮动。那个人倒在了地上，他沉重的，死去的身体压在你身上。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我应该采取行动…",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Addict.getName() + "是死了"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Addict.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 66)
					{
						continue;
					}

					local mood = this.Math.rand(0, 1);
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[mood],
						text = bro.getName() + this.Const.MoodStateEvent[mood]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_39.png[/img]{你低下头，感到非常惭愧，回想起以前关心旧神的日子。当你抬起头时，你发现自己的手指伸进一袋谷物里，里面的东西洒了一地。%SPEECH_ON%嘿，队长，我们得好好利用这些。%SPEECH_OFF%向那边看去，你看见了 %addict% 和一个白色的影子站在他身后。你冲起来，但在所有的纷乱中，那个影子已经消失了。你找不到任何踪迹，也不想再吓唬 %addict%，于是告诉佣兵要注意周围的情况。你自己回帐篷喝一杯。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可能会喝两三杯。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days < 20)
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
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.addict"))
			{
				candidates_addict.push(bro);
			}
			else
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
		this.m.Score = 10;
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

