this.ambition_failed_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.ambition_failed";
		this.m.Title = "露营时…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%randombrother% 抱怨。%SPEECH_ON%放弃从不是我们战队的作风，或者说至少我认为不是。%SPEECH_OFF%团中的人们今天一直闷闷不乐，一边喝酒一边不知道咒骂着什么。 他们对战队没有达到每个人都认同的目标而不高兴。%SPEECH_ON%当然我们可以一直追寻着这项我们设定的任务跑遍整个世界，就像我们花费一整天的时间抓蝴蝶一样，但是如果这件事完成不了就让我们将这件不幸的事情抛在我们的身后然后向前进做我们最擅长的事情：打架，喝酒，还有随意挥霍我们的血汗钱！%SPEECH_OFF%%highestexperience_brother% 鼓励着他手臂搭着的战友。 这些话语给了人们几分安抚，并且你也庆幸没有在你身边发生哗变。 | 正当你在营地帐篷旁边走动的时候，%randombrother% 接近你并抱怨。%SPEECH_ON%在我的记忆中和我签约的是一群无情的战士。 他们不会让任何东西阻挡他们前进的道路。 现在 %companyname% 让人感觉更像是一群累了的孩子而不是一股无法阻挡的力量。%SPEECH_OFF%他停顿了一下，咬着嘴唇。%SPEECH_ON%队长，我的意思是。%SPEECH_OFF%你点了点头并继续向前走着。 很明显，这个男人对于战队没能实现你不久前向他们宣布的目标感到沮丧。 | 尽管你尽了最大的努力，你还是没能在战队通往成功的道路上实现你们最近的目标。 更加糟糕的是，团队中的人们都敏锐地意识到了这一点，他们似乎比你更在意这次失败。 双脚拖着地，脑袋耷拉着，满腹牢骚，不满的声音比平时更大。\n\n尽管如此，太阳照常升起，把心思都用在担心之前的一场失败上就是在浪费时间不如用这些时间去追寻新的目标。 你知道 %companyname% 的战士们将会安然度过这次挫折并且走向更伟大的辉煌。 或者死在尝试的路上。 | 经过了许多的努力和尝试，你最终还是放弃了你为 %companyname% 所选择的目标。 一个雇佣兵战队在走向伟大的道路上必须面对许多挫折，但最近的一次失败对这些人来说尤其痛苦。 明智的做法是获得一份利润丰厚的合同或者提供一些其他分散注意力的东西，比如一次迫在眉睫的死亡威胁，用来分散他们的注意力。 | 当你告诉他们，战队不能做到你自豪的宣布的事情后，他们变得泠漠和喜怒无常。 当你走近他们时，他们像生气的孩子一样转过身去，当你转身时，他们又低声抱怨。%SPEECH_ON%如果我们不能完成我们开始的事情，我们要如何出名？ 无论我们走到哪里，我都想让别人知道我们，并且我想让所有地方在我们进门之前就帮我们把饮品倒上。%SPEECH_OFF%}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{并不是所有的事情都按照计划进行。 | 噢，好吧。 | 人们会理解的。 | 这不会阻止 %companyname%。 | 重要的是我们要继续前进。 | 新的挑战等着我们。}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(this.Const.MoodChange.AmbitionFailed, "对你的领导失去信心");

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

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local lowest_hiretime = 100000000.0;
		local lowest_hiretime_bro;
		local highest_hiretime = -9999.0;
		local highest_hiretime_bro;
		local highest_bravery = 0;
		local highest_bravery_bro;
		local lowest_hitpoints = 9999;
		local lowest_hitpoints_bro;

		foreach( bro in brothers )
		{
			if (bro.getHireTime() < lowest_hiretime)
			{
				lowest_hiretime = bro.getHireTime();
				lowest_hiretime_bro = bro;
			}

			if (bro.getHireTime() > highest_hiretime)
			{
				highest_hiretime = bro.getHireTime();
				highest_hiretime_bro = bro;
			}

			if (bro.getCurrentProperties().getBravery() > highest_bravery)
			{
				highest_bravery = bro.getCurrentProperties().getBravery();
				highest_bravery_bro = bro;
			}

			if (bro.getHitpoints() < lowest_hitpoints)
			{
				lowest_hitpoints = bro.getHireTime();
				lowest_hitpoints_bro = bro;
			}
		}

		_vars.push([
			"highestexperience_brother",
			lowest_hiretime_bro.getName()
		]);
		_vars.push([
			"strongest_brother",
			lowest_hiretime_bro.getName()
		]);
		_vars.push([
			"lowestexperience_brother",
			highest_hiretime_bro.getName()
		]);
		_vars.push([
			"bravest_brother",
			highest_bravery_bro.getName()
		]);
		_vars.push([
			"lowesthp_brother",
			lowest_hitpoints_bro.getName()
		]);
		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearest_town_distance = 999999;
		local nearest_town;

		foreach( t in towns )
		{
			local d = t.getTile().getDistanceTo(playerTile);

			if (d < nearest_town_distance)
			{
				nearest_town_distance = d;
				nearest_town = t;
			}
		}

		_vars.push([
			"currenttown",
			nearest_town.getName()
		]);
		_vars.push([
			"nearesttown",
			nearest_town.getName()
		]);
	}

	function onClear()
	{
	}

});

