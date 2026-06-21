this.minstrel_writes_song_event <- this.inherit("scripts/events/event", {
	m = {
		Minstrel = null,
		OtherBrother = null
	},
	function create()
	{
		this.m.ID = "event.minstrel_writes_song";
		this.m.Title = "露营时…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]{%minstrel% 拿起一把鲁特琴。 你不知道他是从哪里搞到这个东西，但是很快他拨响了琴弦，吸引团队里面其他人的注意力。 他抬起头，闭上眼睛，并且开始大声唱起来。%SPEECH_ON%我…－弹琴声－…因为已经没有钱了，所以我加入了一个雇佣军…－弹琴声－…他们想要一个能够持剑的人，但我却只会唱歌。结束。%SPEECH_OFF%在这个傻瓜把鲁特琴给扔过肩膀之后团队里面的人开始哈哈大笑。 | %minstrel% 这个吟游诗人突然凭空拿出一把鲁特琴就像魔术师变兔子一样。 他很熟练的弹出一段旋律，然后开始唱歌。%SPEECH_ON%从前有一个怪物恐怖的统治着美丽的瑞根…－弹琴声－…他们叫它，如果我没有记错，一个真正的问题…－弹琴声弹琴声－…\n\n这个怪物只会吃那些可爱的小姐，但是没错它只会吃那些依然可口的处女！…－激昂的弹琴声－…但是很明显没有人愿意一直这样下去，不管是对女人还是男人来说，这是一个荒唐的命运！…－简略的弹琴声，另起一段新的旋律－…\n\n 所以他们雇佣了加里科克爵士，这片土地上剑会的最好的人…－轻快节奏弹琴声－…于是他挨家挨户地敲门，征服每一个作为好剑客能够征服的处女！…－狂乱的节拍后，一段悲伤的旋律－…最后，这个怪物饿死了。结束。%SPEECH_OFF% | 随着火苗噼啪作响人们无聊的对坐在火边，%minstrel% 这个吟游诗人清了清嗓子用最好的声音说道“大家听着。” 他马上站了起来，并且举起他的手就像拿着杯啤酒向谁具备一样。%SPEECH_ON%啊哈，你们算是我至今为止见过的最好的男人。 我这么说是因为我从未见过我的父亲并且我把我所有的时间都花在对付那群母狐狸身上。%SPEECH_OFF%他久久凝视着远方思考着什么。%SPEECH_ON%该死的，我跟太多女人呆在一起记不清有多少。%SPEECH_OFF%然后他就坐了下来。 场面突然变得非常安静但马上在场的所有人都开始大笑起来。 | %minstrel% 正在寻找他的鲁特琴。 由于找不到那个东西，没有办法他只好拿出“空气鲁特琴”，还用大拇指拨了几下弦。%SPEECH_ON%等一下，这个听起来有点不太对劲，让我来调一下。%SPEECH_OFF%他举起手舒展了一下手指，又弹了一段。%SPEECH_ON%我是听到地狱的声音？这个比第一次还要糟糕。 稍等一下，我马上解决它，我保证。%SPEECH_OFF%他又试了试，但是似乎这次“演奏”并没有任何好转。%SPEECH_ON%跟狗屎一起下地狱吧！%SPEECH_OFF%乐师跳了起来反复地把看不见的鲁特琴摔在地上然后把它扔进高高的草丛里。 他擦去额头上的汗水。%SPEECH_ON%你是对的，我亲爱的父亲，我应该老老实实当一名铁匠。%SPEECH_OFF%说完他怒气冲冲地走了身后传来一阵哄堂大笑。 | 在把泥土丢到篝火里面为了把火熄灭的时候，%minstrel% 不断的说话，说的都是一些让人不理解的话。%SPEECH_ON%那古老的神明说要有光，不是吗？这是他们做的第一件事，所以明亮的光线肯定是最重要的。%SPEECH_OFF%他抓起了一块泥土并且似乎在分析它。%SPEECH_ON%那么，为什么在一个女人最黑暗的地方能找到这么多快乐呢？%SPEECH_OFF%一开始大家还不太理解但马上在场的所有人都开始大笑。 | %minstrel% 这个吟游诗人站了起来并且把靴子并在一起。%SPEECH_ON%要不要我教你们这些傻瓜怎么跳舞？%SPEECH_OFF%有几个人看了他一下然后马上摇头。%SPEECH_ON%噢，来吧。这个很简单。你们看。%SPEECH_OFF%吟游诗人抬起他的腿，腿弯曲出一个正常人站在地面上时做不到的角度。 他旋转着，并且将手臂举过自己的头顶。 然后他张开双臂好像要飞翔。 这个确实看上去相当的优美，尽管你不会向任何活着的灵魂承认这个就是了。 你看着吟游诗人继续表演，身体前倾突然他朝 %otherbrother%的脸上放了一个可怕的屁。\n\n %minstrel% 立刻挺直了腰板，他那坏掉的背随着那可怕的屁的排出重新变好了并且生效的相当快。%SPEECH_ON%我，呃…好吧，就这些了！ 所以希望你们能够完整的把这些动作做出来！%SPEECH_OFF%他转身就跑，身后追着一个脸色铁青浑身臭气熏天的人。 其余的人笑得前仰后合。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好哇！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Minstrel.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(1.0, "感到愉快");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_minstrel = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.minstrel")
			{
				candidates_minstrel.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_minstrel.len() == 0)
		{
			return;
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		this.m.OtherBrother = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates_minstrel.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"minstrel",
			this.m.Minstrel.getNameOnly()
		]);
		_vars.push([
			"otherbrother",
			this.m.OtherBrother.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Minstrel = null;
		this.m.OtherBrother = null;
	}

});

