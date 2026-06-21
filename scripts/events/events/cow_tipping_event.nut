this.cow_tipping_event <- this.inherit("scripts/events/event", {
	m = {
		Other = null,
		Strong = null,
		Cocky = null
	},
	function create()
	{
		this.m.ID = "event.cow_tipping";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_72.png[/img]行军途中，你遇到一头孤独的奶牛站在田野里。 没啥大不了的：它就是一头牛。\n\n 但这时 %randombrother% 悄悄靠近你。 他说话时对扫把又咬又扭。%SPEECH_ON%你认为谁能做到？%SPEECH_OFF%你问做什么。他笑了。%SPEECH_ON%啊，抱歉。我不知道你没有听说。 我们要看看是否有人能把那头牛撞倒！ 比如说，假如我们只能撞它一次，你来选择我们中的某一个试试怎么样？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "挑选你们认为最好的那个人。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				});

				if (_event.m.Strong != null)
				{
					this.Options.push({
						Text = "我打赌 %strong% 足够强壮来搞定它。",
						function getResult( _event )
						{
							return "Strong";
						}

					});
				}

				if (_event.m.Cocky != null)
				{
					this.Options.push({
						Text = "那个嚣张的家伙 %cocky% 看起来跃跃欲试。",
						function getResult( _event )
						{
							return "Cocky";
						}

					});
				}

				this.Options.push({
					Text = "不要打那头母牛。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_72.png[/img]你告诉他们自己选一个人。 他们很快就选择了 %cowtipper% 这位在一番纠缠之后同意试一试的人。\n\n 佣兵小心地走过田野，尽量避开牛粪。 奶牛满不在乎地看着他。 它先哞哞叫一次，然后短暂地把注意力放回草地上。 队员们窃笑着，向前嘘着 %cowtipper%，做着鬼脸说“上啊！”或“你还在等什么？”最后，站在离奶牛几英尺远的地方，%cowtipper% 冲锋了。%SPEECH_ON%哇呀呀！%SPEECH_OFF%他一头冲向奶牛的肚子，简直就像跑进了一间房子：他的脚从身体下面滑出来，他在母牛的肚子下面打滑，摔了一跤，新鲜的牛粪给他上了一层油。 大家哄堂大笑。%SPEECH_ON%你不能给牛小费你个傻瓜！ 它们太重了！%SPEECH_OFF% %cowtipper% 毫无疑问成为这帮家伙的新笑料，不过他的“牺牲”还是值得的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好一场表演！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Other.worsenMood(0.5, "在战队面前羞辱了自己");

				if (_event.m.Other.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Other.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.5, "被逗乐于" + _event.m.Other.getName() + "'尝试推倒一头奶牛");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_72.png[/img]你告诉他们自己选一个人。 他们很快选择了 %cowtipper%。 佣兵小心地走过田野，尽量避开牛粪。 奶牛自己则若无其事地看了看四周，然后哞了一声，然后又把注意力转移到草上。 队员们窃笑着，向前嘘着 %cowtipper%，做着鬼脸说“上啊！”和“快点！”。 最后，站在离牛几英尺的地方，%cowtipper% 向前冲去。%SPEECH_ON%哇呀呀！%SPEECH_OFF%他的尖叫吓到了牛。 牛沉下肩蹄子刨地，用沉重的后蹄追逐着 %cowtipper%。 他拼命地挪动着双脚，在草地上转来转去。 队员们笑了一会儿，然后意识到问题很严重。 当牛哞哞叫着跑开时，佣兵获救了。虽然伤得很重，他还是幸免于这场牛蹄边缘的杀戮。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很有趣。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local injury = _event.m.Other.addInjury(this.Const.Injury.Accident3);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Other.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Other.worsenMood(0.5, "在战队面前羞辱了自己");

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
			ID = "Strong",
			Text = "[img]gfx/ui/events/event_72.png[/img]你认为强壮而魁梧的 %strong% 会给奶牛很好的上一课。. 你笨拙的措辞引得队员们哈哈大笑，但是 %strong% 却毕恭毕敬地鞠了一躬。%SPEECH_ON%我很荣幸，先生。%SPEECH_OFF%他卷起袖子，在田野里踱来踱去，跨过牛粪，就像一个商人跨过无家可归的人。 奶牛看了看，好奇地扬了扬眉毛。%strong% 点头。%SPEECH_ON%就是这样，我来了。%SPEECH_OFF%更多的措辞问题比比皆是。 不理会嘲笑他的队员们，%strong% 冲向了奶牛。 起初，他只是简单地按压它的侧面，青筋暴起，呼吸急促。 队员们嘲笑他的努力是徒劳的，但是当奶牛徐徐穿过泥地和草地时，他们很快就安静下来了。 伴随着一声巨大的轰鸣，%strong% 向前猛冲，而那头牛则一头栽到一边，发出一阵疑惑的哞哞声。\n\n %otherbrother% 站在那里，目瞪口呆。%SPEECH_ON%这是个笑话… 我认为这在现实中是不可能的…%SPEECH_OFF%队伍里爆发出一阵欢呼声，为这个强壮男子的惊人壮举而喝彩！",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Strong.getImagePath());
				_event.m.Strong.getBaseProperties().Stamina += 1;
				_event.m.Strong.getSkills().update();
				this.List.push({
					id = 17,
					icon = "ui/icons/fatigue.png",
					text = _event.m.Strong.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 最大疲劳"
				});
				_event.m.Strong.improveMood(0.5, "展示显示了他的体力");

				if (_event.m.Other.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Strong.getMoodState()],
						text = _event.m.Strong.getName() + this.Const.MoodStateEvent[_event.m.Strong.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Strong.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.5, "目击(Witnessed)" + _event.m.Strong.getName() + "的惊人壮举");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
			ID = "Cocky",
			Text = "[img]gfx/ui/events/event_72.png[/img]还没等你说完，%cocky% 就拍着胸脯向前走了一步。%SPEECH_ON%我要打倒那头小母牛！%SPEECH_OFF%你提醒他战队和奶牛没有任何关系，这只是为了好玩和游戏。 他站在那里，双臂隆起肌肉双拳击打屁股。%SPEECH_ON%无稽之谈。队友们嘲笑我认为这是不可能的，但是我在这里要让他们知道他们是多么的错误！%SPEECH_OFF%那个自信满满的佣兵一脚跨进地里，立刻就踩到了一块牛粪饼。 他侧着身子向前走，为了保持平衡而挥舞着双臂，但当他重重地摔在地上时，这一切都化为乌有。 伙计们开始大笑起来。 这头奶牛只是瞥了一眼就走开了。%cocky% 把自己弄干净后站起来。%SPEECH_ON%一个小小的失误。但是，看吧！ 这个懦弱的畜生根本不敢与我一战！%SPEECH_OFF%%otherbrother% 大笑并指着他的脏衣服。%SPEECH_ON%也许吧，你对它还有那么点胜算。%SPEECH_OFF%这个嚣张的佣兵马上擦去衣服上的牛屎。 尽管失败了，但他没有被吓倒，队员们几乎要晕过去了，因为他们笑的太多了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你做的足够好了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cocky.getImagePath());
				_event.m.Cocky.getBaseProperties().Bravery += 1;
				_event.m.Cocky.getSkills().update();
				this.List.push({
					id = 17,
					icon = "ui/icons/bravery.png",
					text = _event.m.Cocky.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Cocky.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.5, "目击(Witnessed)" + _event.m.Cocky.getName() + "的失败乐趣");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Plains && currentTile.Type != this.Const.World.TerrainType.Steppe)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidate_strong = [];
		local candidate_cocky = [];
		local candidate_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.strong") || bro.getSkills().hasSkill("trait.tough"))
			{
				candidate_strong.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.cocky"))
			{
				candidate_cocky.push(bro);
			}
			else
			{
				candidate_other.push(bro);
			}
		}

		if (candidate_other.len() == 0)
		{
			return;
		}

		if (candidate_strong.len() != 0)
		{
			this.m.Strong = candidate_strong[this.Math.rand(0, candidate_strong.len() - 1)];
		}

		if (candidate_cocky.len() != 0)
		{
			this.m.Cocky = candidate_cocky[this.Math.rand(0, candidate_cocky.len() - 1)];
		}

		this.m.Other = candidate_other[this.Math.rand(0, candidate_other.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"strong",
			this.m.Strong != null ? this.m.Strong.getNameOnly() : ""
		]);
		_vars.push([
			"strongfull",
			this.m.Strong != null ? this.m.Strong.getName() : ""
		]);
		_vars.push([
			"cocky",
			this.m.Cocky != null ? this.m.Cocky.getNameOnly() : ""
		]);
		_vars.push([
			"cockyfull",
			this.m.Cocky != null ? this.m.Cocky.getName() : ""
		]);
		_vars.push([
			"cowtipper",
			this.m.Other != null ? this.m.Other.getNameOnly() : ""
		]);
		_vars.push([
			"cowtipperfull",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
		_vars.push([
			"otherbrother",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Strong = null;
		this.m.Cocky = null;
		this.m.Other = null;
	}

});

