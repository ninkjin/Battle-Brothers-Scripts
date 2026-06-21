this.broken_cart_event <- this.inherit("scripts/events/event", {
	m = {
		Injured = null
	},
	function create()
	{
		this.m.ID = "event.broken_cart";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_55.png[/img]当你沿路行进时，你在路边发现一个人，他的货车坏了。 载重货车旁边站着一头无所事事的驴子，它看上去已经疲惫不堪了。 商人似乎看起来比较好一点，你的出现似乎吓了他一跳。 他向后仰起身子，立刻向后退去。%SPEECH_ON%你们是来拿我的东西的吗？ 如果是这样，你就不必杀我了。 拿走你想要的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "伙计们，从货车上拿走所有我们能用的东西！",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "让我们帮助你的货车重新上路。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 70 ? "B" : "C";
					}

				},
				{
					Text = "我们没时间做这个。",
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
			Text = "[img]gfx/ui/events/event_55.png[/img]你消除了他的恐惧，并命令 %companyname% 中最好的队员让载重货车重新上路。 他们很快完成了，商人对他们的效率印象深刻。 随着他的财产重新回到道路上，他从载重货车里取出一些物品的作为感谢。 这些补给品在未来的日子里会很有用。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Farewell.",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(2);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List = _event.giveStuff(1);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_55.png[/img]商人在你面前很害怕，但你很快消除了他的恐惧。 几个队员奉命把货车拉回到小路上。 这些吃苦耐劳的人尽可能快的去完成，但是当快要完事的时候，他们中的一个人大声惨叫而且声音越来越大。\n\n商人瞪大了眼睛，眼中充满了新的恐惧，他迅速地给你提供了一些补给品，以表示他的感激之情。 也许他认为你会因为队员受伤而惩罚他？ 无论如何，在未来的日子里，这些补给品将是一个很好的补充。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我希望这物有所值。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(2);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Injured.getImagePath());
				local injury = _event.m.Injured.addInjury(this.Const.Injury.Helping);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Injured.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
				this.List.extend(_event.giveStuff(1));
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_55.png[/img]你命令队员们搜查货车，尽可能能拿走一切。%randombrother% 拔出他的剑，看起来准备杀死驴，动物愚蠢地在锋刃的反光中看着自己的死亡。 商人哭了出来，你伸出手，制止了对驴子的行刑。%SPEECH_ON%把这个拉稀的动物留在原地。%SPEECH_OFF%商人苦着脸表示了感谢，因为你的队员正排成队列走在他身后，手里拿着他最好的货物。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "装好所有东西，我们走。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-2);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List = _event.giveStuff(3);
			}

		});
	}

	function giveStuff( _mult )
	{
		local result = [];
		local gaveSomething = false;

		if (this.Math.rand(1, 100) <= 50)
		{
			gaveSomething = true;
			local food = this.new("scripts/items/supplies/bread_item");
			this.World.Assets.getStash().add(food);
			result.push({
				id = 10,
				icon = "ui/items/" + food.getIcon(),
				text = "你获得了" + food.getName()
			});
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			gaveSomething = true;
			local amount = this.Math.rand(1, 10) * _mult;
			this.World.Assets.addArmorParts(amount);
			result.push({
				id = 10,
				icon = "ui/icons/asset_supplies.png",
				text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 工具和补给"
			});
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			gaveSomething = true;
			local amount = this.Math.rand(1, 5) * _mult;
			this.World.Assets.addMedicine(amount);
			result.push({
				id = 10,
				icon = "ui/icons/asset_medicine.png",
				text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 医疗用品"
			});
		}

		if (!gaveSomething)
		{
			local food = this.new("scripts/items/supplies/bread_item");
			this.World.Assets.getStash().add(food);
			result.push({
				id = 10,
				icon = "ui/items/" + food.getIcon(),
				text = "你获得了" + food.getName()
			});
		}

		return result;
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( b in brothers )
		{
			if (!b.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(b);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Injured = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 9;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Injured = null;
	}

});

