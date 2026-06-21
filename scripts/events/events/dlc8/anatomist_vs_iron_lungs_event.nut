this.anatomist_vs_iron_lungs_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		IronLungs = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_ironlungs";
		this.m.Title = "露营时…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{在雇佣文化的世界里，拥有强大的耐力非常重要，但显然有些人比其他人更能够抵抗疲劳。%ironlungs%就是这样的人，他是一个以在激烈战斗中能保持稳定呼吸而著称的战士。对你来说，这只是一个好奇心，就像一个人有奇怪的脖子、大手或者大锤子一样。但对%anatomist%来说，这完全是另外一回事了。他想知道为什么一个人在日常生活中和他周围的人没有什么差别，却拥有如此强健和有力的肺部。%SPEECH_ON%我们都是战士，所以这个人如何能够和我们其他人相比呼吸如此稳定？他肯定拥有我们所没有的元素，我想我可以找到这个元素。%SPEECH_OFF%等等，“我们”都是战士？你并不完全同意解剖学家的说法。你问他如何研究这个问题。%SPEECH_ON%考虑到种种原因，简单的解剖不太可能，但我相信%ironlungs%会拒绝我的要求。那么就只有一个选项了，就是通过骨骼操作和小心的切口来密切研究他，看看是否能够复制他的力量。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "嘿，这是你的身体。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "绝不可能。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.IronLungs.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你告诉解剖学家继续做他想做的事情。他拿出一支羽毛笔和几本书，然后拿出一个装满金属钳子、剪刀和解剖刀的小篮子。他检查每一件工具是否清洁，然后把它们举起来走向%ironlungs%。这个雇佣兵尴尬地看着他。最终，解剖学家说服了他和他一起走进了一个帐篷。你当心解剖学家会失去理智，陷入狂乱状态。最终，%anatomist%手持一个瓶子回来了，他慢慢地把瓶子里的液体转了一圈，然后喝了下去。他点了点头。%SPEECH_ON%希望这可以奏效。我对自己的身体进行了巨大的压力测试，以真正地压迫肺部，然后使用了%ironlungs%提供的一些成分。然后，自然地加入了其他元素，我永远不会向任何人泄露，因为如果这奏效了，我可能成为这个领域的专家，是科学上的真正英雄，并且绝对胜过其他解剖学家。%SPEECH_OFF%好的。现在%ironlungs%从帐篷里出来了。你问他发生了什么事。他耸了耸肩。%SPEECH_ON%我告诉他我经常做拉伸和有良好的姿势，我也确实练习呼吸。他拒绝了这些回答，自信地认为必须有其他方法。然后他用他手头上的工具进行了一些手术。不管他做了些什么，看起来都很痛苦，但他很镇定。%SPEECH_OFF%等等，你会练习呼吸？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我现在正在手动呼吸。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local trait = this.new("scripts/skills/traits/iron_lungs_trait");
				_event.m.Anatomist.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.Anatomist.getName() + "获得铁肺。"
				});
				local injury = _event.m.Anatomist.addInjury([
					{
						ID = "injury.pierced_lung",
						Threshold = 0.0,
						Script = "injury/pierced_lung_injury"
					}
				]);
				this.List.push({
					id = 11,
					icon = injury.getIcon(),
					text = _event.m.Anatomist.getName() + " 遭受 " + injury.getNameOnly()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.IronLungs.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{%anatomist%得到了批准，他匆匆跑回帐篷，带着工具袋和%ironlungs%。你走进帐篷，发现%anatomist%坐得笔直，脊椎像老年人一样弯曲，然后又挺直起来。\n\n突然，他拿起一个工具，刺向自己。%ironlungs%向后一仰，有点惊讶于这种自残的行为。他向解剖学家伸出援手，但是被挥手拒绝。%anatomist% 牙切齿地开始记笔记，鲜血从他的嘴里向纸张上喷射出来。然后他再次反复这个过程，这次从另一个角度开始。\n\n即使从远处，你现在也能看到血液以深红色的绳索形式喷涌出来，时不时地喷出明亮的鲜红色。他咬紧牙关，又刺了一次，这一次血红色的喷涌更加剧烈。你已经看够了，但是在你干预之前，解剖师的眼睛翻到了后面，他晕倒了。%ironlungs% 看起来很震惊。%SPEECH_ON%这是什么鬼？队长，你批准了这个吗？他希望学到什么？%SPEECH_OFF%你的薪水不足以忍受这些白痴。看着解剖学家的笔记，你可以透过被血染红的页面看到，他只是一遍又一遍地写着“不起作用”。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "当仅仅是呼吸都让你变得无聊起来。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local injury = _event.m.Anatomist.addInjury([
					{
						ID = "injury.pierced_lung",
						Threshold = 0.0,
						Script = "injury/pierced_lung_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Anatomist.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Anatomist.worsenMood(0.5, "他的实验性手术没有成功。");
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.IronLungs.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你告诉解剖学家管好自己的事。当他开始抱怨，接近于让这成为你的事情时，你告诉他 %ironlungs% 是他自己的人，完全是他自己的，除了一点点欣赏之外，没有任何可以从他的存在中得到的东西。就这样。%anatomist% 开始想回应，然后闭上了嘴。相反，他想到的任何事情都被记录在他的笔记里。你希望任何的争吵也随着他的墨水干涸。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的蠢蛋。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.0, "被剥夺了研究机会");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local ironLungsCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && !bro.getSkills().hasSkill("trait.iron_lungs"))
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() != "background.anatomist" && bro.getSkills().hasSkill("trait.iron_lungs"))
			{
				ironLungsCandidates.push(bro);
			}
		}

		if (ironLungsCandidates.len() == 0 || anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.IronLungs = ironLungsCandidates[this.Math.rand(0, ironLungsCandidates.len() - 1)];
		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 5 * ironLungsCandidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
		_vars.push([
			"ironlungs",
			this.m.IronLungs.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.IronLungs = null;
	}

});

