this.rangers_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.rangers_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_10.png[/img]尽管有很多故事中猎人都是一个人孤独地在养活他的家庭，但是现实中偷猎者经常有组织的协同工作，并且建立起一整套渠道来贩卖他们偷猎的毛皮和肉。\n\n但当地领主，也就是%noble%，对偷猎者在他的森林中进行狩猎感到越来越恼火，周围的其他猎人团体基本都被抓获，折磨致残，然后吊死。由于只剩下你，%hunter1%，%hunter2%，还有%hunter3%幸存了下来，你面临着一个决定，当你只知道如何使用弓时该如何谋生？\n\n大家集体讨论后决定把你们的集体才能用到雇佣兵的工作上，而你马上就被选举成了团长。%SPEECH_ON%在我们之中你眼最尖。%SPEECH_OFF%%hunter2%说到，而%hunter3%表示同意的同时打趣说。%SPEECH_ON%当然，你同时也是我们之中最差的射手。别因为我说了这句话就惩罚我哦，‘团长’，哈哈哈！%SPEECH_OFF%当然，这队快乐的偷猎者有着独特的天赋，你的手下们喜欢轻装简行，但他们不仅腿脚快还弓术优秀，而且还是侦查方面的专家，能避免没啥好处的作战。",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会做的不错的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				local brothers = this.World.getPlayerRoster().getAll();
				this.Characters.push(brothers[1].getImagePath());
				this.Characters.push(brothers[2].getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "偷猎者团队";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local settlements = this.World.EntityManager.getSettlements();
		local closest;
		local distance = 9999;

		foreach( s in settlements )
		{
			local d = s.getTile().getDistanceTo(this.World.State.getPlayer().getTile());

			if (d < distance)
			{
				closest = s;
				distance = d;
			}
		}

		local f = closest.getFactionOfType(this.Const.FactionType.NobleHouse);
		_vars.push([
			"hunter1",
			brothers[0].getName()
		]);
		_vars.push([
			"hunter2",
			brothers[1].getName()
		]);
		_vars.push([
			"hunter3",
			brothers[2].getName()
		]);
		_vars.push([
			"noble",
			f.getRandomCharacter().getName()
		]);
	}

	function onClear()
	{
	}

});

