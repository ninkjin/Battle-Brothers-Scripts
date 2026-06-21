this.greenskins_caravan_ambush_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_caravan_ambush";
		this.m.Title = "在路上…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_59.png[/img]{在爬一座小山的时候，你看到一队人马正沿着路行进。 他们正沿着小路走着，载重货车边的锅碗瓢盆叮当作响，孩子们把腿从边缘上甩下来，前面的女人用鞭子命令牲口前进。 男人们一起走着，看着地图，争论着，朝不同的方向做着手势，表示不同的地理观点。 然后，在路上更远的地方，在这队人马的视线之外，有几个哥布林躺在草地上。%randombrother% 也看到他们了，建议。%SPEECH_ON%先生，我们最好现在就下去帮忙，免得发生屠杀。%SPEECH_OFF%%randombrother2% 耸了耸肩。%SPEECH_ON%或者…我们先让哥布林行动，然后我们再冲进去收拾残局。 在一团糟的情况下，我们的战术优势是很大的，不是吗？%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "我们现在进攻！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们等着哥布林先进攻，然后再冲锋！",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我们不需要卷入这件事。继续行军！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_48.png[/img]{你不会为了战术上的优势而牺牲这些无辜的人！ 你命令士兵现在就进攻。 哥布林一听到声音就转过身来。 在远处，农民们看到前方的危险，纷纷撤离。 看来你已经救了他们，但现在你必须面对整个哥布林军团！}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.GoblinsTracks;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.GoblinRaiders, this.Math.rand(90, 110) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						_event.registerToShowAfterCombat("AftermathB", null);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "AftermathB",
			Text = "[img]gfx/ui/events/event_83.png[/img]{哥布林们被解决干净后，农民们慢慢地把他们的载重货车拉回来。 他们敬畏的看着这个场景。 一个人与你握手。%SPEECH_ON%敬畏古老的神明，我们会把你们的善行告诉所有人的，%companyname%！%SPEECH_OFF%剩下的人则给了食物、亲吻还有很多感谢。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "我只是做了一点微小的贡献。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				this.World.Assets.addMoralReputation(3);
				local food = this.new("scripts/items/supplies/bread_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_60.png[/img]{你命令士兵们等待合适的时机。\n\n 当农民们沿着大路继续前进时，一群哥布林用一排毒箭拦截了他们。 争吵的人们倒下了，箭刺进他们的胸膛，他们肌肉僵硬、面部绷紧、身中剧毒。 其他几个男人从他们的妻子手中夺过缰绳，驾着载重货车打算逃跑。 一些拿着草叉的农夫占了出来，但是他们在哥布林们的突袭面前坚持不了多久。 看见哥布林们已经开始分散进攻，你命令 %companyname% 开始冲锋。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.GoblinsTracks;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Edge;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Random;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.GoblinRaiders, this.Math.rand(90, 110) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.Enemy);
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Peasants, this.Math.rand(40, 50) * _event.getReputationToDifficultyLightMult(), this.Const.Faction.PlayerAnimals);
						_event.registerToShowAfterCombat("AftermathC", null);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "AftermathC",
			Text = "[img]gfx/ui/events/event_83.png[/img]{战斗结束了。零零散散的农民们从战场的四面八方聚集过来。 一位老人和你握手。%SPEECH_ON%谢谢你，先生，如果你我们没有碰巧遇到你，我们就被这些绿皮混球杀光了！%SPEECH_OFF%但他还没来得及放开你的手，另一个年轻人就冲了过来，用手指指着你。%SPEECH_ON%胡说八道，老头，我看见山上那个混蛋一直在看！ 他把我们当诱饵！%SPEECH_OFF%老人把手向后一拉。%SPEECH_ON%好吧，我会的。见鬼去吧，佣兵！%SPEECH_OFF%好像你不在乎这句话似的。 你告诉老头子，你找到的任何东西都是你的。 如果他们想要抗议，你手上的家伙会劝说他们。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "认清你的位置，农民。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
				this.World.Assets.addMoralReputation(-2);
				local food = this.new("scripts/items/supplies/bread_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了" + food.getName()
				});
				local item = this.new("scripts/items/weapons/pitchfork");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_75.png[/img]{无论如何，这事情都与你无关。 你悄悄离开了现场，虽然有几个兄弟很不安，你让那些贫苦的农民遭受了如此可怕的命运，尤其是当整个王国都在试图在这些绿色野蛮人下生存的时候。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "没事的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						bro.worsenMood(1.0, "对你逃避战争让农民死去感到失望");

						if (bro.getMoodState() <= this.Const.MoodState.Neutral)
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
		if (!this.World.FactionManager.isGreenskinInvasion())
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 6)
			{
				return;
			}
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

