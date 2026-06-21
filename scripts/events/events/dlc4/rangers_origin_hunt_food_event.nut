this.rangers_origin_hunt_food_event <- this.inherit("scripts/events/event", {
	m = {
		Hunter = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.rangers_origin_hunt_food";
		this.m.Title = "在途中…";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_10.png[/img]{作为猎人圈子中的一员，很明显你已经进入了一个良好的狩猎场。%randombrother% 建议战队去狩猎，但他警告说，团队应该重视适度猎杀这些丰富的猎物。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们去打猎吧！",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 70)
						{
							return "C";
						}
						else if (r <= 90)
						{
							return "B";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "这事儿先缓缓吧。",
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
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_10.png[/img]{这些人奉命去打猎，他们得寸进尺！ 他们射杀，掠夺和屠戮几乎所有能呼吸的动物。 你担心这会引起当地贵族的注意，但他们一点也不知道。 商店的库存马上就会爆满的！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一场美好的狩猎。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local food = this.new("scripts/items/supplies/cured_venison_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了鹿肉"
				});
				local item = this.new("scripts/items/loot/valuable_furs_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_10.png[/img]{几个人出发去打猎，回来的时候带回几个猎物。 你问他们有没有遇到什么麻烦，他们摇摇头说没有。 看起来存货中会补充一些美味，贵族也没那么聪明！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一场还不错的狩猎。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local food = this.new("scripts/items/supplies/cured_venison_item");
				this.World.Assets.getStash().add(food);
				this.List.push({
					id = 10,
					icon = "ui/items/" + food.getIcon(),
					text = "你获得了鹿肉"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "%terrainImage%{大约一个小时后，这些人出去打猎，他们回来了。 只是他们拖着一个血肉模糊的 %bearbrother% 回到营地。 他们报告说，这群人遇到了一只母棕熊。 她的战斗非常激烈，之所以她停止殴打受伤的偷猎者，是因为一个队员用火把威胁她的孩子。 你很高兴那些人都还活着，尽管 %bearbrother% 需要很长一段时间才能恢复。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这种雇佣兵的工作使我们麻木不仁。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local injury = _event.m.Hunter.addInjury(this.Const.Injury.Accident3);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Hunter.getName() + " 遭受 " + injury.getNameOnly()
				});
				this.Characters.push(_event.m.Hunter.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.rangers")
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Hunter = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bearbrother",
			this.m.Hunter.getName()
		]);
	}

	function onClear()
	{
		this.m.Hunter = null;
	}

});

