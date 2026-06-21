this.deserter_in_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.deserter_in_forest";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]在穿越森林时，突然看到一大群鸟惊慌飞散，枝叶发出哗啦啦的声响。紧跟着，一个浑身泥土的人从灌木丛中钻了出来，似乎而不同于赤裸裸的人类，他恳求你给他藏匿。%SPEECH_ON%听着，我坦白交代。我是个叛逃者。没错，我没有啥辩解。但是，你们呢？雇佣兵？太棒了！你们把我藏起来，我会一直支持你们的！%SPEECH_OFF%在他恳求的过程中，你听到远处传来了犬吠声。那人本能地躲进树丛一个洞穴，并用泥土迅速将自己覆盖。他点头示意你们已达成协议。\n\n赏金猎人已经进入树林，它们的犬已经开始搜寻。他们的中尉环顾四周。%SPEECH_ON%别想骗我，雇佣兵。我知道那个叛逃者经过这里。只要你帮我找到他的头颅，我就给你200克朗。他在哪儿？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他在那里，抓住他。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "什么？谁？哪里？",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]你吐了口吐沫并摇了摇头。%SPEECH_ON%我他妈一点都不知道你在说什么，赏金猎人。%SPEECH_OFF%军官盯着你，用老成持重的方式盯着你。%SPEECH_ON%好吧，雇佣兵。就这样吧。 我知道你在撒谎，但我也无能为力。%SPEECH_OFF%赏金猎人吹了一声尖锐的口哨，命令他的队伍前进。 狗对着逃跑者藏着的树屋一个劲地吠叫。 大笑着，军官嘲讽地祝你一切顺利。\n\n 赏金猎人走了，逃兵出现了。%SPEECH_ON%谢谢你，雇佣兵。我欠你一条命！ 你不会后悔的，永远不会！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我最好不会因此后悔。 欢迎加入战队。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "继续逃亡吧。我们不能收留一个逃兵。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"deserter_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "你发现逃兵 %name% 在森林里被追赶。 尽管赏金猎人们对他很感兴趣，但你还是选择了保护他，为此他向你宣誓。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_25.png[/img]你向逃兵藏匿的地方点头。 那个逃兵一定是用一只不信任的眼睛盯着你，因为他马上跳出洞去逃跑了。 几条狗毫不费力地把他追了下来，凶猛地扑向他，把他尖叫着捂着屁股倒在地上。 你还没来得及笑，赏金猎人就把一包克朗放在你的手掌里。%SPEECH_ON%那是我应得赏金的一半，但是如果没有你在这里，我不确定我们会不会抓到那个狡猾的混蛋。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是我应该做的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(200);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]200[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.deserter")
					{
						bro.worsenMood(0.5, "你把逃兵交给了赏金猎人");

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
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		this.m.Score = 10;
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

