this.civilwar_outro_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_outro";
		this.m.Title = "露营时…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_96.png[/img]当你待在帐篷里时，%dude% 突然进来了。他直言不讳。%SPEECH_ON%贵族们在谈话。那边有一个又大又漂亮的帐篷，他们就在里面。%SPEECH_OFF%你放下羽毛笔，答道。%SPEECH_ON%只是聊天？%SPEECH_OFF%雇佣兵耸肩。%SPEECH_ON%这里很安静。所以他们要么是在交谈，要么就是悄无声息地互相残杀。%SPEECH_OFF%你站起来，走出去。 清新的空气扑面而来，里面弥漫着香料的味道。 迎风望去，你发现了帐篷。 厨师们正忙着订购食物和其他材料。 仆人端着一碟碟肉、蔬菜和水果。 一个华丽的黑色帐篷，上面绣着金丝，里面住着贵族。 贵族的士兵们站在外面。他们不参加庆祝活动。 他们大部分时间都在打牌，偶尔也会互相看一眼。 有些人用血迹斑斑的亚麻布包扎。 一个人拄着拐杖，膝盖歪歪斜斜，形容枯槁。 你问 %dude% 这是怎么回事。 他朝现场点了点头。%SPEECH_ON%好吧，大约在一个小时前，你在看地图的时候，它们就在这驻扎了。 我们不想打扰你，但是，嗯，他们似乎打算留下来，你知道。%SPEECH_OFF%你可以好好看看这个高贵的帐篷。 透过它的开口，你可以看到头戴王冠的人隐隐约约地来回走动，头上的王冠闪闪发光。%dude% 吐了口唾沫，问道。%SPEECH_ON%好吧，你觉得这场战争谁赢了？%SPEECH_OFF%你吞了口痰，吐了口唾沫，摇了摇头。%SPEECH_ON%谁他妈在乎呢？%SPEECH_OFF%对你来说最重要的是，和平就意味着更少的合同。 又或许这是时候放下剑来享受你的克朗？ 或者说，让所有这些感情用事见鬼去吧，继续前进，带领你的队伍走向更伟大的未来？\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%",
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
				this.World.Combat.abortAll();
				this.World.FactionManager.makeEveryoneFriendlyToPlayer();
				this.World.FactionManager.createAlliances();
				this.updateAchievement("Kingmaker", 1, 1);

				if (this.World.Assets.isIronman())
				{
					this.updateAchievement("ManOfIron", 1, 1);
				}

				if (this.World.Assets.isIronman())
				{
					local defeated = this.getPersistentStat("CrisesDefeatedOnIronman");
					defeated = defeated | this.Const.World.GreaterEvilTypeBit.CivilWar;
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
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_civilwar_end"))
		{
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
		this.World.Statistics.popNews("crisis_civilwar_end");
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

