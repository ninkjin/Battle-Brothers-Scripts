this.melon_thief_event <- this.inherit("scripts/events/event", {
	m = {
		Other = null,
		Dude = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.melon_thief";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]你看见了一群闹哄哄的村民从前方走来。 他们一群人抬着棵倒下的树木就像一群蚂蚁抬着和它们身形相差巨大的甲虫。 有一个蒙着眼的男人双手和双脚被绑在在树上。 当人群慢慢靠近，浓烈的酒味从那些村名身上传来那感觉就和直面从不断翻滚的沼泽冲出来的臭气一般。\n\n %otherbro% 询问这乱哄哄的人群他们要去哪里。 一个蓄着胡须的汉子突然转向你们，脚跟和脚尖同时行动就像一个不协调的木偶。%SPEECH_ON%哦！我们要去审判并且惩罚这个，这个，呃…%SPEECH_OFF%那闹哄哄的人群里面有人大喊着“偷水果的色鬼！”。 那大汉咬了咬自己的手指。%SPEECH_ON%没错！这个偷瓜贼将会得到，额，…将会带给他。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "一个偷瓜贼？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "好吧，这和我们没有任何关系。",
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
			Text = "[img]gfx/ui/events/event_43.png[/img]那名大汉身体似乎因为醉酒而不断摇摆。 他胡子上的啤酒沫都足够灌醉一个小姑娘了。他指了指前方。%SPEECH_ON%这个…就是这个人没错！ 偷了一个瓜－哦，他不仅仅偷了瓜！ 不，他就像用木塞那样堵住要喷涌而出的东西那样！ 当抓住他的时候我们发现在他身边全是他自己弄出来的污水！ 我指的是从他生殖器官里面溢出来的污水！%SPEECH_OFF%你无法理解那个汉子在说什么，你让那个男人解释－这次慢慢地解释。 他甩了甩手似乎不想和你这样的白痴再解释什么。%SPEECH_ON%还有什么好说的？ 你在拱一个瓜就是这样！ 就像通奸那样，没错，就是…这个罪行不可饶恕！ 现在滚到一边，陌生人，我们还要对这个人涂上沥青和羽毛进行惩罚然后再涂一层焦油，如果我们还有的话！%SPEECH_OFF%人群里面的人不断欢呼。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你有什么要说的，瓜人？",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "和水果通奸？%otherbro%，教训一下这个蠢货！",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "好吧。不是我们的事。",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_43.png[/img]你问那个被绑在树上的男人有什么想要说的，如果有的话。 他耸耸肩说。%SPEECH_ON%一个男人和一个瓜之间发生的事是他们的事情和别人无关。 没有伤害，没有违法。%SPEECH_OFF%那个汉子用棍子狠狠的抽打了那个人。%SPEECH_ON%别胡扯，直接告诉这个家伙，就像向我们说时那样！%SPEECH_OFF%瓜人叹了口气，点了点头。%SPEECH_ON%好吧，如果这就是谈判的最终结果，并且事情也都到了这个地步并且这些人也想要惩罚我，那我就实话实说好了。 我上了一个瓜并且真的很舒服。%SPEECH_OFF%人群中发出骂声和嘘声而你的士兵们却在彼此之间开怀大笑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们不能让你们惩罚这个人。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "和水果通奸？%otherbro%，去帮这个蠢货！",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "好吧。不是我们的事。",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_43.png[/img]你制止住了那名大汉。%SPEECH_ON%让这个男人走。%SPEECH_OFF%那个人询问你是否是真的要保护这个水果狂。 你点头并且告诉他和一个瓜通奸，的确相当迷惑并且恶行，但是这件事情始终没有对别人造成伤害。 一个喝醉了的农民抱住了自己的肩膀。%SPEECH_ON%你在说什么？上周这个就把一只鸭子的脖子给折断了被我们拖到棚子后面教训了一顿。%SPEECH_OFF%那个农名皱着眉头喝下了手里面最后一点酒。 他嘟哝着说他真的很想念那只鸭子。 也许到了现在你依然还是没有弄清楚这件事情，但已经厌倦了和这些白痴胡闹，你拔出剑来把束缚着偷瓜贼的绳子砍断让他自由。 你把剑指向这群农民即使仍然不清醒但他们很快就散开了，有的人跑的太快跌倒在了路旁边，他们向来时的路上分散开来就像是石头砸进湖泊了激起的波纹那样。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你这个白痴，蠢货！",
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
			Text = "[img]gfx/ui/events/event_43.png[/img]这个“偷瓜贼”靠近你。 他用一根绳子和一些破布组成了一条裤子穿在身上。%SPEECH_ON%所以，呃，很感激你把我从这可怕的命运中拉出来，我应该怎么报答你？ 我已经厌倦这个镇子上的一切。%SPEECH_OFF%你告诉他佣兵并不是一个令人羡慕的行当。 他抬起自己的手。%SPEECH_ON%听着，如果你担心我会对你们的食物下手我会在我母亲的坟前发誓我会一直让那个农场品钻孔器在我的裤子里。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "非常好。 欢迎加入 %companyname%！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "不，我们可不想一整天都在查看自己的食物有没有问题。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"thief_background"
				]);
				_event.m.Dude.setTitle("西瓜小偷(the Melon Mugger)");
				_event.m.Dude.getSprite("head").setBrush("bust_head_03");
				_event.m.Dude.getBackground().m.RawDescription = "%name% 只不过是一个普通的偷瓜贼－你就是这么告诉别人的。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.improveMood(1.0, "用甜瓜满足他的需要");
				_event.m.Dude.worsenMood(0.5, "差点被涂上沥青和羽毛");

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
			ID = "H",
			Text = "[img]gfx/ui/events/event_43.png[/img]%otherbro% 点了点头。%SPEECH_ON%这是我的荣幸！别挡着农民的路，让一个真正的男人来为你们展示一下。%SPEECH_OFF%这个佣兵拿起沥青桶并且把里面的东西全部浇在这个水果通奸者身上。 随着滚烫的液体滋滋作响那个人开始惨叫并且强有力的理智也一缕缕的进入蒸腾的烟雾中。 你看见 %otherbro% 抓了几只鸡－已经被拔了毛，光秃秃的－并且开始用它们抽打那个偷瓜贼就像一块破布摇摆在链子串起来的香炉中。 那个浑身沥青的男人哀嚎着，一部分是因为痛苦，一部分是因为疑惑。 这些农民，也很疑惑，勉强欢呼起来。 当完成了惩罚，%otherbro% 放下了这些鸡，这时鸡不过是一堆耷拉下来的肉并且上面都是沥青。 他擦了擦前额。%SPEECH_ON%苦难的经历，先生。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我不太认为他能明白，但这能给他点教训。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Other.improveMood(0.5, "受到惩罚");

				if (_event.m.Other.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
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

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (!t.isMilitary() && !t.isSouthern() && t.getSize() <= 1 && t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
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
		local candidates = [];

		foreach( b in brothers )
		{
			candidates.push(b);
		}

		this.m.Other = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"otherbro",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Other = null;
		this.m.Dude = null;
		this.m.Town = null;
	}

});

