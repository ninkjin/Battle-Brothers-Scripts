this.black_market_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Price = 0,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.black_market";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_01.png[/img]{%townname%的水果车堆满了各种美味但严重超价的食物。你瞟了车主一眼，试图趁他不注意的时候悄悄地偷点东西。就在你准备偷偷拿走时，解剖学家%anatomist%匆忙赶来，吸引了所有人的注意力。你放下了小偷念头，问他想干什么。他笑了。%SPEECH_ON%我们找到了%townname%的黑市。%SPEECH_OFF%你走到那里，找到一个瘦小的人靠在椅子上。桌子前是一堆“商品”，如果可以这么说的话。对你来说，它看起来像一堆不明显的垃圾，但对解剖学家来说，这可能像是来自古老神灵的礼物。瘦小的人打了个哈欠，让你随便挑。%anatomist%凑近一看，评估了这些商品，最终发现有三个的质量值得怀疑，而且用途也不明。他警告说，也许战团只应该购买一个。%SPEECH_ON%如果城镇警卫发现我们有太多东西，他们可能会把我们和小贩搞混，而出售这些商品是相当的犯罪行为。%SPEECH_OFF%你看了看这些选择。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们出100克朗买那个看起来像脑子的东西。",
					function getResult( _event )
					{
						_event.m.Price = 100;
						return this.Math.rand(1, 100) <= 85 ? "Brain" : "Bunk";
					}

				},
				{
					Text = "我要买这个大心脏……克朗550，对吗？",
					function getResult( _event )
					{
						_event.m.Price = 550;
						return this.Math.rand(1, 100) <= 95 ? "Heart" : "Bunk";
					}

				},
				{
					Text = "我会为那个……某种腺体支付200克朗吗？",
					function getResult( _event )
					{
						_event.m.Price = 200;
						return this.Math.rand(1, 100) <= 90 ? "Gland" : "Bunk";
					}

				},
				{
					Text = "我们不能承受这种放纵。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Brain",
			Text = "[img]gfx/ui/events/event_14.png[/img]{你购买了一块看起来像块压缩面条的东西，坚韧的细绳上灰色和黑点斑驳，柔软的质地。相当恶心，%anatomist%整个手掌放在物质上，并按下。当他把手拿开时，手印还在，肉会弹出并再次形成。他微笑着说。%SPEECH_ON%我相信我们可以在我们的研究中大量利用这个东西。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "恶心，但可以。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "获得了一个有前途的研究样本。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(200, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				this.World.Assets.addMoney(-_event.m.Price);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Price + "[/color] 克朗"
				});
				local part = this.new("scripts/items/misc/ghoul_brain_item");
				this.World.Assets.getStash().add(part);
				this.List.push({
					id = 10,
					icon = "ui/items/" + part.getIcon(),
					text = "你获得了" + part.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Heart",
			Text = "[img]gfx/ui/events/event_14.png[/img]{需要一个手推车才能搬运这个巨大的器官。 %anatomist% 声称这是一只巨怪的心脏，是研究的宝贵标本。手推车被降下来，你们两个一起看着它，你身为一个没有受过教育的外行人看着这个令人不快和让人想吐的东西，而解剖学家作为一个没有受过专业训练的外行人却在看着一个令人不快和令人着迷的东西。令你不安的是，一个如此巨大的器官竟然位于野兽的核心。人类的心脏虽小，但却充满了统治一切的火力和决心。然而这颗心脏...\n\n令人不安的是， %anatomist% 握紧拳头猛地砸向心脏的一个腔室。你可以看到肌肉移动，看起来像曾经跳动和搏动的样子。他抽回手来，看着那里的污垢：黑色的组织和一层模糊不清的霉菌或血液或腐烂的血液。%SPEECH_ON%我们的研究将从这个标本中获益匪浅。%SPEECH_OFF%他看着你，仿佛在征求确认。你看着那个沉重的手推车，告诉他如果这是他的标本，那么他的脊柱就会因为搬这个该死的东西而断裂。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "记住，膝盖要弯曲。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "获得了一个有前途的研究样本。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(200, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				this.World.Assets.addMoney(-_event.m.Price);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Price + "[/color] 克朗"
				});
				local part = this.new("scripts/items/misc/unhold_heart_item");
				this.World.Assets.getStash().add(part);
				this.List.push({
					id = 10,
					icon = "ui/items/" + part.getIcon(),
					text = "你获得了" + part.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Gland",
			Text = "[img]gfx/ui/events/event_14.png[/img]{在你看来，这个器官就像是灰色荚草翻腾交织而成。灰色的块状物一遍又一遍地穿梭过这个器官，并且在肌肉因运动而弯曲和扭动的同时也在持续地收缩和扩张。在这些波动的末端，是一个肥状的组织。%anatomist%解释道。%SPEECH_ON% 大家相信, 这是赐予魔狼如此多能量的器官。甚至它的形状都带有一种凶猛的结构，好像器官本身就意味着要复制它的作用一样。%SPEECH_OFF% 他切开组织并将其拉回，显露出一个肉质隧道和通道的网状结构，最终到达一个奇怪的多个空腔的组合体。无法确认一个人可以利用这个部分做什么，但当%anatomist%开始在洞口摸索，你很快离开了，只是警告他不要在公开场合这样做，以免引起平民们的愤怒。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "修剪一下你的指甲。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "获得了一个有前途的研究样本。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(200, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				this.World.Assets.addMoney(-_event.m.Price);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Price + "[/color] 克朗"
				});
				local part = this.new("scripts/items/misc/adrenaline_gland_item");
				this.World.Assets.getStash().add(part);
				this.List.push({
					id = 10,
					icon = "ui/items/" + part.getIcon(),
					text = "你获得了" + part.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Bunk",
			Text = "[img]gfx/ui/events/event_14.png[/img]{当你回到战团时，%anatomist%似乎对购买感到有些失望。他试图从中分离出一些有用的东西，也许是之前没有人看到过的，但他的冒险似乎最终毫无结果。他抱怨说自己已经了解这些部分了，它们已经被写过了，其他人已经因为这些发现而成名。你边吃东西边点头听着，当他用悲伤的眼神看着你时假装关心他说:%SPEECH_ON%这种物质是兽人吃的，有时候是兽人身上割下来的。我们已经知道这些年了。我曾想从中学到一些新的东西，但我的自负只导致了克朗的浪费。%SPEECH_OFF%你舀一勺鸡粒放进嘴里，拿起勺子盯着扭曲的倒影点头说:%SPEECH_ON%这一切都很迷人。现在，你尝过了吗？%SPEECH_OFF%解剖学家注视着奇怪的肉。他承认他不认为有人尝试过，至少不是用于研究的。他在沉思一会儿。他喃喃自语道:%SPEECH_ON%这将是一个科学问题，不是吗？%SPEECH_OFF%你又拿起一块肉咬下去。 %anatomist%伸手将拉出一根滴着湿漉漉的肉的肋骨，突然干呕起来，迅速起身跑开了。你拿起奇怪的肋骨扔到桌子上，当它碰到地面时，几只野狗从一个巷子里涌出来互相争夺着。你指着狗在解剖学家跑开后喊道:%SPEECH_ON%嘿，我想我刚刚做了一个实验！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "看他们为此而战。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(0.5, "一个有希望的研究样本结果被证明是无用的。");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.World.Assets.addMoney(-_event.m.Price);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.Price + "[/color] 克朗"
				});
				local food = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins || !this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		if (this.World.Assets.getMoney() < 650)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
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
		local anatomistCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Price = 0;
		this.m.Town = null;
	}

});

