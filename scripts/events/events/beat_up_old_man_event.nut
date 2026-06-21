this.beat_up_old_man_event <- this.inherit("scripts/events/event", {
	m = {
		AggroDude = null
	},
	function create()
	{
		this.m.ID = "event.beat_up_old_man";
		this.m.Title = "在路上…";
		this.m.Cooldown = 60 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_17.png[/img]{你碰到一个老人在路上蹒跚而行。 他靠在手杖上，等候你的来临。 他的眼睛是灰色的，但他歪着头，好像在用耳朵看你。%SPEECH_ON%裂缝的盔甲。沉重的步伐。稳定的呼吸。 越来越多的勇士在大陆上征战。%SPEECH_OFF%这个人直起身子，好像在说“我说得对吗？”。 你告诉他你不是来伤害他的。%SPEECH_ON%所以，是的，我是对的，和往常一样。 不过，给我讲讲也不会太麻烦。 我的听力正在消失，我想一旦它消失了，我也会消失的。%SPEECH_OFF%他停顿了一下，转过头去。%SPEECH_ON%你说了什么吗？%SPEECH_OFF%你注意到他瘦骨嶙峋的手指上戴着一枚精美的宝石戒指。%aggro_bro% 悄悄走近你。%SPEECH_ON%我们可以拿到它…你知道，就像从婴儿手里拿走蛋挞。 一个真正的瞎子比正常的婴儿更无助。%SPEECH_OFF% | 人们发现一位拄着拐杖的老人靠在石墙上。 他的手以似曾相识的方式抚摸着石头。 他凝视着你，骨瘦如柴的手指上戴着一枚闪闪发光的宝石戒指。%SPEECH_ON%晚上好，先生们。多好的天气啊，不是么？%SPEECH_OFF%仔细看他，你发现他是个瞎子。 | 你看到一位老人站在路中间，身体靠在拐杖上。 他抬头盯着一个路标。他摇了摇头。%SPEECH_ON%我知道这里有个路标。 我想 %randomtown% 在那条路上，如果我没记错的话。%SPEECH_OFF%他笑着转向你。 他因年老而双目失明，眼睛闪着白光。 他瘦骨嶙峋的手指上戴着一枚非常漂亮，非常昂贵的宝石戒指。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "祝旅途平安，老先生。",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "那个宝石戒指。交出来。",
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
			Text = "[img]gfx/ui/events/event_17.png[/img]{你走近那个老人。 他的头抬了起来。%SPEECH_ON%这是变快的步伐，陌生人，但我没有听到剑的声音，相反…%SPEECH_OFF%你猛地一推，把老人撞倒在地。 他紧握着手杖，手杖的末端向上翘着，仿佛要把自己刺进手杖的圆形尖端。 你把他的手踢开，踩在他的手腕上，弯下腰去拿戒指。%SPEECH_ON%当你这么干之时，把钢铁穿透我的心脏，你个混蛋！%SPEECH_OFF%你放开老人，把棍子还给他，甚至扶他站起来。%SPEECH_ON%别生气，老先生。%SPEECH_OFF% | 你把他打倒。 他呼噜呼噜地叫着，就好像你在一头怀孕的野猪身上踢了一脚。 他翻了个身，捂着肚子，问为什么，但你只会再踢他一脚，让他仰面躺下。 从那里你很容易就抢了他的珠宝戒指，然后离开。 | 那人咂咂他那老年人的嘴唇，那种令人作呕的干裂的声音。 作为回报，你后退一步并一拳打在他的肚子上。 老人没有看到拳头来了，就重重的吃了一击，呼出肺里的空气，滚了过去。 当他喘不过气来的时候，你把戒指从他手指上拿下来，然后离开。 | 那位老人靠在手杖上站着。 他抬起头。%SPEECH_ON%哼，沉默。这是陌生人之间的恶意声音。 我站在黑暗中，而你站在光明中，但我们会走向何方？%SPEECH_OFF%你把那人的拐杖踢了出去，他就一瘸一拐地倒在地上，骨瘦如柴的身体就像一间摇摇欲坠的小木屋。 他翻了个身，对男人之间的暴力行为表示赞同。 你朝他胸口踢了一脚，叫他闭嘴。 把戒指轻轻松松地从他的手指上取下，你离开了。 | 你掰指关节发出响声。 老人向后靠了靠。%SPEECH_ON%难道暴力能解决问题吗？ 这个世界不需要更多。%SPEECH_OFF%你一拳把他打倒在地，他瘫成一团。 拿起戒指，你回应道。%SPEECH_ON%我他妈不在乎这个世界需要什么或不需要什么。 我有我的世界，你有你的。 它们只是碰巧相遇，仅此而已。 你猜怎么着，老头？ 我的世界更大。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这就是人生。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
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
			if (!bro.getBackground().isOffendedByViolence() && !bro.getBackground().isNoble() || bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.brute"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.AggroDude = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"aggro_bro",
			this.m.AggroDude.getName()
		]);
	}

	function onClear()
	{
		this.m.AggroDude = null;
	}

});

