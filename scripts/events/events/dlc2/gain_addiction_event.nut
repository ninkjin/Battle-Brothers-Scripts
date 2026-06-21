this.gain_addiction_event <- this.inherit("scripts/events/event", {
	m = {
		Addict = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.gain_addiction";
		this.m.Title = "露营时…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_12.png[/img]{%other%大声喊叫着，拖着%addict%进入你的帐篷，放下他，对朦胧不清的人拔出武器。你要求知道发生了什么事情。 %addict%把他的武器打在了一边，试图起身，但%other%又把他踢倒在地上。%SPEECH_ON%这家伙因为药水大发了一笔财，队长。我们几乎无法将他远离补给。%SPEECH_OFF%%addict%说话含糊，哼哼唧唧，然后点头。他清楚地讲述着，就像一个醉汉试图向警长解释他的罪行。%SPEECH_ON%我没有问题，先生。%SPEECH_OFF%你起身检查那个人的额头。他发冷，但汗水不断。%other%吐了一口口水。%SPEECH_ON%如果你对他谈论药水的话，他会有些暴力的，队长。我认为他已经对这些该死的东西上瘾了。%SPEECH_OFF% 你点头，告诉他们两个尽力保持平静。 | %addict%带着汗水和黑眼睛走进你的帐篷。%SPEECH_ON%先生，我想亲自告诉你这件事，你知道，全权负责。%SPEECH_OFF% 他解释说他已经对药水上瘾了。他说他会尽力管理。你点头，并感谢他的诚实。这个消息让你担心，但现在没有太多的解决办法。 | 男人们解释说，%addict%已经对药水、药瓶和药剂产生了浓厚的兴趣，那些不仅仅是好麦酒和蜜酒的精神品。你不确定是因为过度使用还是因为他无法处理当雇佣兵的困难。几个人被告知要密切关注他。现在，这是你所能做的最好的事情。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这条路要收费，但这些人能应付吗？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Addict.getImagePath());
				local trait = this.new("scripts/skills/traits/addict_trait");
				_event.m.Addict.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Addict.getName() + "已经上瘾"
				});
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

			if (bro.getFlags().get("PotionsUsed") >= 4 && this.Time.getVirtualTimeF() - bro.getFlags().get("PotionLastUsed") <= 3.0 * this.World.getTime().SecondsPerDay)
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

