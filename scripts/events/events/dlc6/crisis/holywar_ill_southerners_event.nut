this.holywar_ill_southerners_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.holywar_ill_southerners";
		this.m.Title = "在途中…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_71.png[/img]{你遇到一个农庄，你本打算快速通过不料突然一扇门摆开了，一个男人从中倒出来，腿交叉过门厅，直到他平倒在前院。 拔出了剑，你检查了他。 翻过他显露出一张又绿又紫的脸，嘴上都是呕吐物与干掉的血，头发也不停的掉下来。 你离开他并进入农庄，在那里你找到了更多像他一样的人。 他们都南方人，染上了某种他们或许不了解的北方疾病。 通过他们装备的败坏程度，他们已经在这里待了有一段时间了。\n\n 其中一个南方人向你伸出他骨瘦如柴的手。%SPEECH_ON%求你了，将我们送往镀金者。 这个世界已经没有光了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们尊严的结束他们",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "愿苍蝇享用你衰老的肉体。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_71.png[/img]{南方人被杀得很有尊严，至少是剑能给予他们的最后那一点尊严。 当然，你在动手的时候保持着距离，不敢碰他们感染恶疾的身体。 在每一个患者都安息后，你环顾了农庄。 幸运的，或许是因为它们的材质很容易擦伤他们的皮肤，病人们把一些装备放在了边上。 你让兄弟们把它擦干净后带上了路。 在离开的时候，有的人发牢骚，认为这些人应该承受更多折磨，但是其他人对于这种仁慈没有意见。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他们最好别再受苦了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local amount = this.Math.rand(10, 20);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 工具和补给"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						continue;
					}

					if (bro.getEthnicity() == 1 && this.Math.rand(1, 100) <= 66)
					{
						bro.improveMood(1.0, "认可你决定结束镀金者同胞的痛苦");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66)
					{
						bro.worsenMood(0.75, "不喜欢你结束了南方侵略者的苦难");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_71.png[/img]{有些南方人的装备被脱下放在房间四周。 你让佣兵们拿了这些并把他们擦干净。 走到前门，你点着了一个火炬并告诉他们镀金者很快会以他的真身会见他们。 士兵们乞求怜悯，一堆扭曲的身影向你爬来，虚弱的哀嚎着他们心中的恐惧。 你关上了门并点燃了屋顶之后将火炬丢入了窗户。\n\n你指导过你的手下不要把这种决策个人化，但是怀疑有些 %companyname% 的人在这件事上不顾这些。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他们不该入侵北方。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local amount = this.Math.rand(10, 20);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 工具和补给"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						continue;
					}

					if (bro.getEthnicity() == 1 && this.Math.rand(1, 100) <= 66)
					{
						bro.worsenMood(1.0, "不喜欢你让镀金者的同胞慢慢死去");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66)
					{
						bro.improveMood(0.75, "认可你让南方侵略者去死的决定");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
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

		if (!this.World.FactionManager.isHolyWar())
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Desert || currentTile.Type == this.Const.World.TerrainType.Steppe || currentTile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local closest = 9000;

		foreach( t in towns )
		{
			local d = t.getTile().getDistanceTo(currentTile);

			if (d < closest)
			{
				closest = d;
			}
		}

		if (closest < 7 || closest > 20)
		{
			return;
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

