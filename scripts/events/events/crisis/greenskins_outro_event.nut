this.greenskins_outro_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_outro";
		this.m.Title = "在路上…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]你遇到一些来自 %randomnoblehouse% 的士兵。他们扭头看向你。%SPEECH_ON%晚上好，雇佣兵。%SPEECH_OFF%不确定他们是否要进攻，你对 %dude% 微微点头。他把武器放在伸手可及的地方，点了点头。 你把注意力转移到这些士兵身上，友好地向他们挥手致意。 他们的军官走上前来，嗤笑道。%SPEECH_ON%哦，雇佣兵，你们对我们还有点用处。%SPEECH_OFF%慢慢地，你放下你的手，把它悬在剑柄上。 你问这个人那是什么意思。他笑着说。%SPEECH_ON%你没听说么？战争结束了。 绿皮已经在 %randomtown% 溃败了，就在几天前。 侦察兵报告说看到他们这些混蛋到处往山上跑，互相厮杀，兽人杀哥布林，哥布林杀兽人，溃不成军。 所以，是的，贵族家族现在不需要为你的屁股付钱了，因为我们这些真正战士已经控制住局面了。 现在你和你那群可怜虫为什么不让开。 我们这些战士在行军，明白吗？%SPEECH_OFF%",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "我们让路，让这些王国的英雄过去。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "你收拾他，%dude%。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.updateAchievement("GreenskinSlayer", 1, 1);

				if (this.World.Assets.isIronman())
				{
					this.updateAchievement("ManOfIron", 1, 1);
				}

				if (this.World.Assets.isIronman())
				{
					local defeated = this.getPersistentStat("CrisesDefeatedOnIronman");
					defeated = defeated | this.Const.World.GreaterEvilTypeBit.Greenskins;
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
			Text = "[img]gfx/ui/events/event_05.png[/img]%dude% 伸手去拿武器，你却摇摇头。 军官朝雇佣兵们点了点头。%SPEECH_ON%最好拴着那条狗，明白吗？%SPEECH_OFF%你张开双臂，邀请士兵们“通过”一条他们知道已经走过的通道。 士兵们整装待发，军官得意地笑了。%SPEECH_ON%我知道你会做出正确的选择。 我们只是想找点乐子，是吗？ 你们这些小妞站好。%SPEECH_OFF%那个男人在经过时飞吻了一下。%dude% 站起来，就像有人打了他的母亲。 你让他坐回去，他很不情愿地坐了下来。 这些表演全是狗屁，但你不是那种会发脾气，让人送命的人。\n\n这件事确实让你怀疑是不是该把一切都结束了。 绿皮被打败了，你赚了足够的钱，可以永远离开这个世界了，但是你也不愿意余生都活在对“如果…”的疑惑中。\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%",
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
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]士兵们的军官瞪着你。%SPEECH_ON%照我说的去做，佣兵，否则会有麻烦的。%SPEECH_OFF%你不理他，又对 %dude% 点了点头。他站了起来，他的刀锋响亮地甩掉了灰尘。 士兵们转向这个雇佣兵。 他双手捧起武器，回头看着。 当军官开始说话时，%dude% 直言不讳地打断了他。%SPEECH_ON%嘘，小家伙。我看到你皮肤柔软。 看不出有什么伤痕。 眼睛和出生时一样新鲜。 手就像没碰过的蜡烛一样光滑。 如果你是那种喜欢战斗的人，你就会出现在你所提到的那些战斗中，而不是在这里的空气中小便。 我给你两个选择，因为我感觉很好。 第一个选择，你在听吗？ 第一种选择是这样的。 去你要去的地方，别再说一句该死的话。%SPEECH_OFF%他停下来举起两根手指。%SPEECH_ON%选项二是一个谜。 说出来，你就会学到的。%SPEECH_OFF%军官的眼睛睁得更大了，嘴巴也安静多了。 他瞥了你一眼，但你只能耸肩。 又过了一会儿，士兵们带着绝对的沉默匆匆离去。\n\n%dude% 哈哈大笑，但是这件事让你怀疑是不是该退休了。 你的未来还会有多少这样的错误？ 还要打多少仗？ 你还要埋葬多少死人？ 战队会在你为它建立的基础上做得很好。 但另一方面，如果你现在退休了，你会错过什么冒险呢？\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%",
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
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.hasNews("crisis_greenskins_end"))
		{
			local currentTile = this.World.State.getPlayer().getTile();

			if (!currentTile.HasRoad)
			{
				return;
			}

			if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.15)
			{
				return;
			}

			local brothers = this.World.getPlayerRoster().getAll();
			local most_days_with_company = -9000.0;
			local most_days_with_company_bro;

			foreach( bro in brothers )
			{
				if (bro.getDaysWithCompany() > most_days_with_company)
				{
					most_days_with_company = bro.getDaysWithCompany();
					most_days_with_company_bro = bro;
				}
			}

			this.m.Dude = most_days_with_company_bro;
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_greenskins_end");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dude",
			this.m.Dude.getNameOnly()
		]);
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		_vars.push([
			"randomnoblehouse",
			nobles[this.Math.rand(0, nobles.len() - 1)].getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

