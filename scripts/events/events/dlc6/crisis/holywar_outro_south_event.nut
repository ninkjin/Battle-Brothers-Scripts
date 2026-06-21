this.holywar_outro_south_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.holywar_outro_south";
		this.m.Title = "露营时…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_84.png[/img]{你回想起镀金者的追随者们曾经团结在他们抗衡旧神们的追求中。 有些人误认为，如果他们让他们的神足够满意，他就会将他强大的眼睛用来把他忠实的信徒们的敌人摧毁。 与之相对，镀金者发现他们的意志面临着极大的考验：他们在这场圣战中输了。 城市，城镇都被烧毁了，神圣的图腾被亵渎，圣地亦被洗劫一空。\n\n 大量的人群散乱的在街上游荡，时不时号啕大哭，没有什么明确的目的，只是如同他们失去了能够表述他们现在承受的痛苦的所有言语。 时不时的，一个尸体就会从上面掉下来，你看到卫兵们从井中捞出尸体时旁观者中的一个女人自己投身进去。 数个人伏在金制的圣物前，任自己受其上纹章在阳光下反射出的光线灼烧，饱受悲伤煎熬的悲怆者趴在炙热的反射下直到他们的皮肤结成硬壳，喉咙因他们自己的血咳嗽，日升日落，他们就这么承受着它的注视。 至于 %companyname%，你投身于其中一方或另一方，不论输赢，你获得了一份微小的财富。 对于未来，你也无需期盼这样的机会再次出现：如果关于信教者有什么是你可以确信的，那便是失败不过是愈加硬化的钢铁上的一击而已。 以你的成就，或许现在是时候放下剑享受你挣到的克朗？\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%}",
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
			Text = "[img]gfx/ui/events/event_84.png[/img]{对镀金者虔诚的信仰得到了回报：圣战结束了，南方人获得了胜利。 维齐尔，议员，神职者之类在街道上，每一个都乘坐着巨大的载重货车，轮子被奴隶替代了的车。 尤其是北方奴隶，因他们对镀金者的罪孽而负债。 你几乎看不到那些人，只是他们的腿在阴影下的黑影，就好像甲虫成队列在前进一般。 富有而奢侈的人们举起巨大的酒杯向欢呼的忠实信徒们抛出看起来像是金色的水的东西。 你自己探身去检测这些泼洒，只发现这原来不过是染过色的水。\n\n 尽管这种假冒的财富只能够满足你的口渴，旧神与镀金者信徒间真实的战争本身已经把 %companyname%的宝箱塞满了。 作为一个逐币者，你从未受到过光头的和屈身的人的尊重，也没有农民的拜倒，亦没有重到一个人搬不动的黄金的微光。 这就是你的现实，但是那不会阻止你的战队在下一次虔诚者们想要争论什么是正义时做好准备。 又或许现在是放下剑享受你挣到的克朗的好时候？\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%}",
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

		if (currentTile.SquareCoords.Y > this.World.getMapSize().Y * 0.18)
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

