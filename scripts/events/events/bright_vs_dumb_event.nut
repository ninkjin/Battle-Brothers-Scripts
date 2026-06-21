this.bright_vs_dumb_event <- this.inherit("scripts/events/event", {
	m = {
		Dumb = null,
		Bright = null
	},
	function create()
	{
		this.m.ID = "event.bright_vs_dumb";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_15.png[/img]%dumb% 可能是你见过的最笨的人之一，但是，有那么一小会儿，似乎 %bright% 做到并教会了他一些关于批判性思维和记忆的东西。 你看着这两个人坐在一起看一些卷轴。 你不确定聪明的人是从哪儿弄到这些文件的，但这个不懂事的笨蛋显然对这些文件很感兴趣。\n\n正如你所看到的，%dumb% 正在问一些相当深刻又深奥的问题。 关于土地和它与人的关系，天空和它与鸟的关系的问题。 你慢慢地就会意识到，这个白痴只不过是在东张西望，而且用 %bright% 教授的那种“好奇”的语言描述他所看到的东西－就是在每句话的后面加上一个带有阿谀口吻的问句。 当这两人结束谈话时，%bright% 笑嘻嘻地向你走来。%SPEECH_ON%我想我们真的让他进步了。 他在学习，你知道吗？ 有这样的学生，你要做的就是耐心一点，慢慢来。%SPEECH_OFF%不远处，%dumb% 正在用一块石头砸蚂蚁。 你只是点头，让 %bright% 实现每个老师的伟大梦想。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你终于走近他了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bright.getImagePath());
				this.Characters.push(_event.m.Dumb.getImagePath());
				_event.m.Bright.improveMood(1.0, "教导了" + _event.m.Dumb.getName() + "某些东西");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Bright.getMoodState()],
					text = _event.m.Bright.getName() + this.Const.MoodStateEvent[_event.m.Bright.getMoodState()]
				});
				_event.m.Dumb.improveMood(1.0, "建立友谊与 " + _event.m.Bright.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Dumb.getMoodState()],
					text = _event.m.Dumb.getName() + this.Const.MoodStateEvent[_event.m.Dumb.getMoodState()]
				});
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

		local dumb_candidates = [];
		local bright_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.dumb"))
			{
				dumb_candidates.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.bright"))
			{
				bright_candidates.push(bro);
			}
		}

		if (dumb_candidates.len() == 0 || bright_candidates.len() == 0)
		{
			return;
		}

		this.m.Dumb = dumb_candidates[this.Math.rand(0, dumb_candidates.len() - 1)];
		this.m.Bright = bright_candidates[this.Math.rand(0, bright_candidates.len() - 1)];
		this.m.Score = (dumb_candidates.len() + bright_candidates.len()) * 2;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dumb",
			this.m.Dumb.getName()
		]);
		_vars.push([
			"dumb_short",
			this.m.Dumb.getNameOnly()
		]);
		_vars.push([
			"bright",
			this.m.Bright.getName()
		]);
		_vars.push([
			"bright_short",
			this.m.Bright.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dumb = null;
		this.m.Bright = null;
	}

});

