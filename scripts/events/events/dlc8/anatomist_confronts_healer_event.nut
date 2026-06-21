this.anatomist_confronts_healer_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Monk = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_confronts_healer";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_20.png[/img]{你进入%townname%，看到一个白胡子慷慨激昂地帮助一家人治疗他们的生病孩子。对你而言，这情景并不稀奇。但对解剖师%anatomist%而言，这里出现了一些极大的冒犯。他迅速走到路对面的老人身边，你跳到他面前拦住他，感觉他的行为可能会给整个%companyname%带来负面影响。%anatomist%站直了身子。%SPEECH_ON%打扰一下，这个人正在提供错误的医疗建议，我需要纠正他。%SPEECH_OFF%你提醒他要注意本地的风俗习惯，插手这些事情可能会有不智之处，而老人几乎肯定是乡里人的代表。他可能也非常重要，比如监督当地的民兵组织。但解剖师对这个任务非常努力，他想要武装自己的知识并使用它，即使这会撕裂当地的政治局势。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去纠正他吧。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "不值得惹恼当地人。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "（队长）%monk%，你能劝劝他吗？",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_17.png[/img]{你沉思了一会儿，决定任由解剖学家为所欲为。离开一旁，你转身观察着周围的情况，希望这次事件不会比这个自以为是的杂碎已经做过的更丢%companyname%的脸。%anatomist%走到老人身边，他们对视了一会儿，这时几个农民也看了过来。解剖学家蹲了下来，问老人他的观点是否正确。\n\n出人意料的是，老人愿意接受他的建议，两人一起坐下聊了很长时间。镇民们并没有被外来者的意见所冒犯，相反，他们对这些知识充满了好奇。虽然有些琐碎的细节存在争议，但%anatomist%自己被这种接待所感动，他随手挥了挥手，甚至撒谎说这些问题仍然有待医学界的研究，来化解这些分歧。等当一切结束时，解剖学家将一些笔记交给老人，村民们也用食品和物品表示感谢。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一切顺利。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "向一个愿意接受的听众提供医疗建议。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(100, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+100[/color] 经验值"
				});
				local food;
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					food = this.new("scripts/items/supplies/cured_venison_item");
				}
				else if (r == 2)
				{
					food = this.new("scripts/items/supplies/pickled_mushrooms_item");
				}
				else if (r == 3)
				{
					food = this.new("scripts/items/supplies/roots_and_berries_item");
				}

				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_141.png[/img]{你思考了一会儿，最终决定让解剖学家随心所欲。你侧步而退，转身观看着这场闹剧，希望这不会让%companyname%的名声变得更糟。%anatomist%走到老人身边，他们对视了一会儿，一些农民也盯着他们看。解剖学家蹲下来问老人是否意识到他是个江湖骗子。你捂着头。老人站起来，把解剖学家向后推了一下。%SPEECH_ON%你到底是哪里来的，又带着一箱子花言巧语，是吧？%SPEECH_OFF% 解剖学家举起手来，试图解释他来自一所受过良好教育的学校，突然之间一个农民走到他身旁，打了他一巴掌，把他打倒在泥里。%companyname%的成员冲上去保护解剖学家，在混战中又交换了几拳，但好在最终没有太大的事端。你让%anatomist%重新加入队伍，并下令大家平静下来，以免把%companyname%卖剑手的一面暴露在观众面前。老人点头表示他不希望把这些事情拿给警卫队看。看来大家勉强避过了更加惨烈的斗争。%anatomist%只是看着鼻子里的血，思考是否有人在计算凝固所需的时间。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的傻瓜。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.0, "医疗建议被拒绝了。");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Anatomist.getName() + "遭受轻伤"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 10)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%anatomist%向你走来，想从你身边穿过去，但你伸手挡住了他。你解释说，纠正当地人的习俗和信仰是危险的，而你作为一个佣兵已经不受信任，被看成是不良分子。你最不需要的就是让村民的传统受到更多的冒犯。解剖学家抗议，但你并不动摇。如果他想要一直去纠正每一个人的一切，他可以回到他来的学校或大学。最终，%anatomist%默默离开。你回头看镇长时，恰好看到他咬下一只青蛙的头并把它的血倒入一个碗中进行未来的占卜。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们上路吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.0, "被拒绝纠正不当的医疗行为的机会。");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_40.png[/img]{当%anatomist%试图移动时，僧侣%monk%介入了。他站在解剖学家身边，平静地解释说，仅仅因为某人错了，并不意味着外国一方必须介入并纠正他们。在公众的眼中，失去面子不会因为被纠正的个人而结束，它只会把批判的光芒再次照回那个批评的人身上。%anatomist%思索了一段时间。%SPEECH_ON%你是在告诉我，这里的错误不在于提供的劣质建议，而在于整个社区被谎言所污染，事实的到来会不会煽动维护错误信仰的热情？%SPEECH_OFF%僧侣皱起嘴唇耸了耸肩。%SPEECH_ON%是的。%SPEECH_OFF%解剖学家没有进一步反驳，走开了，也许还在考虑某些科学要素。他走后，僧侣摇了摇头。%SPEECH_ON%我只是不希望他变成一个混蛋，让%companyname%陷入比必要更多的麻烦中。%SPEECH_OFF%你同意，感谢僧侣用更好的话来表达这个观点，而这比你说的话更恰当。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "谢谢，%monk%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(0.5, "学会了如何处理农民。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(50, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+50[/color] 经验值"
				});
				_event.m.Monk.improveMood(1.0, "停止了。" + _event.m.Anatomist.getName() + "玷污战团声誉");

				if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}

				local resolveBoost = this.Math.rand(1, 2);
				_event.m.Monk.getBaseProperties().Bravery += resolveBoost;
				_event.m.Monk.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Monk.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] 决心"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Monk.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local monkCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk")
			{
				monkCandidates.push(bro);
			}
		}

		if (monkCandidates.len() > 0)
		{
			this.m.Monk = monkCandidates[this.Math.rand(0, monkCandidates.len() - 1)];
		}

		if (anatomistCandidates.len() > 0)
		{
			this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		}
		else
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Monk = null;
		this.m.Town = null;
	}

});

