this.glutton_eats_apple_event <- this.inherit("scripts/events/event", {
	m = {
		Glutton = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.glutton_eats_apple";
		this.m.Title = "露营时…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_18.png[/img]{你发现饕餮(%glutton%)在与一个桶发生着争执。他用力地吐着，背部像猫一样蜷缩，呕吐声像亡灵牛在生产。当他抬起头时，脸看起来像个葫芦，脸颊鼓起，嘴巴里还咕咕作响。%otherbrother%走过来说。%SPEECH_ON%他吃了女巫的苹果。%SPEECH_OFF%你皱起眉毛，问饕餮为什么会这样做。他擦了擦眼睛，手腕上还有呕吐物。%SPEECH_ON%{因为我总是饿啊——呕，嗯，很饿！ | 我真的不知道为什么，先生，我难道不能仅仅因为疼痛而不必证明我的行为吗？——呕，呕，呕！ | 如果我没有失去知觉，我还需要解释吗？——呕呕！ | 因为您告诉我要健康饮食，而这是一个苹果——呕呕！}%SPEECH_OFF%他将头投入桶中，像一个掉进了水井里的人一样。你告诉雇佣兵们要照顾好他，直到他身体中的东西排出为止，如果有可能的话。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Why...?",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Glutton.getImagePath());
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.poisoned_apple")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				local effect = this.new("scripts/skills/injury/sickness_injury");
				_event.m.Glutton.getSkills().add(effect);
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Glutton.getName() + "是生病了"
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

		local candidates_glutton = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.gluttonous"))
			{
				candidates_glutton.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_glutton.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local hasItem = false;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.poisoned_apple")
			{
				hasItem = true;
				break;
			}
		}

		if (!hasItem)
		{
			return;
		}

		this.m.Glutton = candidates_glutton[this.Math.rand(0, candidates_glutton.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates_glutton.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"glutton",
			this.m.Glutton.getNameOnly()
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Glutton = null;
		this.m.Other = null;
	}

});

