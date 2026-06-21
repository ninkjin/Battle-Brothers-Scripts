this.cultish_arrangement_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null
	},
	function create()
	{
		this.m.ID = "event.cultish_arrangement";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]{你翻过一个沙丘看到半打人。 他们穿着黑色的斗篷，并且他们藏入袖子里的手连起来组成了一个完整的圆圈。 尽管他们中的一个低着头，他们看起来都注意到你并转过头来看。 其中一个放开了他的手并走上前来。%SPEECH_ON%达库尔即将降临到我们，旅行者，即使镀金者的道路也在他的耐心之内。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们不会打扰你们。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Cultist != null)
				{
					this.Options.push({
						Text = "跟你的兄弟们谈谈信仰，%cultist%。",
						function getResult( _event )
						{
							return "C";
						}

					});
				}

				this.Options.push({
					Text = "杀了这些蠢货！",
					function getResult( _event )
					{
						return "B";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_12.png[/img]{你拔出你的剑并命令队伍快速解决这些异教徒。 他们坦然的接受了，异教徒甚至不举手抵抗他们自己的死亡。 一个幸存者任由伤口流血咳嗽了起来。 他伸出他的手好似要给你展示你的所作所为。%SPEECH_ON%你的一切努力都不能争取更多时间，佣兵。 达库尔即将降临到我们。%SPEECH_OFF%你拿出你的匕首了结了他。 你踢开他的尸体并搜刮了一番，尽管没找到什么有用的东西。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们走吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-2);
				local money = this.Math.rand(10, 100);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_03.png[/img]{%cultist% 走上前来，向所有陌生人们展示他饱受伤痕的头顶。 他们点着头伏下身，然后他们的头领看着沙子说道。%SPEECH_ON%达库尔说了。%SPEECH_OFF%点着头，%cultist% 回应道。%SPEECH_ON%还有我听到的每一个字。%SPEECH_OFF%头领不知道从哪里拿出一把奇怪的刀并划过他的手指。 他埋着头再次说道。%SPEECH_ON%那便遵从他。%SPEECH_OFF% %cultist% 拿走刀点了点头。%SPEECH_ON%达库尔即将降临到我们。%SPEECH_OFF%奇怪的人们倒在地上，脸埋入沙子。 他们的胸口上和下，颤抖，然后停滞。 他们把自己淹死到了沙漠中。%cultist% 转过身回来，身上带着一把诡异的匕首。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Alright...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				local item = this.new("scripts/items/weapons/oriental/qatal_dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
				_event.m.Cultist.improveMood(1.0, "在信仰上与兄弟们有了默契");

				if (_event.m.Cultist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_03.png[/img]{你低调的致敬并向这些黑袍人告别并继续前进。 他们没有阻止你，也没有任何回应。 你最后看到他们，他们又一次把手牵在一起，头顶着沙地轻声哼唱着什么。 视线中没有任何水或食物。 如果他们不是来到这里找死，又有什么可以救他们？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也许不是我们应该知道的。",
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

		if (this.World.getTime().Days < 10)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 7)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_cultist = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				candidates_cultist.push(bro);
			}
		}

		if (candidates_cultist.len() != 0)
		{
			this.m.Cultist = candidates_cultist[this.Math.rand(0, candidates_cultist.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
	}

});

