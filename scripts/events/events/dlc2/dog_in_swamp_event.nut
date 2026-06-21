this.dog_in_swamp_event <- this.inherit("scripts/events/event", {
	m = {
		Helper = null,
		Houndmaster = null,
		Beastslayer = null
	},
	function create()
	{
		this.m.ID = "event.dog_in_swamp";
		this.m.Title = "在途中…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_09.png[/img]一声刺耳的尖叫声打破了沼泽地的寂静。你匆忙前去，发现一名男子在水中挣扎，他的手臂缠绕着葛藤。水中泡沫和气泡不断涌起，一只狗的口鼻短暂地出现，它在那一秒中尖叫着求救，而不是为任何稍纵即逝的生命延续而呼吸。看到你，那只狗的主人喊道。%SPEECH_ON%救救我的狗！有东西抓住了它！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这不是我们的事。",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "伙计们，我们得帮帮那条狗！",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 60)
						{
							return "GoodEnding";
						}
						else
						{
							return "BadEnding";
						}
					}

				}
			],
			function start( _event )
			{
				local stash = this.World.Assets.getStash().getItems();
				local net = false;

				foreach( item in stash )
				{
					if (item != null && item.getID() == "tool.throwing_net")
					{
						net = true;
						break;
					}
				}

				if (net)
				{
					this.Options.push({
						Text = "也许我可以用我们的网来救那条狗。",
						function getResult( _event )
						{
							return "Net";
						}

					});
				}

				if (_event.m.Houndmaster != null)
				{
					this.Options.push({
						Text = "也许我们的驯兽师能帮忙？",
						function getResult( _event )
						{
							return "Houndmaster";
						}

					});
				}

				if (_event.m.Beastslayer != null)
				{
					this.Options.push({
						Text = "%beastslayer%，你习惯与野兽打交道。 知道这是什么吗？",
						function getResult( _event )
						{
							return "BeastSlayer";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "GoodEnding",
			Text = "[img]gfx/ui/events/event_09.png[/img]%helpbro%伸出手臂，左右晃动，像拧开桶盖的样子迈入沼泽水中。他高高举起武器，狗的主人紧张地看着。一个得意的笑容浮现在佣兵的脸上。%SPEECH_ON%抓住你了！%SPEECH_OFF%他刺穿了沼泽的水并捕获了一条比你见过的任何一条蛇都长的蛇，这条蛇的长度在他手中晃动着，就像一根有价值的彩绳。主人想去抓狗，但它从他的手中溜了出去，就像他的手臂是另一条蛇，它向你的身边奔去。你问他这是否是他的狗。他点了点头，然后缓慢地摇了摇头。%SPEECH_ON%我想现在这只狗是你的了。它是个战士，但如果不是一只狗屎游泳者的话，它什么都不是。就算你把这条蛇留给我，我也算看作是个公平交易吧。%SPEECH_OFF%你点点头，完成了交易，让%helpbro%交出他的新战利品。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我想我会给你起名的…游泳者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Helper.getImagePath());
				local item = this.new("scripts/items/accessory/wardog_item");
				item.m.Name = "游泳者(Swimmer)";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "BadEnding",
			Text = "[img]gfx/ui/events/event_09.png[/img]%helpbro%来到海岸线并拔出武器。他像一位披着麦芽酒的圣徒一样走进泥潭，避免人们认出他的脸。他艰难地挣扎着，最终跌倒在那只狗上面，随后消失在冒着泡沫的战场上。你赶到他的身边，并将他拖上岸。他浑身上下沾满了青苔，靴子上缠着睡莲，他一边咳嗽着肮脏的沼泽水，一边拣出发酵它的盐水。狗的身影不见了，只剩下微小的水波荡漾。看着有点不安，兄弟的主人点了点头。%SPEECH_ON%感谢你的帮助，但事情就是这样。沼泽会处理这些事情，因为它就是一个沼泽，我真的想让这个地理奇观变成荒地，以抵销它的恶性。%SPEECH_OFF%你抬起眉毛问他是否住在沼泽中。他深呼吸一口气，点点头。%SPEECH_ON%是的，没有租金。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，那是一种欺骗的行为。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Helper.getImagePath());
				_event.m.Helper.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Helper.getName() + "遭受轻伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "Houndmaster",
			Text = "[img]gfx/ui/events/event_09.png[/img]%houndmaster% 兽猎大师冲上前去，但沼泽中的狗就这样停了下来。这个男人滑进水里摸索。他的手紧紧握住，盯着那个陌生人。%SPEECH_ON%我内心深处是个狗管理员。这意味着我训练他们不会陷入这么大的麻烦。但是我从来不需要训练一只狗提防这个沼泽，这意味着这个混蛋把他扔进去了，对吗？%SPEECH_OFF%陌生人的第一句话就是借口，所以兽猎大师痛打他。陌生人双腿生生地向后剪刀踢，裤子松了下来，在他的抽屉里掉出了各种宝藏。可恶的傻瓜是个宝藏猎人！%houndmaster% 拉出武器，准备谋杀这个人。陌生人尖叫着踢掉裤子，朝沼泽森林跑去，半裸着像被鬼魂控制的麻袋一样。你笑着蹲下来，寻找离去者的物品，其中并不都是闪亮的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真可惜。 多大的收获啊！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/loot/silverware_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "BeastSlayer",
			Text = "[img]gfx/ui/events/event_09.png[/img]屠兽者%beastslayer%点了点头，走向沼泽。他冷静地来到激荡的水面上，站在上面，眼睛从左到右跟踪着，好像在看着清澈水中的鲤鱼一样。最后，他拿出一把餐刀，猛砍水中。再一次。又一次。那只狗浮出水面，喘着气。屠兽者再次刺了一下，这次狗跑了，穿过你的腿，湿漉漉地趴在那里哭泣。%beastslayer%握着什么东西，然后放开了，无论它是什么，在沼泽中潜行，水纹在它后面荡漾。%SPEECH_ON%只是一条蛇，队长。%SPEECH_OFF%屠兽者抬起脚，踢出水面，他脚趾骑着一只闪闪发光的高脚杯，一脸蔑视地看着沼泽上的陌生人。%SPEECH_ON%你的懦弱使你成为了一个怪物，财宝猎人，一个会用狗代替自己双手的野蛮人。你没有在这些沼泽中的道理。等我转身时，你最好走开，知道吗？%SPEECH_OFF%屠兽者把高脚杯递给了你，陌生人毫不拖延地撤退了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beastslayer.getImagePath());
				local item = this.new("scripts/items/accessory/wardog_item");
				item.m.Name = "游泳者(Swimmer)";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/loot/golden_chalice_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Net",
			Text = "[img]gfx/ui/events/event_09.png[/img]你从库存中拿出一张网将其投向那只狗。尽管狗在拼命挣扎，网的边缘却像孩子慢慢捉住一个紧张的苍蝇一样，渐渐地沉入泥潭。几个雇佣兵加入了你的队伍，走进泥潭，拉紧绳子，然后将网拖上岸。狗的腿四处乱晃，即使是在生死存亡的情况下，它也呆滞地看着，有一种惭愧的狗的表情。无论是什么抓住了这只狗，似乎已经意识到危险，放开了它。你看着一根滑溜溜的绿色绳子展开，然后潜入水中，最终在微小的涟漪中消失了。\n\n%randombrother% 注意到这只狗的身材匀称和顺从的态度。确实，它似乎已经不受死亡的影响，友好地吠叫着作为证据。你告诉陌生人这只狗现在是战团的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我想我会给你起名的…游泳者。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/wardog_item");
				item.m.Name = "游泳者(Swimmer)";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "tool.throwing_net")
					{
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						stash[i] = null;
						break;
					}
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Swamp)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_houndmaster = [];
		local candidates_beastslayer = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.houndmaster")
			{
				candidates_houndmaster.push(bro);
			}
			else if (bro.getBackground().getID() == "background.beast_slayer")
			{
				candidates_beastslayer.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.player"))
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Helper = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_houndmaster.len() != 0)
		{
			this.m.Houndmaster = candidates_houndmaster[this.Math.rand(0, candidates_houndmaster.len() - 1)];
		}

		if (candidates_beastslayer.len() != 0)
		{
			this.m.Beastslayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"helpbro",
			this.m.Helper.getNameOnly()
		]);
		_vars.push([
			"houndmaster",
			this.m.Houndmaster ? this.m.Houndmaster.getNameOnly() : ""
		]);
		_vars.push([
			"beastslayer",
			this.m.Beastslayer ? this.m.Beastslayer.getNameOnly() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Helper = null;
		this.m.Houndmaster = null;
		this.m.Beastslayer = null;
	}

});

