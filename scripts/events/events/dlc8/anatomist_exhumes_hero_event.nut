this.anatomist_exhumes_hero_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Graver = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_exhumes_hero";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_20.png[/img]{你在%townname%听到一个当地的英雄最近去世了的消息。对你来说，这只是一条无聊的消息。如果你把他与级别高于捕鼠人的人物比较，那这个人或许甚至不是一个英雄，所以你并没有在意。当然，解剖学家们是另一种类型的人，他们像苍蝇闻到尸体味一样迅速，开始计划去掘开这位英雄的尸体，看看是什么让这位“英雄元素”不同于普通人。%anatomist%解释道。%SPEECH_ON% 英雄的尸体不仅仅是另一个尸体。它浸染着某种完全不同的东西，一种独特的动力让它与我们其他人不同。%SPEECH_OFF% 你见识过很多事情，所以你向解剖学家保证这具尸体看起来与其他任何尸体都差不多。但他们非常热衷于窥探一眼，即使这会冒犯民众。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好的，让我们去挖它。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "今天不准挖墓。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Graver != null)
				{
					this.Options.push({
						Text = "（%graver%），你在这里干嘛？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_46.png[/img]{在经过多次请求后，解剖学家们打败了你的防线并说服你前去从坟墓中取回当地英雄的尸体，据说他已经冷逝并且被塑造成英勇的样子。你们像一群不怀好意的孩子一样在墓地内逛荡，很快就会有许多潜行和偷偷摸摸的事情发生。英雄的墓碑很容易就被发现了，因为上面装饰着花朵和其他美好的东西。\n\n%anatomist%将鲜花踢开，推开一个孩子的玩具，将它扔到墓地对面。他快速地将铲子钉在地上，开始挖掘。没有多长时间，这块土壤就被搅动了。一些物品散落在坟墓里，而在它们的旁边就是尸体本身：一位普普通通的男子，面色苍白。它被拽了起来，像一块胶合板一样被解剖学家们翻来覆去地抛出，当它掉在草地上时，他们像小鬼一样追赶着它，带着令人不安的热情剖开它。当他们完成时，他们将尸体滚回墓里，它的形状比之前更加破烂不堪。他们抱怨你也许是正确的，一个英雄的尸体没有任何不寻常的地方。但他们不想同意像一个没受过教育的佣兵那样的人，相反，他们认为也许他根本不是一位英雄，他们需要继续寻找。你只是庆幸自己没有被抓住。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "恶心。 让我们离开这里。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.anatomist")
					{
						bro.improveMood(1.0, "需要检查一位英雄的尸体。");
						bro.worsenMood(0.5, "被误导了关于该具尸体的特殊之处");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}

						bro.addXP(150, false);
						bro.updateLevel();
						this.List.push({
							id = 16,
							icon = "ui/icons/xp_received.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+150[/color] 经验值"
						});
					}
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_141.png[/img]{经过一番讨价还价，解剖学家击破你微薄的防线，你同意前去墓地取回当地英雄的尸体。在你向墓地踱步的过程中，他们像一群毫无意义的孩子一样进行了大量的潜行和偷偷摸摸。你到达墓地，询问他们是否知道英雄的名字。%anatomist%说他认为是个讽刺的名字，名叫莫蒂默。\n\n你发现了这样一个名字的坟墓，开始挖掘，但当你到达底部时，你只发现一只死猫，蜷缩在那里，灰色的、腐朽的，身上的虫子比毛发还多。解剖学家们把它举了起来，然后有人从树林中尖叫了起来。你转身看到那里有一个哭泣的小男孩，他指着坟墓。在你抓住他之前，他扭头跑开，高喊着你们的冒险行为是错误的。作为回应，一群人的低语声传来，他们的话在狂热中被淹没了，但你还是能听出%companyname%的名字和一群草叉中混杂着的喧闹声。你转身告诉解剖学家停止挖掘，只见他们已经半路逃离墓地，拼命地逃命。你恶语相向，加入了他们的不名誉的撤退，一起离开了镇子。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他们把我引入了一些麻烦之中……",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationMinorOffense, "你的战团因盗墓被捕。");
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "你与" + f.getName() + "受到了影响。"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.anatomist")
					{
						bro.worsenMood(0.75, "无法挖掘出一具不寻常的尸体");

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

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_46.png[/img]{%graver% 突然来到你身边，墓地守护者把一个肮脏的拇指压在他的胸口上。%SPEECH_ON%想挖掘尸体吗？我是你的人。%SPEECH_OFF%有了他的专业知识，你决定跟随解剖学家可怕的计划。你找到了墓地，并开始寻找英雄的坟墓。整个地方都是穷人区，但你最终找到了一个带有鲜花和装饰的标记，而这些人劣等地践踏和踢飞了这些鲜花。很快就开始了地基的工作，有了 %graver% 的帮助，尸体被挖掘出来，速度惊人。解剖学家们开始对这具尸体进行工作，在尸体上弯腰低头，私语细语，他们卷曲、披着斗篷的姿态像秃鹫一样。%graver% 在这个坟墓中四处搜索，并在一个角落里找到了一件武器。考虑到所有的事情，这是一个不错的发现，几乎让所有的事情都值得。当你转身看着解剖学家把尸体踢回坟墓里时，英雄的脸死死的盯着这个扰乱土地的地方，眼睛睁开了。每个人都得到了自己需要的东西，你很快离开这个地方，以免当地人出现并把你追杀到底。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.anatomist")
					{
						bro.improveMood(1.0, "得检查一位英雄不寻常的尸体。");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}

						bro.addXP(150, false);
						bro.updateLevel();
						this.List.push({
							id = 16,
							icon = "ui/icons/xp_received.png",
							text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+150[/color] 经验值"
						});
					}
				}

				_event.m.Graver.improveMood(1.0, "运用他挖墓的技能。");

				if (_event.m.Graver.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Graver.getMoodState()],
						text = _event.m.Graver.getName() + this.Const.MoodStateEvent[_event.m.Graver.getMoodState()]
					});
				}

				local weaponList = [
					"arming_sword",
					"hand_axe",
					"military_pick",
					"boar_spear"
				];
				local item = this.new("scripts/items/weapons/" + weaponList[this.Math.rand(0, weaponList.len() - 1)]);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Graver.getImagePath());
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
		local graver_candidates = [];
		local anatomist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.graverobber")
			{
				graver_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
		}

		if (graver_candidates.len() > 0)
		{
			this.m.Graver = graver_candidates[this.Math.rand(0, graver_candidates.len() - 1)];
		}

		if (anatomist_candidates.len() > 1)
		{
			this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		}
		else
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 10 + anatomist_candidates.len();
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
			"graver",
			this.m.Graver != null ? this.m.Graver.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Graver = null;
		this.m.Town = null;
	}

});

