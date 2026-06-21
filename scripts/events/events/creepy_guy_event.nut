this.creepy_guy_event <- this.inherit("scripts/events/event", {
	m = {
		Thief = null,
		Minstrel = null,
		Butcher = null,
		Killer = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.creepy_guy";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]当你走在 %townname% 的街道上时，你看到一群人围着一个被绞死的人。 他一定是出了什么名：人们互相推搡，试图轮流把一个脚趾或手指割下来，作为一种值得悬挂的传家之宝。 一个老人很快被挤出了人群。 他转向你，声音沙哑，瘦骨嶙峋的手指像烂排骨一样耷拉着。%SPEECH_ON%啊，你们是佣兵？ 当然，我能嗅出你的斤两，你的生意来了。 喂，你能帮我做点事么？ 我需要那个死人的一些手指和脚趾。 这是我给你的工作，你应该明白。 我会给你五百克朗作为报酬。%SPEECH_OFF%你问他为什么需要那个特殊男人的附属肢体。 这个语调低沉，肩膀蜷缩着的男人笑了，发出一阵前所未闻的诘问。%SPEECH_ON%问得好。这个人赢得了走向刽子手绞索的机会，因为他有暴力倾向和一种能看穿自己欲望的强大能力。 一个傻瓜的脚趾和手指是不行的。我需要一个不受约束的残忍之人，而我现在看到的唯一的人正被那根绳子吊着。 所以，你们有啥要说的？ 五百克朗，记得么？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "好的，我去找它们。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 30 || this.World.Assets.getMoney() <= 1000)
						{
							return "Good";
						}
						else
						{
							return "Bad";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Thief != null)
				{
					this.Options.push({
						Text = "我们的小偷，%thief%，看起来有个主意。",
						function getResult( _event )
						{
							return "Thief";
						}

					});
				}

				if (_event.m.Minstrel != null)
				{
					this.Options.push({
						Text = "%minstrel% 正笑的合不拢嘴…",
						function getResult( _event )
						{
							return "Minstrel";
						}

					});
				}

				if (_event.m.Butcher != null)
				{
					this.Options.push({
						Text = "看起来 %butcher% 想助你一臂之力。",
						function getResult( _event )
						{
							return "Butcher";
						}

					});
				}

				this.Options.push({
					Text = "我们宁愿不卷入其中。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "[img]gfx/ui/events/event_43.png[/img]你挤进人群，寻找手指，脚趾或血迹斑斑的口袋。 一个男人已经拿到了好处，他的口袋呈现块状凹陷的形状。 你把他逼到一个角落里，用匕首抵住他的喉咙来勒索他。\n\n 在他后面，你看到一个脸上带着病态笑容的女人在鹅卵石上蹦蹦跳跳。 那是个轻蔑的少妇，如果你曾见识过的话。 把她拉到一边，你很快就能在她的亚麻布衣服里找到一根手指和一个脚趾。 她撒谎说他们只是在做食材。 你告诉她如果是这样的话你就去向守卫报告他们吃人肉。 她放弃了它们。\n\n 把残肢还给老人，你马上就得到五百克朗。 他甚至都不感谢你的“工作”，就匆匆离开了。 他从来没有解释过，确切地说，这些东西是用来干什么的。 你不在乎。因为五百克朗是实打实的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "轻而易举。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(500);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]500[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_43.png[/img]你同意了这个令人毛骨悚然的老人的任务，开始在人群中穿行，注意脚趾和手指是否在不该在的地方，或者又红又湿的块状物口袋。 没过多久：一个女人在路上蹦蹦跳跳，她的连衣裙前面冒着气泡，相当奇怪的是他的口袋里到底有什么。 你把她拉到小巷里，拔出匕首让她安静下来。 一个手指和脚趾被发现了。 当你去拿他们的时候，一个男人突然从后面截住了你。 你钱包里的克朗和附属品在鹅卵石上乱滚。 一个孩子拿走了一个，一只老鼠叼走了另一个，他们很快逃得不知所踪因为一群农民在疯狂追逐你掉落的硬币。 那个拦住你的男人给了你一拳。%SPEECH_ON%婊子养的，你想要她你就得付钱！%SPEECH_OFF%你交叉双臂，格挡他的攻击，扭动身体把他撂倒在地上。 他正要说些别的话，但你马上用你的指关节代替他的牙齿，他就安静下来了。 不幸的是，你无法完成你开始的工作，而且你在这个过程中丢失了一些硬币。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(200, 400);
				this.World.Assets.addMoney(-money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "Thief",
			Text = "[img]gfx/ui/events/event_43.png[/img]%thief% 笑了笑。%SPEECH_ON%见鬼，这很容易。%SPEECH_OFF%他走到人群中，你立刻就看不见他了。 老人在提高嗓门前咬了咬牙。%SPEECH_ON%这个家伙，他值得信任么？%SPEECH_OFF%你还没来得及回答，%thief% 就从就从老人的肩膀后面冒出来，把一条血淋淋的绷带扔到他的手掌上。 这个令人毛骨悚然的人打开亚麻布，发现新鲜的散落的四肢。 小偷沾沾自喜地笑了。%SPEECH_ON%任何值得一提的小偷都是先学会扒窃，然后才是其他事情。 我通常追求的是钥匙而不是脚趾，但是工作就是工作。 我还四处“挑选”了一些其他有趣的东西。瞅瞅啊。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Thief.getImagePath());
				this.World.Assets.addMoney(500);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]500[/color] 克朗"
					}
				];
				local initiative = this.Math.rand(2, 4);
				_event.m.Thief.getBaseProperties().Initiative += initiative;
				_event.m.Thief.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Thief.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] 主动性"
				});
				_event.m.Thief.improveMood(1.0, "用他独特的才能取得了巨大的成功");

				if (_event.m.Thief.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Thief.getMoodState()],
						text = _event.m.Thief.getName() + this.Const.MoodStateEvent[_event.m.Thief.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Minstrel",
			Text = "[img]gfx/ui/events/event_92.png[/img]%minstrel% 这个吟游诗人抓住老人的肩膀。%SPEECH_ON%说吧，你有多少肌肉啊，我强壮的朋友。 我不想问你为什么需要那个死人的脚趾和手指…%SPEECH_OFF%老人点头说他无论如何也不会说。吟游诗人继续道。%SPEECH_ON%…是如果你想要一个好的，强壮的，暴力的男人，难道不看看我么？ 是你，老头子！ 带上你自己的手指和脚趾，和它们一起去完成任务－啊哼，不管是什么奇怪的狗屎，啊哼－你会找到你想要的奖品。 你是这个故事的主人公，你看不出来吗？%SPEECH_OFF%老人吐唾沫摇摇头。%SPEECH_ON%你把我当个傻瓜，不是吗？ 我们的生意结束了！ 别挡我的路，你们这帮该感到羞愧的佣兵。%SPEECH_OFF%老人走了。 你问吟游诗人他在干什么。 他耸耸肩，举起了一个装着克朗的钱袋。%SPEECH_ON%露了一手。%SPEECH_OFF%干的漂亮。但是你询问你自己的钱包哪去了。%minstrel% 又举起了一个袋子。%SPEECH_ON%真的，真的好好的露了一手。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很有趣。现在交回来吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Minstrel.getImagePath());
				this.World.Assets.addMoney(500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] 克朗"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]1000[/color] 克朗"
				});
				local initiative = this.Math.rand(2, 4);
				_event.m.Minstrel.getBaseProperties().Initiative += initiative;
				_event.m.Minstrel.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Minstrel.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] 主动性"
				});
				_event.m.Minstrel.improveMood(1.0, "用他独特的才能取得了巨大的成功");

				if (_event.m.Minstrel.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Minstrel.getMoodState()],
						text = _event.m.Minstrel.getName() + this.Const.MoodStateEvent[_event.m.Minstrel.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Butcher",
			Text = "[img]gfx/ui/events/event_19.png[/img]%butcher% 这个屠夫吐口水说他会做的。 你告诉他他不是那种擅长偷东西的人。他摇了摇头。%SPEECH_ON%不，我说我将会给他一个手指。 只有一个，但对这个老家伙而言，它将是一个愚蠢的东西并且值得用金子来衡量。 对你而言，队长，我想要一半的酬劳。%SPEECH_OFF%这个令人毛骨悚然的陌生人点头，笑容使他干裂的皮肤噼啪作响。%SPEECH_ON%好的…好的！一个愿意这样做的人肯定会符合我所需要的原料的要求。 做吧。做吧！%SPEECH_OFF%你还没来得及同意，屠夫就抓起挂在附近墙上的钳子，把钳子放在铁砧上，用钳子夹住一根手指，把膝盖压在刀柄上，一下子就把一根手指砍断了。 他先把手包起来，然后把那根断指交给那个陌生人。%SPEECH_ON%就在这里：一个特别残忍的人的手指。%SPEECH_OFF%这个陌生人抓住它，好像它是世界的钥匙。 “真是不可思议！”你认为他说，但很难听到，因为他匆匆给你一些克朗就逃跑了。 事实上这比你最初同意的要多。 屠夫当然已经“赚”了他的那一半，你交给了他。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Insane.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				this.World.Assets.addMoney(250);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]250[/color] 克朗"
				});
				_event.m.Butcher.improveMood(1.0, "卖了他的一根手指赚了一大笔钱");

				if (_event.m.Butcher.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Butcher.getMoodState()],
						text = _event.m.Butcher.getName() + this.Const.MoodStateEvent[_event.m.Butcher.getMoodState()]
					});
				}

				local injury = _event.m.Butcher.addInjury([
					{
						ID = "injury.missing_finger",
						Threshold = 0.0,
						Script = "injury_permanent/missing_finger_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Butcher.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Butcher.getBaseProperties().Bravery += 3;
				_event.m.Butcher.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Butcher.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+3[/color] 决心"
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

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getSize() >= 2 && t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_thief = [];
		local candidates_minstrel = [];
		local candidates_butcher = [];
		local candidates_killer = [];

		foreach( b in brothers )
		{
			if (b.getBackground().getID() == "background.thief")
			{
				candidates_thief.push(b);
			}
			else if (b.getBackground().getID() == "background.minstrel")
			{
				candidates_minstrel.push(b);
			}
			else if (b.getBackground().getID() == "background.butcher" && !b.getSkills().hasSkill("injury.missing_finger"))
			{
				candidates_butcher.push(b);
			}
			else if (b.getBackground().getID() == "background.killer_on_the_run")
			{
				candidates_killer.push(b);
			}
		}

		if (candidates_thief.len() != 0)
		{
			this.m.Thief = candidates_thief[this.Math.rand(0, candidates_thief.len() - 1)];
		}

		if (candidates_minstrel.len() != 0)
		{
			this.m.Minstrel = candidates_minstrel[this.Math.rand(0, candidates_minstrel.len() - 1)];
		}

		if (candidates_butcher.len() != 0)
		{
			this.m.Butcher = candidates_butcher[this.Math.rand(0, candidates_butcher.len() - 1)];
		}

		if (candidates_killer.len() != 0)
		{
			this.m.Killer = candidates_killer[this.Math.rand(0, candidates_killer.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getName() : ""
		]);
		_vars.push([
			"minstrel",
			this.m.Minstrel != null ? this.m.Minstrel.getName() : ""
		]);
		_vars.push([
			"butcher",
			this.m.Butcher != null ? this.m.Butcher.getName() : ""
		]);
		_vars.push([
			"killer",
			this.m.Killer != null ? this.m.Killer.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Thief = null;
		this.m.Minstrel = null;
		this.m.Butcher = null;
		this.m.Killer = null;
		this.m.Town = null;
	}

});

