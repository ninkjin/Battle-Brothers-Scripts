this.anatomist_vs_clubfooted_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Clubfooted = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_clubfooted";
		this.m.Title = "露营时…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你发现解剖学家%anatomist%盯着%clubfoot%笨拙的脚步情况看：即他的一只脚看起来像一袋锤子。这是一件令人厌恶和不美观的事情，当然也使得他难以履行雇佣兵的全部职责。消息称这在女人中间异常流行，但这是未经证实的传闻。不管怎样，解剖学家向你提出了建议。%SPEECH_ON%这种病症并不罕见，这个人的畸形足在年轻的时候很容易修复，但是年龄越大手术就越难以矫正。幸运的是，我是一位受过训练的解剖学家，在这个问题上拥有极其丰富的知识。如果你允许我，我将尝试治愈这个人的不幸并且不必要的终身情况。%SPEECH_OFF%%clubfoot%自己点头表示，如果你认为这是最好的办法，他就准备试一试。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去做吧，努力工作吧。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "不，风险太大了。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Clubfooted.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你同意了%anatomist%的建议。他和那个脚残的人一起走向目的地。自然地，你也跟了上去。你看着%anatomist%把%clubfoot%的脚放在凳子上。他拿出一块刻有牙齿印记的木头，然后拿出一瓶液体，拔开塞子，将液体涂抹在木头上，自己先喝了一口，然后把剩下的递给了他的病人。%clubfoot%喝完液体，咬着木头。接下来是一连串恶心的折腿、打石膏、换石膏的过程。%anatomist%开始用手术刀切开，一边咧嘴笑着一边工作。%clubfoot%早就晕了过去。\n\n最后，%clubfoot%的腿完全残废，并且被包扎起来。%anatomist%说手术很成功，但是康复期会相当漫长。脚还必须不断地重新包扎，走动起来时需要走多几步，但起码能走动了。神志不清的%clubfoot%望着自己的脚笑了。%SPEECH_ON%这对我来说，也对%companyname%来说都是值得的，队长。%SPEECH_OFF%他职业操守良好、被麻醉就倒头大睡，打起呼噜来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "走走，兄弟，这是你的人生。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Clubfooted.getSkills().removeByID("trait.clubfooted");
				this.List.push({
					id = 10,
					icon = "ui/traits/trait_icon_23.png",
					text = _event.m.Clubfooted.getName() + "不再瘸足。"
				});
				local injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.broken_leg",
						Threshold = 0.0,
						Script = "injury/broken_leg_injury"
					}
				]);
				this.List.push({
					id = 11,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " 遭受 " + injury.getNameOnly()
				});
				injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.cut_achilles_tendon",
						Threshold = 0.0,
						Script = "injury/cut_achilles_tendon_injury"
					}
				]);
				this.List.push({
					id = 12,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Clubfooted.improveMood(1.0, "他的畸形脚被治愈了。");
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Clubfooted.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你不情愿地让解剖学家%anatomist%开始工作。你考虑加入他和%clubfoot%在帐篷里工作，但是让自己的脚骨折来治疗它，这种想法让你感觉不对劲。相反，你去数你最喜欢的存货清单。记录下你拥有什么，需要多少，战团正在以什么速度消耗这些物品，这一切都很有趣。\n\n确实没有什么比数存货清单更好的事情了，唯一可能停止你的享受的是%clubfoot%的尖锐可怕的尖叫，它突然从你刻意避免进入的帐篷中传来。现在，他尖厉的呼喊声充满了空气，你跑到帐篷里进去了。你发现%anatomist%在一侧擦拭额上的汗水。%SPEECH_ON%你好，队长。总之，让我这样总结一下。正如你所看到的，发生了一些无法预料的并发症。当然，他会康复，你不必担心，但那个脚残将会留下。它被我的医治所耗费的时间证明了，呃，它有点抵抗力。%SPEECH_OFF%你看着%clubfoot%。他现在已经昏迷，他的腿在膝盖以下扭曲得像一块抹布。解剖学家恭敬地点点头。%SPEECH_ON%别担心这个，我会解决的。只需要这个人停止尖叫和动来动去，我好好喘口气，就行了。你想看吗？%SPEECH_OFF% 解剖学家拿起那个人的脚。它在他的手中像揉面团一样晃动。你摇了摇头，赶快离开帐篷。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Aaaaahh.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.broken_leg",
						Threshold = 0.0,
						Script = "injury/broken_leg_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " 遭受 " + injury.getNameOnly()
				});
				injury = _event.m.Clubfooted.addInjury([
					{
						ID = "injury.traumatized",
						Threshold = 0.0,
						Script = "injury_permanent/traumatized_injury"
					}
				]);
				this.List.push({
					id = 11,
					icon = injury.getIcon(),
					text = _event.m.Clubfooted.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Clubfooted.worsenMood(this.Const.MoodChange.PermanentInjury, "被疯子实验过");
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Clubfooted.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]{你好奇地看着%anatomist%。%SPEECH_ON%难道我在这经营的是一家马匹赛马场吗? 如果那个人想让他的残疾脚得到治愈，他可以光荣地和尊严地退休。我们不需要那些会得出旧神知道什么结果的奇怪实验。%SPEECH_OFF%解剖学家清了清嗓子，说这些程序非常简单，但他在说到完成这些程序所获得的科学利益时失言了，表明他根本没有%clubfoot%的利益在心中。你告诉他对话已经结束。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一拐一拐地走吧。",
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
		local clubfootedCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() != "background.anatomist" && bro.getSkills().hasSkill("trait.clubfooted"))
			{
				clubfootedCandidates.push(bro);
			}
		}

		if (clubfootedCandidates.len() == 0 || anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Clubfooted = clubfootedCandidates[this.Math.rand(0, clubfootedCandidates.len() - 1)];
		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 5 * clubfootedCandidates.len();
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
		_vars.push([
			"clubfoot",
			this.m.Clubfooted.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Clubfooted = null;
	}

});

