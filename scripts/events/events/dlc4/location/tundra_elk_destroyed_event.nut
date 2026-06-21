this.tundra_elk_destroyed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.tundra_elk_destroyed";
		this.m.Title = "战斗之后…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_146.png[/img]{当受到最后一击后，伊吉洛克捂着自己最后的那道伤口。 发出了一声痛苦的嚎叫，双膝屈曲，他开始呕吐起来，并用一只手支撑着自己以防倒在地上。 整件事情看起来就像是一个谜团，那只野兽时不时看向你为了确保你看着它。 这是一出戏剧，由一个对死亡都没有任何感觉的人出演的糟糕演出。 紧闭着眼睛，那令人不安的微笑又出现在了你的脑海，怪兽的尸体上闪烁着蓝色的闪光，当光线恢复正常的时候，尸体被冻成了冰块，雪花从天空中纷纷扬扬地飘落。\n\n 不可能吧。 你知道的。 你走到结冰的尸体旁，开始凿冰。 当你切入冰块时，缝隙中流出了蓝色的液体。 当你敲碎最后一块冰时，黏液向四周飞溅而出。 在佣兵们担心得看着你时，你抓起破碎的盔甲扔进了伊吉洛克的血液里。 奇怪的触手把它们的碎片粘在一起，盔甲的图案变得清楚，你看着它们开始扭紧，把护板拉在一起。 磨砂的麋鹿毛皮与金属结合在一起，好像他们能治愈旧伤一样。 血液在护板上像蛇一样盘旋，就像河床下旋转的苔藓，在消失前来回卷曲着将盔甲涂成光滑的红色。 \n\n拿起盔甲的时候，你感到指尖嗡嗡作响。%SPEECH_ON%我希望你不要让我穿那个，队长。%SPEECH_OFF%%randombrother% 边说边摇着头，伴随着一个紧张的微笑。 你无法确定盔甲的作用，但毫无疑问，你要留着它收入库存中以便观察。 至于伊吉洛克，毫无疑问它还在世界的某个地方。 它的尸体已经在迅速腐烂，剩下的骨头不是一头巨兽的骨头，而是一只可怜的麋鹿的骨头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "最后，还是我们赢了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IjirokStage", 5);
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.broken_ritual_armor")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				this.World.Assets.getStash().makeEmptySlots(2);
				local item = this.new("scripts/items/helmets/legendary/ijirok_helmet");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local item = this.new("scripts/items/armor/legendary/ijirok_armor");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_146.png[/img]{当受到最后一击后，伊吉洛克捂着自己最后的那道伤口。 发出了一声痛苦的嚎叫，双膝屈曲，他开始呕吐起来，并用一只手支撑着自己以防倒在地上。 整件事情看起来就像是一个谜团，那只野兽时不时看向你为了确保你看着它。 这是一出戏剧，由一个对死亡都没有任何感觉的人出演的糟糕演出。 紧闭着眼睛，那令人不安的微笑又出现在了你的脑海，怪兽的尸体上闪烁着蓝色的闪光，当光线恢复正常的时候，尸体被冻成了冰块，雪花从天空中纷纷扬扬地飘落。\n\n 不可能吧。 你知道的。 你走到结冰的尸体旁，开始凿冰。 当你切入冰块时，缝隙中流出了蓝色的液体。 当你敲碎最后一块冰时，黏液向四周飞溅而出。\n\n毫无疑问这玩意还在世界的某个地方。 它的尸体已经在迅速腐烂，剩下的骨头不是一头巨兽的骨头，而是一只可怜的麋鹿的骨头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "最后，还是我们赢了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IjirokStage", 5);
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
		local stash = this.World.Assets.getStash().getItems();

		foreach( i, item in stash )
		{
			if (item != null && item.getID() == "misc.broken_ritual_armor")
			{
				return "A";
			}
		}

		return "B";
	}

	function onClear()
	{
	}

});

