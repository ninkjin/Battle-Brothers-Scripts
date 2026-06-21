this.oldguard_becomes_drunkard_event <- this.inherit("scripts/events/event", {
	m = {
		Oldguard = null,
		Casualty = null,
		OtherCasualty = null
	},
	function create()
	{
		this.m.ID = "event.oldguard_becomes_drunkard";
		this.m.Title = "露营时…";
		this.m.Cooldown = 70.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]你发现 %oldguard% 在火堆旁边抱着一个巨大啤酒杯。 事实上，它根本不是一个啤酒杯，而是一个装满啤酒的木桶。 他的脚上散落着几只比较普通的杯子。 他将桶抱起来，将啤酒灌进自己的肚子里。 当他看见你，他尝试去整理自己的仪表，抹去脸上的酒沫后尝试着露出一个微笑但很快就变成了醉醺醺的皱眉。%SPEECH_ON%嗨，队长。没想到你会在这时候来看我。%SPEECH_OFF%你坐在那个人旁边然后问他近况如何。%SPEECH_ON%喝醉了。%SPEECH_OFF%你把酒桶从他的手中拿走并且他也没有阻止，尽管他的手好像依然拿着那个酒桶。 你把酒桶放在一边并且严肃的问他现在怎么样。 他顿了顿最后将手放在自己的膝盖上面。%SPEECH_ON%就像狗屎一样。这就是我的感觉。 首先，是 %casualty% 死去。 之后是 %othercasualty%。我知道的至少还有五六个人。 都死了。从相识到死去。 我忘不了，曾经和他们一起冒险的记忆，也忘不了他们临死前的惨叫，我的记忆都是由我的兄弟一起组成的。 但是我现在已经想清楚了尽管不能想的那么简单。 如果我不能选择遗忘一段记忆，那我将无视它并且将它埋在脑海的最深处。 这个啤酒帮我很好的完成这个过程现在它是我的兄弟了，嘿嘿。%SPEECH_OFF%随着一声叹气，你心情复杂的将酒杯还给这个男人。 眼神盯着面前的火堆，但是他的思绪已经沉寂在过去，他默默的喝酒再也没有说话。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "为那些缺席的朋友…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Oldguard.getImagePath());
				local trait = this.new("scripts/skills/traits/drunkard_trait");
				_event.m.Oldguard.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Oldguard.getName() + "变成了一个酒鬼"
				});
				_event.m.Oldguard.worsenMood(1.0, "失去了太多的朋友");

				if (_event.m.Oldguard.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Oldguard.getMoodState()],
						text = _event.m.Oldguard.getName() + this.Const.MoodStateEvent[_event.m.Oldguard.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 7)
		{
			return;
		}

		local numFallen = 0;

		foreach( f in fallen )
		{
			if (!f.Expendable)
			{
				numFallen = ++numFallen;
			}
		}

		if (numFallen < 7)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().getID() == "background.slave")
			{
				continue;
			}

			if (bro.getLevel() >= 8 && !bro.getSkills().hasSkill("trait.drunkard") && this.World.getTime().Days - bro.getDaysWithCompany() < fallen[0].Time && this.World.getTime().Days - bro.getDaysWithCompany() < fallen[1].Time && !bro.getSkills().hasSkill("trait.player") && !bro.getFlags().get("IsPlayerCharacter"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Oldguard = candidates[this.Math.rand(0, candidates.len() - 1)];

		for( local i = 0; i < fallen.len(); i = ++i )
		{
			if (fallen[i].Expendable)
			{
			}
			else if (this.m.OtherCasualty == null)
			{
				this.m.OtherCasualty = fallen[i].Name;
			}
			else if (this.m.Casualty == null)
			{
				this.m.Casualty = fallen[i].Name;
			}
			else
			{
				break;
			}
		}

		this.m.Score = numFallen - 2;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oldguard",
			this.m.Oldguard.getName()
		]);
		_vars.push([
			"casualty",
			this.m.Casualty
		]);
		_vars.push([
			"othercasualty",
			this.m.OtherCasualty
		]);
	}

	function onClear()
	{
		this.m.Oldguard = null;
		this.m.Casualty = null;
		this.m.OtherCasualty = null;
	}

});

