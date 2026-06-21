this.master_no_use_apprentice_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.master_no_use_apprentice";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%当你们在 %townname% 闲逛时，你看到一位老人正在拉着一个轻年的耳朵不断训斥着他。%SPEECH_ON%你想要成为一名大师，这个过程需要你的时间！鲜血！汗水！ 如果你是一个爱哭鬼现在就哭出来因为你只能成为那样的人。 那里，快看！一个佣兵！ 如果你这么想要战斗的话，为什么不去找他呢？%SPEECH_OFF%在参与着两个人的莫名其妙的争斗前你伸出手要求老人能给出一个合理的解释毕竟你自己也不想惹上什么麻烦。 这个老人心情渐渐平复下来并且也放开了那个孩子的耳朵。%SPEECH_ON%是啊，我认为你应该得到解释。 我是这个城镇的剑术老师，但是在我任何一个学生学会耐心和严守纪律之前我不会让他碰剑！ 但是我这个学生却一点都没有做到！ 所以我告诉他，如果你这么想战斗，滚出去！%SPEECH_OFF%你看了看孩子。 虽然他的脸庞依然很稚嫩，但是他的眼睛里充满着对战斗的热情。 你询问他这个剑术大师说的是不是真的。这个孩子点了点头。%SPEECH_ON%没错先生。并且我很乐意为你而战，这也是我一直想要的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，我们会带走他。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "不了，谢谢。 这个孩子还需要你。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"apprentice_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "作为一个剑术大师的不耐烦的学生，%name% 没有天赋坚持成为锋刃大师的磨难和痛苦。 但他在精神上缺乏的勇气在用努力来弥补。 你只是简单地把他从老人的手中夺走，就“雇佣”了他。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() <= 1)
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
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"town",
			this.m.Town.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Town = null;
	}

});

