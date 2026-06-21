this.civilwar_hungry_hamlet_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_hungry_hamlet";
		this.m.Title = "在路上…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]{当你在路上走的时候，你遇到了一个小村庄，很明显，几乎所有人都站村外。 他们的村长向前走了几步，伸出双手，恳求着，尽管他虚弱的几乎没有力气把双手合在一起。%SPEECH_ON%拜托，你能帮帮我们吗？ 我们已经将近一个星期没有食物吃了。 我们只能吃土了！ 我们已经什么都没有！ 战争蹂躏了我们所有人。%SPEECH_OFF% | 在你的旅途的路旁出现了一个小村庄，如果不是因为似乎外面站着一大群村民在等你的村民，这只不过是旅途路上的匆匆一瞥。他们的村长走上前来。%SPEECH_ON%雇佣兵，我知道你不是那个能保护我们的人，但是你有多余的食物吗？ 战争蹂躏了我们的庄稼，在这片土地上游荡的士兵们拿走了我们的一切！ 求求你，救救我们！%SPEECH_OFF% | 这条路通向一个小村庄。 村民们蹲在他们的村子外面，头埋在膝盖之间，看上去又瘦又灰。 孩子们和他们在一起，身体虚弱，精力充沛，但他们眼中仍闪烁着青春的光芒。 村长亲自来找你。%SPEECH_ON%先生…是佣兵？是的，佣兵。 求求你，我们已经一个星期没吃东西了。 我们靠我们的宠物，昆虫生存…甚至是泥土。 你能帮帮我们吗？%SPEECH_OFF% | 当你的人在路边休息的时候，附近一个村庄的村民来找你们。 他们蹒跚向前，瘦削的腿从一边到另一边摇晃着。 一群人的头抬起或者低下一只手，好像在祝福你的存在。%SPEECH_ON%噢，佣兵，请问，你有什么吃的吗？ 我们已经两天没有吃东西了！ 我们这几天所吃的，一些根本不能说的东西！ 贵族之间的战争毁了这个地方，你能帮帮我们吗？%SPEECH_OFF%}",
			Characters = [],
			Options = [
				{
					Text = "好吧，给那些可怜的人们一些食物。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(3);
						local r = this.Math.rand(1, 3);

						if (r == 1)
						{
							return "B";
						}
						else if (r == 2)
						{
							return "C";
						}
						else if (r == 3)
						{
							return "D";
						}
					}

				},
				{
					Text = "自力更生吧，农民们。",
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
			Text = "[img]gfx/ui/events/event_79.png[/img]{你不是唯利是图的雇佣兵，你选择给穷人一些食物。%randombrother% 被告知要尽可能的分给每个穷人，虽然这样每个人就分不到太多。 村民们感激不尽，他们涌向佣兵，仿佛他要低声说出一个惊天大秘密似的。 这儿的村长说他会传播你的善意。 你实际上并不确定利他主义的新闻是否对雇佣兵团有好处… | 你命令 %randombrother% 给村民分发食物，这个命令震惊了村民。 你没给太多，给的刚好够这些人吃。 显然，不要放弃任何太好的东西！\n\n 这儿的村长向你走来，握着你的手拍着你的肩膀。%SPEECH_ON%你根本不知道这对我们意味着什么！ 所有人都会知道的…%SPEECH_OFF%他瞥着你，然后看着你的旗帜。你点头。%SPEECH_ON%%companyname%。%SPEECH_OFF%这个人笑了笑。%SPEECH_ON%每个人都该知道 %companyname% ！%SPEECH_OFF%}",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "他们在未来几天会好点吗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.distributeFood(this.List);
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_79.png[/img]{善良占了上风: 你命令 %randombrother% 开始分发食物。 他答应了，但是当他开始分发的时候，人群几乎疯狂地互相抢夺。 暴躁的脾气很快被空腹的空气所助长。 雇佣兵试图维持秩序，但他所说的一切只会促使饥饿的群众认为这都是他的错。 暴力蔓延开来，具有讽刺意味的是，所有的食物都洒进了泥里。 你的兄弟们必须拔出剑，最后一些农民死了，而幸存者用食人的眼睛看着尸体。\n\n在情况变得更糟之前，你迅速命令 %companyname% 继续前进。 | 出于某种原因，也许为了晚上睡得更好，你命令 %randombrother% 去分发食物。 但他才刚刚开始分发，一个村民就迅速抓起一袋食物。 在旁边的另一个农民把那个村民的头放进炉子里，自己拿袋子。 这很快就演变成一场混战，你的雇佣兵们必须拿出武器来保护其他的粮食。 混战结束时，几个村民死了，你的手下们也受了点伤。 看到没有理由留下来，你命令大伙重新上路。 在远处，你发现了乞求你们帮助的村长，他凝视着远方的地平线，一股刺骨的寒风把他的破裤子卷在小腿上。}",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "事情居然就这样搞砸了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.distributeFood(this.List);
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_79.png[/img]好吧。生活是残酷的，为什么不做点让世界更美好的事情呢？ 你命令 %randombrother% 去分发食物，不要发太多，但每个人都要有。 但就在他刚刚分完食物之后，些许 %noblehouse% 的手下出现了。 他们从饥饿的人群中筛选，拿走食物，每当有人反抗时就拔剑。 他们所谓的头子狂妄的说。%SPEECH_ON%这些食物是 %noblehouse% 所需要的。不准拒绝我们。%SPEECH_OFF%你向那个人解释说，这实际上是你的食物，而你只是把它们分发出去。%SPEECH_ON%如果是你的食物，为什么在他们手里？ 去吧，伙计们，尽你们所能！ 别轻举妄动，佣兵，否则我们就不客气了。%SPEECH_OFF%%randombrother% 瞥了你一眼，就好像在说，我们该怎么办？",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "这是我们的食物，只有我们才能决定怎么处理它！",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				},
				{
					Text = "那是我们的食物，但这不是我们的战斗。",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.distributeFood(this.List);
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_79.png[/img]军官转向他的士兵，指挥他们抢夺。 你拔出剑，一瘸一拐地走过去，身体一侧的疼痛仍然挥之不去，但是悄悄接近一个男人并不费劲。 你用匕首抵着他脖子，你向他手下的其他人喊道。%SPEECH_ON%你真的想要暴力吗？%SPEECH_OFF%军官举起手，尖声说出了一些话。%SPEECH_ON%等等，等等，都停下。 我想我们，呃，犯了个错误。 伙计们，我们走错村庄了。%SPEECH_OFF%在释放他之前，你先用匕首刺伤了他。 当食物回到农民手中时，他们高兴极了。 毫无疑问，贵族们会听说你在这里所做的“好事”，但是普通人也会听说。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "有时候犯傻感觉很好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "你威胁他们的一些人");
				this.World.Assets.addMoralReputation(3);
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess * 2);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_79.png[/img]你抓住军官的肩膀把他拉近。 他抓住你的胳膊，把你扔了出去，然后用同样的动作拔出他的剑。 你跳到他身边，挡住了他拔剑，然后迅速拔出匕首，刺入他的脖子。 他的士兵从人群中匆匆而来，但是你的雇佣兵把他们砍倒了，农民们用只有饥饿才能创造出来的残忍把他们杀死。 军官慢慢地从你的手里滑了下来。 你低头看着他那双发黑的眼睛。%SPEECH_ON%对，我们确实不客气了。%SPEECH_OFF%农民们对结果欢呼雀跃，尽管你建议他们埋葬尸体，或者，更好的是，不再留在这里。 毫无疑问，一支军队会想知道这些来征粮的人去了哪里。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "我们也该走了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationOffense, "你杀了他们的一些人");
				this.World.Assets.addMoralReputation(1);
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess * 2);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				local brothers = this.World.getPlayerRoster().getAll();
				local bro = brothers[this.Math.rand(0, brothers.len() - 1)];
				local injury = bro.addInjury(this.Const.Injury.Accident1);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = bro.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_79.png[/img]你通知你的人撤退。 老百姓哀号着，因为他们的食物又被夺走了。 这是一个可怕的哭声，许多人诅咒你，说他们宁愿你从来没有出现过，也不愿意被这样折磨。 | 给予食物是一回事，与士兵战斗是另一回事。 你告诉士兵们不会有战斗，他们可以继续前进。 村民们叫喊着，乞求你阻止这一切。 有些人虚弱得什么也说不出来，这种突如其来的事态变化比长达数周的饥饿对他们的打击更大。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Sorry...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.World.Assets.addBusinessReputation(-this.Const.World.Assets.ReputationOnContractSuccess);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队失去了声望"
				});
			}

		});
	}

	function distributeFood( _list )
	{
		local food = this.World.Assets.getFoodItems();

		for( local i = 0; i < 2; i = ++i )
		{
			local idx = this.Math.rand(0, food.len() - 1);
			local item = food[idx];
			_list.push({
				id = 10,
				icon = "ui/items/" + item.getIcon(),
				text = "你失去了 " + item.getName()
			});
			this.World.Assets.getStash().remove(item);
			food.remove(idx);
		}

		this.World.Assets.updateFood();
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

		local food = this.World.Assets.getFoodItems();

		if (food.len() < 3)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= bestDistance)
			{
				bestDistance = d;
				bestTown = t;
				break;
			}
		}

		if (bestTown == null)
		{
			return;
		}

		this.m.NobleHouse = bestTown.getOwner();
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
	}

});

