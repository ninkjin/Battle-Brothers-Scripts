this.tree_fort_event <- this.inherit("scripts/events/event", {
	m = {
		Witchhunter = null
	},
	function create()
	{
		this.m.ID = "event.tree_fort";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你发现一群孩子坐在一个树屋里。从小圆窗里透出锐利的目光，在木头堡垒周围，你可以看到已经准备好的弹弓。当你审视这座堡垒时，他们收起了绳梯，告诉你走开。你很好奇，想知道他们为什么会对一群几乎肯定会摧毁他们的人做出这样的反应，他们究竟拥有什么有价值的东西。\n\n因为孩子们容易受到压力，你询问他们是否隐藏了什么东西。其中一个做了个手淫的动作，让你滚开，而另一个孩子狠狠地打了他一拳，叫他闭嘴。这不像是藏着糖果或糕点的孩子的回答。他们肯定有一些有价值的东西藏在那里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "攻击这座堡垒！",
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
					Text = "我们没有时间做这个。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.Assets.getOrigin().getID() == "scenario.paladins")
				{
					this.Options.push({
						Text = "宣誓者!(Oathtakers)",
						function getResult( _event )
						{
							return "D";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你命令%companyname%攻打这座堡垒，无法在被岩石和弹弓威胁下爬上树干，你让士兵们搭起梯子、掏出自己的绳索。孩子们尖叫着，抛下棍棒和石头，给士兵们造成了不少疼痛，但他们骂你的话更伤人，比如说你是个观鸟者或者猪屎之类的。这些小鬼很毒，其中几个人还切断了士兵们攀爬时的绳索，导致更多的受伤。但最终雇佣军把孩子们赶了出来，扔掉他们并缴获了他们在树屋里积攒的武器。你把这些武器拿走了，让整座树屋和上面的树一起烧掉。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的孩子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local weapons = [
					"weapons/military_pick",
					"weapons/morning_star",
					"weapons/hand_axe",
					"weapons/reinforced_wooden_flail",
					"weapons/scramasax"
				];
				local item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
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

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你抬起两个手指，命令士兵们攻击树堡。孩子们用弹弓和石头回应。你假装石头不会像狗逼一样疼，告诉孩子们放弃。作为回应，他们称你为无能的傻瓜和脑残的阴谋家。这些话几乎和石头一样疼。\n\n突然，一群更多的孩子从相邻的树枝上加入战斗中，增援了树堡。这些家伙像海盗登上船般，涌过来。整个攻击变得一团糟，一些人抱怨整个事情太麻烦了，不值得继续下去。你想知道他们是不是只是担心自己的尊严。叹了口气，你命令停止攻击。孩子们嘲笑你，但事实就是这样的。%SPEECH_ON%他们可能什么都没有，不值得麻烦。%SPEECH_OFF%其中一个士兵说。尽管你不赞同，但也没有必要继续纠结。孩子们团结起来，发出刺耳的鸡鸣声，你们离开时被嘲笑。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那本来可以更好。",
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
					if (this.Math.rand(1, 100) <= 25)
					{
						if (this.Math.rand(1, 100) <= 50)
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_183.png[/img]{你拿起安瑟姆的头骨，高声宣扬年轻的安瑟姆，最初的守誓者的试炼和胜利。孩子们被你讲述的勇气和荣誉的故事所震撼，互相看着对方。最终，孩子们拿出了一件相当华丽的武器%SPEECH_ON%我们在池塘里找到的%SPEECH_OFF%另一个孩子推了一下另一个孩子%SPEECH_ON%不是的，是在一块石头里!记得吗，是我把它拔出来的!%SPEECH_OFF%孩子们争斗一段时间，但最终一个小女孩拿起武器，将它扔出了树屋的窗户。它的刃插入地面，钢铁随着弯曲而颤动。她嗤之以鼻。%SPEECH_ON%也许让别人拿走这个东西是最好的，他们只是为它争斗！%SPEECH_OFF%你握住剑柄，它发出钢铁之音，然后安静地结束。你从地上拔出剑来，感谢孩子们为守誓者的使命做出的贡献。孩子们互相看着。其中一个问另一个%SPEECH_ON%我们有某种目的吗？%SPEECH_OFF%}",
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
				local item = this.new("scripts/items/weapons/noble_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();
		local foundTown = false;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 2)
			{
				continue;
			}

			if (t.getTile().getDistanceTo(currentTile) <= 5)
			{
				foundTown = true;
				break;
			}
		}

		if (!foundTown)
		{
			return;
		}

		if (currentTile.HasRoad)
		{
			return;
		}

		this.m.Score = this.World.getTime().Days <= 25 ? 10 : 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

