this.raid_farmstead_event <- this.inherit("scripts/events/event", {
	m = {
		SomeGuy1 = null,
		SomeGuy2 = null
	},
	function create()
	{
		this.m.ID = "event.raid_farmstead";
		this.m.Title = "在路上…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_72.png[/img]%randombrother% 拿着一份关于战队食物库存的报告走到你身边。 手上有粮，干活不累，但战队已经快要没有足够的食物分给大家了。 库存里的大部分水果都已变质发软，上面长满了灰色的毛霉。 剩下所有的东西都被一股脑扔进锅里做成了乱炖，佣兵们形象地称之为“吊毛炖汤”。 老实说，那看起来根本不像是给人类吃的东西。\n\n不过，机缘巧合之下，一个小农场出现在了远方。 尽管兄弟们没人直接站出来明说，但还是有人委婉地建议战队或许可以去抢了它。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们抢了它。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们继续前进。",
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
			Text = "[img]gfx/ui/events/event_72.png[/img]你朝农场走去。 几名农夫在田里直起腰来，在你们走过来的同时互相瞥了瞥眼神。 一个正在打干草的农民把他的草叉插在地上，双手搭在上面。 当你穿过田野时，他们看着你们的眼神既紧张又好奇，而你的手下毫不掩饰对身边庄稼的渴望之情。\n\n当你靠近农庄宅邸时，一个女人走了出来迎接你。 她擦擦额头，问你们想要什么。 几个孩子从附近的屋子里跑出来，站在门廊上。 他们躲在一个或许是那女人父亲的年长男人腿后，试探地看着你们。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "只拿走我们需要的就好。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "把所有东西都拿走。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "把所有东西都拿走。 杀了所有人。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_72.png[/img]你向那位女人解释说你的人需要食物。 她倒吸了一口冷气，但你举起一只手来。%SPEECH_ON%我们只拿我们需要的东西，一点不多，一点不少。 我们不想惹出更多的麻烦，而且我很确定你们也是一样。行吗？%SPEECH_OFF%那女人迅速点了点头。 你转过身去命令你的人去收集一些作物，与此同时，女人拔高了嗓音，告诉农夫别干傻事。 这整个过程持续了大约十分钟，然后你的人继续上路了。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们别无选择。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local food;
				food = this.new("scripts/items/supplies/smoked_ham_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/bread_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				this.World.Assets.updateFood();
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_72.png[/img]这里的食物十分充足。 你转过身去告诉你的人把能拿走的全拿走。 那女人倒抽一口冷气，向后退了几步，并且看起来马上就要开始尖叫。 你抓住她，小孩们爆发出一阵尖厉的哭声。 几个农夫举起镰刀和草叉作为回应。 你让她命令那些农夫放下武器。 她服从了，而农夫们也照做了，尽管看上去很不情愿。\n\n你在你的人抢劫的时候始终挟持着女人。 知道他们抢到拿不动更多东西为止，你才放走女人，并让你的人继续上路。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们应该得到更多。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-2);
				local food;
				food = this.new("scripts/items/supplies/smoked_ham_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/smoked_ham_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/goat_cheese_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/bread_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				this.World.Assets.updateFood();
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_30.png[/img]这里有许多食物。 还有许多多余的目击者。\n\n你转过身去给了 %someguy1% 一个眼神。他点头作为回应，然后射出一根箭。 在女人反应过来开始尖叫之前，雇佣兵射出的箭击中了门廊上的那名老人，他踉跄跌回了房子中，随之而来的是他边上孩子们的哭喊。 战队里其他的人一哄而散，冲进田野，利剑出鞘。 几个农夫试图反抗，但全副武装的佣兵很快就解决了他们。%someguy2% 冲进了农场屋子里，你在里面听到了许多的哭喊声一个接一个地消失，直到最终归于沉寂。 你把那个女人交给几个佣兵，告诉他们在你们离开前确保她已经死了就行。 另一批佣兵则立即开始收割作物以及从屋子里搬走东西。 没过多久，你们重新上路，带着几乎被填满的仓库。 几个佣兵用被染成红色的抹布擦拭着他们湿漉漉的利刃。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "不会有活人知道这里发生了什么的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-5);
				local food;
				food = this.new("scripts/items/supplies/smoked_ham_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/smoked_ham_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/goat_cheese_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				food = this.new("scripts/items/supplies/bread_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				this.World.Assets.updateFood();

				for( local i = 0; i < this.Math.rand(1, 2); i = ++i )
				{
					local pitchfork = this.new("scripts/items/weapons/pitchfork");
					this.World.Assets.getStash().add(pitchfork);
					this.List.push({
						id = 10,
						icon = "ui/items/" + pitchfork.getIcon(),
						text = "你获得了一个 " + pitchfork.getName()
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.bloodthirsty"))
					{
						bro.improveMood(1.0, "喜欢掠夺和抢劫");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.worsenMood(1.0, "对战队的行为感到震惊");

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
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Plains && currentTile.Type != this.Const.World.TerrainType.Farmland)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getFood() > 50)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 5)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.bloodthirsty") || !bro.getBackground().isOffendedByViolence())
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		local x = 0;
		local y = 0;

		while (x == y)
		{
			x = this.Math.rand(0, candidates.len() - 1);
			y = this.Math.rand(0, candidates.len() - 1);
		}

		this.m.SomeGuy1 = candidates[x];
		this.m.SomeGuy2 = candidates[y];
		this.m.Score = 30;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"someguy1",
			this.m.SomeGuy1.getName()
		]);
		_vars.push([
			"someguy2",
			this.m.SomeGuy2.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.SomeGuy1 = null;
		this.m.SomeGuy2 = null;
	}

});

