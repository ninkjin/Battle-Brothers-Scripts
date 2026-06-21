this.wildman_finds_something_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.wildman_finds_something";
		this.m.Title = "在途中…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]当你试着不要因为有许多根低垂的树枝刮到了你的脸而发脾气时，%otherguy% 他赶紧跑到你身边说野人 %wildman% 跑了。 你转过身去看到其他人和你一样困惑。 举起你的拳头让队伍安静下来，森林不远处鸟儿的若有若无的叫声和蜜蜂或黄蜂的嗡嗡声在你的沉默中清晰可闻。 摇摇头，你决定继续前进。\n\n几个小时后，野人从你准备用大砍刀砍开的灌木丛后跳出来。 他手里拿着一大堆稀奇古怪的东西。 他从哪里得到这些东西，你不知道，但你让这些人筛选调查结果。 %wildman% 回到了队伍，就好像什么都没发生过一样。 你瞥了他一眼，发现他盯着停在他手指上的一只蝴蝶。 当你再撇他一眼的时候，蝴蝶不见了，那人正在吞东西。你的下属 %otherguy% 正向你报告他带来的东西。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他从哪儿弄来的？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				local item;
				local items = 0;

				for( local maxitems = this.Math.rand(1, 2); items < maxitems;  )
				{
					item = null;
					local r = this.Math.rand(1, 10);

					if (r == 1)
					{
						item = this.new("scripts/items/weapons/wooden_stick");
					}
					else if (r == 2)
					{
						item = this.new("scripts/items/armor/tattered_sackcloth");
					}
					else if (r == 3)
					{
						item = this.new("scripts/items/weapons/knife");
					}
					else if (r == 4)
					{
						item = this.new("scripts/items/helmets/hood");
					}
					else if (r == 5)
					{
						item = this.new("scripts/items/misc/ghoul_teeth_item");
					}
					else if (r == 6)
					{
						item = this.new("scripts/items/weapons/woodcutters_axe");
					}
					else if (r == 7)
					{
						item = this.new("scripts/items/shields/wooden_shield_old");
					}
					else if (r == 8)
					{
						item = this.new("scripts/items/weapons/militia_spear");
					}
					else
					{
						item = this.new("scripts/items/accessory/berserker_mushrooms_item");
					}

					if (item != null)
					{
						items = ++items;
						this.World.Assets.getStash().add(item);
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_wildman = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_wildman.len() == 0)
		{
			return;
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		this.m.OtherGuy = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates_wildman.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman.getNameOnly()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.OtherGuy = null;
	}

});

