this.holywar_sand_storm_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.holywar_sand_storm";
		this.m.Title = "在途中…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_161.png[/img]{你遇到一队半埋进沙子的士兵。 北方人，扎营过夜时被卷入沙尘暴。 他们在痛苦中哀嚎，至少还在活着那些。 有的人皮开肉绽，而其他的已经在被蝎子与秃鹫啄着。 看起来有的选择了自杀。 没有一个人可以被拯救，他们只是艰难的扒在终结的边缘。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有尊严地杀了他们。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "将他们留给沙漠。",
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
			Text = "[img]gfx/ui/events/event_161.png[/img]{拔出你的剑，你询问他们是否接受你所给予他们的尊严。 他们太渴，太饿，难以说话，但是几个人点头了。 其中一个在他能回答前便死去了。 你走过每一个人，蹲下，愿他们安息，并将剑推入。 皮肤在锋刃下裂开，正在死去的人们因疼痛短暂的恢复一丝活力后便不情愿的离开了这个世界。 队伍里的几个人对此有不同的意见。\n\n你让佣兵们拿上他们可以带走的，尽管大部分的装备都被狂躁的沙漠损坏了。}",
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

					if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66)
					{
						bro.improveMood(1.0, "同意你结束北方同胞苦难的决定");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getEthnicity() == 1 && this.Math.rand(1, 100) <= 66)
					{
						bro.worsenMood(0.75, "不喜欢你结束了北方侵略者的苦难");

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
			Text = "[img]gfx/ui/events/event_161.png[/img]{你命令佣兵们从半死不活的士兵们身上扒下任何有用的装备。 十字军只能随着他们的武器和盔甲被拿走时嘟哝和哀嚎。 他们身体裸露在灼热的沙漠里，而随着你带着可用的废品离开，荒野上的动物们已经进场开始进食。 对于这一决定 %companyname% 有所争执，但是最终争论与支持都安静了下来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "镀金者已经审判了他们。",
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

					if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66)
					{
						bro.worsenMood(1.0, "不喜欢你让北方同胞慢慢死去");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getEthnicity() == 1 && this.Math.rand(1, 100) <= 66)
					{
						bro.improveMood(0.75, "同意你决定让镀金者来审判北方侵略者");

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

		if (currentTile.Type != this.Const.World.TerrainType.Desert)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 7)
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

