this.anatomist_reflects_on_webknechts_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		OtherBro = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_reflects_on_webknechts";
		this.m.Title = "露营时…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_184.png[/img]{%anatomist%伸出手臂，看着一只长腿蜘蛛在他的皮肤上爬行。当这只生物到达它新找到的领域的边缘时，解剖学家转动了他的手臂，建议蜘蛛换一个方向继续前进。他这样做了一段时间，直到用手指指向地面，蜘蛛就才真正爬走了，也许从未意识到它身处一个活体之上。解剖学家在笔记中写下了几页。%SPEECH_ON%前几天，我看到一只蜘蛛跳了20倍身长，抓住了一只苍蝇。这只我放走的蜘蛛，一旦看到它的猎物，就会像狩猎狗一样在地面上加速奔跑。看来古神对我们这帮恶棍人很宽容，因为这两个生物都不会是以巨大的织网蛛形态出现的。%SPEECH_OFF%尽管被攻击和剖开是相当可怕的，但你告诉他被蛛牢牢钱在一只蜘蛛吸血前包裹起来无疑更糟糕。解剖学家举起一根手指。%SPEECH_ON%一个普遍的错误认识，无赖，因为织网蛛实际上更喜欢在你死后很久很久再进食。我们认为它的毒素是针对腹部的，打开腹部并利用体液将你从内部融化掉。这可能就是为什么它们会把猎物倒挂在上面，这样毒素就可以在器官中滴落，将你变成一种液体袋。过程中消耗物质只是消化剩余部分。它们唯一不吃你的时候，是当它们把他们的幼虫放在你体内时，这时你将会是幼虫的食物。%SPEECH_OFF%这仍然听起来比被一只狩猎蜘蛛刺伤要糟糕得多，但无论哪种情况，你都后悔刚刚的谈话，不再深究这个话题。不幸的是，%otherbro%就在附近，听到了太多......}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "停止散布恐慌，该死。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.OtherBro.getImagePath());
				local trait = this.new("scripts/skills/traits/fear_beasts_trait");
				_event.m.OtherBro.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.OtherBro.getName() + "现在害怕野兽"
				});
				_event.m.OtherBro.worsenMood(1.0, "怕蜘蛛");

				if (_event.m.OtherBro.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.OtherBro.getMoodState()],
						text = _event.m.OtherBro.getName() + this.Const.MoodStateEvent[_event.m.OtherBro.getMoodState()]
					});
				}

				_event.m.Anatomist.improveMood(1.0, "迷恋蜘蛛");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() != "background.beast_slayer" && bro.getBackground().getID() != "background.wildman" && !bro.getSkills().hasSkill("trait.brave") && !bro.getSkills().hasSkill("trait.fearless") && !bro.getSkills().hasSkill("trait.fear_beasts") && !bro.getSkills().hasSkill("trait.hate_beasts"))
			{
				other_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0 || other_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.OtherBro = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = 2 * anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
		_vars.push([
			"otherbro",
			this.m.OtherBro.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.OtherBro = null;
	}

});

