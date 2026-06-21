this.lone_wolf_origin_squire_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.lone_wolf_origin_squire";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_20.png[/img]酒吧里到处都是醉醺醺的人，他们在那里晃荡，欢呼唱歌，与女人们狂欢作乐，其中包括女仆、太太、妓女等等。 一个拿着琵琶的人在跳舞和演奏，另一个拿着金属钹的人在头顶轰鸣，而一个胖子则高唱着战争或爱情的歌曲，无论胜利还是失败的故事都能激起一轮又一轮的共饮啤酒和更多的欢乐。\n\n 你离开酒吧，进入另一栋建筑。 当你站在门口时，风呼啸着吹过满是长凳的教堂中殿。 一个人扫着石头地板，抬头看了一会儿，然后继续工作。 另一个男人高高兴兴地穿过房间，问你是否愿意祈祷。 你拒绝了，他噘起嘴唇，交叉双臂。 隔壁的人群醉醺醺地欢声笑语，好像在嘲笑你们俩，然后那人走了。 你再多呆一会儿，然后离开，回到城镇中心，蹲在一系列的台阶上。 那些台阶的顶端似乎曾经有过一座雕像，但破坏者和掠夺者等人很快就攫取了别人的手艺。 徘徊了一会儿，你就在那儿睡着了。 \n\n 中午你才醒来，你发现一个年轻人站在台阶的底部。 他说他知道你是个骑士，他是来当扈从的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你杀过人么？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "你能做什么？",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我会带上你做我的扈从。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "我单干。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"squire_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "你遇见了 %name% 在" + _event.m.Town.getName() + " 他自愿成为你的侍从。 他可能不知道他当时在干什么。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body));
				_event.m.Dude.getItems().equip(this.new("scripts/items/armor/linen_tunic"));
				_event.m.Dude.setTitle("侍从(the Squire)");
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_20.png[/img]{那人摇了摇头。.%SPEECH_ON%我没有杀过任何人，先生。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你能做什么？",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "我会带上你做我的扈从。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "我单干。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_20.png[/img]{这个男人站直了。%SPEECH_ON%我知道怎样打磨钢铁和修补皮革。 我可以拆装重甲和轻甲，无论多复杂或多简单，我都可以快速完成。 如果我们有一匹马。%SPEECH_OFF%你打断他。%SPEECH_ON%我走了。%SPEECH_OFF%不安地站了起来，他继续说下去。%SPEECH_ON%好的。我可以做饭。 我厨艺不错，不管我有没有配料。 我行的。而且。而且。就。就这些了。 但是我愿意学习！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你杀过人么？",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我会带上你做我的扈从。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "我单干。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_20.png[/img]{你问那个人叫什么名字。他紧张地吞咽了一口唾沫。%SPEECH_ON% %squire%，长官。%SPEECH_OFF%你点了点头。%SPEECH_ON%好，那你就跟着我吧。%SPEECH_OFF%他微笑着。%SPEECH_ON%真的吗？%SPEECH_OFF% 你点了点头。%SPEECH_ON%是的。就是这样。%SPEECH_OFF% %squire%四处张望。%SPEECH_ON%好吧，那接下来呢？%SPEECH_OFF%你靠在石阶上。%SPEECH_ON%跟我来。现在我要再打个盹。当我醒来时，如果你仍在这里，那么你就通过了第一轮考核——打败无聊。%SPEECH_OFF%这个侍从一脸笑容。当你醒来时，他还在那儿。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在我需要喝一杯。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.improveMood(1.0, "成为骑士的扈从");
						_event.m.Dude.getFlags().set("IsLoneWolfSquire", true);
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_20.png[/img]{你久久地注视着那个想要成为扈从的人，然后对他说不。他耸耸肩。%SPEECH_ON%我想让你知道，你在这个世界上并不孤单。 孤独从未存在，它无处可寻，它无形无影，而是一种人生方式！%SPEECH_OFF%你吐了口唾沫，擦了把脸，然后大笑。%SPEECH_ON%你每天早上都是这么对自己说的吗？离开这里。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我需要喝一杯。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.lone_wolf")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() > 1)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (!t.isSouthern() && t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
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

		this.m.Town = town;
		this.m.Score = 75;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"squire",
			this.m.Dude.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Town = null;
	}

});

