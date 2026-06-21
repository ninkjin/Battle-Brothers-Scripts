this.farmer_old_tricks_event <- this.inherit("scripts/events/event", {
	m = {
		Farmer = null
	},
	function create()
	{
		this.m.ID = "event.farmer_old_tricks";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img],你发现 %farmhand% 坐在战队的载重货车旁。 他在牙缝里滚动着一些干草茎，设法把它们磨碎，把碎渣吐出来。 你问他在想什么。这个农夫耸耸肩。%SPEECH_ON%我父亲告诉过我的捆干草的事。 他有一种旋转手腕的方法，在每次抓或放干草时非常有效。 然而我第二个环节还没有做好。%SPEECH_OFF%这人把稻草拿出来一弹。你问道。%SPEECH_ON%但是你能做好第一个环节是吧？ 你在哪里刺和拉干草？%SPEECH_OFF%他点了点头。你告诉那个人，他只需要第个一环节的技术就可以把一个人的内脏取出来。 你看到他的脸因为现实而容光焕发。%SPEECH_ON%是的…确实是这样！ 我之前怎么没想到呢？ 你真是个天才，先生！ 下次出手我要试试！ 这就像给干草打捆一样简单！%SPEECH_OFF%他尖叫着，声音充满了血性，但这很好。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是不要尝试把它们丢到你的肩膀上。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Farmer.getImagePath());
				local meleeSkill = this.Math.rand(2, 4);
				_event.m.Farmer.getBaseProperties().MeleeSkill += meleeSkill;
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Farmer.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
				});
				_event.m.Farmer.improveMood(1.0, "意识到他有一些战斗知识");

				if (_event.m.Farmer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Farmer.getMoodState()],
						text = _event.m.Farmer.getName() + this.Const.MoodStateEvent[_event.m.Farmer.getMoodState()]
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
			if (bro.getLevel() <= 2 && bro.getBackground().getID() == "background.farmhand")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Farmer = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"farmhand",
			this.m.Farmer.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Farmer = null;
	}

});

