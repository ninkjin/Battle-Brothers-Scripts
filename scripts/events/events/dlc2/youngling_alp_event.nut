this.youngling_alp_event <- this.inherit("scripts/events/event", {
	m = {
		Callbrother = null,
		Other = null,
		Beastslayer = null,
		Flagellant = null
	},
	function create()
	{
		this.m.ID = "event.youngling_alp";
		this.m.Title = "露营时…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]{%callbrother%跑进你的帐篷里，说有东西在监视营地。你走到外面看到远处有一个轮廓，躲在灌木和树枝后面。它发出嘶嘶声，你知道它在盯着什么，否则它不会发出这样的声音。它的手臂又长又细，末端是爪子。你拿了一把火把，向野兽扔去。火把着地，向外溅出一片橙色的光芒，野兽尖叫着逃离火花的云团。最后你看到的是那张满是尖牙的嘴渐渐消失在黑暗中。%SPEECH_ON%我想它是个鬼压床，指挥官。据我们所知，它独自一人。%SPEECH_OFF%你问佣兵是否有预知能力。他耸耸肩。%SPEECH_ON%是的，有一些，但我也在喝酒，所以可能有误。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "杀死它。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "忽视它。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Callbrother.getImagePath());

				if (_event.m.Beastslayer != null)
				{
					this.Options.push({
						Text = "%beastslayer%，你是这方面的专家。 你怎么看？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Flagellant != null)
				{
					this.Options.push({
						Text = "%flagellant% 是怎么说的？",
						function getResult( _event )
						{
							return "E";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_122.png[/img]{这位地精可能还很年轻并且孤身一人。即使是怪物，也需要通过努力工作来成为真正可怕的野兽，但这一只看起来还未如此。你派了一对雇佣兵去杀死这只野兽。他们在黑暗中逐渐逼近。你看到他们在埋伏中崛起，然后听到了一阵嘈杂的声音和尖叫，接着是一声更不像人声的尖叫。现在哭喊的是一个人。有人在说话，声音很轻。很长很长时间的安静。然后他们俩回来了。一个人捂着头好像被一阵剧痛折磨了一样，另一个人看着你点了点头。%SPEECH_ON%我们杀死了它，并且，嗯，我想我们需要躺下休息一下。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Callbrother.getImagePath());
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Callbrother.addXP(200, false);
				_event.m.Callbrother.updateLevel();
				_event.m.Other.addXP(200, false);
				_event.m.Other.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Callbrother.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				_event.m.Callbrother.worsenMood(0.75, "梦魇侵入了他的思想");

				if (_event.m.Callbrother.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Callbrother.getMoodState()],
						text = _event.m.Callbrother.getName() + this.Const.MoodStateEvent[_event.m.Callbrother.getMoodState()]
					});
				}

				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Other.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				_event.m.Other.worsenMood(0.75, "梦魇侵入了他的思想");

				if (_event.m.Other.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你告诉士兵们忽略那只狮鹫。如果它真的对你们构成威胁，早就已经表现出来了。相反它让你知道它的存在，无论是出于无知还是傲慢，这都不会让你困扰。然而有几个人不同意这个决定，他们整夜都在观察那只野兽。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "长出了一对。",
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
					if (bro.getLevel() <= 3 || bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.witchhunter" || bro.getSkills().hasSkill("trait.hate_beasts") || bro.getSkills().hasSkill("trait.fear_beasts") || bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.paranoid") || bro.getSkills().hasSkill("trait.superstitious"))
					{
						bro.worsenMood(0.75, "你让梦魇活下来，以后可能会闹鬼");

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
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_122.png[/img]{%beastslayer% 兽人猎手走过来。%SPEECH_ON%不危险，它只是有些困惑。我来处理它。%SPEECH_OFF%他嚼着干饼干，咕哝着把饼干放进口袋，独自一人走向黑暗。片刻后，山怪的轮廓突然消失了。几分钟后，猎手回来了，把最后一口饼干塞进嘴里。你问为什么山妖没闹腾。兽人猎手笑了。%SPEECH_ON%你说%callbrother%从你的帐篷里把你叫出来了，是吧？是啊。%callbrother%在哪儿？%SPEECH_OFF%兽人猎手指了指篝火。佣兵在那里，睡着了。沉睡着。%beastslayer%拿了另一块饼干。%SPEECH_ON%年轻的山妖还在学习如何读取你的思想。它们不擅长并且往往在尝试时引起注意。它们就像无法撬开锁的小偷，所以只能敲门。%SPEECH_OFF%有几个人听了这话，似乎被这些可怕生物的显而易见的缺陷激励了。}  ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做的好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beastslayer.getImagePath());
				_event.m.Beastslayer.improveMood(0.5, "派出没有经验的梦魇");
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getLevel() <= 3 && this.Math.rand(1, 100) <= 33 || bro.getBackground().getID() == "background.witchhunter" || bro.getSkills().hasSkill("trait.hate_beasts") || bro.getSkills().hasSkill("trait.fear_beasts") || bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.paranoid") || bro.getSkills().hasSkill("trait.superstitious"))
					{
						bro.improveMood(1.0, "通过学习年轻梦魇的弱点而变得胆大");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_33.png[/img]{%flagellant%鞭笞者正在营地边缘用鞭子抽打自己的身体。他的灵魂净化器装有破碎的玻璃和猫爪，用浸了尿的皮革紧密地捆绑着，并以扭曲的马毛为饰。他走出丛林，在每一步中都躲藏着。%SPEECH_ON%我并不怕你，影子中的生物。我并不害怕你，在我脑海中的影子。我害怕的是你不是所敬畏的古神！你只是一只昆虫！%SPEECH_OFF%鞭笞者停下了脚步，但他鞭打自己的狂热愈发增强，你可以看到月光下闪烁的血迹。%SPEECH_ON%我害怕的是你不是所敬畏的古神！你只是一只昆虫！%SPEECH_OFF% 魇魔的轮廓缩小，尖叫声，然后快速逃走。这个人回到了营地，倒在地上。一些人感到震惊，而另一些人则因他的勇气和正义而变得勇敢起来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "以古老神明的名义。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Flagellant.getImagePath());
				local hitpoints = this.Math.rand(1, 3);
				_event.m.Flagellant.getBaseProperties().Hitpoints += hitpoints;
				_event.m.Flagellant.getSkills().update();
				local injury = _event.m.Flagellant.addInjury(this.Const.Injury.Flagellation);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Flagellant.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
				this.List.push({
					id = 16,
					icon = "ui/icons/health.png",
					text = _event.m.Flagellant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] 生命值"
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

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days < 20)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];
		local candidates_beastslayer = [];
		local candidates_flagellant = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.beast_slayer")
			{
				candidates_beastslayer.push(bro);
			}
			else if (bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				candidates_flagellant.push(bro);
			}
			else
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		local r = this.Math.rand(0, candidates.len() - 1);
		this.m.Callbrother = candidates[r];
		candidates.remove(r);
		this.m.Other = candidates[this.Math.rand(0, candidates.len() - 1)];

		if (candidates_beastslayer.len() != 0)
		{
			this.m.Beastslayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];
		}

		if (candidates_flagellant.len() != 0)
		{
			this.m.Flagellant = candidates_flagellant[this.Math.rand(0, candidates_flagellant.len() - 1)];
		}

		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"callbrother",
			this.m.Callbrother.getName()
		]);
		_vars.push([
			"beastslayer",
			this.m.Beastslayer != null ? this.m.Beastslayer.getName() : ""
		]);
		_vars.push([
			"flagellant",
			this.m.Flagellant != null ? this.m.Flagellant.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Callbrother = null;
		this.m.Other = null;
		this.m.Beastslayer = null;
		this.m.Flagellant = null;
	}

});

