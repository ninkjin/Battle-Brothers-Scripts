this.civilwar_refugees_event <- this.inherit("scripts/events/event", {
	m = {
		AggroDude = null,
		InjuredDude = null,
		RefugeeDude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_refugees";
		this.m.Title = "在途中…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_59.png[/img]{通常情况下，一场真正的战争会有大量人员伤亡，这场战争也不例外：沿着一条小路，你看到一大群难民挤在一起。 你发现他们时，他们正在小溪里洗澡，一个帮人半裸半洗，你吓到他们了。 难民中大多数是妇女和儿童，还有一些老人，以及一些准备用生命守护周围人的男人，虽然他们非常瘦弱。 一个这样的人站出来。%SPEECH_ON%你想要什么？%SPEECH_OFF%%aggro_bro% 靠近了你。%SPEECH_ON%先生，我们可以拿走他们所有的东西，但我相信他们不会自愿放弃的。%SPEECH_OFF%%injured_bro% 摇了摇头。%SPEECH_ON%我得说他们不值得我们这样做。 这些人已经经历了太多东西了，他们现在已经一无所有了。%SPEECH_OFF% | 你遇到一群难民。 女人，孩子，老人，还有一些瘦小的男人。 他们几乎一无所有，但如果你花点力气，他们仍然有值得的东西。 | 难民。他们中的一群人沿着小路排成一长排。 一看到你，这个蜈蚣一样的队伍就停了下来，所有的身体慢慢地拖着步子，变成了一团可怕的东西。%aggro_bro% 建议杀了这些难民，拿走他们的所有东西，尽管你认为这些难民已经一无所有了。}",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "别再骚扰那些可怜的人了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local food = this.World.Assets.getFoodItems();

				if (food.len() > 2)
				{
					this.Options.push({
						Text = "和那些穷人分享我们的一些食物。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.RefugeeDude != null && food.len() > 1)
				{
					this.Options.push({
						Text = "%refugee_bro%，你以前是个难民。 和他们谈谈？",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Options.push({
					Text = "搜他们的贵重物品！",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-3);

						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_59.png[/img]你命令你的人拿走他们能拿走的东西。 当你的兄弟们列队进入难民的队伍时，难民们带着恐惧开始抗议。 突然，其中一个难民拿起一块大石头，砸向了 %injured_bro% 的头。 妇女和儿童尖叫着，其他几个男人抓住雇佣兵，争抢着他身上的武器。 但是这些瘦弱的人们已经好几天没有吃东西了，他们虚弱的身体根本无法与你的人匹敌。 %companyname% 拿走了他们想要的一切。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "摆清楚你们的位置，白痴们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.InjuredDude.getImagePath());
				local injury = _event.m.InjuredDude.addInjury(this.Const.Injury.Accident3);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.InjuredDude.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
				_event.addLoot(this.List);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_59.png[/img]你命令你的人拿走他们能拿走的东西。 难民们吓得东倒西歪。 妇女们和孩子们哭喊着。 一些泪流满面的人乞求你离开。 不幸的是，对于这帮无家可归的流浪汉来说，%companyname% 可以随心所欲。 你的手下在人群中自由地筛选，最终带着他们的战利品返回了。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "他们知道最好不要反抗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.addLoot(this.List);
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_59.png[/img]{你叫 %randombrother% 给难民们一些食物。 当他们拿到一些面包和水的时候，不知所措的人们不可思议地盯着你。 一个老人走上前来，颤颤巍巍地跪下来亲吻你的脚。 你把他扶起来，告诉他没必要这么夸张。 你手下的一些雇佣兵窃笑着称你为“面包大王。” | 这些人很容易被抢劫，但是当这些消息在这个地区传开的时候，你觉得这样的消息不会是好消息。 相反，你命令 %randombrother% 去给这些难民分发食物和水。 难民们非常高兴，他们把你当成神，把你当成一个从手中扔魔法石的神。 而你只是扔掉了一些快要变质的食物。 不过，也有人说，当古老的神明更仁慈的时候，人们会更神圣。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "旅行安全。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(3);
				local food = this.World.Assets.getFoodItems();

				for( local i = 0; i < 2; i = ++i )
				{
					local idx = this.Math.rand(0, food.len() - 1);
					local item = food[idx];
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你失去了 " + item.getName()
					});
					this.World.Assets.getStash().remove(item);
					food.remove(idx);
				}

				this.World.Assets.updateFood();
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_59.png[/img]你决定对一个有难民经历的人施加压力：%refugee_bro%。\n\n这位雇佣兵走进了一大群哭泣着、祈祷着的难民们中。 他和他们聊了一会儿，分享了一些食物，友好的手势和他自己过去的故事，渐渐的，人群聚拢到他的身边。 你看到一个老人递给他一些用皮带和羊皮包着的东西。 佣兵鞠了个躬，握了握他的手，然后回来了。\n\n他把羊皮和皮带解开，露出一把剑，剑在阳光下闪闪发光，你能想象它有多锋利这把剑就有多锋利。%refugee_bro% 笑了%SPEECH_ON%就像我妈妈常说的，一点友善永远不会伤害任何人，但这把剑一定会的！%SPEECH_OFF%",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "和好朋友一起工作就是好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(3);
				this.Characters.push(_event.m.RefugeeDude.getImagePath());
				local food = this.World.Assets.getFoodItems();
				local item = food[this.Math.rand(0, food.len() - 1)];
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你失去了 " + item.getName()
				});
				this.World.Assets.getStash().remove(item);
				this.World.Assets.updateFood();
				local r = this.Math.rand(1, 2);
				local sword;

				if (r == 1)
				{
					sword = this.new("scripts/items/weapons/arming_sword");
				}
				else if (r == 2)
				{
					sword = this.new("scripts/items/weapons/falchion");
				}

				this.List.push({
					id = 10,
					icon = "ui/items/" + sword.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(sword.getName()) + sword.getName()
				});
				this.World.Assets.getStash().add(sword);
			}

		});
	}

	function addLoot( _list )
	{
		local r = this.Math.rand(1, 3);
		local food;

		if (r == 1)
		{
			food = this.new("scripts/items/supplies/dried_fish_item");
		}
		else if (r == 2)
		{
			food = this.new("scripts/items/supplies/ground_grains_item");
		}
		else
		{
			food = this.new("scripts/items/supplies/bread_item");
		}

		_list.push({
			id = 10,
			icon = "ui/items/" + food.getIcon(),
			text = "你获得了" + food.getName()
		});
		this.World.Assets.getStash().add(food);
		this.World.Assets.updateFood();

		for( local i = 0; i < 2; i = ++i )
		{
			r = this.Math.rand(1, 10);
			local item;

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
				item = this.new("scripts/items/weapons/woodcutters_axe");
			}
			else if (r == 6)
			{
				item = this.new("scripts/items/shields/wooden_shield_old");
			}
			else if (r == 7)
			{
				item = this.new("scripts/items/weapons/pickaxe");
			}
			else if (r == 8)
			{
				item = this.new("scripts/items/armor/leather_wraps");
			}
			else if (r == 9)
			{
				item = this.new("scripts/items/armor/linen_tunic");
			}
			else if (r == 10)
			{
				item = this.new("scripts/items/helmets/feathered_hat");
			}

			this.World.Assets.getStash().add(item);
			_list.push({
				id = 10,
				icon = "ui/items/" + item.getIcon(),
				text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
			});
		}
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_aggro = [];
		local candidates_other = [];
		local candidates_refugees = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().isCombatBackground() || bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.brute"))
			{
				candidates_aggro.push(bro);
			}
			else if (bro.getBackground().getID() == "background.refugee")
			{
				candidates_refugees.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.player") && bro.getBackground().getID() != "background.slave")
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_aggro.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		this.m.AggroDude = candidates_aggro[this.Math.rand(0, candidates_aggro.len() - 1)];
		this.m.InjuredDude = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_refugees.len() != 0)
		{
			this.m.RefugeeDude = candidates_refugees[this.Math.rand(0, candidates_refugees.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"aggro_bro",
			this.m.AggroDude.getName()
		]);
		_vars.push([
			"injured_bro",
			this.m.InjuredDude.getName()
		]);
		_vars.push([
			"refugee_bro",
			this.m.RefugeeDude != null ? this.m.RefugeeDude.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.AggroDude = null;
		this.m.InjuredDude = null;
		this.m.RefugeeDude = null;
	}

});

