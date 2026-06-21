this.oathtakers_skull_event <- this.inherit("scripts/events/event", {
	m = {
		Oathtaker = null
	},
	function create()
	{
		this.m.ID = "event.oathtakers_skull";
		this.m.Title = "在途中…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_183.png[/img]{你发现%oathtaker%紧盯着年幼的安瑟姆的头骨眼窝，头骨的重量落在他伸出的手掌上。他不时点头，喃喃自语地祈祷。感觉到你的存在后，宣誓者转过身来。%SPEECH_ON%我很担心，但是尽管海洋一片混沌，如今我们拥有年幼的安瑟姆，他是如此勇敢，以至于我会毫无保留地游向世界的海洋，我确信他会引领我度过难关。我应该和其他人一起传播年幼安瑟姆的教诲。%SPEECH_OFF%他绝对应该这样做。 | 宣誓者们正在篝火旁享用美食。%oathtaker%将年幼安瑟姆的头骨放在一个树桩上。他偶尔转身，手里拿着一勺肉筋，看起来好像在考虑喂一些食物给这个头骨嘴里。这些时刻让你感到不安，但不知为何，这个小小头骨仅仅凭借它的存在就足以把宣誓者们的情绪变得更好，以至于你又觉得可以接受这些同时古怪和令人不安的怪癖。 | %oathtaker% 正在读一本有毛绒封面和镀金页签的书。在他身边，年幼的安瑟姆的头骨靠在一根将死的蜡烛旁。你问他在读什么。他抬起头来。%SPEECH_ON%研究誓言的事情，正如年轻的安瑟姆所写。记住小子明智的话语：墨水是最为强大的记忆，因此不仅要依赖自己的能力来遵守誓言，还要通过写作来刷新心灵的泉源。这也是年轻安瑟姆的教诲之一。如果你遵循他的建议照顾这些文字，你就会明白。%SPEECH_OFF%有点刻薄，但他并没有错。 | 你看到 %oathtaker% 正在清洗年轻安塞姆的头骨。为了测试这个人对初代宣誓者的信仰，你问了一个你已经知道答案的问题：安塞姆是如何死去的。宣誓者挺直身子，以一种真诚而受到冒犯的表情盯着你。%SPEECH_ON%队长，安塞姆是如何死的，甚至是什么时候、为什么、死于何人之手并不重要，甚至可能也不知道是谁，重要的是他在最后之路的誓言上，所以我们也与他同在，在死亡之时也伴随左右。我们不仅仅是宣誓者，更是最后的宣誓者。%SPEECH_OFF%他转过身来，轻轻拍掉一只虫子，然后开始清理头骨，似乎昆虫的足迹弄脏了它。%SPEECH_ON%队长，我们正在进行一项伟大的经历，但有时我觉得你就像是来凑热闹的。%SPEECH_OFF%至少，这是一次能让你深入了解的机会。值得庆幸的是，唯一能够注意到你更加愤世嫉俗的自然是一个被认为是有意义的头骨，年轻安塞姆空洞的眼窝注视着你，而宣誓者仍在擦拭着骨头。 | %oathtaker%跪在年幼安瑟姆的头骨前。%SPEECH_ON%年幼的安瑟姆，请在誓言中赐予我力量，我无法独自完成，单凭队长的帮助也是不够的。%SPEECH_OFF%你告诉他他不是孤身一人，他和%companyname%在一起，你自己也不是没用的，但想了想现在可能不是说实话的时候。男人突然跳了起来点了点头。%SPEECH_ON%年轻的安瑟姆，谢谢你的指引。%SPEECH_OFF%你希望自己也能够从这颗头骨中得到指导，但是你从头骨上得到的只有一个空洞的凝视。 | 战团经历了起起伏伏，但年轻的安瑟姆仍被视为其主要的虔诚之源。你承认，有时你会带着一点轻蔑地看着这颗头骨。尽管是你领导着这个团队，而且领导得很好，但很多战团的成功都被归功于这个头骨。当男人们需要帮助时，他们经常去寻求这颗头骨的帮助，而不是找队长。%oathtaker%就是这样的例子，他最近一直过得不顺，但他没有和你谈话，相反他抱起了年幼安瑟姆，寻求一些关于誓言的建议。你有时会梦想着抓住这初代宣誓者的头骨，像扔石头一样扔向湖面。 | 年轻的安瑟姆的头骨是宣誓者中最忠诚的人的试金石，是知识和指导以及其他一切的源泉，仿佛世间一切都出自于这头骨。%oathtaker%最近几天一直感到失落和沮丧，因此他被允许接触这个头骨。即使只是短暂的保管，他也重新对誓言恢复信仰。 | 你把年轻的安瑟姆的头骨放在一根棍子上开始转动，骨头随着转动咯咯作响，这咔嗒声莫名地恐怖。%oathtaker%从灌木丛中走过来，询问了一些事情，你立即抓住头骨并放下。宣誓者看着你、棍子、头骨，然后又看着你。他清了清嗓子，解释了他最近几天经历了一些困难。为了给与指导，也因为懒惰，你递给了他安瑟姆的头骨，并告诉他可以在初代宣誓者的内心找到新生的活力、信仰的恢复和勇气的复苏。这个人恭敬地点了点头。%SPEECH_ON%安瑟姆可是初代宣誓者，但我仍然相信你是一位智慧超出年龄的队长。我本应该一开始就去找安瑟姆的!%SPEECH_OFF% | 你把年幼的安瑟姆的头骨放在树墩上，并往眼窝里扔小鹅卵石。一块石子从眼眶中穿过，你挥舞着拳头庆祝。就在此时，%oathtaker%走了过来。他看着你，看着握紧的拳头和年幼的安瑟姆。宣誓者点了点头。%SPEECH_ON%即使像你这样的怀疑者都能被安瑟姆鼓舞，初代宣誓者的能力一定超出了我的想象。我就不打扰你了，这样你就可以从安瑟姆那里找到更多的指引。%SPEECH_OFF%你向他点了点头表示感谢，在他走后你依旧继续扔石子。但不幸的是，石子却一个接一个地弹在安瑟姆的脑袋上而咔嗒作响。看来你已经失去了投掷的灵感。 | 你手中握着一根粗大的树枝，将石头扔到空中然后猛力击飞到远处。每一声巨响深邃而令人愉悦，而石头飞舞的景象更加令人满意。当你俯身捡起另一块石头时，你发现年轻的安塞姆的头骨就在那里，向你瞪视着。你自然而然地将它举起，在手中称量着。它是如此轻盈。你将它扔到空中，然后用树枝猛击，骨片向每个方向扩散，细碎的骨粉弥漫在您周围的空气中，仿佛你施展了一场魔术。突然，你感到侧边有些动静，随后，这个世界瞬间消失，你睁开眼睛，发现你睡在篝火旁边。%oathtaker% 用脚趾戳着你，并放下一颗头骨点点头%SPEECH_ON%队长，我与年轻的安瑟姆寻求了建议并得到了回应，但看到你在睡梦中出汗，我想或许你也需要找初代宣誓者谈谈。%SPEECH_OFF%他转身离开，你留下了一颗头骨独自在那里。它睿智地注视着你，似乎太懂了你的想法。你转过头，继续睡觉。 | %oathtaker% 这几天过得很不顺利。 你带给他年轻的安瑟姆的头骨，告诉他要坐在那里冥想，反思誓言。这个男人点头，几分钟后他就带着头骨来到你面前。%SPEECH_ON%你是对的，队长。我偏离了正道，但通过初代宣誓者的指引，我又找回了它。%SPEECH_OFF% | 年轻的安瑟姆的头骨看起来有点破烂了。草，泥巴，几只虫子，所有这些东西都粘在骨头上。%oathtaker%过来问一些无聊的库存问题。你打断他，把头骨递给他，告诉他去清洗。他点点头，盯着头骨看，就像看着一磅纯金一样。他在十分钟内完成了工作，当他回来时，他的心情完全焕然一新，他自己承认，和年轻的安瑟姆独处的时间使他恢复了活力，并让他想起了他最初参加宣誓者的原因。这很好，但最重要的是，他忘记和你谈论库存，这太好了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你开心就好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Oathtaker.improveMood(1.35, "年轻的安瑟姆(Anselm) 重归他的誓约信仰。");

				if (_event.m.Oathtaker.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Oathtaker.getMoodState()],
						text = _event.m.Oathtaker.getName() + this.Const.MoodStateEvent[_event.m.Oathtaker.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Oathtaker.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local haveSkull = false;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin" && bro.getMoodState() < this.Const.MoodState.Neutral)
			{
				candidates.push(bro);
			}

			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.oathtaker_skull_01" || item.getID() == "accessory.oathtaker_skull_02"))
			{
				haveSkull = true;
			}
		}

		if (!haveSkull)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && (item.getID() == "accessory.oathtaker_skull_01" || item.getID() == "accessory.oathtaker_skull_02"))
				{
					haveSkull = true;
					break;
				}
			}
		}

		if (!haveSkull)
		{
			return;
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Oathtaker = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 5 * candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getName()
		]);
	}

	function onClear()
	{
		this.m.Oathtaker = null;
	}

});

