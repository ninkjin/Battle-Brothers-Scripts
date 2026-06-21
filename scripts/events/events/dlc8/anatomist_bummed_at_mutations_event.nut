this.anatomist_bummed_at_mutations_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_bummed_at_mutations";
		this.m.Title = "露营时…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{%anatomist%坐在篝火旁边，离火有些近。你把他拉开一些，以免他烧着自己。他抬起头，脸上布满了疱疹，并且涂了一些已经爆破的脓油。%SPEECH_ON%我现在开始怀疑喝那剂药是不是个巨大的错误。%SPEECH_OFF%他向火移动，眼中似乎有一种想要投身其中的欲望。你没办法帮他太多，大多数是因为他此刻看起来相当恶心，你宁愿不再碰他。 | 你在战团大篷车旁发现%anatomist%站着，卷起袖子用手指在一些奇怪的标记上戳。你好奇地问他这是不是胎记。解剖学家转过身来摇头。他抬起衣服，展示了他全身上下的这些标记，肉上有着不好看的颜色，感觉粗糙，像是无法撕下的痂，让人很不舒服。%SPEECH_ON%我喝的药水导致了这个结果，而我不知道该如何是好。%SPEECH_OFF%你点点头，告诉他一定会好起来的。他叹了口气，简单地放下衣服，扭头离开。 | %anatomist%站在水桶边，看着自己的黑暗反射，叹了口气。你问他最近怎么样，他转身露出了皮肤上可怕的皮疹和疮。%SPEECH_ON%老实说，情况不太好。我饮用的药物似乎对我产生了严重的影响，尽管我的措辞可能有些大。我会活下去，但这伤害不仅仅是对肌肤和身体，还是对精神。我之前以为自己与此无关，但现在，看到自己可怕的脸……我感到无尽的不安。%SPEECH_OFF%你拍了拍他的肩膀，向他点头，提建议说他应该喝些水，当然不要难过。你并不擅长安慰别人，更别说安慰那些遭受疯狂科学的可怕疾病折磨的人了。 | %anatomist%解剖学家处于一种失落的状态中。他制造的药水，却被迫饮用，导致整个身体充满了从皮疹到疮痍再到异常痉挛和不断涌出鼻涕的恶疾。你向他保证他会好起来的，但他的可怕外表正在对他造成影响。 | %anatomist%解剖学家制造的奇怪配方，都是他自己饮用的。毫不意外的是，影响并不好：皮肤起疹子，感染，臭味，脱发等等等等。尽管他在外面宣称他的行为是为了科学，但你能看出这些病症和变形对他的士气造成了打击。你只能希望他能在一定的时间内恢复过来。 | 超出你理解范围的科学问题总是伴随着风险。你记得小时候你的朋友冒险用草绳荡秋千，而意外的是你们却发现树枝在摇晃的时候能承受多少重量。\n\n现在，看来%anatomist%解剖学家正在尝试从喝下他自己制作的奇怪药物中得到克服疾病的滋味。他的脸上长满了恶心的疙瘩和脓包，而蚂蚁也不知道出于什么原因为什么变成了有吸引力的磁铁，整天都在他身上爬。希望这些疾病会随着时间的推移离开他，也希望这些可恶的蚂蚁跟着消失。 | 你一直都知道解剖学家有点神经质，但他们制造药剂并饮用的方法真的让你吃惊。如果没有从正确的杯子小口地啜饮就有可能中毒，更不用说这些解剖学家从科学概念的泥沼中提炼的一系列药水了。自然而然，没过多久，其中一个蛋头，%anatomist%，就生病了。他仍然能够行动和做日常任务，但巨大的瘤子和不断渗出脓液的疱疹让他看上去很可怕。尽管他也认为自己与社会疏离，你毫不怀疑，像粘了猪粪的抹布四处走动对心灵和精神不利。希望随着时间的推移，他能够恢复过来。 | %anatomist%解剖学家并不是因为饮用他自己的药水而生病了。毕竟，他仍然能够行动、四处走动，甚至有必要的时候还能战斗。但他的身体却显然受到了药物的影响，并变得非常丑陋。他脸颊上长出了大疙瘩，眼睛偶尔从眼窝中弹出，需要用力推回去，这是你不愿看到的。唾液在嘴角滴下，鼻孔里满是鼻涕、鼻屎和血。你可以想象，他现在的样子比死猪的尸体还难看。但你相信，随着时间的推移，他会恢复好转。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "早日康复，%anatomist%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.25, "因突变而变化的事情令他感到不安。");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.getFlags().add("gotUpsetAtMutations");
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

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && !bro.getFlags().has("gotUpsetAtMutations") && bro.getFlags().getAsInt("ActiveMutations") > 0)
			{
				anatomistCandidates.push(bro);
			}
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 6 * anatomistCandidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});

