this.gunpowder_wagon_event <- this.inherit("scripts/events/event", {
	m = {
		Bought = 0
	},
	function create()
	{
		this.m.ID = "event.gunpowder_wagon";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_171.png[/img]{一列骆驼出现在视野中。它们的两侧摇晃着数十个书包和背包，还有一把大伞高高举起。骆驼由一个马夫掌控，他骑在最前面的骆驼上，一个老人侧坐在马鞍上，一只脚在马镫里，另一只脚平衡着一盘食物。他正在吃坚果和浆果，享受着冷饮。他看到你并不烦恼。%SPEECH_ON%皇室子民，是吧？我可以看出来从你们的趾高气扬，你们那个骄傲自大的炼金师。将原本的黄金转化成他人血液中的铜。我不会瞧不起你们，皇室子民，你们也不要将我看作是匪徒心中的猎物，我知道这种念头在你们的心中悄然滋生。%SPEECH_OFF%他拿起一根有着黑痕的棍子，他的拇指压在上面。%SPEECH_ON%我运送的是维齐尔用于制造不同战争机器的硝酸盐。你知道的，没有了这种重要成分，大铸铁炮弹飞不远也不能高。我的骆驼的每个袋子里都装满了这种粉末。如果你敢认为自己是有勇气的强盗，我会点燃我的货物，让我们都一起发光到让至高无上的吉尔德本人也要闭上双眼。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你表述的很清楚。 有什么东西卖吗？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们不会打扰你的旅行的。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_171.png[/img]{商人咧嘴一笑。%SPEECH_ON%我很高兴你问这个问题，因为我确实有时候对跟维齐尔羽毛插满的制服打交道。 那些黑卫兵和马屁精。%SPEECH_OFF%他打了个响指用父亲般的诚意指向你。%SPEECH_ON%对话会很快变成闲谈。 像我父亲过去说的，做生意就像唱民谣。 而我们所有人都在这无聊的生活中需要点诗词。%SPEECH_OFF%他点头并用一种你知道的他用来跟他的商人同行的语气说道。%SPEECH_ON%我跟维齐尔定了个时间，但是被抢劫或丢点东西也是可以接受的。 在这之上，我确实有东西可以提供，如果我们都同意，这些东西将会被“偷走”，费用由你承担。 但你只能有着其中的一个：一杆只要2500克朗的手炮，或一根只要500克朗的火矛。 你只能从两个中选一个。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们要2500克朗的手炮。",
					function getResult( _event )
					{
						_event.m.Bought = 1;
						return "C";
					}

				},
				{
					Text = "当然是500克朗的火矛。",
					function getResult( _event )
					{
						_event.m.Bought = 2;
						return "C";
					}

				},
				{
					Text = "这个价格我没有兴趣。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_171.png[/img]{你和商人就商品达成一致意见。 在你们交换完硬币和货物后，他回到他的骆驼上并向你蹭了蹭鼻子。%SPEECH_ON%我对于被偷东西很难受，这真是一个糟糕的一天。 麻烦了，维齐尔将会跟我现在一样悲伤。%SPEECH_OFF%商人再次侧坐在马鞍上开始吃他的浆果和坚果。 他没有拿起他的缰绳，而骆驼们看起来就好像受到指令一般。%SPEECH_ON%愿你的道路金光闪耀，逐币者，也愿我被偷走的货物提供给你所追寻的光辉。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也愿你找到你的光辉。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				switch(_event.m.Bought)
				{
				case 1:
					local item = this.new("scripts/items/weapons/oriental/handgonne");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					item = this.new("scripts/items/ammo/powder_bag");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					this.World.Assets.addMoney(-2500);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]2500[/color] 克朗"
					});
					break;

				case 2:
					local item = this.new("scripts/items/weapons/oriental/firelance");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
					this.World.Assets.addMoney(-500);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] 克朗"
					});
					break;
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_171.png[/img]{商人将他的手张开好似你在打劫他。%SPEECH_ON%你不想要我的货物并不重要，真的。%SPEECH_OFF%他将腿盘起再次侧坐在马鞍上然后骆驼们马上开始了移动好似这就是他们的指令一般。 商人一边吃坚果和浆果一边说。%SPEECH_ON%愿你的道路金光闪耀，逐币者，也愿这篇沙漠的维齐尔让你派上好用场。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我也这么希望。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_171.png[/img]{你点头并祝他旅途顺利。他鞠躬回应道。%SPEECH_ON%愿你的道路金光闪耀，逐币者。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你也是。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.FactionManager.isHolyWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills && currentTile.Type != this.Const.World.TerrainType.Oasis)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 2500)
		{
			return;
		}

		if (this.World.Assets.getStash().getNumberOfEmptySlots() < 1)
		{
			return;
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Bought = 0;
	}

});

