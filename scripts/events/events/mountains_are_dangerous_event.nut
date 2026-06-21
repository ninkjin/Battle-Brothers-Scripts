this.mountains_are_dangerous_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.mountains_are_dangerous";
		this.m.Title = "在山上…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_42.png[/img]尽管现在还在深山之中，但是你依然可以看见山脉的山峰一直延伸到更远的地方，每一座山峰都在山谷之间挺拔向上。 这是一副相当壮观的景象，但是却要耗费他们大量的体力。 徒步穿越这山隘口－并且有些时候必须自己找到可以通过的山口－这对于人来说是非常难的。 山坡上的石头、泥沙和根本无法起到支撑作用的沙砾让你的人必须手脚并用才能爬上去。 山壁上难以抓牢的石头会让疲劳的攀登者回到山脚的起点甚至是死亡，这考验着那些不希望进行多次重复旅程的人的决心。\n\n 然而，在你的周围却有山羊在四处游荡。 有一只带着嘲弄般轻松不可思议地跃上背斜而另一个发出困惑的叫声在干枯的草地上磨着自己的角。 高耸入云的巨石上，上面布满着古老的地质构造，在顶端有困惑的山狮不断的看着你们。 你感觉它们以前见过像你们这样的人。 他们知道不用去攻击你们，只要跟着就会得到猎物。 也许你们中的一个会因为摔碎什么东西变成残废而被团里面的人留下因为在这样的地方抬伤兵将会葬送两个人。\n\n盘点一下你的士兵，你发现许多人受伤了。 大腿疼痛。小腿酸痛。颤动的膝盖。 可能有些骨折了，但却也不是特别严重。 只有强壮敏捷的人才能安全地在这样的地方穿行，而且他们通常是每次攀登中第一个冲顶的人。",
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
				this.List = _event.giveEffect();
			}

		});
	}

	function giveEffect()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local result = [];
		local lowestChance = 9000;
		local lowestBro;
		local applied = false;

		foreach( bro in brothers )
		{
			local chance = bro.getHitpoints() + 20;

			if (bro.getSkills().hasSkill("trait.dexterous"))
			{
				chance = chance + 20;
			}

			if (bro.getSkills().hasSkill("trait.sure_footing"))
			{
				chance = chance + 20;
			}

			if (bro.getSkills().hasSkill("trait.strong"))
			{
				chance = chance + 20;
			}

			if (chance < lowestChance)
			{
				lowestChance = chance;
				lowestBro = bro;
			}			
			
			if (this.Math.rand(1, 100) > chance)
			{
				applied = true;
				local injury = bro.addInjury(this.Const.Injury.Mountains);
				result.push({
					id = 10,
					icon = injury.getIcon(),
					text = bro.getName() + " 遭受 " + injury.getNameOnly()
				});
			}
		}

		if (!applied && lowestBro != null)
		{
			local injury = lowestBro.addInjury(this.Const.Injury.Mountains);
			result.push({
				id = 10,
				icon = injury.getIcon(),
				text = lowestBro.getName() + " 遭受 " + injury.getNameOnly()
			});
		}

		return result;
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Mountains || this.World.Retinue.hasFollower("follower.scout"))
		{
			return;
		}

		this.m.Score = 25;
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

