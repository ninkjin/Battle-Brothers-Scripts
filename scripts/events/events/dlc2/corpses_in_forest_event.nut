this.corpses_in_forest_event <- this.inherit("scripts/events/event", {
	m = {
		BeastSlayer = null,
		Killer = null
	},
	function create()
	{
		this.m.ID = "event.corpses_in_forest";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_132.png[/img]{在穿越森林时，你碰到了一堆黑烬尸体，他们将自己搂在一起做最后的火葬。这是一堆黑色脚和偶尔露出天空的脸，隐约有烤猪的味道，但周围没有猪。%randombrother%看着这一幕点头。 %SPEECH_ON% 这可真是一堆糟糕的东西。%SPEECH_OFF% 你点点头，的确是这样。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "也许里面有些有用的东西。",
					function getResult( _event )
					{
						if (_event.m.BeastSlayer != null && this.Math.rand(1, 100) <= 75)
						{
							return "D";
						}
						else if (_event.m.Killer != null && this.Math.rand(1, 100) <= 75)
						{
							return "E";
						}
						else
						{
							return this.Math.rand(1, 100) <= 50 ? "B" : "C";
						}
					}

				},
				{
					Text = "最好不要住在这里。",
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
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_132.png[/img]{雇佣兵们开始搜查尸体。大多数尸体成簇三四个，像鸟蛋一样被敲开。他们需要用靴子或钢楔分开。当士兵们忙碌时，烤焦的肉块飘散着。烤焦的孩子们被剥下来，胸膛塌陷，手臂像辐条一样伸出来。在尸体下面没有什么发现。顶多就是一些金子碎片。%randombrother%发现了一件可怕的面具。你不太确定它是什么，但认为带上它也不会有坏处。或许会有一些商人会对它感兴趣。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/misc/petrified_scream_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local money = this.Math.rand(10, 100);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_132.png[/img]{%randombrother%蹲在这堆焦黑的尸体旁，摇了摇头。%SPEECH_ON%我想这里没有什么值得我们留意的东西，长官。%SPEECH_OFF%在你来得及回应之前，一只黑手突然从中伸出，抓住了这个士兵的脚踝。尸体们起身扭动着，只有一具尸体渐渐爬了起来，它背上的焦黑尸体条状地像小蜘蛛一样摆动着。它的嘴紧紧张着，嘴唇已经烧毁，脸颊凹陷，眼神深沉。它的手像石头雕刻一样有力，当雇佣兵向后爬时，焦黑的生还者也向后爬动。整个尸体堆颤抖着翻滚，一些身体像茶几一样翻滚着肢体伸展开，另一些则晃晃悠悠地向天空凝视，还有一些前倾着，把头朝下撞向地面，将自己的头颅粘在地上形成一片墨黑的污迹。\n\n生还者呻吟着喊着要水。你拔出剑，砍断了他的脖子，结束了他的痛苦。%randombrother%打破了骨头，摆脱了可怕的手。几个雇佣兵被这个事件震惊了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (!bro.getBackground().isOffendedByViolence() || bro.getLevel() >= 7)
					{
						continue;
					}

					bro.worsenMood(0.75, "被可怕的场景惊到");

					if (bro.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_132.png[/img]{[%beastslayer%举起他的手。%SPEECH_ON%他们不是被谋杀的，他们被清除了。%SPEECH_OFF%他蹲在堆积物的边缘旁，摆弄着一个被烧焦的手臂，并在肘部处用力扭动。他把手臂翻过来，然后用力挤压。青色汁液从静脉应该存在的地方渗出，滴落到地上。这位兽人猎手拿起一个小瓶子，收集了他能收集到的内容。%SPEECH_ON%这些人被织网蛛的毒素感染了。这种毒素通常会溶解器官并致死，但有时候却会有其他效果。会在手臂生长出厚实的毛发，指甲变长，肩胛骨开始疼痛并凸出背部。不好看。而中毒者则会发疯。%SPEECH_OFF%你问这些人是否都中毒了。兽人猎手摇了摇头。%SPEECH_ON%我从这个肩膀认识他，其余的，我不知道。当一种疾病笼罩着一个村庄时，整个村庄都会被笼罩在其中，很快混乱和困惑就会成为感染的传播，而疾病本身只是在自己引发的篝火中漂泊的一道被遗忘的火花。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.BeastSlayer.getImagePath());
				local item = this.new("scripts/items/accessory/spider_poison_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_132.png[/img]{逃犯%killer%嘴角扯动着，点头摇头，指向堆积如山的尸体。%SPEECH_ON%那种残忍，做这件事的人也许本身就没有活下来。%SPEECH_OFF%你问他什么意思，但他一只手指指着森林，左右踱步，走到了一颗树旁停下。%SPEECH_ON%就像我想的一样。%SPEECH_OFF%你转身看到一具被绞死的男子身上布满了灰烬，指尖和脖子则是一片漆黑，手中抓着一张抱歉的字条。字条上没有描述罪行的性质或者是否为真，那个人或许是个贵族。他脚下的是他的盔甲和武器。无论如何，你现在把他放下来把他的一切掠夺。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Killer.getImagePath());
				local item = this.new("scripts/items/weapons/morning_star");
				item.setCondition(this.Math.rand(5, 30) * 1.0);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/armor/basic_mail_shirt");
				item.setCondition(this.Math.rand(25, 60) * 1.0);
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		local myTile = this.World.State.getPlayer().getTile();

		foreach( s in this.World.EntityManager.getSettlements() )
		{
			local d = s.getTile().getDistanceTo(myTile);

			if (d <= 6)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_beastslayer = [];
		local candidates_killer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.beast_slayer")
			{
				candidates_beastslayer.push(bro);
			}
			else if (bro.getBackground().getID() == "background.killer_on_the_run")
			{
				candidates_killer.push(bro);
			}
		}

		if (candidates_beastslayer.len() != 0)
		{
			this.m.BeastSlayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];
		}

		if (candidates_killer.len() != 0)
		{
			this.m.Killer = candidates_killer[this.Math.rand(0, candidates_killer.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"beastslayer",
			this.m.BeastSlayer != null ? this.m.BeastSlayer.getNameOnly() : ""
		]);
		_vars.push([
			"killer",
			this.m.Killer != null ? this.m.Killer.getNameOnly() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.BeastSlayer = null;
		this.m.Killer = null;
	}

});

