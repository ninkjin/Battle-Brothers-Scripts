this.oracle_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.oracle";
		this.m.Title = "在路上…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_11.png[/img]{在路边你看到一顶山羊皮帐篷。兽皮帐篷已经被浸泡在紫色染料中，并且新鲜的雏菊扭在交织的山羊毛结上。一位驼背老妇人站在帐篷外，双手交叉垂在身旁，用枯萎的眼睛打量着你。%SPEECH_ON%啊，一个雇佣兵。不，是一个雇佣兵的队长。或者更高等的角色。你身上有异样的气味，不仅仅是男人的气味。你想算一下你的命运吗？%SPEECH_OFF% 她朝帐篷里面比划。你看到一排长长的牌面朝下横放在桌子上。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "告诉我我的命运，老太婆。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 20 && this.World.getTime().Days > 15)
						{
							return "D";
						}
						else if (r <= 80)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				},
				{
					Text = "我会告诉你的：你要把你所有的贵重物品都给我们。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 50)
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
					Text = "不，我们没事。",
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
			ID = "B",
			Text = "[img]gfx/ui/events/event_11.png[/img]{像这样的读卡器可能已经做了很多生意，足以让你忍不住想把它拿走。你命令战团搜索这个地方。女人没有说什么，当你把她搬开的时候，她也没有说什么，当雇佣兵们涌入她的帐篷，把它倾斜在地上时，她微笑了一下。他们像魔术师一样揭开了山羊皮布，看到了赃物，却像发现了失败的魔术一样失望。他们开始搜查她的东西，蹂躏、摧毁一些对他们没有用的东西。老巫婆耸了耸肩，从袖子里拿出两张牌。%SPEECH_ON%告诉我，雇佣兵，你看到了什么？%SPEECH_OFF%你看了看。塔罗牌描绘了一群骑士正在抢劫一座村庄，另一张牌则是一个墓地，由一个非常严厉的守卫守卫着。你耸了耸肩，告诉她她为这两张牌而保留着，正如你不是一个容易被路上可怜巴巴的老巫婆愚弄的傻瓜。你告诉她，她也许嚇到了几个抢劫犯，但你并不容易被骗。她笑了。%SPEECH_ON%你既聪明又残忍。%SPEECH_OFF%你说得没错。现在让我们看看战团找到了什么。}",
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
				this.World.Assets.addMoralReputation(-1);
				local money = this.Math.rand(75, 200);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_11.png[/img]{你环顾四周，如果有某个老巫婆伏击等着你的话，你肯定什么都看不到。你挥了一下手，让战团搜查她的藏身之处。几名兄弟溜进她的帐篷，开始翻找，翻桌子，拉抽屉。老妇人退到了一边，然后继续退，一边退一边...在笑？%SPEECH_ON%看看这个东西！%SPEECH_OFF%你转过身去，看到其中一名佣兵拿着一颗悬挂在帐篷天花板上的珠子。他把它拽了下来。链子突然绷紧，弹了出来，同时传来一声金属的断裂声。蓝色的电芒顺着链子呼啸而上，飞到了珠子上。你没听到声音。帐篷在一片蓝色的火焰中炸开，旗杆冲过了天际，佣兵们的剪影笨拙地从火烟中走出。灰色而燃烧的雏菊在空中扭曲。你捂住耳朵，等待听力恢复，然后看看老妇人在哪里，但她已经不见了。皱着嘴唇，你赶紧查看造成了什么样的伤害。}",
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
				this.World.Assets.addMoralReputation(-1);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_11.png[/img]{当你走进帐篷，帐篷就闭上了。一盏灯笼发出橙色的光芒。瘦弱的老婆子倚在烛台上，用烛台把灯光照亮，照到了桌子和两把椅子。她朝着桌子做了一个手势。%SPEECH_ON%坐下。%SPEECH_OFF%你坐了下来，她也坐了下来。她咂着嘴唇，嚼动着没有牙齿的牙龈，点点头，开始洗牌。%SPEECH_ON%先是这张牌...%SPEECH_OFF%你向前靠了一下，想看得更仔细，结果当你的重量落在桌子上的时候，桌子断裂了。牌飞舞着，老婆子向后倒去，烛光四溅。你一只手接住了烛台，一只手冲过去扶助了老婆子。你让她重新坐下，把烛台还给她。她看着你，露出了一丝黑边的笑容，眯起眼睛看着你。%SPEECH_ON%我们就假装没发生过什么，然后说你得到了你一直想要的，雇佣兵，从这里开始。%SPEECH_OFF% 她亲了你一下，并拿匕首的把手戳了你一下。%SPEECH_ON%发牌！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "多漂亮的女人啊。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/named/named_dagger");
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_11.png[/img]{你迈步走进帐篷，一个不安的%randombrother%在折叠的帐篷收口外望。老妇人点燃蜡烛，拿到她的位置上。讽刺的是，在黑暗中，她古老的身形更加凸显了，因为阴影发现了你从未意识到人身上可能会存在的缝隙，她的皮肤充满着永久的闪电。她立刻翻牌并开始占卜。%SPEECH_ON%失败。猜测。怀疑。%SPEECH_OFF%手绘的骑士上下前后进出，他们的肢体扭曲成奇怪的姿势。%SPEECH_ON%更多的失败，但也有胜利。许多胜利。你忘记了脆弱，你对它的传染性感到厌倦。你变得强大，实现自我保护。你老了。你死了。%SPEECH_OFF%你皱眉看着最后一张牌并将它推到了光线下。你看到一个留着长长灰胡子的男人坐在一个椅子上。你告诉这位妇人你从未真正长出胡子，她就吹灭了蜡烛并把你撵出了帐篷。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我应该停止刮胡子。",
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
			ID = "F",
			Text = "[img]gfx/ui/events/event_11.png[/img]{你迈进帐篷，布料合拢，一片黑暗。你站了一会儿，询问女巫去了哪里。你撅起嘴，掀起帐帘，想要点亮些许光明。一缕光线从黑暗中射出，你回身看见匕首正向你飞来。你戴着的护手护住自己，并拔出剑刺向女巫的胸膛。她扔掉了刀子，抓住了你的肩膀。%SPEECH_ON%像你这样残忍的佣兵，竟杀了一个单纯的老太婆。你们都会死的，你和你的手下。%SPEECH_OFF%你让女巫靠近，突然看见了她邪恶的猫眼。你吐了口唾沫并点了点头。%SPEECH_ON%在世间万物都会死去的前景下预言恶兆？这份工作可不难。你知道我的工作是什么吗，女巫？%SPEECH_OFF%女巫露出了满嘴的黑汁般的笑容。黑血从她的嘴角喷溅出来。%SPEECH_ON%哦，佣兵！等达库尔拿到你的时候，我们就会看你是什么德行了！%SPEECH_OFF%女巫的身子变得松弛，你的剑直接从她胸口穿过，留下了你脚旁的切割的肌肉。你迅速退出帐篷，将整个帐篷烧毁。一些人发誓他们在烟雾中看到了女巫的面容在咧嘴。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "烧死这个女巫！",
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.SnowyForest)
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
	}

});

