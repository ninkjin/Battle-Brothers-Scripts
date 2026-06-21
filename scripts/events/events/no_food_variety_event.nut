this.no_food_variety_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.no_food_variety";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_52.png[/img]{你发现雇佣兵簇拥在营火旁边，只是他们没有把能够被称作食物的东西放在火上。 一个人将他碗里的汤倒了出来。 那个汤就像污泥一样粘稠的粘在碗上没有流出去的迹象，说老实话，这个实在是太恶心了。%randombrother% 看见了你。%SPEECH_ON%先生，求求你了，让我们吃一些肉吧！ 或者任何一样比这个狗屎强的东西！%SPEECH_OFF%你同意，说有点变化不会有什么坏处。 | %randombrother% 走到你面前，用勺子猛击你的办公桌。 勺子上有东西，但你不确定那是什么。 雇佣兵靠在椅背上，双手插在腰间，愤怒似乎要从胸膛喷涌而出。 然后他叹了口气，因为他知道在你面前不该表现的这么无礼。但是他也对自己的行为做出了解释。%SPEECH_ON%先生，伙计们在抱怨食物。 我想如果我们在下一个城镇买些肉和其他食物能够鼓舞团里面兄弟的士气。 当然，这只是一个建议。%SPEECH_OFF%他起身走了。你拿起勺子，仔细琢磨勺子里的东西是什么。 这个…这个不会是他们在外面吃的东西把，这东西人能吃吗？ 也许有些变化也无妨… | %randombrother% 手里拿着碗向你走了过来。 他把碗向前倾斜，露出里面无色的东西，然后慢慢地沿着碗边滑下去。 这个雇佣兵摇摇头。%SPEECH_ON%先生，同伴们今晚都不高兴，我也不高兴，就是因为这个东西。 一个人不可能忍受的了长时间吃同样的东西，特别是当他知道他可以担负起其他美味价格的时候。 这只是一个建议，先生，既是我的也是其他人的，也许我们应该增加其他粮食的储备这样就不会每顿饭都…嗯，这样。%SPEECH_OFF%他放下碗走了。 | 有几个雇佣兵围着营火抱怨。 你呆在能听到的范围内，仔细倾听因为他们可能会说一些在你面前不会说的事情。 谢天谢地，这不是一场密谋的背叛，而是一系列对食物的批评。 团队里面食品库存品种实在是太少了。 他们早已厌倦了一遍又一遍地吃同样的东西。 也许 %companyname% 的食物水平应该在下一个城镇拜访中得到提高？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，是应该改善一下食物质量。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isLowborn() || bro.getSkills().hasSkill("trait.spartan"))
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.gluttonous"))
					{
						bro.worsenMood(1.0, "几天来除了谷物什么都没吃");
					}
					else
					{
						bro.worsenMood(0.5, "几天来除了谷物什么都没吃");
					}

					if (bro.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 5)
		{
			return;
		}

		if (this.World.State.getEscortedEntity() != null)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local hasBros = false;

		foreach( bro in brothers )
		{
			if (bro.getBackground().isLowborn() || bro.getSkills().hasSkill("trait.spartan"))
			{
				continue;
			}

			hasBros = true;
			break;
		}

		if (!hasBros)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local hasOtherFood = false;

		foreach( item in stash )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Food))
			{
				if (item.getID() != "supplies.ground_grains")
				{
					hasOtherFood = true;
					break;
				}
			}
		}

		if (hasOtherFood)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

