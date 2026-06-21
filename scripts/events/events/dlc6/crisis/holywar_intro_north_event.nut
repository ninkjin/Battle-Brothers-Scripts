this.holywar_intro_north_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.holywar_intro_north";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{%SPEECH_START%好吧，好吧，肃静，肃静。%SPEECH_OFF%你来到了一个农民法庭，不出所料，那里有更多的农民。%SPEECH_ON%现在我刚被告知这些镀金的南方狗屁认为他们的“造物主”给旧神们准备了点玩意。%SPEECH_OFF%人群里的一个声音问道那会是什么。喊话者耸耸肩。%SPEECH_ON%不知道。现在，我想我们都可以认同旧神在很多年以前就解决了他们的战争，没有什么好暴力的。 但是镀金者，他可不是旧神。 这意味着异端。%SPEECH_OFF%群众欢呼着。你开始寻思这个人是不是个穿着普通人衣服的牧师。他继续道。%SPEECH_ON%集起你们的武器，你们的盔甲，你们的金子还有最重要的，你们的信仰，我们要去给那个“镀金者”来点阴影！ 这是旧神的意志！%SPEECH_OFF%这次群众们咆哮了起来，震耳欲聋的响。 这种能量是好兆头。 一旦战斗开始，生意肯定会相当兴隆，特别是某些正义的人想要看到的信仰必然在 %companyname%。 | 一个大胡子牧师站在一群农民面前。%SPEECH_ON%传说旧神在许多年前便完成了他们的战争，说他们将这个世界撕裂，并把我们遗留在这一片毁灭上，以及他们欣赏我们艰难奋斗生存下去的能力。%SPEECH_OFF%群众低语着。那个人继续道。%SPEECH_ON%但我们现在面对挑战，忠实信徒哟！ 在南方异端横行着“镀金者”的信徒们，一个象征奢侈，浪费，以及他们认为正义实为下贱巫术的伪神。%SPEECH_OFF%群众们一个词都没听懂，但是他们将他们的草叉高举着嘶吼了起来，询问着牧师们他们将前往何处。 微笑着，长老们转向对方并点头。 你不在乎是谁或是什么在发起南北间的圣战，只在乎 %companyname% 能从中捞到的好处。 | 堆积在你面前的军械前所未有。 武器堆起来有三人多高。 士兵们排成队，其中一半握着宗教旗帜，每一个都装饰着旧神中的一个。 神职人员和僧侣们都循规而行，用世俗和天国的语气来谈论这件事。 这就是圣战，北方人因宗教聚集在一起去面对镀金者的追随者。%SPEECH_ON%佣兵，是吗？%SPEECH_OFF%你转过身看到一个小伙子正穿上装备。%SPEECH_ON%你会在正直的道路上的，我懂的，而且旧神会照顾好我们所有人的。 好好表现给他们看，小流氓。%SPEECH_OFF%当然。但是首先你要为了 %companyname% 从战争的漩涡中赚得盆满钵满。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战争就要来了。",
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

		if (this.World.Statistics.hasNews("crisis_holywar_start"))
		{
			local playerTile = this.World.State.getPlayer().getTile();
			local towns = this.World.EntityManager.getSettlements();
			local nearTown = false;
			local town;

			foreach( t in towns )
			{
				if (t.isSouthern())
				{
					continue;
				}

				if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
				{
					nearTown = true;
					town = t;
					break;
				}
			}

			if (!nearTown)
			{
				return;
			}

			this.m.Town = town;
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_holywar_start");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

