this.kraken_cult_enter_event <- this.inherit("scripts/events/event", {
	m = {
		Replies = [],
		Results = [],
		Texts = [],
		Hides = 0,
		Dust = 0,
		IsPaid = false
	},
	function create()
	{
		this.m.ID = "event.location.kraken_cult_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Texts.resize(4);
		this.m.Texts[0] = "那么，你是谁？";
		this.m.Texts[1] = "那么你到底知道些什么？";
		this.m.Texts[2] = "你是个十足的疯子。";
		this.m.Texts[3] = "所以，我能帮上什么忙？";
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_120.png[/img]{你在沼泽中偶然遇到了一个独自一人的女人，她背着背包，携带着一个挂篮，里面装满了可能是地图的卷轴。同时她的臀部左边挂着一把匕首，右边则挂着锅碗瓢盆。附近有一堆踢灭的篝火，还有一堆塞进天鹅绒袜子里的书。她以及她所有的东西都被沼泽的绿色植物包覆着。她站在那里盯着你，你也盯着她，一个女人独自身处沼泽绝非寻常。她怪异且迟疑的笑着。%SPEECH_ON%你好。%SPEECH_OFF%一手握着剑柄，你环顾四周查看是否有埋伏。你问她在这里做什么，她则回答说你不会相信她的。你已经见识过了足够多的东西，不可能给她可能用来回答的疯言乱语给予哪怕一丁点信任。这个女人点了点头。%SPEECH_ON%好吧，那么过来吧，我给你看看。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看一看。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们很好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Flags.set("IsKrakenCultVisited", true);
				this.World.Flags.set("KrakenCultStage", 0);

				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_120.png[/img]{你告诉战团保持警戒，小心隐藏在沼泽中的恶棍，但他们只是笑着说如果你这么急着来一发就应该在之前去一下妓院。你无视他们朝那个女人走去，发现她坐在一根原木上，手里捏着一个蘑菇盖，而且她说的话挺诚恳。%SPEECH_ON%我在寻找一只怪兽，无论是真的还是编的，对我来说都一样是只怪兽。明白吗？%SPEECH_OFF%从某种程度上来说，你理解了。并不是所有的怪物都是真实存在的，而在这样宽广的沼泽里寻找简直疯狂。你问她这个所谓的怪兽是什么。她吃下蘑菇然后拿起一本书，朝你扔了过来。书里有一页夹着一片树叶，你翻到了那一页。上面画东西看起来像是一只章鱼，触手有长船那么大。这个女人向前倾身，她青绿色的手仿佛藤蔓般无力的悬挂在膝盖之间。%SPEECH_ON%我正在寻找的怪兽就是克拉肯。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B0",
			Text = "[img]gfx/ui/events/event_120.png[/img]{女人向后倾斜身体。她吃下另一个蘑菇，转头用匕首刺穿一只正爬过木头的虫子，几乎毫无犹豫就把匕首尖的虫子吃了进去。她一边咀嚼甲壳一边说。%SPEECH_ON%通常，我不会透漏细节并且现在应该已经把这只匕首挥向你的那玩意了，但我觉得你很愿意帮助我，我从你的眼神中看到了这点。你是个杀手、凶手、好色之徒、贪财之人和婊娘养的疯子。%SPEECH_OFF%她吞下了昆虫的残渣，然后像吐瓜子皮一样吐出了残骸。她点了点头。%SPEECH_ON%我是一位富有贵族的女儿，但我现在显然已经远离了那种生活。%SPEECH_OFF%确实如此。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[0] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B1",
			Text = "[img]gfx/ui/events/event_120.png[/img]{她转向书本并盯着它们，仿佛那是墓碑一般。%SPEECH_ON%我父亲拥有全天下最大的图书馆之一，在那里我发现了一些关于这个沼泽的故事。这些作者们无意间在重复着同样的故事。十年前，一百年前，一千年前，全都是同样的故事。一个关于人们来到这里，然后消失的故事。原因没有被探寻，答案也不明确。强盗，疾病，一个学者甚至说那些人被这片沼泽美景所吸引，所以决定留下来。你能相信吗？沼泽的美景？%SPEECH_OFF%你笑着说你正看着这样一个人。她大笑起来。%SPEECH_ON%我已经好几个月没有看到过自己。但说真的，陌生人，我已经搜索过这片地方，但什么东西都没有发现。%SPEECH_OFF%她伸手指着她的书本。%SPEECH_ON%一共二十多起失踪，涉及最多三百多人，有些全副武装带有马匹，有些带着商队，还有些带着被保护着的贵族，但我在这里四处看了，还是什么都没有发现。%SPEECH_OFF%你怀疑如果你搞砸然后死在一片沼泽里，一样也没有人会在乎你，但那么多的故事还是有一点可疑的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[1] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_120.png[/img]{她耸了耸肩。%SPEECH_ON%也许吧，但至少我不会雇佣一个全是混球的战团。%SPEECH_OFF%你回头看了一下%companyname%，营地的一侧正在斗殴，营地中间某人正把沼泽蛇塞进一名睡着的佣兵的裤子里，而在离得较近的一侧，有几个兄弟正一边指着你们俩一边抓着裆部日空气。你转过头告诉她，他们还算不错。就在这时，一个佣兵尖叫着穿过沼泽奔了过来。%SPEECH_ON%告诉她所有人都翘了辫子的那一次，我们让你当了团长是因为没有其他人了！女士们喜欢英雄！%SPEECH_OFF%你咧嘴笑着重复了一遍。%SPEECH_ON%老实说，他们至少不是最差的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				_event.m.Replies[2] = true;
				_event.addReplies(this.Options);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_120.png[/img]{这个女人在她的背包里翻找，拿出了一枚你从未见过类似式样的纹章戒指。她像是在扔一枚赝品硬币一样把它抛给了你。%SPEECH_ON%我还有一堆这样的东西，不过不在这。你知道，我可不想让你起了抢劫的念头。但如果你帮我做点事，我能扔你头上一箱这种玩意。%SPEECH_OFF%你把纹章戒指装进口袋，问她需要做什么。她回答说。%SPEECH_ON%我现在也不是完全确定。水手们说克拉肯和鲸鱼是天敌，但你看，因为我们在陆上，这附近根本就没有鲸鱼。不过有些东西很接近，那就是沼泽中的巨魔。我猜想克拉肯经过了漫长的岁月，一边向内陆迁徙一边吃下了它们能吃下的东西，并且就像在海中一样，它们在这里也找到了一个敌人。带给我%hides%张巨魔皮，我或许能诱使这个怪兽苏醒。%SPEECH_OFF%苏醒？它能在哪个鬼地方睡觉呢？你耸了耸肩，盘算着如果她愿意把那些了不得的珠宝给你，那你当然乐意去为她效劳。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会把皮带给你的。",
					function getResult( _event )
					{
						this.World.Flags.set("KrakenCultStage", 1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}

				if (!_event.m.IsPaid)
				{
					_event.m.IsPaid = true;
					local item = this.new("scripts/items/loot/signet_ring_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_120.png[/img]{你把这个女人要求巨魔皮带了回来，结果你发现现在有更多人了。几个男人和女人到处闲逛，在沼泽里乱翻，吃蘑菇。他们问你是否来协助寻找克拉肯。你严肃质问他们是否也是来寻求报酬，因为你当然不想分享。然后那个女人叫住了你并跑了过来。她转过头，像拧抹布一样把头发里的沼泽泥水拧了出去。%SPEECH_ON%那是？没错！%SPEECH_OFF%她打了个响指，几个帮手拿走了巨魔皮。你问这些人到底是谁。她耸耸肩。%SPEECH_ON%我想，他们就是开始过来了。他们说他们来这是因为星星，我也不是能质疑这个的人。不，我不会向他们支付我欠的报酬的。他们只是乐意呆在这里，远离其他地方，远离一切。%SPEECH_OFF%你皱了皱眉头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那么交易完成了？",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				local items = this.World.Assets.getStash().getItems();
				local num = 0;

				foreach( i, item in items )
				{
					if (item == null)
					{
						continue;
					}

					if (item.getID() == "misc.unhold_hide")
					{
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + this.Const.Strings.getArticle(item.getName()) + item.getName()
						});
						items[i] = null;
						num = ++num;

						if (num >= _event.m.Hides)
						{
							break;
						}
					}
				}

				_event.m.IsPaid = false;
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_120.png[/img]{巨魔皮已经交付，你要求应得的报酬。她像对待乞丐一样地抛给了你另一个纹章戒指，然后挥手让你去看他的书。当你走过去时，你看见帮手们正在分割巨魔皮，他们似乎要将其裁剪成斗篷。那个女人说。%SPEECH_ON%我想我们离克拉肯觉醒更接近了。这里的帮手们说他们看到了星星，但我认为他们真正看到的是萤火虫。我自己有时也会看到它们，在黑暗中发光的小虫子。我尝试过去捉几个，但它们总是闪烁着消失。%SPEECH_OFF%咋样都好，你再次要求支付报酬。她以重新打开那本旧书作为回答，并看着水手被克拉肯攻击的绘图。%SPEECH_ON%周围有这么多帮手，我有更多的时间深入研究书籍，然后在这些时间里我注意到了一些事。你在这张图片中看到了什么？现在仔细看看。%SPEECH_OFF%你盯着图片，但耸了耸肩。她用手指划过图片的细节部分，就像她的叙述正在刻画那情那景一样。%SPEECH_ON%月光，这场战斗发生在夜间。这里飞翔的是什么？海鸥吗？不，是蝙蝠。这些蝙蝠在大海中心到底在干什么呢？再看这个人，在船舵的位置，他有着长长的耳朵和一件黑色的斗篷。有趣的形象，不是吗？另外还有这个，翻到下面几页，我引用这的记录：'一个流浪汉从他的斗篷里扔出蝙蝠以掩盖他的逃跑'。相当具体，不是吗？我认为它们被称为吸血鬼，古老的存在。而且我认为它们不是被克拉肯埋伏，它们是在猎杀克拉肯。%SPEECH_OFF%叹了口气，你问她需要什么。女人啪的合上书。%SPEECH_ON%这要看它们存不存在，因为我并没有亲眼见过他们，但在我过去的日子里，我见过巫医和魔法师带着奇怪的闪光灰烬。也许只是诡计，也许是真的。给我带来%remains%份这些夜行人的灰烬，我们可能就能得到我们的克拉肯。%SPEECH_OFF%女人兴奋地吃进去更多的蘑菇。她停下来，咧嘴一笑，嘴里全是黑色的蘑菇盖。%SPEECH_ON%然后你也会得到你的克朗，当然。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "尘归尘，我找尘。",
					function getResult( _event )
					{
						this.World.Flags.set("KrakenCultStage", 2);
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}

				if (!_event.m.IsPaid)
				{
					_event.m.IsPaid = true;
					local item = this.new("scripts/items/loot/signet_ring_item");
					this.World.Assets.getStash().add(item);
					this.List.push({
						id = 10,
						icon = "ui/items/" + item.getIcon(),
						text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_120.png[/img]{由于在这里呆了不少时间，你本以为这里越来越熟悉，但沼泽突然感觉起来奇怪而又陌生，就像走进一间旧卧室却发现有东西被移动了一样。\n\n你发现那个女人站在远处，她的帮手们在她身后排成队伍。他们都穿着用巨魔皮制成的斗篷，蹲在绿色光球面前，把它们捧在手中，并且你可以从每个青绿色的光景中看到因笑容露出的牙齿，嘴唇随着理性的消失轻轻发出微声。那个女人的书籍、卷轴和文件散落一地。一股雾气萦绕着，带来了可怕的气味。你问你的钱在哪里。女人露出了笑容，她的眼睛发黄，嘴唇干裂，蘑菇碎片凃的满脸都是。%SPEECH_ON%雇佣兵想要他的克朗！这里什么也没有，只有逃走！从所有东西所有地方那里逃走！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这里发生了什么？",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "我要求立即得到报酬。",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_103.png[/img]{你看着其中一名帮手突然被提到了空中，绿光中你看到光滑的触手将他向后拖去，然后仿佛大地本身裂开，有上千潮湿的树皮和树枝褶皱起来并滴下水，里面一层层的尖牙如刷子般互相撞击，就像争抢食物一般。而那名帮手被扔进了巨口中，牙床蠕动，他被褪去衣服，褪去血肉，褪去肢体，彻底摧毁。那个女人又咬了一大口蘑菇，然后用她的手抚摸着绿色的光球，你可以看到每个光球下面都是蠕动的触手。%SPEECH_ON%加入我们，雇佣兵！让'万兽之王'享受它的盛宴！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "组成队型！",
					function getResult( _event )
					{
						this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
						this.World.Events.showCombatDialog(true, true, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function addReplies( _to )
	{
		local n = 0;

		for( local i = 0; i < 3; i = ++i )
		{
			if (!this.m.Replies[i])
			{
				local result = this.m.Results[i];
				_to.push({
					Text = this.m.Texts[i],
					function getResult( _event )
					{
						return result;
					}

				});
				  // [028]  OP_CLOSE          0      4    0    0
			}
		}

		if (n == 0)
		{
			_to.push({
				Text = this.m.Texts[3],
				function getResult( _event )
				{
					return "C";
				}

			});
		}
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		this.m.Replies = [];
		this.m.Replies.resize(3, false);
		this.m.Results = [];
		this.m.Results.resize(3, "");

		for( local i = 0; i < 3; i = ++i )
		{
			this.m.Results[i] = "B" + i;
		}

		if (this.m.Hides == 0)
		{
			local stash = this.World.Assets.getStash().getItems();
			local hides = 0;

			foreach( item in stash )
			{
				if (item != null && item.getID() == "misc.unhold_hide")
				{
					hides = ++hides;
				}
			}

			this.m.Hides = hides + 3;
		}
		else if (this.m.Dust == 0)
		{
			local stash = this.World.Assets.getStash().getItems();
			local dust = 0;

			foreach( item in stash )
			{
				if (item != null && item.getID() == "misc.vampire_dust")
				{
					dust = ++dust;
				}
			}

			this.m.Dust = dust + 3;
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hides",
			this.m.Hides
		]);
		_vars.push([
			"remains",
			this.m.Dust
		]);
	}

	function onDetermineStartScreen()
	{
		if (!this.World.Flags.get("IsKrakenCultVisited"))
		{
			return "A";
		}
		else if (this.World.Flags.get("KrakenCultStage") == 0)
		{
			return "B";
		}
		else if (this.World.Flags.get("KrakenCultStage") == 1)
		{
			local stash = this.World.Assets.getStash().getItems();
			local hides = 0;

			foreach( item in stash )
			{
				if (item != null && item.getID() == "misc.unhold_hide")
				{
					hides = ++hides;
				}
			}

			if (hides >= this.m.Hides)
			{
				return "D";
			}
			else
			{
				return "C";
			}
		}
		else if (this.World.Flags.get("KrakenCultStage") == 2)
		{
			local stash = this.World.Assets.getStash().getItems();
			local dust = 0;

			foreach( item in stash )
			{
				if (item != null && item.getID() == "misc.vampire_dust")
				{
					dust = ++dust;
				}
			}

			if (dust >= this.m.Dust)
			{
				return "F";
			}
			else
			{
				return "E";
			}
		}
	}

	function onClear()
	{
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU8(this.m.Hides);
		_out.writeU8(this.m.Dust);
		_out.writeBool(this.m.IsPaid);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 43)
		{
			this.m.Hides = _in.readU8();
			this.m.Dust = _in.readU8();
			this.m.IsPaid = _in.readBool();
		}
	}

});

