this.anatomist_wants_skull_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Thief = null,
		Wildman = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_wants_skull";
		this.m.Title = "在路上...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_16.png[/img]{你来到一个偏远的村庄，发现一些村民蹲在一个装饰在讲台上的巨大漂白头骨前。路过的农民停下来信仰它。当你走近时，你意识到这颗头骨本身是非同寻常的: 一个长长的，厚厚的额头从上面伸出来，它的眉骨非常突出，有嵴状，而它的下颚在尚未破裂的情况下，拥有巨大而锋利的牙齿，其中大部分处于杂乱状态，就好像在任何普通的头部中，这样的嘴巴都会对它本身构成威胁。它很可能是一个Nachzehrer的头骨。当然，有了这个奇怪的骷髅前景，你希望能把队伍撤回去。-%SPEECH_ON%我们应该把它拿去研究一下。%SPEECH_OFF%你叹了口气，转身看见%anatomist%站在那里，盯着那颗头骨。你纠正他，说他真正想做的是偷它。解剖学家盯着你看。-%SPEECH_ON%词汇并不重要，当研究完毕，它们在我们手中的用处要比他们手中的好得多，这很清楚。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好的，拿去吧。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "我不这么认为。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Thief != null)
				{
					this.Options.push({
						Text = "这位小偷%thief%有什么话要说吗？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "那颗头骨看起来像我们的野人，%wildman%。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_46.png[/img]{叹息着，你同意了解剖学家的幻想，但告诉他如果他想研究，就要他自己去盗取。这个人毫不犹豫地离开了，眼睛瞪着他向科学幻想的骨头核心运动。如果他被抓住，你不会为混乱负责，所以你离开了，转而数清库存，同时保持耳朵听着宗教毁灭性的声音。几分钟后，%anatomist%回来了，一只肥胖的头骨托在臂弯间，他的额头上带着一点点汗水。%SPEECH_ON%这是一个Nachzehrer的头骨，应该对我们的研究有很大价值。%SPEECH_OFF%你好奇地问他是如何得到这个头骨的。%anatomist%扬了扬眉毛。%SPEECH_ON%你没有看吗？我认为这次尝试非常了不起，但遗憾的是如此了不起，我相信转述可能会让你容易相信我在编故事。一个寓言，如果你愿意。只知道我们应该尽快离开这里。可能比很快更快，比快更快。你明白吗？%SPEECH_OFF%远处传来喊叫声。解剖学家擦了擦汗，转身离开。他的衬衫后面被撕裂，身后还有小镖或箭头-远处的喊叫声越来越响。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Hmm.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "获得了一颗不寻常的颅骨进行研究。");
				_event.m.Anatomist.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Anatomist.getName() + "遭受轻伤"
				});
				local resolveBoost = this.Math.rand(1, 3);
				local initiativeBoost = this.Math.rand(1, 3);
				_event.m.Anatomist.getBaseProperties().Bravery += resolveBoost;
				_event.m.Anatomist.getBaseProperties().Initiative += initiativeBoost;
				_event.m.Anatomist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiativeBoost + "[/color] 主动性"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你告诉解剖学家%anatomist%他可以拿走那个头骨。他盯着你看了一会儿，然后说他以为你会去做这件事。你告诉他，你不会从当地崇拜那个头骨的农民那里拿走头骨。如果他想研究这个头骨，那就是他自己去偷。%anatomist%捧着胸口说： %SPEECH_ON%我是一位科学家，而不是一名普通的抄写员，我不能做如此肮脏低劣的事情。这需要一个有见识，了解日常生活的人来偷这个头骨。%SPEECH_OFF%解剖学家握紧了拳头，非常确定他的话没有侮辱到你。他的眼神充满坚定的凶猛气息，最多只能说是间接的。%SPEECH_ON%你这两个陌生人在说什么？%SPEECH_OFF%你和解剖学家都转身看到一个农民拿着一把干草叉。随着更多的人加入，他们向你们挥手。%SPEECH_ON%这些家伙打算偷头骨！%SPEECH_OFF%你伸出双手，解释说-在你说完之前，%anatomist%转身就跑。你迅速想到，称他为小偷，并承诺会砍掉他的脑袋，然后炫耀地拔出剑，向农民挥舞。你假装不小心掉了一袋克朗，把农民的怒火转化成了贪婪，给你足够的时间逃脱。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们离开这里。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-100);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]100[/color] 克朗"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_65.png[/img]{叹息着，你同意盗取这个头骨。在你能说出更多话之前，%thief%贼出现了。他嘴里嚼着草，神态嚣张地走过来。%SPEECH_ON%所以，你想偷点什么啊？只要指出你需要的东西，我就去拿回来给你。是黄金吗？武器？%SPEECH_OFF%%anatomist% 指向头骨。盗贼盯着它看了一会儿，然后转身离开。%SPEECH_ON%好的，嗯。%SPEECH_OFF%盗贼和想偷头骨的人离开了，你去数库存，给他们时间完成工作。后来，他拖着头骨回来，还带着一大堆武器和盔甲，你知道他并没有买。当你盯着显然是偷来的物品时，他耸耸肩。%SPEECH_ON%什么？我必须让它值得我的时间。%SPEECH_OFF%解剖学家拿走了头骨，没有说一句话，拿着头骨走了，眼睛直直地看着它空洞的眼窝，仿佛它是一个情人，喃喃自语，还能从它空洞的眼神中获得许多信息。盗贼也是一样，但他拿着装满克朗和其他好东西的包，自言自语，他终于可以同时支付两个妓女了，这显然是他长久以来的梦想。你拿着武器和盔甲去库存，远处你听到农民们为了那件文物而号啕大哭。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "胜利就是胜利。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "获得了一颗不寻常的颅骨进行研究。");
				_event.m.Thief.improveMood(1.0, "成功从农民那里盗取了物品。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				if (_event.m.Thief.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Thief.getMoodState()],
						text = _event.m.Thief.getName() + this.Const.MoodStateEvent[_event.m.Thief.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(100, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+100[/color] 经验值"
				});
				local initiativeBoost = this.Math.rand(2, 4);
				_event.m.Thief.getBaseProperties().Initiative += initiativeBoost;
				_event.m.Thief.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Thief.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiativeBoost + "[/color] 主动性"
				});
				local item;
				local weaponList = [
					"militia_spear",
					"militia_spear",
					"militia_spear",
					"shortsword",
					"falchion",
					"light_crossbow"
				];
				local itemAmount = this.Math.rand(1, 2);

				for( local i = 0; i < itemAmount; i = ++i )
				{
					item = this.new("scripts/items/weapons/" + weaponList[this.Math.rand(0, weaponList.len() - 1)]);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + item.getName()
					});
					this.World.Assets.getStash().add(item);
				}

				local armorList = [
					"leather_tunic",
					"leather_tunic",
					"thick_tunic",
					"thick_tunic",
					"padded_surcoat",
					"padded_leather"
				];
				itemAmount = this.Math.rand(1, 2);

				for( local i = 0; i < itemAmount; i = ++i )
				{
					item = this.new("scripts/items/armor/" + armorList[this.Math.rand(0, armorList.len() - 1)]);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + item.getName()
					});
					this.World.Assets.getStash().add(item);
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Thief.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你决定如果解剖学家能从这颗头骨中得到些什么重大用途，那么你会同意给他们一个机会来研究它。问题是如何从这么疯狂，甚至崇拜这颗头骨的群体中偷走这颗丑陋的头骨呢？就在这时，%wildman%那个野人出现了，他大口吞咽着一把蠕虫。他洗过的脸和形状残忍的头骨似乎与村庄中心讲台上的魔物几乎是一样的。%anatomist%啪的一声响了响手指，表示他有一个主意。他推着野人，两人径直走向村庄心爱的头骨。\n\n解剖学家把野人推到祈祷的群众前，声称他们谋杀了其表亲。他表示，通过偷走他的表亲的头骨，他们注定会受到诅咒的厄运。人群很震惊，没有意识到他们的错误。野人吃了另一只蠕虫。你继续观察，解剖学家拿起头骨，高高举起，说他最终可以治愈%wildman%身上的毛病，也可以消除村庄自身所遭受的任何诅咒。此时人群已经起立，像一个帐篷牧师一样向解剖学家走去，为他鼓掌。他们为盗窃欢呼，头骨高举过他的头。两个男人回到了你的身边。%anatomist%咧嘴笑了。%SPEECH_ON%研究身体时不应忘记研究心灵，在研究心灵时，不应忘记研究众多心灵！因为许多心灵组合在一起是一个特别值得研究的生物。%SPEECH_OFF%解剖学家离开了。一群农民拿着各种物品走过来向%wildman%道歉。野人又吃了一只蠕虫。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "获得了一颗不寻常的颅骨进行研究。");
				_event.m.Wildman.improveMood(1.0, "帮助了 (Helped)" + _event.m.Anatomist.getName() + "获得一颗不寻常的头骨");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				if (_event.m.Wildman.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Wildman.getMoodState()],
						text = _event.m.Wildman.getName() + this.Const.MoodStateEvent[_event.m.Wildman.getMoodState()]
					});
				}

				local initiativeBoost = this.Math.rand(1, 3);
				_event.m.Anatomist.getBaseProperties().Initiative += initiativeBoost;
				_event.m.Anatomist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiativeBoost + "[/color] 主动性"
				});
				_event.m.Wildman.addXP(75, false);
				_event.m.Wildman.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Wildman.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+75[/color] 经验值"
				});
				local food;
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					food = this.new("scripts/items/supplies/cured_venison_item");
				}
				else if (r == 2)
				{
					food = this.new("scripts/items/supplies/pickled_mushrooms_item");
				}
				else if (r == 3)
				{
					food = this.new("scripts/items/supplies/roots_and_berries_item");
				}

				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				local goods;
				r = this.Math.rand(1, 2);

				if (r == 1)
				{
					goods = this.new("scripts/items/trade/cloth_rolls_item");
				}
				else if (r == 2)
				{
					goods = this.new("scripts/items/trade/peat_bricks_item");
				}

				this.World.Assets.getStash().add(goods);
				this.List.push({
					id = 10,
					icon = "ui/items/" + goods.getIcon(),
					text = "你获得了" + goods.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Wildman.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local thief_candidates = [];
		local wildman_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.thief")
			{
				thief_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.wildman")
			{
				wildman_candidates.push(bro);
			}
		}

		if (thief_candidates.len() > 0)
		{
			this.m.Thief = thief_candidates[this.Math.rand(0, thief_candidates.len() - 1)];
		}

		if (wildman_candidates.len() > 0)
		{
			this.m.Wildman = wildman_candidates[this.Math.rand(0, wildman_candidates.len() - 1)];
		}

		if (anatomist_candidates.len() > 0)
		{
			this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		}
		else
		{
			return;
		}

		this.m.Score = 5 + anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getNameOnly() : ""
		]);
		_vars.push([
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Thief = null;
		this.m.Wildman = null;
	}

});

