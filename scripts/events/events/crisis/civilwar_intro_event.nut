this.civilwar_intro_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_intro";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_92.png[/img]你进入 %townname%，发现一群村民站在一个木制平台周围。 你以为有什么悬着的东西等着看，便迅速地从人群中挤了过去。 结果恰恰相反，你发现一个穿着奇怪的男人在向镇民;大声宣布新闻。%SPEECH_ON%瞧一瞧啊，看一看啊，贵族家族 %noblehouse1% 与 %noblehouse2% 之间互相仇恨！他们要全面开战了！%SPEECH_OFF%人群之中传来窃窃私语的声音。 随着音量越来越大，低语声逐渐消失。吟游诗人继续道。%SPEECH_ON%是的，村民们！ 战争就要来了！ 啊，是的，那个潜伏在所有人心中的变幻无常的野兽。 一件可悲的事，一件正义的事，一件光荣的事！%SPEECH_OFF%站在你面前的一位老人嘟哝着吐口水。 他走了，摇摇头，自言自语。 吟游诗人继续前进，他的兴奋与他面前惊恐的面孔极不相称。%SPEECH_ON%我们不要在仪式上磨磨蹭蹭的。 男人们，拿起你们能拿的武器，在不拿武器的时候多耕地！ 女人们，把你们的儿子养好，免得他们连剑都拿不起来！%SPEECH_OFF%最后，吟游诗人深吸了一口气。%SPEECH_ON%而你们当中那些希望获得一两个克朗的人，贵族家族正在寻找任何能挥剑的人的优质服务。 你们这些不太体面的人，你们这些放荡的，偷新娘的，卖水蛭的，臭气熏天的，不干好事的，恶习成性的，胡作非为的人，还有强盗，土匪，偷东西的，病态的，染毒的，被诅咒的，狂暴的，被治愈的，愚蠢的，佣兵，吟游诗人等等，先生们，现在是你们表现的时间了。 为贵族而战，为自己赢得新生活！ 战争不会永远持续下去，出人头地要乘早！%SPEECH_OFF%看起来好像 %companyname%的未来要变得更加光明了，因为你将会赚到大量的金子。",
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
		if (this.World.Statistics.hasNews("crisis_civilwar_start"))
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
			this.m.NobleHouse = this.m.Town.getOwner();
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_civilwar_start");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"noblehouse1",
			this.m.NobleHouse.getNameOnly()
		]);
		local nobles = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local noblehouse2;

		do
		{
			noblehouse2 = nobles[this.Math.rand(0, nobles.len() - 1)];
		}
		while (noblehouse2 == null || noblehouse2.getID() == this.m.NobleHouse.getID());

		_vars.push([
			"noblehouse2",
			noblehouse2.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
		this.m.NobleHouse = null;
	}

});

