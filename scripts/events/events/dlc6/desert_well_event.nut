this.desert_well_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Monk = null
	},
	function create()
	{
		this.m.ID = "event.desert_well";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你遇到一个水井。 井的外墙布置着动物头骨还有同样挂上去的动物肋骨。 随着你靠近，深处传来微弱的嘶嘶声。 向里面望去，你看到一个细小的橘色光点左到右蜿蜒而过。%SPEECH_ON%你最好不要多往下看。%SPEECH_OFF%你转身看到一个穿着破布的人。 他的头发丫字形的向后突出。 脸上满是黑色的斑点以及每个手指上都一样的淤青还有一个黑漆漆的笑容。%SPEECH_ON%要喷发了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "什么要喷发了？",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{这个人点头。%SPEECH_ON%那不是什么水井，那是个大炮。 我在底下堆了许多火药。 滑道上装着水桶和钓鱼竿还有各种各样的餐具，某些士兵的铁靴子，一把短剑，几个剑鞘，我想有几个动物掉下去现在他们应该都死了，如果没有他们有好戏看了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢不，不，别这样！",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "神跟你对过话，%monk%，你快去跟他说说！",
						function getResult( _event )
						{
							return "D";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%terrainImage%{那人咧嘴一笑。%SPEECH_ON%你根本不了解我，陌生人。 也许我的目的是自杀，因为我犯了一个可怕的罪行。 我的意思是，我没有，但是你为什么要说“不要做”呢？ 你已经看到了我的准备，如果我想停下来，我以前不会做吗？ 现在，你退下看好了。%SPEECH_OFF%他转身跃入了洞。 他坠落的响声传出来，还有些咕哝说他不记得有这么多碎片在下面。 当你往下看他叫你闪开然后橘黄色的光点进入了一个洞。那个人鞠躬。%SPEECH_ON%祝你好运陌生人，一个奇怪的告别－%SPEECH_OFF% 爆炸令你耳鸣并把你震到地上。 你身下的土地颤抖的翻滚着你甚至在这种被震聋的状态下都能感受到。 一股烟火刺入天空伴随着金属金属的叮叮当当还有更平钝的皮革和其他物资落地的扑通声，而你蜷起身子护住头保护自己免于下雨一样的各种废品，就好像什么神的地狱风暴似的。\n\n 这一些残渣绝对毫无任何用处。 至于那个人，好吧，他得到了他想要的。 毫无疑问，他在眨眼间就死了，剩下的只是到处烧焦的大块，烤过的肺和烧焦的肌腱等等。 你检查了一下来确认你的眉毛是否还在，有些欣慰，你准备继续赶路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有时候你希望这些只是幻象。",
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
			Text = "%terrainImage%{%monk% 这个僧侣走上前去。%SPEECH_ON%为了了结自己可花了不少功夫啊，朋友。%SPEECH_OFF%那人耸耸肩。%SPEECH_ON%我并不真的是你的朋友。%SPEECH_OFF%僧侣点了点头。%SPEECH_ON%语言习惯，仅此而已。 说实话我不知道你的任何事情。 说实话你很可能有一个很好的理由来做这些事。 你花了多长时间把这些东西堆起来？%SPEECH_OFF%奇怪的男人思考了一会，之后说他想可能用了几个月。%monk% 笑道。%SPEECH_ON%做得很好，这是很艰苦的工作。%SPEECH_OFF%那人说。%SPEECH_ON%你在试图哄我？%SPEECH_OFF%僧侣摇了摇头。%SPEECH_ON%不，先生。%SPEECH_OFF%男人咪起了他的眼难以置信的说。%SPEECH_ON%我听起来你好像在把我当小孩子哄。 想说服我不要杀了自己。 不我不接受！%SPEECH_OFF%%monk% 耸了耸肩。%SPEECH_ON%再一次错了先生。如果你想，继续了结自己吧。 今天或者以后，旧神们都会等着你的。%SPEECH_OFF%那人转过身吐了一口唾沫。%SPEECH_ON%这下面可没有旧神。 只有镀金者的闪耀与光辉。%SPEECH_OFF%%monk% 点头然后转身面向你。%SPEECH_ON%老实说，队长，我真的只剩一句话可以说了。 我能说吗？ 我想跟这个陌生人说出来，直接的说出来。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那就继续。",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "如果那是他想要的，就让他结束自己吧。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "%terrainImage%{僧侣在你的肯定下点头，然后突然给了陌生人一拳。 他从井壁上摔下来，倒在泥土里，眼睛发抖地盯着看。%SPEECH_ON%你干啥子？%SPEECH_OFF%他问道，摸着他的嘴唇。%monk% 蹲下。%SPEECH_ON%感觉怎么样？%SPEECH_OFF%陌生人讥笑着吐了一口血沫。 他说很疼。僧人点了点头。%SPEECH_ON%感觉活着吗？%SPEECH_OFF%陌生人站起来拍了拍灰。他点头。%SPEECH_ON%有点，确实。%SPEECH_OFF%两个人聊了一会，当他们完事时那个人愿意免费加入战队。 他还说井里有不少东西你可以用上，尽管注意不要丢任何火下去因为会被炸到天上去。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入，我想是吧。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"peddler_southern_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "一连串的不幸事件导致前军火贩子%name%试图以炸毁自己的方式结束生命，但是" + _event.m.Monk.getName() + "干预并说服他加入你的战团，为自己开始新的生活。";
				_event.m.Dude.getBackground().buildDescription(true);
				local trait = this.new("scripts/skills/traits/deathwish_trait");

				foreach( id in trait.m.Excluded )
				{
					_event.m.Dude.getSkills().removeByID(id);
				}

				_event.m.Dude.getSkills().add(trait);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.worsenMood(2.5, "有一连串的不幸，失去了一切");
				this.Characters.push(_event.m.Dude.getImagePath());
				local item = this.new("scripts/items/loot/silverware_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "%terrainImage%{你告诉僧侣退下。 他耸耸肩便回到你身边。 当你回头看向那个男人你看到他点了把火跳下了井。\n\n 爆炸令你耳鸣并把你震到地上。 你身下的土地颤抖的翻滚着你甚至在这种被震聋的状态下都能感受到。 一股烟火刺入天空伴随着金属金属的叮叮当当还有更平钝的皮革和其他物资落地的扑通声，而你蜷起身子护住头保护自己免于下雨一样的各种废品，就好像什么神的地狱风暴似的。\n\n 这一些残渣绝对毫无任何用处。 至于那个人，好吧，他得到了他想要的。 毫无疑问，他在眨眼间就死了，剩下的只是到处烧焦的大块，烤过的肺和烧焦的肌腱等等。 你检查了一下来确认你的眉毛是否还在，有些欣慰，你准备继续赶路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有时候你希望这些只是幻象。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 6)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_monk = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk")
			{
				candidates_monk.push(bro);
			}
		}

		if (candidates_monk.len() != 0)
		{
			this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Monk = null;
	}

});

