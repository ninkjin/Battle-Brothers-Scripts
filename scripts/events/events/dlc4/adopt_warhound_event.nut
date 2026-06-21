this.adopt_warhound_event <- this.inherit("scripts/events/event", {
	m = {
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.adopt_warhound";
		this.m.Title = "在途中…";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你碰到一个死火山口，在它的底部你发现几只羊用鼻子摩擦着什么东西。 当你走近时，你看到那里有一只巨大的猎犬，它的皮毛上沾满了鲜血，项圈被撕碎了，爪子上的指甲已经断了。 它对你发出一声咆哮，但没坚持多久它就垂下头，发出一声疲惫的呼噜声，也许它撑不了多久了。 羊走了，在他们后面，你看见一个人倚在岩石上。 他的胸部被撕开了，杀死他的东西用如此大的力量把他的内脏扯了出来，散落在岩石上。 沿着这条路走下去，你发现一个巨型食尸鬼，他的喉咙被撕开了。%randombrother% 点头。%SPEECH_ON%我觉得这条狗值得被收留到战队。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他会很适合我们的。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Houndmaster != null)
				{
					this.Options.push({
						Text = "%houndman%,，你以前处理过猎犬，是吗？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "给他个痛快的吧，让它从痛苦中解脱。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{你把手伸向那只猎犬，它抬起头来看着你，仿佛你是另一个威胁。 它黑色的眼睛从长而杂乱的鬃毛上凝视着，鬃毛上还滴着血。 绵羊见识过这只野兽的造成的杀戮，一边紧张刨着蹄子，一边注视着你。 但你不会被吓倒。 你伸出手，掌心后仰，那只疲倦的狗慢慢地俯下身来。你点头。%SPEECH_ON%还有更多战斗需要你呢，朋友。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我以后叫你“勇士”。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/warhound_item");
				item.m.Name = "勇士战猎犬";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%terrainImage%{你想带走那只猎犬，但当你蹲下时，一只羊叫着冲过来，把你撞倒了。 队员们哈哈大笑，当你跪下来的时候，另一只羊从后面把你压扁了，欢呼声此起彼伏。 拔出你的剑会发出一种使羊逃跑的尖锐的声音。 当你回头看那只猎犬时，它的鼻子落上了灰尘，眼睛暗淡了。 它已经死了，羊群慢慢地聚集在它周围，咩咩叫着。 你把你的剑套在鞘上，告诉大家继续前进。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "勇敢的小家伙。",
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
			Text = "%terrainImage%{%houndman% 走上前去。%SPEECH_ON%我知道这个品种。 它是北方的一种家畜，一种健壮的动物。 在它身上有一样东西是值得尊敬的，那就是它的力量。%SPEECH_OFF%佣兵在狗狗面前蹲下，不停地用手掐住狗狗脖子上的伤痕，开始抓挠。 尽管动作很突然，狗还是做出了积极的反应，当他停止抓挠时，狗就会从地上站起来，向前跑，跟在他后面。%houndman% 盯着你，重重的爱抚着狗。%SPEECH_ON%是的，他会为我们而战。 战斗是他的使命。 他只是需要有人看着他撕咬和流泪。%SPEECH_OFF%这是一个多么可爱的动物啊。 而且这只狗也很好。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们以后就叫他“勇士”吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/warhound_item");
				item.m.Name = "勇士战猎犬";
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.7)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.houndmaster" || bro.getBackground().getID() == "background.barbarian")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"houndman",
			this.m.Houndmaster != null ? this.m.Houndmaster.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Houndmaster = null;
	}

});

