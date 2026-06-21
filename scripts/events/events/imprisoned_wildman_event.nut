this.imprisoned_wildman_event <- this.inherit("scripts/events/event", {
	m = {
		Other = null,
		Wildman = null,
		Monk = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.imprisoned_wildman";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_41.png[/img]在行军途中，你遇到一排停着的载重货车。 你意识到这些载重货车是笼子，每一辆车都是为一只野生动物服务的。 浏览这一排货车，你遇到各种各样的野兽。 一只蹲着的，喵喵叫的黑猫从栅栏里伸出它的杀人魔爪。 你跳开，回到另一个笼子边，里面的熊在咆哮，发出刺耳的声音。 值得庆幸的是，它强有力的爪子太胖了，塞不进栅栏里。 另一个笼子发出蛇的嘶嘶声。\n\n 一个男人从一辆载重货车后面走出来，向后靠了靠。 他脸上的表情很野蛮，就好像你刚刚抓住了他的手腕一样。%SPEECH_ON%嘿！你是谁？ 你在这儿干什么？%SPEECH_OFF%你告诉那个陌生人你是 %companyname% 的队长。男人直起身子。%SPEECH_ON%噢，佣兵！我以为我的运气来了，跑到我身上去了！ 听着，我遇到了麻烦而我的雇工拒绝帮忙。 他们漠不关心，也不想知道更多，但是现在该死的雇工们从载重货车上下来跑路了，然后雇主们闭口不谈我为他们运送了那么多货物！%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你需要什么帮助？",
					function getResult( _event )
					{
						return this.World.Assets.getOrigin().getID() != "scenario.manhunters" ? "B" : "B2";
					}

				},
				{
					Text = "这不是我们自己的问题。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_100.png[/img]驯兽者把你带到一辆马车前。 你马上就能看出他的雇工们逃跑的原因：一个疯狂而不可理喻的野人正坐在笼子里。 他的脚镣上有来自手腕的血迹，这是他企图逃跑的迹象。 饿得半死的野人啃着一根棍状物，可能是风滚草的须子。 看到这种悲伤的景象，你抓住陌生人的衬衫，把他往载重货车上撞。%SPEECH_ON%你觉得那像动物吗？%SPEECH_OFF%驯兽者咧着嘴笑，露出用象牙做的假牙。他为自己辩解。%SPEECH_ON%市民们听到了“未开化”野人的风声，希望能近距离看到他们。 我只是像任何商人一样满足这个新需求。 现在，我只需要有人把那具尸体从笼子里弄出来。%SPEECH_OFF%他指着笼子角落里的一具尸体。 野人后退，咆哮着，走过去充满戒备地坐在尸体上。 驯兽者摇了摇头。%SPEECH_ON%我的一个助手靠得太近了，嗯，是的。 我不能带着这些脏东西进城，所以我想你可以帮我把它弄出来。 当然，我会付很多钱。 250克朗听起来不错吧？ 只要把手伸进去，把那个垃圾拉出来。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "好吧，我会派个人进去。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 80 ? "C" : "D";
					}

				});

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "我们队伍中的野人也许能帮上忙。",
						function getResult( _event )
						{
							return "Wildman";
						}

					});
				}

				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "我们的僧侣似乎有点按捺不住了。",
						function getResult( _event )
						{
							return "Monk";
						}

					});
				}

				this.Options.push({
					Text = "我不会拿手下的生命来冒险。",
					function getResult( _event )
					{
						return "E";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_100.png[/img]驯兽者把你带到一辆马车前。 你马上就能看出他的雇工们逃跑的原因：一个疯狂而不可理喻的野人正坐在笼子里。 他的脚镣上有来自手腕的血迹，这是他企图逃跑的迹象。 饿得半死的野人啃着一根棍状物，可能是风滚草的须子。 The animal tamer grins, ivory for teeth.%SPEECH_ON%市民们听到了“未开化”野人的风声，希望能近距离看到他们。 我只是像任何商人一样满足这个新需求。 现在，我只需要有人把那具尸体从笼子里弄出来。%SPEECH_OFF%他指着笼子角落里的一具尸体。 野人后退，咆哮着，走过去充满戒备地坐在尸体上。 驯兽者摇了摇头。%SPEECH_ON%我的一个助手靠得太近了，嗯，是的。 我不能带着这些脏东西进城，所以我想你可以帮我把它弄出来。 当然，我会付很多钱。 250克朗听起来不错吧？ 只要把手伸进去，把那个垃圾拉出来。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "好吧，我会派个人进去。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 80 ? "C" : "D";
					}

				});

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "我们队伍中的野人也许能帮上忙。",
						function getResult( _event )
						{
							return "Wildman";
						}

					});
				}

				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "我们的僧侣似乎有点按捺不住了。",
						function getResult( _event )
						{
							return "Monk";
						}

					});
				}

				this.Options.push({
					Text = "我不会拿手下的生命来冒险。",
					function getResult( _event )
					{
						return "E";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_100.png[/img]%taskedbro% 接受了这个把尸体弄出野人杀人圈的任务。 他卷起袖子，双手伸向笼子。%SPEECH_ON%哇哦，这事简单。轻松！%SPEECH_OFF%野人从尸体上爬起来，走到笼子的另一边。 佣兵很容易抓住尸体的靴子，把它拖向栅栏。 它以令人作呕的轻松方式滑过，已经像丢弃的湿衣服一样膨胀起来。 尸体的内脏和四肢从载重货车的平台边缘滚落下来。 驯兽者高兴地欢呼。%SPEECH_ON%非常感谢你！ 你也让这事看起来很简单！%SPEECH_OFF%%taskedbro% 盯着那具尸体，意识到自己差点就这个下场了。%SPEECH_ON%好的。不客气。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，至少我们拿到了报酬。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				this.World.Assets.addMoney(250);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]250[/color] 克朗"
				});
				_event.m.Other.getBaseProperties().Initiative += 2;
				_event.m.Other.getBaseProperties().Bravery += 1;
				_event.m.Other.getSkills().update();
				this.List.push({
					id = 17,
					icon = "ui/icons/initiative.png",
					text = _event.m.Other.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 主动性"
				});
				this.List.push({
					id = 17,
					icon = "ui/icons/bravery.png",
					text = _event.m.Other.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_100.png[/img]%taskedbro% 任务是把尸体弄出笼子。 他走近笼子，就像一个妓女在一个民风淳朴的小镇上游荡。 当他接近栅栏时，他笑得像野人的老朋友。%SPEECH_ON%嘿，老兄。你搞出来的尸体不错。 一具伟大的尸体，真的是我见过的最好的尸体之一。 不如我把…它拿…出来…%SPEECH_OFF%当雇佣兵靠近时，野人就猛击上去。 它的动作太快了，几乎看不到。%taskedbro% 慢慢转身。 他原来的一只眼睛的成了一个黑洞。 野人把眼球压在牙缝里，一个白色的粘稠的东西像脓包一样冒出来，当他咀嚼的时候，它就变成了粘糊糊的东西。 驯兽者扔给你一袋钱，然后跑掉了。%SPEECH_ON%不是我的错！不关我的事！%SPEECH_OFF%%taskedbro% 晕了过去，几个复仇的兄弟刺死了被囚禁的野人。 所有关在笼子里的野兽都咆哮起来，好像你们刚刚杀了它们的首领。 你赶紧命令队员们离开商队，以免其中一只野兽逃脱并造成更大的伤害。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真见鬼！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local injury = _event.m.Other.addInjury([
					{
						ID = "injury.missing_eye",
						Threshold = 0.0,
						Script = "injury_permanent/missing_eye_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Other.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_100.png[/img]你告诉这个驯兽者，这是他个人的问题。他耸耸肩。%SPEECH_ON%是的，我没有怪你。 你比你看起来更聪明，佣兵。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "呃，谢谢。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Wildman",
			Text = "[img]gfx/ui/events/event_100.png[/img]如果队伍中有人能帮忙说服这个被关在笼子里的野人，那大概是 %wildman%。他走向笼子，盯着里面。 他们开始交流。 你的野人用指关节敲打着铁栅栏，而关在里面的那个则用手回击，并发出低沉的叫声。 突然，%wildman% 抓住驯兽者的头，把他赶进了笼子。 你去救驯兽者，但被囚禁的野人在笼子里扑腾起来，眼睛里带着本能的恐惧。 你向后退却确保自身安全，你只能看着这个野人扑向驯兽者。 两个野人在他的脸上又拉又拽。 这个被打成脑震荡的家伙无力地大叫。%SPEECH_ON%我想我们达成共共共识了！%SPEECH_OFF%%wildman% 把拇指塞进那人的眼睛里，而被囚禁的野人则抓住驯兽师的嘴巴往下拉。 他的头连筋带骨被撕裂了。 当驯兽者的大脑从他的舌头原来的位置掉出来的时候，有几个人呕吐了，这真是一种表达个人的思想的可怕方式。 这个“看守”被解决了，%wildman% 看着你，这个野人做出了“我们能收留他么？”的手势。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真恶心。他很完美。",
					function getResult( _event )
					{
						return "Wildman1";
					}

				},
				{
					Text = "不，他实在是太危险了。",
					function getResult( _event )
					{
						return "Wildman2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Wildman1",
			Text = "[img]gfx/ui/events/event_100.png[/img]对于一个雇佣兵团来说，在暴力方面的杰出才能是很必要的。 你同意带走被囚禁的野人。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入战队。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return "Animals";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"wildman_background"
				]);
				_event.m.Dude.setTitle("动物(the Animal)");
				_event.m.Dude.getBackground().m.RawDescription = "%name% 是在一次与驯兽者变成奴役者的对抗中被你“拯救”的。 一种感激和人情债的感觉克服了任何语言障碍：这个曾经被囚禁的野人为战队服务，忠诚于帮助他的人。";
				_event.m.Dude.getBackground().buildDescription(true);

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Wildman2",
			Text = "[img]gfx/ui/events/event_100.png[/img]你不认为那个被囚禁的野人会适应战队，但你还是释放了他。 他像女妖一样冲出笼子，向树林深处奔去。 他站在远处，不断嚎叫，直到再次跑掉。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我猜这是他表达感谢的方式。",
					function getResult( _event )
					{
						return "Animals";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Monk",
			Text = "[img]gfx/ui/events/event_100.png[/img]%monk% the monk steps forth, hands clasped, head borrowed forward. 一副布道的做派，贤者的仪态，也可以说误入歧途的姿态。 他把驯兽者拉到一边。%SPEECH_ON%汝之所为，神明不齿。%SPEECH_OFF%驯兽者笑着靠在笼子上，得意洋洋地交叉双臂。 他指出，在南方，他们认为奴隶制是自然秩序的一部分。 和尚继续说。%SPEECH_ON%是的，但是你和这个野人都不是他们生活方式的亲戚。 你想奴役他个局外人。 他不了解这种关系，这个事是不适当和特别令人痛苦的。 我的建议是让他为你工作，向你学习。 和他做朋友，你就会有一个终生的朋友－%SPEECH_OFF%被囚禁的野人把手穿过铁栅栏，手指插进了驯兽者的眼球。 他的脸被撕开了，像一块旧面包，两根衣架套在一块颚骨上，舌头耷拉着，像一条被连根拔起的蛇。%monk% 满脸是血，吐了一地。%otherbrother% 摇了摇头。%SPEECH_ON%我想说他很适合 %companyname% …%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真恶心。他很完美。",
					function getResult( _event )
					{
						return "Wildman1";
					}

				},
				{
					Text = "不，他实在是太危险了。",
					function getResult( _event )
					{
						return "Wildman2";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				_event.m.Monk.worsenMood(1.0, "被他目睹的暴力所震惊");

				if (_event.m.Monk.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Animals",
			Text = "[img]gfx/ui/events/event_47.png[/img]好吧，驯兽者走了，没有人跟他一起照顾这些野兽了。%randombrother% 上前询问应该如何处理它们。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "放它们出来。",
					function getResult( _event )
					{
						return "AnimalsFreed";
					}

				},
				{
					Text = "把它们全宰了。",
					function getResult( _event )
					{
						return "AnimalsSlaughtered";
					}

				},
				{
					Text = "别管他们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "AnimalsFreed",
			Text = "[img]gfx/ui/events/event_27.png[/img]你觉得把它们扔在这里饿死是不对的，毫无疑问，在这个丰收时节，这些关在笼子里的动物能够抓到野味的。 你决定让它们离开笼子。 这些奇怪的动物大多径直朝树林走去，但有两只留在了后面：一只哈士奇和一只戴着兜帽的猎鹰，它们似乎都在寻找主人。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你们俩都很适合我们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/wardog_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/accessory/falcon_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "AnimalsSlaughtered",
			Text = "[img]gfx/ui/events/event_14.png[/img]让这些动物在这里饿死腐烂掉是一种罪过。 也是对肉食美味的一种可怕的浪费。 你把那些动物都杀了。 这是一个简单的，但残酷的工作，刺和砍杀一群不幸的动物和野兽。 熊是最后一个死的，它不肯认命。 它设法将 %hurtbro% 拖近一顿猛揍，但除此之外，你的人把它慢慢地，残忍地杀死。 其余的载重货车都被翻了个底朝天，被洗劫一空。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不错的收获。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item;
				_event.m.Other.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Other.getName() + "遭受轻伤"
				});
				local money = this.Math.rand(200, 500);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				item = this.new("scripts/items/supplies/cured_venison_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/supplies/smoked_ham_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidate_wildman = [];
		local candidate_monk = [];
		local candidate_other = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.wildman")
			{
				candidate_wildman.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk")
			{
				candidate_monk.push(bro);
			}
			else if (!bro.getSkills().hasSkill("injury.missing_eye"))
			{
				candidate_other.push(bro);
			}
		}

		if (candidate_other.len() == 0)
		{
			return;
		}

		if (candidate_wildman.len() != 0)
		{
			this.m.Wildman = candidate_wildman[this.Math.rand(0, candidate_wildman.len() - 1)];
		}

		if (candidate_monk.len() != 0)
		{
			this.m.Monk = candidate_monk[this.Math.rand(0, candidate_monk.len() - 1)];
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
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getNameOnly() : ""
		]);
		_vars.push([
			"wildmanfull",
			this.m.Wildman != null ? this.m.Wildman.getName() : ""
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"monkfull",
			this.m.Monk != null ? this.m.Monk.getName() : ""
		]);
		_vars.push([
			"hurtbro",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
		_vars.push([
			"taskedbro",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
		_vars.push([
			"otherbrother",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.Monk = null;
		this.m.Other = null;
		this.m.Dude = null;
	}

});

