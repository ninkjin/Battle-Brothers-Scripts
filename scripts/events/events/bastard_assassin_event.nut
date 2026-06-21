this.bastard_assassin_event <- this.inherit("scripts/events/event", {
	m = {
		Bastard = null,
		Other = null,
		Assassin = null
	},
	function create()
	{
		this.m.ID = "event.bastard_assassin";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "Intro",
			Text = "[img]gfx/ui/events/event_33.png[/img]在夜幕的掩护下，一个男人溜进了你的帐篷，而帐篷的帘子仅仅在地上飘了几下。 他披着一件黑斗篷，戴着高贵的宝龙面具。 你自己武装自己，但他伸出手来。%SPEECH_ON%不必麻烦了，佣兵，因为我不是为你而来的。%SPEECH_OFF%那对你来说不够好。 那人再走一步，你就冲过去把他按在你的桌子上，用你那只空着的手把匕首刺向他的脖子。他笑着说。%SPEECH_ON%我已经告诉过你，我不是为你而来。 我来是为了 %bastard%。%SPEECH_OFF%那个贵族私生子？你问这个陌生人想对他怎么样。%SPEECH_ON%好吧，那要看情况，你愿意谈谈么？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，谈谈。",
					function getResult( _event )
					{
						return "A";
					}

				},
				{
					Text = "没什么好谈的。你去死吧。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "Decline1";
						}

						if (r <= 66)
						{
							return "Decline2";
						}
						else
						{
							return "Decline3";
						}
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Assassin = roster.create("scripts/entity/tactical/player");
				_event.m.Assassin.setStartValuesEx([
					"assassin_background"
				]);
				this.Characters.push(_event.m.Assassin.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]你把匕首从他脖子上拿下来。 他在桌子上直起身子，瞥了瞥地图。%SPEECH_ON%我看到 %companyname% 已经声名远扬了。%bastard% 明智地选择了适合自己的行列。%SPEECH_OFF%当一滴血溅到纸上时，他停下来，去抓你留在他脖子上的一个小伤口，噘起嘴唇，仿佛他是在早晨刮胡子时给自己留下的。%SPEECH_ON%不管怎样，我们谈谈生意吧。 我的雇主要 %bastard% 死。 既然我已经得到了一大堆硬币，我就有义务把这个野心坚持到底。或者…也许不。%SPEECH_OFF%当他挑起有趣的眉毛时，你告诉他说出他的想法。 他指着地图上我们的行军路线说道。%SPEECH_ON%%bastard% 有一支军队等着他，如果他愿意。 这就是为什么这些贵族们想要他死，因为他现在是一个真正的和可怕的威胁，而这一点他还不知道。 我想他也不需要，但这将是一次愉快的送别，不是吗？ 你要确保他在这个世界上的地位是正当的，他不是在一个他认为恨他的世界里偶然地飘过。 但是我呢，一个非常有天赋的杀手，有着完美的杀人记录，嗯？ 关于我的什么？好吧，我不想再过这种生活了。 所以我的提议是：我来代替他。 他走了，我跟你。 他去征服别人，我的雇主并不比他聪明，他们只知道我消失了。听起来不错，不是吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们成交。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "他们给了你多少钱？",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我还是要杀了你。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "Decline1";
						}

						if (r <= 66)
						{
							return "Decline2";
						}
						else
						{
							return "Decline3";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]%bastard% 理应得到更好的待遇。并不是 %companyname% 对他不好，而是他一生都把自己看成一个局外人，是自己家族姓氏的污点，是他所爱的人的威胁，仅仅是他们的血统比他好。 你同意刺客的要求，让那个私生子进入你的帐篷。 当他这样做的时候，你迅速地解释一下情况。 他要求出示证据，证明有一支军队在等着他，雇佣的刺客迅速答应了他的要求，拿出了一份盖有图章和签名的卷轴，只有那个私生子能认出来。%bastard% 仔细地读了它。 他低头看着你。%SPEECH_ON%你已经同意这事了？ 命运掌握在我自己手中，但只要你愿意，我的剑和忠诚将永远属于你。%SPEECH_OFF%你拍拍他的肩膀，告诉他继续走他该走的路。 刺客告诉他如果他要这么做，那么他应该尽快行动。 流着泪，一点也想不掩饰的 %bastard% 感谢你至少相信他，即使他只是在 %companyname% 很短的时间。然后他离开了。 转过身，你发现刺客在鞠躬。%SPEECH_ON%就这样吧，我为你而战，队长。%SPEECH_OFF%这需要向其他队员做一些解释，但是他们一定会相信你的直觉。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "多保重，你个混蛋。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Assassin);
						this.World.getTemporaryRoster().clear();
						_event.m.Assassin.onHired();
						_event.m.Bastard.getItems().transferToStash(this.World.Assets.getStash());
						_event.m.Bastard.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.Bastard);
						_event.m.Bastard = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
				this.Characters.push(_event.m.Bastard.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Bastard.getName() + "离开了" + this.World.Assets.getName()
				});
				this.List.push({
					id = 13,
					icon = "ui/icons/special.png",
					text = _event.m.Assassin.getName() + "加入了" + this.World.Assets.getName()
				});
				_event.m.Assassin.getBackground().m.RawDescription = "%name%加入了战团以换取" + _event.m.Bastard.getName() + "的性命。对这个刺客的所知甚少，大部分人仍对他保持警惕。当拿着匕首时，这个杀手持剑的手转向和摆动的更像蛇而不是人。";
				_event.m.Assassin.getBackground().buildDescription(true);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]在你决定任何事之前，你问刺客收了多少钱来杀死这个杂种。 他左右摇晃着脑袋来计算数字。%SPEECH_ON%好吧，是…然后，扣除旅行时间，装备成本，找到那块该死的草皮的时间，以及侦察你的营地，确定你是否愿意接受对话的时间…五千克朗。 如果你想更相称的话，那要再多一点。 再多给一千克朗吧，这样你的帐单上就有六千克朗了。 你还在等着刚才那种“讨论”，哼？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我同意你的条件。%bastard% 可以走，你将会取代他的位置。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我会付你6000克朗，但是 %bastard% 和你都要留下。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "我想我会杀了你。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 33)
						{
							return "Decline1";
						}

						if (r <= 66)
						{
							return "Decline2";
						}
						else
						{
							return "Decline3";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_33.png[/img]虽然 %companyname% 运转的很好，它可能是世界上最好的，但六千克朗仍然是一个很高的要求。 但是…你同意了。刺客听到你的话，坐了一会儿。%SPEECH_ON%你同意了？你愿意出六千克朗，真的吗？%SPEECH_OFF%你点头。他把这些话又想了一会儿，这是他进行一场持续而坚定的演讲前的一个小停顿。%SPEECH_ON%老实说，我没想到你会那么做。 但协议就是协议，我不是那种会开玩笑而浪费言语的人。%SPEECH_OFF%他伸出手来，你坚定地握了一下－以防这是他的诡计。 他优雅地鞠躬，毫无疑问，这是他从最初派他来这里的贵族们那里学到的。%SPEECH_ON%%companyname% 的队长，我为你而战！%SPEECH_OFF%这需要解释一下，一个路人是如何在一个夜晚溜进战队的，但这些队员对你的指挥有着足够的信心，就算你招募一只挥舞着剑的山羊，他们也会追随你。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入，刺客。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Assassin);
						this.World.getTemporaryRoster().clear();
						_event.m.Assassin.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Assassin.getImagePath());
				_event.m.Assassin.getBackground().m.RawDescription = "作为一个厌倦了杀戮生活的刺客，%name%以你很快就接受了的高价加入了你的战队。他非常善于使用短刃，旋转匕首比某些人对自己手指的控制更为灵巧。";
				_event.m.Assassin.getBackground().buildDescription(true);
				this.World.Assets.addMoney(-6000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]6,000[/color] 克朗"
				});
				this.List.push({
					id = 13,
					icon = "ui/icons/special.png",
					text = _event.m.Assassin.getName() + "加入了" + this.World.Assets.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Decline1",
			Text = "[img]gfx/ui/events/event_33.png[/img]你拒绝了刺客的提议。他点头。%SPEECH_ON%好的。%SPEECH_OFF%匕首来的很快，比你想象的要快。 你举起手来格挡，但速度太慢了。 刀子的一边划过你的脸颊让你流血。 当你拔出剑的时候，刺客已经跳出了帐篷。 你听到外面一阵骚动，就冲过去。%bastard% 这个私生子躺在地上。他身边还有几个队员。%otherbrother% 过来问你有没有事。 他说一个穿黑衣服的人想杀了私生子。%SPEECH_ON%我想我们使他受了致命伤，但我不知道他去哪儿了。 那个混蛋被我们砍中不少下。 先生，你流血了。%SPEECH_OFF%你告诉他你知道，现在的首要任务是照顾好私生子和其他队员。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，至少没有人被杀。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bastard.getImagePath());
				local injury = _event.m.Bastard.addInjury(this.Const.Injury.PiercingBody);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Bastard.getName() + " 遭受 " + injury.getNameOnly()
				});
				injury = _event.m.Bastard.addInjury(this.Const.Injury.PiercingBody);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Bastard.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "Decline2",
			Text = "[img]gfx/ui/events/event_33.png[/img]你把手放在剑柄上，拒绝了刺客的请求。他鼓起了掌。%SPEECH_ON%好吧，佣兵。足够好了。 不要在那里浪费时间。%SPEECH_OFF%他向你拿剑的手点了点头。%SPEECH_ON%如果我真想让那个私生子死，你认为我还会站在这里么？ 我是来谈的，我们谈过了。 杀戮的生活离我而去，显然，我的扑克脸也是如此。 你向我虚张声势，我想就是这样。晚上好，雇佣兵。%SPEECH_OFF%在你说出话之前，刺客就从帐篷里钻了出来。 你冲过去看他去了哪里，但你发现的只是黑夜。%bastard% 这个私生子看到你四处张望，还问你在干什么。 你微笑着告诉他休息一下，因为这对他来说绝对是值得的。 满脸疑惑，他耸耸肩。%SPEECH_ON%好的，呃，我想是的。多谢，队长。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我想事情就是如此。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bastard.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Decline3",
			Text = "[img]gfx/ui/events/event_33.png[/img]你拒绝了刺客的提议。 他点了点头，把一只手放在蜡烛上。%SPEECH_ON%好吧那么。我想我们的谈话该结束了，所以必须开始别的事情。%SPEECH_OFF%他的脸转向你。他眨眨眼。\n\n 匕首来的很快，它的光泽闪烁着，就在你的面前。 你伸手去拿你的利刃，但那个人踢了你的手，把剑猛地甩回鞘中。 第二把匕首来了－从你背后抽出来，带着杀人的意图向前刺去。 刺客的匕首突然打开，变成一个三叉戟，你的利刃被勾住了。 他扭转他的手，在一瞬间解除你的武装，然后再扭转他的手，再次把匕首合成一个刀片。婊子养的…\n\n 那人想捅一刀，但你抓住了他的胳膊。 他用空着的那只手虚晃你一下，然后又拿起另一把利刃，你无法阻止他。 他以令人不安的平静低声说话。%SPEECH_ON%优雅地死去吧，队长。%SPEECH_OFF%他的手向后一伸，突然消失在金属的闪光中。 剩下只是一片喷涌而出的红色粘稠物。 刺客看着树桩尖叫起来。%bastard% 站在那里，手里拿着武器。 又一道金属闪光，刺客的脑袋从肩膀上滚落下来。 当他的躯干撞到你的桌子上并撞到地上时，血从洞里涌出。 私生子急切地问。%SPEECH_ON%你还好吗？那个混蛋是谁？%SPEECH_OFF%更多的佣兵进入帐篷，看看发生了什么骚乱。 你让他们知道一个刺客来此刺杀私生子，但你没有让他轻易得手。 队员们为你保护雇佣兵的行为而喝彩。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你欠我个人情，你个混蛋。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bastard.getImagePath());

				if (!_event.m.Bastard.getSkills().hasSkill("trait.loyal") && !_event.m.Bastard.getSkills().hasSkill("trait.disloyal"))
				{
					local loyal = this.new("scripts/skills/traits/loyal_trait");
					_event.m.Bastard.getSkills().add(loyal);
					this.List.push({
						id = 10,
						icon = loyal.getIcon(),
						text = _event.m.Bastard.getName() + "现在是忠诚的"
					});
				}

				_event.m.Bastard.improveMood(2.0, "你为他冒着生命危险");

				if (_event.m.Bastard.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Bastard.getMoodState()],
						text = _event.m.Bastard.getName() + this.Const.MoodStateEvent[_event.m.Bastard.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Bastard.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.5, "你为了别人冒着生命危险");

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
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local candidates = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getBackground().getID() == "background.bastard")
			{
				candidates.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.player"))
			{
				candidates_other.push(bro);
			}
		}

		if (candidates.len() == 0 || candidates_other.len() == 0)
		{
			return;
		}

		this.m.Bastard = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates.len() * 2;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bastard",
			this.m.Bastard.getNameOnly()
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		return "Intro";
	}

	function onClear()
	{
		this.m.Bastard = null;
		this.m.Other = null;
		this.m.Assassin = null;
	}

});

