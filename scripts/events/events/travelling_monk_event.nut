this.travelling_monk_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.travelling_monk";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A1",
			Text = "[img]gfx/ui/events/event_40.png[/img]你在路上遇到了一个僧侣，跟着他的是一个驴拉的车，那个可怜的拖着车的牲口低着头，无声而疲惫。 刚割完的金雀花杆和碧绿的苔藓挂在车的一侧，两者都在将它们烘干了的大风中大幅度地弯曲着，一些壶和盘子相互碰撞着，听起来就像乡巴佬的风铃，好像是些朴实的货物笨手笨脚地停停走走。 一个桶子在车板的边缘摇摇晃晃，一对蜜蜂摇动着来保持飞行，它们因极大的好奇心戳着桶的裂缝。\n\n僧侣把一顶羊毛帽从他的脸上拿起举高，但是帽檐直接叠进了他的眼睛里。 他马上把帽子全拿了下来，然后用袖子擦了擦他的眉毛。 带着惬意的微笑，他似乎一点也没被面前货真价实的盔甲人打扰到。%SPEECH_ON%晚上好先生们。不难看出你们并没有在一面贵族的旗帜下行军。 对我来说你们看起来像佣兵。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你带着什么？",
					function getResult( _event )
					{
						return "A2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "A2",
			Text = "[img]gfx/ui/events/event_40.png[/img]%SPEECH_ON%是，我已经想到你会问了。 这是贝西，一头母牛的名字，但我给了这头蠢驴。 别担心，她不会踢你的。 她很乖的，看到了吗？ 她带着什么，哦，那是啤酒。 这是给那边的人的，这样他们就可以和更多的人喝酒。 如果你不介意的话，或者你不在乎我的生意的话，我想继续向我该去的方向走了。%SPEECH_OFF%僧侣握紧了他的母驴的缰绳，他已经准备好要出发了。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "要来一轮啤酒得花多少钱？",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "B" : "D";
					}

				},
				{
					Text = "我们保护道路安全，这些是我们应得的－拿走啤酒，兄弟们！",
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
			Text = "[img]gfx/ui/events/event_40.png[/img]你举起了你的手，在僧侣再次上路之前拦下了他。 他叹了口气，慢慢地放下了手中的缰绳。 你感觉到他好像会错了你的意，因此你马上问他有没有些啤酒能够分给你的人。 你很乐意付钱。 僧侣回头看了看他的存货，然后转了过来。%SPEECH_ON%行。我给你的人一小口一克朗，或者两口一克朗。 别在意绕着顶上转悠的蜜蜂，你来的时候它们很快就会跑了，但是如果当它们跑了的时候你跑了，它们就会快速地追着你跑。奇怪的小家伙。%SPEECH_OFF%你问他他想要多少。%SPEECH_ON%我觉得一个人十克朗就够了。 虽然我不是商人，但是在这我自己也想获利。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "给整个战队都来一轮！",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "你要的太多了。",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_40.png[/img]你答应了给他付他要求的，他张开了双臂以示欢迎。 你的人掀开了酒桶的盖子，把他们的杯子伸了进去。 他们坐到了树荫下，抿着金属酒杯，并且交换着啤酒。 僧侣向你道了别并且祝你好运，所有的人都举起了他们的酒杯，向他进行了一个大声的，连续不断而含混不清的致意。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "干杯！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-10 * this.World.getPlayerRoster().getSize());
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + 10 * this.World.getPlayerRoster().getSize() + "[/color] 克朗"
					}
				];
				this.List.extend(_event.giveTraits(90));
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_40.png[/img]你举起了你的手，在僧侣再次上路之前拦下了他。 他叹了口气，慢慢地放下了手中的缰绳。 你感觉到他好像会错了你的意，因此你马上问他有没有些啤酒能够分给你的人。 你很乐意付钱。 僧侣回头看了看他的存货，然后转了过来。%SPEECH_ON%是啊。如果上帝不高兴我拿你的钱，那就去他的吧。 如果你打了一场好仗，那么我请你免费喝一些，但肯定不是全部。%SPEECH_OFF%你谢过了僧侣的慷慨，并且命令你的人喝的时候都诚实一点。 当几个兄弟围在桶边的时候，僧侣举起了他的手。%SPEECH_ON%别在意绕着顶上转悠的蜜蜂，你来的时候它们很快就会跑了，但是如果当它们跑了的时候你跑了，它们就会快速地追着你跑。奇怪的小家伙。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "干杯！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List = _event.giveTraits(90);
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_40.png[/img]当运货车摇晃着离开的时候，你握紧了你剑上的配重球，并且用它猛击啤酒桶，砸开了顶上的盖子，这让许多蜜蜂陷入了疯狂。 当僧侣回头看你的时候，他放开了缰绳。%SPEECH_ON%我就担心你会那样做。%SPEECH_OFF%他在被揍了一拳后消失了，他的身体在他掉到地面的时候扭成了一团。 当其他人举起了啤酒，并把它们带到阴凉地的时候几个兄弟蜂拥过去给了他结结实实一顿踢打。 你把一个马克杯伸进了酒桶以便于你喝酒，然后把它举向了在地上抽搐翻滚着的僧侣。%SPEECH_ON%喝光它们小伙子们，同时，别忘了谢谢我们那边慷慨的朋友！%SPEECH_OFF%僧侣翻倒过来，呲牙咧嘴，眼睛不停地眨着。 他用一只手捂着他的背，用另外一只手支持着他缓慢地站起来。 他以一个弯曲的姿势握上了驴的缰绳，开始向前走。 他尝试再带上他的帽子，但是帽子掉了下来，他并没有花时间管它。 他离得越来越远，因距离太远和酒精作用越发模糊不清，他走了。\n\n所有的人都举起了他们的酒杯，向你进行了一个大声的，连续不断而含混不清的致意。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "干杯！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-2);
				this.List = _event.giveTraits(66);
			}

		});
	}

	function giveTraits( _chance )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local result = [];

		foreach( bro in brothers )
		{
			if (this.Math.rand(1, 100) <= _chance)
			{
				bro.improveMood(1.0, "与战队一起庆祝");

				if (bro.getMoodState() >= this.Const.MoodState.Neutral)
				{
					result.push({
						id = 10,
						icon = this.Const.MoodStateIcon[bro.getMoodState()],
						text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
					});
				}
			}
		}

		return result;
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getMoney() <= 10 * this.World.getPlayerRoster().getSize() + 250)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Snow)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		this.m.Score = 8;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A1";
	}

	function onClear()
	{
	}

});

