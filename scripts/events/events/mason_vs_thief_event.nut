this.mason_vs_thief_event <- this.inherit("scripts/events/event", {
	m = {
		Mason = null,
		Thief = null
	},
	function create()
	{
		this.m.ID = "event.mason_vs_thief";
		this.m.Title = "露营时…";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]%mason% 这个石匠站在为营火添柴的 %thief% 旁边。 这个小偷正在思考着一个问题。%SPEECH_ON%什么东西是最难以破开的？ 当然，别说保险库那是最简单的，首先就把它排除出去。 有一次我从金库里偷了很多东西他们想把锁匠吊死因为这个锁匠的锁很容易被一个普通小偷破开。 但是他们找不到那个锁匠，也抓不到那个普通的小偷，因为我就是那个被打败的锁匠。 哈－哈！回答你的问题，塔楼是最难以突破的，尤其是只有一个塔楼。%SPEECH_OFF%摆弄好眼前的营火，这个石匠点了点头。%SPEECH_ON%是的，就猜到你会这么说。 塔楼是为囚禁那些外来犯人或者保存那些奇珍异宝而建立的。 对于没有翅膀的生物来说它们就像天空中的笼子。 但是有一次一个囚犯一个臭名昭著的偷鱼贼，不可思议地逃脱了。 他花了许多年的时间每天从自己的头发中抽出几缕把它们绑在一起直到这个头发做的绳子长度能够让他从塔上爬下来。 不幸的是，一天后他们又抓住了他。 几年后他又做了同样的把戏但这一次的绳子只绑了一半长为了上吊自杀了。%SPEECH_OFF%%thief% 笑了笑。%SPEECH_ON%这很有趣，但我是一个真正的小偷，石匠，不是个偷鱼贼。 我的问题是我如何进入塔内。%SPEECH_OFF%石匠点了点头。%SPEECH_ON%简单。上交一个…鲱鱼。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好一个长篇大论。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Mason.getImagePath());
				this.Characters.push(_event.m.Thief.getImagePath());
				_event.m.Mason.improveMood(1.0, "建立友谊与 " + _event.m.Thief.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Mason.getMoodState()],
					text = _event.m.Mason.getName() + this.Const.MoodStateEvent[_event.m.Mason.getMoodState()]
				});
				_event.m.Thief.improveMood(1.0, "建立友谊与 " + _event.m.Mason.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Thief.getMoodState()],
					text = _event.m.Thief.getName() + this.Const.MoodStateEvent[_event.m.Thief.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local mason_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.mason")
			{
				mason_candidates.push(bro);
				break;
			}
		}

		if (mason_candidates.len() == 0)
		{
			return;
		}

		local thief_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.thief")
			{
				thief_candidates.push(bro);
			}
		}

		if (thief_candidates.len() == 0)
		{
			return;
		}

		this.m.Mason = mason_candidates[this.Math.rand(0, mason_candidates.len() - 1)];
		this.m.Thief = thief_candidates[this.Math.rand(0, thief_candidates.len() - 1)];
		this.m.Score = (mason_candidates.len() + thief_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"mason",
			this.m.Mason.getNameOnly()
		]);
		_vars.push([
			"thief",
			this.m.Thief.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Mason = null;
		this.m.Thief = null;
	}

});

