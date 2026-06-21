this.cannon_execution_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.cannon_execution";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_177.png[/img]{你遇到一个军人穿着的男人和一对衣着相似的卫兵。 在他们中间是一个手脚绑在巨大臼炮上的男人，他的躯干面向炮管，他的头靠在瞄具上。 他抬头用侧眼看向你。%SPEECH_ON%啊，旅行者。我这儿陷入了个不小的麻烦。 你看的出来，这些友善的，沉默绅士们想用这个我们时代的技术奇观来把我射出沙漠。 尽管这可以让我避开行刑者的锈剑，我必须坦白在最后时刻看着自己的身体轰炸沙漠生物是相当羞耻的。 对于某些罪行而言固然是合理的，但我只不过偷了点东西而已。%SPEECH_OFF%士兵装束的行刑者瞥向你，但就像那个贼说的意义，他看起来是个哑巴。 或者是聋子，如果去解读他臼炮手的工作是怎么来的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你究竟犯了什么罪？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "这与我们无关。",
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
			Text = "[img]gfx/ui/events/event_177.png[/img]{行刑者出人意料的回答了，一边用根手指掏着耳朵说道。%SPEECH_ON%逐币者，这与你无关。走开。%SPEECH_OFF%小偷再次试着扭动他的头。%SPEECH_ON%啊，啊！他会说话！太棒了。 让我们好好聊聊这件事，像或许有点超前我们时代的明事理的好先生们会做的那样。%SPEECH_OFF%行刑者无视了小偷花言巧语的请求。%SPEECH_ON%我会为你保持中立提出一个交易，逐币者。 当这个贼洒到沙漠上，你可以拿走他的任何东西，你懂得，他们说他有一颗金制的心。%SPEECH_OFF%小偷紧张的说道。%SPEECH_ON%这在我的家乡意味着别的含义。%SPEECH_OFF%你让行刑者解释。 他声称镀金者会“触碰”那些叛逆者，通过让他们的内脏变成金子来惩罚他们。 这样的惩罚比负债更高一层。 这挺起来很奇幻，就算对你而言。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那就继续行刑吧。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "你得停下这场行刑。",
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
			Text = "[img]gfx/ui/events/event_177.png[/img]{你对于行刑者的说法感兴趣，想看看他说的是真是假便站在了一边。小偷叹了口气。%SPEECH_ON%好。那么好吧。当他们记述我的时候，注明这不符合标准。 那是“标准”的拼法－%SPEECH_OFF%爆炸粉碎性的力量将一波沙尘从迫击炮上弹开了，射出一股血与沙的烟，在空中旋转好似一个风暴，过一会东西开始噼里啪啦的掉到地上。 这些零碎的东西没有一块是金的。 实际上，大部分要么焦黑要么亮红，暴露给这个世界。 行刑者从他脸上抹去火药。%SPEECH_ON%看来我们错了。 这个小偷会被镀金者亲自补偿的，哦，真幸运。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我猜就这样了吧。",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_177.png[/img]{你告诉卫兵和行刑者你要阻止这场行刑。 他们马上从臼炮边离开。 行刑者又开始掏耳朵了。%SPEECH_ON%暂缓执行？ 又或者你来说开始？%SPEECH_OFF%小偷紧张的笑道。%SPEECH_ON%是的，逐币者，帮我们这位朋友理清楚。%SPEECH_OFF%事态缓慢的平和了下来。 意外的，守卫们同意了。 他们并未将你视作一个随机干预者，而是镀金者的使徒，不然你怎么会在这里？ 小偷从装置上被解放出来并交给你的战队。 他伸出他的手。%SPEECH_ON%抛开所有有趣的事情，我会为你而战，呃，嗯… %companyname%。奇特而有趣。 但我不是个普通的小偷，我充满荣誉，使命感，当然还有对克朗的敏锐直觉！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入战队，我想。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们救了你。 这不意味着我们欢迎你。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"thief_southern_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "你恰到好处的干预，从 %name% 被巨大的臼炮射出去的命运中救下了他。 一个古怪的小偷，他最近一次在维齐尔宫殿里企图行窃的失败让他成了一个非常适合用来杀鸡儆猴的选项。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head));
				_event.m.Dude.worsenMood(1.0, "差点被一个技术奇迹以壮观的方式处决");
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
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
		this.m.Dude = null;
	}

});

