this.aging_swordmaster_preview_event <- this.inherit("scripts/events/event", {
	m = {
		Swordmaster = null
	},
	function create()
	{
		this.m.ID = "event.aging_swordmaster_preview";
		this.m.Title = "在途中…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_17.png[/img]你发现 %swordmaster% 坐在树桩上。 他望着外面的土地。%SPEECH_ON%你知道，作为一个刀口舔血干这行儿很久的老头，我意识到了一些事情。 这些日子让我聪明了许多。 我已经获益良多，多的让我现在明白了我不知道的事。 我回想起来，我年轻的时候就是这样一个傻瓜。 然后我想，那些被我杀死的人，他们停止了成长，那正是他们正年轻并开启美好人生的时候么？%SPEECH_OFF%你坐下来耸肩。他继续道。%SPEECH_ON%我意识到我是一个聪明的的杀手。 我从这个世界上带走了许多老人，也带走了许多知识和学问。 外面世界有太多东西被我毁灭了。 这些人生活的世界，他们的来生，也许会做着他们的伟大的事情。 如果第一个人就杀了我，他能救很多人吧？ 会有多少智慧被保留下来吧？ 对不起，我不是有意要啰嗦的。%SPEECH_OFF%那人站起来，拍着他那摇摇晃晃的腿。 你抓住他的胳膊。%SPEECH_ON%你有没有想过你也可能拯救了世界？ 那些被你杀死的人活着可能成为可怕的怪物吗？%SPEECH_OFF%他笑了，但你知道他已经考虑过了，不想再用想到的答案打搅你。 他只是点头，然后离开，去找战队的其他成员。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我希望他振作起来。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Swordmaster.getImagePath());
				_event.m.Swordmaster.worsenMood(1.0, "意识到他老了");

				if (_event.m.Swordmaster.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Swordmaster.getMoodState()],
						text = _event.m.Swordmaster.getName() + this.Const.MoodStateEvent[_event.m.Swordmaster.getMoodState()]
					});
				}

				_event.m.Swordmaster.getFlags().add("aging_preview");
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getBackground().getID() == "background.swordmaster" && !bro.getFlags().has("aging_preview") && !bro.getSkills().hasSkill("trait.old") && !bro.getFlags().has("IsRejuvinated"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() > 0)
		{
			this.m.Swordmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
			this.m.Score = this.m.Swordmaster.getLevel();
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"swordmaster",
			this.m.Swordmaster.getName()
		]);
	}

	function onClear()
	{
		this.m.Swordmaster = null;
	}

});

