this.sickness_event <- this.inherit("scripts/events/event", {
	m = {
		SomeGuy = null
	},
	function create()
	{
		this.m.ID = "event.sickness";
		this.m.Title = "在途中…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_09.png[/img] {沼泽紧紧拖住你的每一步，如此希望你停留在这。 当你的靴子陷入泥潭时，%someguy% 转过身来，突然呕吐起来，把他的早餐吐进了泥潭。 你转过身去，看见远处的另一个兄弟弯着腰，从他嘴里吐出一大团东西，把你自己将要吐出来的东西给呛住了。 %companyname% 表达了他们的集体不适，因为更多的可怜虫在呕吐。 这确实不是人待的地方。 | 虽然沼泽里充满了令人恶心的生命形式，但实际上却散发着有毒死亡的气味。 似乎有毒的蒸汽从静止的水流中翻腾而出。 它会灼伤你的眼睛和喉咙，使你的食物染毒变得很难吃。 有什么肮脏的东西敢住在这里？ 你看到蟾蜍，蛇和小动物，它们在出生的时候显然被魔鬼碰过。 %companyname% 的队员无一例外的病了。 只有强者才有勇气去忍受这些，其他人都已经恶心过了，并看见了那里不存在的东西。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的地方！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List = _event.giveSicknessEffect();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_08.png[/img] 你的呼吸出现在你的面前，仿佛它是装在灰色的皮包里。 它开始变慢，这种痛苦。雪片飞舞。 来自古代冰川的风。 你的脚陷进了白色的粉末里，然后你就知道接下来的旅程将是对耐力的考验。\n\n你想知道生活在这些地方的古代人是怎么做到的。 他们围坐在营火旁，全世界的人都出来找他们。 坐在黑暗中被冰霜包围着。孤单的坐着。. 他们出生在这里，这一定是他们的诡计。 无知是他们的温暖。 只有无家可归的人才能住在这样的地方。\n\n%companyname% 的人踉踉跄跄地跌倒了，再也不能像以前那样迅速爬起来。 一些人开始咳嗽，还有一些人看起来已经要筋疲力尽了。 只有最强壮的人才能毫无困难地坚持下去。 这些人肯定与这片可怕土地的祖先有关系。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的地方！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List = _event.giveSicknessEffect();
			}

		});
	}

	function giveSicknessEffect()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local result = [];
		local lowestChance = 9000;
		local lowestBro;
		local applied = false;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("effects.sickness"))
			{
				continue;
			}

			local chance = bro.getHitpoints() + 20;

			if (bro.getSkills().hasSkill("trait.strong"))
			{
				chance = chance + 20;
			}

			if (bro.getSkills().hasSkill("trait.tough"))
			{
				chance = chance + 20;
			}

			if (bro.getSkills().hasSkill("trait.lucky"))
			{
				chance = chance + 20;
			}

			if (this.m.SomeGuy.getID() != bro.getID() && this.Math.rand(1, 100) < chance)
			{
				if (chance < lowestChance)
				{
					lowestChance = chance;
					lowestBro = bro;
				}

				continue;
			}

			applied = true;
			local effect = this.new("scripts/skills/injury/sickness_injury");
			bro.getSkills().add(effect);
			result.push({
				id = 10,
				icon = effect.getIcon(),
				text = bro.getName() + "生病了"
			});
		}

		if (!applied && lowestBro != null)
		{
			local effect = this.new("scripts/skills/injury/sickness_injury");
			lowestBro.getSkills().add(effect);
			result.push({
				id = 10,
				icon = effect.getIcon(),
				text = lowestBro.getName() + "生病了"
			});
		}

		return result;
	}

	function onUpdateScore()
	{
		if (this.World.Retinue.hasFollower("follower.scout"))
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Swamp && currentTile.Type != this.Const.World.TerrainType.Snow && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 4)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		this.m.SomeGuy = brothers[this.Math.rand(0, brothers.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"someguy",
			this.m.SomeGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Swamp)
		{
			return "A";
		}
		else if (currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.SnowyForest)
		{
			return "B";
		}
	}

	function onClear()
	{
		this.m.SomeGuy = null;
	}

});

