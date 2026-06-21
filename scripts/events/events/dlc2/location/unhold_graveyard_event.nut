this.unhold_graveyard_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.unhold_graveyard";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_117.png[/img]{指骨就像倒下的图腾柱一样，大腿像是被樵夫采伐后从膝盖处斩下来的，弯曲的肋骨散落在地上，像是被船匠评估过，头骨歪歪斜斜地栖息在下颌后的楔形骨上，像是萨满的动物居所，大门牙齿有盾牌一般大，任何人都能爬进它的眼眶。\n\n穿过巨魔的骨骸，你发现更多的骨骼扇形展开在山谷中。最重的骨头停留在它们主人呼出最后一口气的地方，而最小的那些早已滚到山谷的沟渠里，在一片白色的褶皱中和属于它们的肉和皮毛混在一起安静地归宿了。\n\n您没有理由认为，除了巨魔自己以外，还有其他人在这里策划了他们的死亡。暴力不在他们的形状中。他们坐起来或躺下来，度过平静的永恒时光，的确，%randombrother%指出了一个巨大的巨人，看起来最近躺下来休息了。它蜷缩着，双手环抱着膝盖，头靠在肩膀上。它看着日落，将会这样做很多年。但是你并不在乎。你命令士兵们展开并收集他们能够得到的东西。他们带回的一些骨头、皮毛或其他物品可能对战团有很大的用处。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "把所有东西都拿走。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.getStash().makeEmptySlots(5);
				local item;
				item = this.new("scripts/items/misc/unhold_bones_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/misc/unhold_bones_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/misc/unhold_bones_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/misc/unhold_hide_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/misc/frost_unhold_fur_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
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

