this.sellsword_vs_bees_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Wildman = null
	},
	function create()
	{
		this.m.ID = "event.sellsword_vs_bees";
		this.m.Title = "在途中…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{沙漠里几乎没有什么沙子以外东西。 所以一颗单独立在那的树很吸引眼球，更奇怪的是树枝上还有个肥厚的蜂巢和一片工蜂围绕着它。 这个距离上你已经可以看到蜂巢里蜂蜜金色的闪光…}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "来个人拿住它！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "Good" : "Fail";
					}

				});

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "看起来 %wildmanfull% 想去试试。",
						function getResult( _event )
						{
							return "Wildman";
						}

					});
				}

				this.Options.push({
					Text = "我们走。这没我们好果子吃。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "%terrainImage%{%chosen% 自信的走向树，蜜蜂好似被他的存在驱赶开一样。 它们的振翅声带着愤怒的震动越来越大了，但是除此之外他们没有发起攻击。 他小心的挖些蜂蜜到罐子里并后撤回来。 他回到战队里。%SPEECH_ON%轻而易举，小伙子们。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "尽管显摆把，但蜂蜜我们都有份！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.75, "在沙漠里享受蜂蜜");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "Fail",
			Text = "%terrainImage%{%chosen% 伸展了下他的手指。%SPEECH_ON%像从个婴儿手中偷糖果一样。%SPEECH_OFF%他走向树，站在蜂窝下。 他摆着姿势指向它，笑着，然后举起手－令所有人震惊的－去抓整个蜂窝。 蜜蜂们一瞬间就淹没了他，而他丢下蜂巢就开始跑，一片愤怒的嗡嗡着的云赶着他下了一个沙丘。 他滚啊滚，他的喊叫声每次飞出沙子的时候都会传出来，最后他落在底端，一层沙遮住他免于更多的叮刺。 你等了一会才去救他，不然蜜蜂们会知道你也是这场未遂盗窃的一份子。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们最好不要再来一次那个。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Dude.addHeavyInjury();
				_event.m.Dude.worsenMood(2.0, "被蜜蜂残忍地对待");
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Dude.getName() + "遭受重伤"
				});

				if (_event.m.Dude.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Dude.getMoodState()],
						text = _event.m.Dude.getName() + this.Const.MoodStateEvent[_event.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Wildman",
			Text = "%terrainImage%{你确定野人 %wildman% 在他森林生活中见过一个两个蜂窝。 他嘟囔着指向蜂窝然后他自己。你点头。 他再次嘟囔着走上沙丘到树那里，而你在安全距离观察着他。 在他站在蜂窝下的时候，他又一次喊了一声，手围在嘴边好让你听清楚。 他指着蜂窝。 你再次点头并对蜂窝做出进攻性的指指点点。 这是这几里内唯一一个蜂窝，有什么难理解的？ \n\n 野人转向蜂窝。 他把一个手臂弯向身后。 那…那不是你想看到的。 他打量着蜂窝，吐出舌头眯着眼。 你赶快向前跑，对着他喊，但他已经上了。 他击出一拳，绝对性的毁灭了蜜蜂。 蜂窝块黏糊糊的围绕他的手腕好像他毛茸茸的手臂是什么还没准备好节日装饰的柱子。 野人轻松的向回走下沙丘。 随着他靠近，你看到蜜蜂爬满了他的脸并且像他们应该的那样愤怒的叮着他，但是他好像根本没察觉到他们的存在似的。 他举起他的蜂蜜爆破留下的松脆的残留物就好像一头猛兽的心脏似的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "干得好...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Wildman.getName() + "遭受轻伤"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 50 || bro.getID() == _event.m.Wildman.getID())
					{
						bro.improveMood(0.75, "在沙漠里享受蜂蜜");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 5)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local candidates_wildman = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
			else
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Dude = candidates[this.Math.rand(0, candidates.len() - 1)];

		if (candidates_wildman.len() != 0)
		{
			this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getNameOnly() : ""
		]);
		_vars.push([
			"wildmanfull",
			this.m.Wildman != null ? this.m.Wildman.getName() : ""
		]);
		_vars.push([
			"chosen",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Wildman = null;
	}

});

