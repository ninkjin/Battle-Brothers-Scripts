this.dried_oasis_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Slayer = null
	},
	function create()
	{
		this.m.ID = "event.dried_oasis";
		this.m.Title = "在途中…";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{沙漠里的景象是如此的一致以至于绿色非常惹眼。 这就是绿洲的吸引力。 你很远就看到了它，而随着你靠近你意识到这个绿东西不是树，而是枯树上飘荡的旗帜。 在边上有更多枯树，有的陷入了沙漠，沙子从四面八方侵蚀着它。 在这个曾经的绿洲中央有一具面朝一片碗状土地的骷髅，或许这里曾经有过水。 骷髅边上是一堆宝藏。 满是克朗，但没有一滴水可以买。\n\n 你拿起金子，但硬币随你移动，滑开变成一条黑蛇，挺起身向你发出嘶嘶声。 绿色的毒液从它的獠牙上滴下。}",
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
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				});

				if (_event.m.Slayer != null)
				{
					this.Options.push({
						Text = "%beastslayer% 能对付这个小怪物。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "这不值得我们费心。",
					function getResult( _event )
					{
						return "E";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{%brother% 拿着他的武器走上前。 蛇弓起身然后他干净利落的捅过了它，瞬间杀死了这个生物。 他用剑的末端举起它，扭了一下后将它丢到一旁。%SPEECH_ON%我接过最轻松的活。%SPEECH_OFF%他说着这笔财富便被收入战队的仓库。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				local money = this.Math.rand(100, 300);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%terrainImage%{%brother% 拿着他的武器走上前。 蛇弓起身，他笑着用他的武器捅下去。 蛇蛇灵地侧爬上剑并咬向他抓着柄的指关节。 尖叫着，他往后退，人们接住他并把他拖开了。 很快他就开始抽搐口吐白沫还有他的手肿胀和化脓。\n\n你相信他会活下来的，只是会花很长时间才能再次战斗。 至于宝藏，它在沙中漂着而你只能看着它慢慢的像入水一样滑入沙丘。 当你探身来看最后一点都消失，更多的黑蛇出现，好似要告诫你这些宝藏的所属者：它现在而且永远的是沙漠的宝藏了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不错的尝试。",
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
				_event.m.Dude.worsenMood(1.5, "被沙漠蛇咬了");
				local injury = _event.m.Dude.addInjury([
					{
						ID = "injury.pierced_hand",
						Threshold = 0.25,
						Script = "injury/pierced_hand_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Dude.getName() + " 遭受 " + injury.getNameOnly()
				});
				local effect = this.new("scripts/skills/injury/sickness_injury");
				_event.m.Dude.getSkills().add(effect);
				this.List.push({
					id = 11,
					icon = effect.getIcon(),
					text = _event.m.Dude.getName() + "是生病了"
				});

				if (_event.m.Dude.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 12,
						icon = this.Const.MoodStateIcon[_event.m.Dude.getMoodState()],
						text = _event.m.Dude.getName() + this.Const.MoodStateEvent[_event.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "%terrainImage%{%beastslayer%俯视着蛇，他点着头仿佛在回想起以前的课程。%SPEECH_ON%你只会在沙丘中找到这品种，剧毒。%SPEECH_OFF%大蛇向他嘶嘶作响。他点着头突然伸手抓住蛇的头。%SPEECH_ON%你的毒只会留在你的嘴中，小家伙，但我可以在任何地方运用它。我想你会明白这一点的。%SPEECH_OFF%他打碎了蛇头后用小刀将其完整切下，之后他用手指按住蛇的长条尸体，再次点头。%SPEECH_ON%我会让这条蛇派上用场，我也相信队长你会用好这些宝藏。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你在这真是太好了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Slayer.getImagePath());
				local money = this.Math.rand(100, 300);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
				local item = this.new("scripts/items/accessory/antidote_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Slayer.improveMood(1.0, "把他的专长应用在生物上");

				if (_event.m.Slayer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Slayer.getMoodState()],
						text = _event.m.Slayer.getName() + this.Const.MoodStateEvent[_event.m.Slayer.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "%terrainImage%{你听说过这种蛇可以让人当场毙命。 意识到这种威胁，你觉得这不值得并把宝藏留在原地。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们继续前进！",
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

		if (currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 8)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local candidates_slayer = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.beast_slayer")
			{
				candidates_slayer.push(bro);
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

		if (candidates_slayer.len() != 0)
		{
			this.m.Slayer = candidates_slayer[this.Math.rand(0, candidates_slayer.len() - 1)];
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
			this.m.Slayer != null ? this.m.Slayer.getName() : ""
		]);
		_vars.push([
			"brother",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Slayer = null;
	}

});

