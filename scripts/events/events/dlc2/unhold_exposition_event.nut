this.unhold_exposition_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.unhold_exposition";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_126.png[/img]{一个老人在一块岩石上用粉笔画画。他看着战团，好像他们干扰了他的艺术创作。但是当你走到他旁边时，你会看见他一直在“画”出一些巨人笼罩在人类部落之上的场景。老人敲着粉笔继续说道：%SPEECH_ON%我敢打赌，不死族巨人在这里的时间比任何人都长。你知道有些生活在寒冷之处，有些在森林里，还有一些在沼泽地里吗？他们之间彼此不喜欢。他们基本上是本能上的人类，对自己的种族具有毁灭性和恶意，但他们对一件事情的敌意特别深厚。%SPEECH_OFF%老人指着你的粉笔，把它的末端翘起来，让粉末从末端飘散出来。%SPEECH_ON%外来者。离那些独眼巨人远点，旅行者。%SPEECH_OFF%他似乎有点疯，而且没有任何值得抢劫的东西，除了更多的粉笔，所以你催促着战团继续前行。 | 一位年轻的孩子在小路上用泥巴画画。当你靠近时，你意识到他实际上不是在路上，而是在一个像石棺一样大小和形状的坑里，孩子正在画内壁，大多数是一些狗的粗略形状。%SPEECH_ON%我爸说他们是“独眼巨人” ，独眼巨人从这儿来，朝那边走，这是传说中的巨人，但他们是“真实如你妈妈为那个混蛋伯克离开我，我会杀了他”这部分他说了很多遍。伯克会有报应的。所以他说。很多次。先生，我认为你应该远离那些独眼巨人。我爸这么说，我也是这么说，你也应该这样做。另外，你叫伯克吗？%SPEECH_OFF%你摇了摇头，并祝愿孩子一切顺利。从许多方面来说，你认为他说的是来自一个孩子的公平建议。 | 一位年长的男子，身材绝对像一块巨石，正从农舍的门廊上盯着你。%SPEECH_ON%你知道的，我曾经亲眼见过一只独眼巨人。没错。真正的巨人，堆积起来等于十个人那么大或更大。在草原上游荡，追着马啥的。他们出动了民兵，可这该死的东西把他们像娃娃一样扔来扔去。他抓起一名男子，把他扔得那么猛烈，我以为他会飞越这座山。你看起来像是一个好战的人，所以就听这个老糊涂的话，远离那些独眼巨人。%SPEECH_OFF%你点点头，祝愿老人一切顺利。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有人应该付钱让我们照顾他们。",
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Tundra)
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
	}

});

