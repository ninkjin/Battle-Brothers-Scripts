this.fisherman_tells_story_event <- this.inherit("scripts/events/event", {
	m = {
		Fisherman = null
	},
	function create()
	{
		this.m.ID = "event.fisherman_tells_story";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%fisherman%，这个老渔夫，向战队讲述他打鱼的故事。%SPEECH_ON%{那条鱼很大。 我以我妈的名义发誓！ 鱼太大了，当我把它从水里拽出来时，整条河都干枯到一只脚那么浅。 | 海洋是一只野兽，是啊，天空是它的主人，风是它的缰绳，而我们人类就是跳蚤。 | 我迷路了！整个夏天都在海上漂流，整个船在危机四伏的水中穿行，每个浪都带走了一个水手，直到只剩下我一个人，是啊，是啊！ 这是真的！到了秋天，我又看到了陆地，看到树，看到山，看到鸟在上面栖息，我是如此的高兴，以至于我把船撞到岩石上，当碎片在我周围漂浮时，我亲吻着沙滩。 这是我一生中最快乐的一天。 | 以前从没见过大白鲸，但见过一只绿的？ 是这么回事。穿着一件苔藓外套，不只用什么途径偷来的陆地皮毛。 我们用长矛和老水手精神捕猎它。 唉，它意识到我们在喷水孔上，当%randomname%－一个人用最锋利的鱼叉瞄准它－把它射到喷水孔里。 我不知道一条鲸竟能这样快地掉头，但它做到了，它很快就追上了我们的船，并在一阵狂怒中淹死了许多水手。 | 我曾经钓到一条鲈鱼，真他妈，大个。你能相信吗？ 好吧，它有这么大。 好吧，也许这么大。 好吧，我从没钓到过一条鲈鱼。 好啊！我从来没见过一条鲈鱼！ 我只知道它们就在那里！ 让我自己待会儿，你们这些旱鸭子！ 我在大海里捕鱼，他妈的！ 我对你那些愚蠢的池塘一无所知。 当然，鲈鱼除外，我了解他们。}%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "听起来很可疑。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Fisherman.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
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
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.fisherman")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Fisherman = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fisherman",
			this.m.Fisherman.getName()
		]);
	}

	function onClear()
	{
		this.m.Fisherman = null;
	}

});

