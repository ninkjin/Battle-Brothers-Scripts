this.surefooted_saves_damsel_event <- this.inherit("scripts/events/event", {
	m = {
		Surefooted = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.surefooted_saves_damsel";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_85.png[/img]几个兄弟带着最奇怪的故事回到你身边。 显然，%surefooted% 这位步伐沉稳的佣兵出名了，在 %townname%。\n\n 在一个小酒店的楼梯上与女士们谈笑时，栏杆断了，一位姑娘几乎要摔下去了。 一手拿着一壶酒，一手裹着姑娘的腰，这个雇佣兵用脚卡住这个正在摔倒的姑娘的靴子尖，毫不夸张说他赢得了醉酒人群的热烈掌声。 你问他现在在哪里。雇佣兵们大笑。%SPEECH_ON%掉进了被称赞的烦恼中，别提了？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "当然，当然。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Surefooted.getImagePath());

				if (!_event.m.Town.isSouthern())
				{
					_event.m.Town.getFactionOfType(this.Const.FactionType.Settlement).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "你的一个手下在女士们中享有盛名");
				}

				_event.m.Surefooted.improveMood(2.0, "有点派对的味道");

				if (_event.m.Surefooted.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Surefooted.getMoodState()],
						text = _event.m.Surefooted.getName() + this.Const.MoodStateEvent[_event.m.Surefooted.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 2 && bro.getSkills().hasSkill("trait.sure_footing"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isMilitary())
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

		this.m.Surefooted = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = candidates.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"surefooted",
			this.m.Surefooted.getNameOnly()
		]);
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
		this.m.Surefooted = null;
		this.m.Town = null;
	}

});

