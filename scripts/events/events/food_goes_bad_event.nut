this.food_goes_bad_event <- this.inherit("scripts/events/event", {
	m = {
		FoodAmount = 0
	},
	function create()
	{
		this.m.ID = "event.food_goes_bad";
		this.m.Title = "露营时…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们本该用掉这些的…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local food = this.World.Assets.getFoodItems();
				food = food[this.Math.rand(0, food.len() - 1)];
				this.World.Assets.getStash().remove(food);

				if (food.getID() == "supplies.bread")
				{
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{在清点存货的时候，%randombrother% 提醒你一个可怕的消息：一大堆食物坏了。 简洁而中肯，你点头并感谢他这么快告诉你。 | %randombrother% 来到你面前擦他的下巴。 他说他几乎被一小块面包硌碎了牙齿。 显然，他是在一个食品箱的底部发现了这片东西，而且它似乎已经在那里放了一段时间了。 你拿起一把剑，把面包劈成两半，几个兄弟用具有讽刺意味的虚张声势来庆祝。 拿起切成两半的面包，给他们看里面：一团漆黑。 如果你吃了这个，你的胃就会是这个样子，你会咆哮，然后把面包扔进灌木丛，在那里你可以听到它像一块沉重的石头一样翻滚。}";
				}
				else if (food.getID() == "supplies.dried_fish")
				{
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{在清点存货的时候，%randombrother% 提醒你一个可怕的消息：一大堆食物坏了。 简洁而中肯，你点头并感谢他这么快告诉你。 | %randombrother% 坐在木头上，突然大叫一声，跳了起来。 你走过去看他把一条鱼扔在路边，他不停地指着它。 当他警告你不要靠近它时，你决定靠近它。 很明显，一只水蜘蛛在鱼的腹部产了一窝卵。 你现在盯着那些小蜘蛛，它们的腿和身体像一团烟雾一样冒出来。\n\n把所有的鱼都扔进火里，你让那个队员检查剩下的鱼。 不幸的是，它们都处于相似的状态，没有人愿意用蜘蛛肉替代鱼肉。}";
				}
				else if (food.getID() == "supplies.dried_fruits")
				{
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{在清点存货的时候，%randombrother% 提醒你一个可怕的消息：一大堆食物坏了。 简洁而中肯，你点头并感谢他这么快告诉你。 | 你在几箱食品中仔细挑选，结果发现一整箱的苹果都覆盖着一层灰色的毛状物。%randombrother% 对此说了一个词，但你以前从未听说过它。 不管怎样，这些水果都无法挽救，你只能把腐烂的水果扔掉。}";
				}
				else if (food.getID() == "supplies.smoked_ham" || food.getID() == "supplies.cured_venison")
				{
					this.Text = "[img]gfx/ui/events/event_52.png[/img]{在清点存货的时候，%randombrother% 提醒你一个可怕的消息：一大堆食物坏了。 简洁而中肯，你点头并感谢他这么快告诉你。 | 蛆在几块肉上蠕动。 你的人盯着食物看，有些人看起来好像愿意冒着生病的风险来咬一口。 在有人做出蠢事之前，你会告诫每个人，并亲自把肉处理掉。}";
				}
				else
				{
					this.Text = "{[img]gfx/ui/events/event_52.png[/img]在清点存货的时候，%randombrother% 提醒你一个可怕的消息：一大堆食物坏了。 简洁而中肯，你点头并感谢他这么快告诉你。 | [img]gfx/ui/events/event_36.png[/img]幼稚的傻笑把你从午睡中吵醒。 你站起来，发现一些食物不见了，唯一能证明食物去向的地方是一片仍在移动的高草。 不假思索，你拿起一把剑，跟随它的踪迹。 不幸的是，没过多久，你迷失在巨大的绿色植物中，每一阵风吹过，这些植物就会盖在你的脸上。 然而，咯咯的笑声并没有停止，你听到了身后和前面传来的脚步声。 一个声音在说话，听起来就像一个孩子在深井里。%SPEECH_ON%追我们啊！在这里！追我们！追我们…追我们。赶紧追我们！%SPEECH_OFF%你突然觉得没有想要取回粮食的冲动。 你慢慢地把你的剑放回剑鞘，然后退出这个地方。 当你凝视着高高的草丛时，它开始慢慢地分开，就像一块被撕破的皮革。 你听到可怕的哭泣声，就像每个植物的茎裂成两半。\n\n%randombrother% 问你在做什么时，他吓了你一跳。 你转过头去看他，然后又转回那随风轻轻摇摆的田野。 你没有回答，只是告诉他准备好，因为你很快就会再次出发。 值得庆幸的是，雇佣兵们并没有询问丢失的食物。}";
				}

				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你失去了 " + food.getName()
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 10)
		{
			return;
		}

		if (this.World.Assets.getFood() < 70)
		{
			return;
		}

		if (this.World.Retinue.hasFollower("follower.cook"))
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Plains && currentTile.Type != this.Const.World.TerrainType.Swamp && currentTile.Type != this.Const.World.TerrainType.Farmland && currentTile.Type != this.Const.World.TerrainType.Steppe && currentTile.Type != this.Const.World.TerrainType.Hills)
		{
			return;
		}

		this.m.Score = this.World.Assets.getFood() / 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.FoodAmount = 0;
	}

});

