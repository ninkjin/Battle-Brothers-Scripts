this.undead_outro_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_outro";
		this.m.Title = "在路上…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]你打了个盹儿。\n\n 黑。暗。完全是一个正常的梦境，除了一个小事实：你了解到你在梦里。 像迷惘的思绪伫立于虚空一样。 一个声音从各个方向向你渗透过来，仿佛你就在那个发出声音的人的嘴里。%SPEECH_ON%你为什么抛弃我们，帝王？%SPEECH_OFF%你旋转起来，或者说至少你自己以为在转，因为附近什么东西都没有，连最微小的活动的立足点都没有。%SPEECH_ON%你答应过我的，你不记得了吗？ 你说如果一切都崩溃了也没关系。 你说你有个计划，你和那个丑陋的男人做了个交易。发生了什么？%SPEECH_OFF%",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "我还是个孩子呀。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "别紧张，我的爱人。 死亡没有什么可怕的。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "那个丑男人是谁？",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]你抬高声音。%SPEECH_ON%你们要找的不是我。%SPEECH_OFF%你的意思还未传达到位，她就开始啜泣起来。 夹杂在哭泣中她边打着嗝哭诉着。%SPEECH_ON%我－我知道…我原不想承认的，但我确实明白了。 帝国和我们一起消亡了。 亲爱的，我的帝王。%SPEECH_OFF%“帝王”的回音回荡着，每次重复都更加微弱，最终只留下黑暗和寂静。",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "醒醒！",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]一开始，你什么也没说。 她开始哭了。 你听到了泪水的声音，每一滴泪水都在你周围回响。%SPEECH_ON%你在吗，我的帝王？%SPEECH_OFF%你清了清喉咙回答到。%SPEECH_ON%是我，帝国不会再兴起了。 我们必须得接着走下去了，死亡没有什么可怕的。%SPEECH_OFF%那个女人还是在哭，但慢慢缓和下来。%SPEECH_ON%我并不害怕。 另一件事，是他的故事、他的故事，我的帝王。%SPEECH_OFF%当她的话从黑暗中消失，也许你的思想，你剩下的只有沉默。",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "醒醒！",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_33.png[/img]你转过身。%SPEECH_ON%那个丑男人是谁？%SPEECH_OFF%震惊让她结巴了。%SPEECH_ON%你，你都不记得了吗？%SPEECH_OFF%清了清喉咙，你假装承认你忘了。%SPEECH_ON%是的亲爱的，我什么都不记得了。%SPEECH_OFF%黑暗中传来一声长叹。 你能感受到蕴藏在之中的沮丧。 她恼了。%SPEECH_ON%我也知道我们不该相信他… 那个丑陋的男人在我们的孩子还没出生的那个晚上来找我们。 他说，如果他能取走我们的血，以及我们死去的孩子的血，他就能确保帝国永远不灭亡，我们也会永远统治下去。 但是…这有个代价。%SPEECH_OFF%你一下子就听懂了，回应道。%SPEECH_ON%他剥夺了你育子的能力。%SPEECH_OFF%那个女人继续哭。%SPEECH_ON%我们不应该相信他！ 我要抓住那个丑男人！ 毋庸置疑，凯瑞姆苏拉。 我会让他尝尝永恒的痛苦和折磨！%SPEECH_OFF%曾经漆黑的虚空开始泛红，闪出着一个深红色的世界，强烈的红。 你抬起一只手遮住眼睛。 她尖叫起来，刺痛你的耳朵，直到你剧烈耳鸣。",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "醒醒！",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_33.png[/img]你醒来了。一阵狂风压弯了帐篷，卷起帐篷的皮革像浪潮一样拍打着顶棚。 微弱的烛光摇晃着驱赶着黑暗。%dude% 站在那里看着你，影子跳动着在他的胸前明灭不定。 他不断换着支撑的腿，脸上露出不安的神色。%SPEECH_ON%你刚在和谁说话？%SPEECH_OFF%翻下床，你把靴子叩在地上，打算在说事情之前先搞清楚是否处于现实世界。 泥土踩在你脚下咯吱作响。你回答道。%SPEECH_ON%我也不知道，但我认为…我想危机已经结束了。%SPEECH_OFF%佣兵点头，把手转向帐篷的入口。%SPEECH_ON%是啊，这就是我来这里的原因。 一分钟前一个高贵的信使来了。 他说亡灵已经停止从地面出现。 书记员相信这一切都结束了。 先生，你还好吧？%SPEECH_OFF%你挠挠头。 是时候退休了吗？ 既然你知道你在做什么，你能为这个世界做些什么？ 要么平静地度过你的余生，要么诅咒这一切，并率领 %companyname% 追寻更大的荣耀。\n\n%OOC%你已经胜利了！战场兄弟是为可重玩性和战役而设计的，直到你在游戏后期打败了一两次危机。 开始一个新的战役会让你在不同的世界尝试不同的东西。\n\n你可以选择继续你的战役，只要你想。 只是要意识到，战役并不是要永远持续下去的，你可能最终会尝尽所有的挑战。%OOC_OFF%",
			Image = "",
			Characters = [],
			Options = [
				{
					Text = "%companyname% 需要他们的指挥官！",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "是时候从雇佣兵生活中退休了。 （结束战役）",
					function getResult( _event )
					{
						this.World.State.getMenuStack().pop(true);
						this.World.State.showGameFinishScreen(true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.updateAchievement("BaneOfTheUndead", 1, 1);

				if (this.World.Assets.isIronman())
				{
					this.updateAchievement("ManOfIron", 1, 1);
				}

				if (this.World.Assets.isIronman())
				{
					local defeated = this.getPersistentStat("CrisesDefeatedOnIronman");
					defeated = defeated | this.Const.World.GreaterEvilTypeBit.Undead;
					this.setPersistentStat("CrisesDefeatedOnIronman", defeated);

					if (defeated == this.Const.World.GreaterEvilTypeBit.All)
					{
						this.updateAchievement("Savior", 1, 1);
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

		if (this.World.Statistics.hasNews("crisis_undead_end"))
		{
			local brothers = this.World.getPlayerRoster().getAll();
			local most_days_with_company = -9000.0;
			local most_days_with_company_bro;

			foreach( bro in brothers )
			{
				if (bro.getDaysWithCompany() > most_days_with_company)
				{
					most_days_with_company = bro.getDaysWithCompany();
					most_days_with_company_bro = bro;
				}
			}

			this.m.Dude = most_days_with_company_bro;
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_undead_end");
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dude",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

