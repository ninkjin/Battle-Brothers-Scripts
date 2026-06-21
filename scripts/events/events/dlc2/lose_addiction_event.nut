this.lose_addiction_event <- this.inherit("scripts/events/event", {
	m = {
		Addict = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.lose_addiction";
		this.m.Title = "露营时…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{%addict%以一种尊敬的姿态，双手放在背后，进入你的帐篷。他问你是否有时间。你点点头，他说他已经摆脱了颤抖和疾病。你问他是什么意思。他扭动手上方的嘴巴，仿佛喝了口饮料。%SPEECH_ON%先生，药水，我不再对它们有强烈的亲和力。我好了，健康了，像一个男人一样准备战斗。%SPEECH_OFF%你不完全明白他的意思。你以为大多数人会沉迷于酒精，但是你对此没有意见。无论是什么，似乎他已经改善了。 | 你发现%addict%正坐在地上看着他的手掌。他用手指跟随凹槽。%SPEECH_ON%我在听你说话，先生。%SPEECH_OFF%点点头，你问他在干什么。他微笑着。%SPEECH_ON%感觉好了。感觉就像不再需要那些药水来放松自己。我感觉到了自己的存在，准备为您奉命而战，并且清晰地知道我在做什么和为什么这么做。%SPEECH_OFF%太好了。你不确定这是什么意思，但祝他好运，希望他能一直保持这种状态。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你做的真好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				local trait = _event.m.Addict.getSkills().getSkillByID("trait.addict");
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Addict.getName() + "不再上瘾"
				});
				_event.m.Addict.getSkills().remove(trait);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_addict = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getFlags().get("PotionLastUsed") >= 14.0 * this.World.getTime().SecondsPerDay && bro.getSkills().hasSkill("trait.addict"))
			{
				candidates_addict.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_addict.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		this.m.Addict = candidates_addict[this.Math.rand(0, candidates_addict.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = 5 + candidates_addict.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"addict",
			this.m.Addict.getName()
		]);
		_vars.push([
			"other",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Addict = null;
		this.m.Other = null;
	}

});

