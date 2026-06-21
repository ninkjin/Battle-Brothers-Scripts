this.fountain_of_youth_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.fountain_of_youth";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_114.png[/img]{你站在森林清地的边缘，眼前的景象足以让人惊讶。\n\n一根人体的躯干就像一棵细长的树从地下冒出来，赤裸而毛茸茸，鸡皮疙瘩般的树皮，延伸向上，直到比你自己高出一倍。它没有树枝。也没有手。相反，在一个树冠应该出现的地方，有一系列人头绑在一起。从左到右，他们的头像是宝贵而又朦胧的，性别不明，仿佛是时光的变形创造，他们自己创造的阴影使他们的面容从奇怪的熟悉到陌生的天真不断地变换，仿佛他们不知道自己是如何到达那里的，似乎随时准备问问你。这让你想起了溺水的情景，河水之下的脸庞在扭曲，肉身始终不安地揣摩着是什么让它出现在这里。\n\n树林中传来窃窃私语。它们像是昆虫所说的那样在地上穿梭，并爬上你的手臂，直到在你的耳朵里轻轻地挠痒。它们请求你留下。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看这是什么。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们必须离开这里。 尽快的。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_114.png[/img]{进入空地后，奇怪的生物站直了身子，像孔雀般左右摇晃着它的头。它们对你说话了。%SPEECH_ON%长老。是的。在这里。是的。他。我们。认识。他。我们。曾经认识。%SPEECH_OFF%当这些话离开它们的嘴巴时，它们的脸庞变形，变得不自然。慢慢地再一次变回，一个恶心的面具一个接一个地出现。%SPEECH_ON%喝。一点点。治愈。所有的。喝。所有的。成为。一体。%SPEECH_OFF%你低头看见一个弯曲的土之岩棚弯曲在一个盘子大小的水坑上方。有一丝微弱的滴答声，水滴从上面滴落，水从哪里来任何人都说不清。你抬头看着脸部，它们的面容从痛苦变成了快乐，从惊喜、恐惧到困惑。%SPEECH_ON%熟悉。永远熟悉。喝。一点点。是。不。喝。所有的。%SPEECH_OFF%看回来，你拿出水囊，拔掉软木塞。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我就喝一点点。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我要把它全部喝完！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_114.png[/img]{你蹲在畸形的树下。头颅摇摆着向下，阴影伴随着它们，仿佛有人在篮子上盖上盖子。当你抬头时，它们就在一英尺之外凝视着你，起伏着，不停地移动着。然而，远端的一个异常静止。它的面孔扭曲成一个老人的怒容，眉头紧皱，嘴角紧绷，衰老的皱纹被折叠起来，就像愤怒像精心打造的剑一样自我折叠。一团黑暗的光环将其包围，半影脉动着，就像头颅正在从另一个世界凝视着。\n\n 手紧握着，你拿起水袋，倒出其中的内容。倒空后，你把它放在滴水的屋檐下，听着每一滴落在底部的声音。面孔越来越靠近，将你笼罩在混沌的漩涡中。当它们靠近时，你可以听到它们现实的撕裂声，因为它们进入并失去了形状。水袋在你手中摇晃，仿佛你必须抵住瀑布的冲击才能握住它。你从屋檐下拉开它，当你向后摔倒时，你意识到头颅早已竖立起来。翻滚着，你爬起来，跑出了空地。看起来安全了，你向后看去，发现怪物已经不见了。那里什么也没有。没有树。没有喷泉。然而，水袋仍然在那里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "最好把这个放在安全的地方。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().die();
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(1);
				local item;
				item = this.new("scripts/items/special/fountain_of_youth_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_114.png[/img]{你把水袋扔在一旁，用嘴伸入水坑喝水。水坑底下的世界是空荡荡的，没有声音。你的嘴唇动着、喉咙咕着，但这里没有什么可喝的。你尖叫，却什么也没有。甚至连感觉都没有。只有恐惧的概念，无法解决的刺痛。当你试图用手抓住地面离开水坑时，却发现自己无法离开。\n\n虚空中的淡淡面容闪烁着。它们就像树一样，生动而又死寂，从过去到现在到未来，痛苦地降临在这里，一波又一波地汇聚，冒着气泡，向前推挤，把这黑暗的地狱变成了一个翻腾的白色。当他们接近时，你意识到自己一直在看错了。从个体上看，它们只是没有实体的面容。但是，当你把这一切看作一个整体，看着那逐渐逼近的巨大白色面具时，你意识到它们组成了一个巨大的面部：你的面孔，而且在发笑。\n\n你尖叫着，最终从水坑里跌出来。%randombrother% 扶着你，关切地看着你。%SPEECH_ON%先生，你还好吗？你刚才在睡觉吗？%SPEECH_OFF%你抬头看着周围，希望看到憎恶的树和它的可怕面容，但什么都没有。无论你看多少次，无论你看到哪里，它再也不会出现了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我…不…明白。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().die();
						}

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
	}

});

