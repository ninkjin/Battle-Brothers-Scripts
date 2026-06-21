this.oathtaker_mistaken_identity_event <- this.inherit("scripts/events/event", {
	m = {
		Oathtaker = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.oathtaker_mistaken_identity";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%{一个男孩突然跑向了战团，紧紧地握着 %oathtaker% 的腿，而战团的表情变得混乱起来。他问男孩是否迷路了。男孩弹开他的手。%SPEECH_ON%迷路了？不，我没有迷路！我以为我永远不会再见到像你们这样的人，那些高贵的誓言守护者！%SPEECH_OFF%%oathtaker%的眼睛抽搐了一下，他的手紧紧地握着武器的手柄。你不确定他的尖叫从何时开始，男孩是怎么弄黑了眼睛的，但是那愤怒的正义之怒从他身上裂开，像一道神圣之怒的闪电。你看着他将男孩推到泥浆里，咆哮着说他是誓言守护者，而不是可怕、丑陋和不光彩的誓言使者。他将男孩的脸捏在草地上，将他拖到一堆马粪上，并将他滚到路边，直到男孩尖叫着逃命。%oathtaker% 排着队走，整理着他的服装，收拾着不整齐的武器。%SPEECH_ON%我们离开这个污秽堕落的地方，队长。%SPEECH_OFF%当他挺着胸闯过去时，你回过头看到镇上的居民惊恐地盯着你。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这基本上就是看起来的样子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Oathtaker.getImagePath());
				this.World.Assets.addMoralReputation(-1);
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationMinorOffense, "你的一个士兵打了一个孩子。");
				_event.m.Oathtaker.worsenMood(2.0, "被误认为是一名誓约者(Oathbringer)。");

				if (_event.m.Oathtaker.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Oathtaker.getMoodState()],
						text = _event.m.Oathtaker.getName() + this.Const.MoodStateEvent[_event.m.Oathtaker.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
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

		local brothers = this.World.getPlayerRoster().getAll();
		local oathtaker_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin")
			{
				oathtaker_candidates.push(bro);
			}
		}

		if (oathtaker_candidates.len() == 0)
		{
			return;
		}

		this.m.Oathtaker = oathtaker_candidates[this.Math.rand(0, oathtaker_candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 3 * oathtaker_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Oathtaker = null;
		this.m.Town = null;
	}

});

