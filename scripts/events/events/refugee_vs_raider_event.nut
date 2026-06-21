this.refugee_vs_raider_event <- this.inherit("scripts/events/event", {
	m = {
		Refugee = null,
		Raider = null
	},
	function create()
	{
		this.m.ID = "event.refugee_vs_raider";
		this.m.Title = "露营时…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]%refugee%，一个曾经被迫背井离乡成为难民的人，眼神茫然地盯着 %raider%。那名掠夺者察觉了自己正被人盯着看，放下了手里盛着食物的盘子。%SPEECH_ON%你小子在那看什么，哏？%SPEECH_OFF%难民看向一只正在滴水的勺子。%SPEECH_ON%你是个掠夺者，对吧？%SPEECH_OFF%%raider% 点了点头。%SPEECH_ON%曾经是。没准将来还会重操旧业。 关你什么事？%SPEECH_OFF%%refugee% 站了起来，指向他。%SPEECH_ON%就是你这样的人把好人逼出了家门。 你们让那么多好人不得不拖家带口流离失所。%SPEECH_OFF%%raider% 大笑着，也站了起来。%SPEECH_ON%噢，是吗？ 那他们又是为什么落得那样的？ 因为他们连拿起剑保护他们自己都做不到？ 你觉得如果角色互换的话他们不会对我做出相同的事吗？ 换成是你自己呢？ 人们会当好人只是因为他们没得选。%SPEECH_OFF%两个人的口角变得越来越激烈，其他的一些雇佣兵也站起来了。 没人能阻止这场冲突的爆发，两个人互相咒骂着扭打在一起，就像你以前看过的任何一起酒馆斗殴一样。 谢天谢地，至少这场斗殴没有造成太严重的后果。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "都冷静点吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Refugee.getImagePath());
				this.Characters.push(_event.m.Raider.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury1 = _event.m.Refugee.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury1.getIcon(),
						text = _event.m.Refugee.getName() + " 遭受 " + injury1.getNameOnly()
					});
				}
				else
				{
					_event.m.Refugee.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Refugee.getName() + "遭受轻伤"
					});
				}

				_event.m.Refugee.worsenMood(1.0, "发生斗殴和 " + _event.m.Raider.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Refugee.getMoodState()],
					text = _event.m.Refugee.getName() + this.Const.MoodStateEvent[_event.m.Refugee.getMoodState()]
				});

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury2 = _event.m.Raider.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury2.getIcon(),
						text = _event.m.Raider.getName() + " 遭受 " + injury2.getNameOnly()
					});
				}
				else
				{
					_event.m.Raider.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Raider.getName() + "遭受轻伤"
					});
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

		local refugee_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 2 && bro.getBackground().getID() == "background.refugee")
			{
				refugee_candidates.push(bro);
				break;
			}
		}

		if (refugee_candidates.len() == 0)
		{
			return;
		}

		local raider_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 6 && bro.getBackground().getID() == "background.raider")
			{
				raider_candidates.push(bro);
			}
		}

		if (raider_candidates.len() == 0)
		{
			return;
		}

		this.m.Refugee = refugee_candidates[this.Math.rand(0, refugee_candidates.len() - 1)];
		this.m.Raider = raider_candidates[this.Math.rand(0, raider_candidates.len() - 1)];
		this.m.Score = (refugee_candidates.len() + raider_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"refugee",
			this.m.Refugee.getNameOnly()
		]);
		_vars.push([
			"raider",
			this.m.Raider.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Refugee = null;
		this.m.Raider = null;
	}

});

