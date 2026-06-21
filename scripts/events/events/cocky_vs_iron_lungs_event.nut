this.cocky_vs_iron_lungs_event <- this.inherit("scripts/events/event", {
	m = {
		Cocky = null,
		IronLungs = null
	},
	function create()
	{
		this.m.ID = "event.cocky_vs_iron_lungs";
		this.m.Title = "露营时…";
		this.m.Cooldown = 150.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]当你卷起一些地图并把它们放回包里时，一阵骚动使你离开了帐篷。 这些队员正把 %cocky% 拖拽在地面上。 他的衣服都湿透了，他的面色看上去像要死了一样。 队员们在他的脸颊上狠狠地打了几下。 终于，他醒了，眼睛睁得大大的，嘴巴吐着水，就像一个破损的喷泉。 他环顾四周，询问你也想知道的事。%SPEECH_ON%发生了什么？%SPEECH_OFF%%ironlungs% 走了过来，同样是湿润的脸，但面色更加红润。%SPEECH_ON%你这个嚣张的婊子竟敢比试我们当中谁憋气最长。 你输了，因为他们不会无缘无故地把这些叫做铁肺。%SPEECH_OFF%队员们笑了起来，当 %ironlungs% 正在骄傲地捶打者自己的胸膛。%cocky%，仍然摇摇晃晃，站了起来。 仅仅在完全失去知觉的片刻之后，他已经回到了他的高傲模式。%SPEECH_ON%是啊，是啊，你今天打败了我，但是我会是最好的，你等着吧！%SPEECH_OFF%另一位佣兵异想天开地指出，这个自信满满的家伙鼻子上挂着一大串鼻涕。 他满怀信心地把它擦去，尽管队伍里一阵爆笑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "唉，对男子气概最安全的检验方法。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cocky.getImagePath());
				this.Characters.push(_event.m.IronLungs.getImagePath());
				_event.m.Cocky.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Cocky.getName() + "遭受轻伤"
				});
				_event.m.Cocky.worsenMood(1.0, "在战队面前丢脸");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cocky.getMoodState()],
					text = _event.m.Cocky.getName() + this.Const.MoodStateEvent[_event.m.Cocky.getMoodState()]
				});
				_event.m.IronLungs.improveMood(1.0, "击败 (Beat)" + _event.m.Cocky.getName() + "在力量比拼中");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.IronLungs.getMoodState()],
					text = _event.m.IronLungs.getName() + this.Const.MoodStateEvent[_event.m.IronLungs.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() != _event.m.Cocky.getID() && bro.getID() != _event.m.IronLungs.getID() && this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.5, "感到愉快来自 " + _event.m.Cocky.getNameOnly());

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
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local cocky_candidates = [];
		local ironlungs_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.cocky"))
			{
				cocky_candidates.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.iron_lungs"))
			{
				ironlungs_candidates.push(bro);
			}
		}

		if (cocky_candidates.len() == 0 || ironlungs_candidates.len() == 0)
		{
			return;
		}

		this.m.Cocky = cocky_candidates[this.Math.rand(0, cocky_candidates.len() - 1)];
		this.m.IronLungs = ironlungs_candidates[this.Math.rand(0, ironlungs_candidates.len() - 1)];
		this.m.Score = (cocky_candidates.len() + ironlungs_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cocky",
			this.m.Cocky.getNameOnly()
		]);
		_vars.push([
			"ironlungs",
			this.m.IronLungs.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Cocky = null;
		this.m.IronLungs = null;
	}

});

