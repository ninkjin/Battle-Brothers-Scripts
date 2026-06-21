this.player_is_rich_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.player_is_rich_event";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_04.png[/img]一段时间之后，你挣了很大一笔钱。 虽然你仍然保持战利品箱妥善保管，但是你却注意到一些兄弟的贪婪心随着待在战队里的时间的延长而日益膨胀。 最近你开始听见一些关于伙计们要求涨薪的传言。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好吧，现在是时候给你们都涨涨薪水了。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "你们都在雇佣契约上签了名，一切所得也符合契约。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_04.png[/img]为了防止任何形式的兵变或者要求提高待遇，你宣布整个战队都将有一次涨薪。 每个人每天将能多获得三克朗。 作为结果，伙计们对这次事件非常满意，开始热切地欢呼着你的名字！",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这是你们应得的，孩子们！",
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
					if (bro.getSkills().hasSkill("trait.player") || bro.getFlags().get("IsPlayerCharacter") || bro.getBackground().getID() == "background.slave")
					{
						continue;
					}

					bro.getBaseProperties().DailyWage += 4;
					bro.improveMood(2.0, "得到加薪");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]在任何人发表意见的之前，你站到了战队面前，大声宣布不会有涨薪。 就你而言，在场的每个人都签了合同。 任何人对涨薪的要求只能基于他的资历，而这只能通过最适合佣兵来做的一件事来达成：杀戮。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这就是运作的中的 %companyname%。",
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
					if (bro.getSkills().hasSkill("trait.player") || bro.getFlags().get("IsPlayerCharacter") || bro.getBackground().getID() == "background.slave")
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.greedy"))
					{
						bro.worsenMood(2.0, "被拒绝加薪");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (!bro.getBackground().isExcluded("trait.greedy"))
					{
						if (this.Math.rand(1, 100) <= 20)
						{
							local trait = this.new("scripts/skills/traits/greedy_trait");
							bro.getSkills().add(trait);
							this.List.push({
								id = 10,
								icon = trait.getIcon(),
								text = bro.getName() + "变得贪婪"
							});
						}
						else
						{
							bro.worsenMood(1.0, "被拒绝加薪");

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
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() <= 30000)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() < 5)
		{
			return;
		}

		if (this.World.Retinue.hasFollower("follower.paymaster"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local numBros = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() != "background.slave")
			{
				numBros = ++numBros;
			}
		}

		if (numBros < 2)
		{
			return;
		}

		this.m.Score = (this.World.Assets.getMoney() - 30000) * 0.0005;
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

