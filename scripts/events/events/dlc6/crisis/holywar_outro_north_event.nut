this.holywar_outro_north_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holywar_outro_north";
		this.m.Title = "露营时…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_84.png[/img]{对旧神们的虔诚信仰得到了回报：圣战结束了，北方人获得了胜利。 喜乐随着人群摆动，好友击着拳，旗帜飘扬，一切都以一种虔诚感而团结起来。 你站在路边，你的肩膀上环绕着装饰品，念珠，项链，没有什么物质价值的东西，但同时它们有一种只有在看入那些交出它们的人的眼睛时才能感到的重量。\n\n 当然，一些美德在庆祝中被无视了：败者的尸体被摆出展示，鞭打过，仿佛是为了满足注视着的旧神一般，还有镀金者的神圣图腾，被嘲弄，亵渎，并最终烧掉。 很显然没有一个欢快的灵魂在这种庆祝的高潮中承认你的贡献。 你只不过又一次滑入了幕后，佣兵，逐币者，入侵者。 但是 %companyname% 在这一系列宗教活动中收获不少。 抛开欢言笑语，你知道这种争端只是埋在了脑海中，而不是土里，总有一天什么人或什么东西会回来复活它，在那时战队将等到又一个荣耀的发薪日。 又或许现在是放下剑享受你挣到的克朗的好时候？\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%}",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "%companyname% 需要他们的指挥官！",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "是时候从雇佣兵生活中退休了。 （结束战役）",
					function getResult( _event )
					{
						this.World.State.getMenuStack().pop(true);
						this.World.State.showGameFinishScreen(true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Combat.abortAll();
				this.World.FactionManager.makeEveryoneFriendlyToPlayer();
				this.World.FactionManager.createAlliances();
				this.updateAchievement("CulturalMisunderstanding", 1, 1);

				if (this.World.Assets.isIronman())
				{
					this.updateAchievement("ManOfIron", 1, 1);
				}

				if (this.World.Assets.isIronman())
				{
					local defeated = this.getPersistentStat("CrisesDefeatedOnIronman");
					defeated = defeated | this.Const.World.GreaterEvilTypeBit.HolyWar;
					this.setPersistentStat("CrisesDefeatedOnIronman", defeated);

					if (defeated == this.Const.World.GreaterEvilTypeBit.All)
					{
						this.updateAchievement("Savior", 1, 1);
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_84.png[/img]{低语他们的名字是将言语从舌尖变为非世俗的事物：旧神。 他们是超越时间的，他们的数量让人对明确性敬而远之。 对于不论对宗教熟悉与否的听众而言可喜的是，它同样在那些追随这些不明确个体的人在落败时给予巨大的压力。 圣战结束了，北方人输了。\n\n 你看着北方人互相试着解释这一切是怎么发生的。 这不是地上人的失败，也不是南方人的胜利－不，这是惩罚。 北方人放牧到了离圣地太远的地方，他们沉沦在物质世界的草场中，修道院与教堂点缀着国土，空洞已久，太久。 很自然的，对南方的所谓“镀金者”的调查也曾有过，但是他们很快就过去了。 即使是停留在他身上，也会引起怀疑，而现在怀疑就像毒药一样危险。 当然，%companyname% 保持着距离。 作为一个佣兵你的信仰在于剑和钱袋上，这两个都得到了这场战争中它们应得的。 在接下来的日子里，你唯一要做的哲学思考就是思考南北两国多久会重新开始陈述他们的分歧。 又或许这是时候放下剑来享受你的克朗？\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%}",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "%companyname% 需要他们的指挥官！",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "是时候从雇佣兵生活中退休了。 （结束战役）",
					function getResult( _event )
					{
						this.World.State.getMenuStack().pop(true);
						this.World.State.showGameFinishScreen(true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Combat.abortAll();
				this.World.FactionManager.makeEveryoneFriendlyToPlayer();
				this.World.FactionManager.createAlliances();
				this.updateAchievement("CulturalMisunderstanding", 1, 1);

				if (this.World.Assets.isIronman())
				{
					this.updateAchievement("ManOfIron", 1, 1);
				}

				if (this.World.Assets.isIronman())
				{
					local defeated = this.getPersistentStat("CrisesDefeatedOnIronman");
					defeated = defeated | this.Const.World.GreaterEvilTypeBit.HolyWar;
					this.setPersistentStat("CrisesDefeatedOnIronman", defeated);

					if (defeated == this.Const.World.GreaterEvilTypeBit.All)
					{
						this.updateAchievement("Savior", 1, 1);
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.18)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Contracts.getActiveContract() != null)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_holywar_end"))
		{
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_holywar_end");
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		local north = 0;
		local south = 0;
		local sites = [
			"location.holy_site.oracle",
			"location.holy_site.meteorite",
			"location.holy_site.vulcano"
		];
		local locations = this.World.EntityManager.getLocations();

		foreach( v in locations )
		{
			foreach( i, s in sites )
			{
				if (v.getTypeID() == s && v.getFaction() != 0)
				{
					if (this.World.FactionManager.getFaction(v.getFaction()).getType() == this.Const.FactionType.NobleHouse)
					{
						north = ++north;
					}
					else
					{
						south = ++south;
					}
				}
			}
		}

		if (north >= south)
		{
			return "A";
		}
		else
		{
			return "B";
		}
	}

	function onClear()
	{
	}

});

