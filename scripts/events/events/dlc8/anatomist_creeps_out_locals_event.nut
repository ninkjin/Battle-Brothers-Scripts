this.anatomist_creeps_out_locals_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_creeps_out_locals";
		this.m.Title = "在途中…";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{尽管周围村民和商贩的喧闹声不断，%anatomist%(解剖学家)却翻开了一本解剖学的书籍，专注地阅读内容。尽管当地的农民可能看不懂这些文字，但他却可以看到页面上画的恶心图片：揭开身体内部的细节、标识身体部位。这些似乎是百姓无法理解的符号，甚至可能导致自己的灾难。毫不奇怪，农民对解剖学家的书产生了兴趣。%SPEECH_ON%于是，你是一名巫师之类的吗？%SPEECH_OFF%%anatomist%微笑着转过身来，呼之欲出地说，如果农民认为这是真的，他是否会问他呢？农民后退了几步。%SPEECH_ON%哦，所以你是一个聪明人？手里有一本愚人的书？%SPEECH_OFF%%anatomist%看着农民转身离去，然后转过头，面带微笑地看着你。%SPEECH_ON%那个农民脸上有个奇怪的包块。他一年内就会死。如果他不走运，那就是两年。%SPEECH_OFF% | %anatomist%暂停了旅程和佣兵生涯，坐在石头上打开一本书。几分钟后，一个小女孩拿着鲜花走了过来。她递过来一朵花，并问他在读什么。解剖学家抬起书，把它转了一圈。她瞪着野兽和怪物被撕开的可怕图画，以及他们奇特的内脏。停顿了一下，她慢慢地把书推下来，盯着解剖学家。她说。%SPEECH_ON%我知道有一个你可以做的野兽。%SPEECH_OFF%你和解剖学家的耳朵一起变得尖锐。小女孩压低了声音，像个幼小的阴谋家般地轻声说道。%SPEECH_ON%我小弟弟，他两岁，但是我发誓他放弃了旧的信仰，魔鬼进入了他的身体。%SPEECH_OFF%%anatomist%听了以后，很有水平地点了点头。%SPEECH_ON%当然，我会在我的笔记里记录下来，如果有时间我会把那种恶心的东西从你的亲戚身上剜出来。%SPEECH_OFF%小女孩再次感谢解剖学家，并为他的承诺给了他更多的花。%anatomist%轻轻地拿花，左右摆动着，回到了他的阅读中，脸上挂着微笑。你希望他的微笑只是因为他被一个小孩所迷惑，而不是他真的希望看到一些邪恶的母猪。 | 当战团休息的时候，一个人站在路边观察，好奇地注视着。他点头示意。%SPEECH_ON%你们这群人有着死亡的气息，但我不能说你们是屠夫或行刑者。你们是其他的东西。%SPEECH_OFF%毫不迟疑，%anatomist%走到前面，用目光盯着那个人，把他的脸贴了上去，那个人向后倾斜，但没有退缩。解剖学家失神的目光以一个应该的点头结束。%SPEECH_ON%你是对的，我们确实有恶臭，你也有。我们的问题是科学问题，你们的问题是疾病问题。而你的问题，嗯，你的问题是染病的迹象。让我看看你的脚。%SPEECH_OFF%农民紧张地拒绝了这个请求。他后退时，解剖学家向前走去，手指像蜘蛛一样爬动，他的眼睛睁得大大的，那人最终尖叫着逃走。%anatomist%转过头来微笑着说。%SPEECH_ON%多么奇怪的一个研究对象。我相信他非常,非常的生病，但他还没有意识到。没关系。%SPEECH_OFF% | 你看到一个摆放着一个棺材的开放马车，它的后面是一群哀悼的人。%anatomist%从战团中走出来，询问有关该个体死亡的情况。他们说是被野兽击杀的。解剖学家好奇地问，是什么样的野兽能杀死一个人。人们相互看了看，然后打开棺材，里面躺着一个带着小伤疤的男人。伤口早已变成了深紫色，还有绿色和其他令人不安的色斑，证明他的死是因被攻击致死。其中一个农民抬起头来。%SPEECH_ON%是他的家猫干的。他立刻不再关注了，然后颜色消失了，并漫游在他的肉体中，直到他在两个晚上之内死去。%SPEECH_OFF%解剖学家与哀悼者分享了一些话，然后回到了你身边。他叹了口气。%SPEECH_ON%这只是一个简单的写照。他只需要清洗一下伤口就可以了。不幸的是，尽管我很高兴我的研究成果能给我带来现实世界的启示，但现在来应用似乎已经太晚了。%SPEECH_OFF%你问猫的情况如何。解剖学家点点头，说它和它的受害者一起躺在棺材里，那只猫作为一个看似不知道自己最终命运的“野兽”将其藏在那里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "如果他对雇佣工作也感到如此高兴就好了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 4 * anatomistCandidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});

