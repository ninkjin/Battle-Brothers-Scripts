this.civilwar_wounded_soldier_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_wounded_soldier";
		this.m.Title = "在途中…";
		this.m.Cooldown = 25.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_21.png[/img]{当你沿着一条小路行进时，你遇到了一个 %noblehouse% 的士兵，他是你的盟友。他在地上，靠在一堵岩壁上，一只手臂搭在岩壁上，就好像他刚刚放下了最后一块石头。 他抬头看着你，冷笑着。%SPEECH_ON%你想要什么，雇佣兵？ 你是来杀我的，哏？ 要拿走我所有的东西？%SPEECH_OFF%他穿着一套漂亮的盔甲，身上还带着件武器。 在他现在的状态下，不是说他会用它来保护自己，而是在你的手下手里看起来不错。%randombrother% 走上去。%SPEECH_ON%我们可以干掉他，先生，但我们得速战速决。 因为他这身贵族军服，我们行动越慢就越有危险。%SPEECH_OFF% | 你遇到一个受伤的 %noblehouse% 士兵，是你的盟友。 他躺在草地上，盯着你，你也盯着他：这个人身上戴着一件像样的盔甲，腿上还摆放着一把武器。 你可以把他的东西全部抢走，但是很明显，他不会愿意。 而且士兵的军队很可能就在不远处… | 一位受伤的 %noblehouse% 士兵，你的盟友，躺在路上。 他拖着身子爬行，但一听到你的声音，他就停下来转过身来。%SPEECH_ON%啊，见鬼。你最好不要对我有什么坏心思，雇佣兵。 我的人就离着不远，如果你再跟着我，我就会尖叫。%SPEECH_OFF%你挑了挑眉。%SPEECH_ON%你会像个娘们那样做，嗯？%SPEECH_OFF%那个人吐了口唾沫。%SPEECH_ON%我知道我不用等太久就能在另一个世界看到你了。%SPEECH_OFF%这个狡猾的家伙身上有一套很好的盔甲和武器，但是 %randombrother% 警告你，他是贵族军队的一员。 | 一个 %noblehouse%的军队的伤兵躺在你面前。 一方面，他确实有一件武器和一些盔甲，你可以从他身上抢走。 另一方面，他无疑是一支比你们强大得多的军队的一部分。 只是此时此刻这支军队不在周围。 如果你决定抢他的东西，一定要快。 | 是幸运还是灾难？ 你发现一个伤兵穿着相当漂亮的盔甲。 他身边还带着一件武器，放在 %companyname%的人旁边看起来会更好看。 拿走他的东西很容易。 周围没有人能看见他，而且让他发不出声也不是什么难事。\n\n但是你这样做很可能会被一支人数众多的军队所注意，因为这个士兵碰巧穿着你的盟友 %noblehouse% 的衣服。于是你决定，决定… | 你遇到一个伤兵，他身上挂着你的盟友 %noblehouse% 的破旗子。 看到你，他飞快地向后跨过草地。 他伸出手想骂人，但从他嘴里喷出来的只有血。%randombrother% 向你走过来。%SPEECH_ON%先生，他身上有一套漂亮的盔甲和武器。 如果你愿意的话，我们可以把他干掉，但他的军队有可能就在不远处。 我们应该非常小心。%SPEECH_OFF% | 你发现一个 %noblehouse% 的士兵试图踢进一个废弃的小屋的门。 听到你的话，他迅速转过身来，举起一把剑自卫。 然而，刀刃摇摇晃晃，握力不稳。 血从他的手臂一直流到手腕，他挣扎着站着。%SPEECH_ON%退后，你们所有人都给我退后！%SPEECH_OFF%之后他慢慢的往角落里靠。 就当你准备下令前进时…\n\n %randombrother% 抓着你的手。%SPEECH_ON%等一下，先生。如果他的军队发现我们，我们就有麻烦了。 我们行动前得先认真想想。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			Banner = "",
			Options = [
				{
					Text = "我们最好别管他，继续前进。",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "那些盔甲和武器可能有用，而且他死后也不需要了。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);

						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_21.png[/img]{你拔出剑来，向士兵走去。 他叫了一声，但声音很短，最后以你的利刃划过他的后脑勺发出的尖锐鼻音而结束。 他一边挣扎，一边敲打着那给他致命一击的金属，然后坐了下来。 颤抖的眼睛仰望着你，就像寒冷的死亡带走了他。 你收回剑，回头告诉那些人把他身上所有的东西都拿走。 你在死者的旗帜布上擦拭你的刀刃。 | 那个人从你的眼神中看出了你的意图，迅速提高了嗓门，但你冲过去，拔出你的利刃，飞快地把它刺穿了他的脑壳。 他死了，你感到一阵剧痛。 不是一种道德上的痛苦，而是一种更老、更真切的痛苦。%randombrother% 把手搭在你的肩膀上，让你保持稳定。%SPEECH_ON%放松点，先生，你已经不像以前那么灵活了。%SPEECH_OFF%你点头，你清洗你的刀刃，并且告诉手下，把这个士兵身上的东西都拿走。 | 这个士兵向后靠了靠。%SPEECH_ON%唉，我知道了。%SPEECH_OFF%他抬起他的脖子。%SPEECH_ON%行，我已经无处可逃了。我会像一个男人一样死去。%SPEECH_OFF%他头往后仰，自刎了，血液乱喷。 你的手下随后抢光了他的东西。 | 你拿出匕首。 那人举起武器，你却把它踢到一边。 他的手臂不费吹灰之力就垂下来了，好像你刚刚帮他减轻了一个巨大的负担。 他盯着你看。%SPEECH_ON%等等…%SPEECH_OFF%这是他最后一句话了。 他试着说点别的，但是你在他喉咙上划开的大口子只会让他发出可怕的漱口声。 你命令 %randombrother% 把尸体上所有东西都拿走。}",
			Image = "",
			Characters = [],
			List = [],
			Banner = "",
			Options = [
				{
					Text = "又一个战争的牺牲品。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.addLoot(this.List);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_90.png[/img]{你拿出你的剑，走向那个人。 他举起手来，你把刀锋穿过他的手掌，直接插入他的大脑。 他的舌头耷拉着最后的话语，血液混合着唾液流了下来。 清理着你的刀，你转向 %randombrother%，但是只看到一名士兵站在地平线上。%SPEECH_ON%噢，该死的混蛋！大家快跑！%SPEECH_OFF%%companyname% 行动很快，尽管逃跑很混乱，你们穿过灌木丛，越过河床，甚至还悄悄的杀死了一只还没来得及吠叫的猎狗。 你最终设法逃脱了，但没有时间带走任何东西。 | 你拿出你的剑，刺进那人的胸膛。 他伸出手抓住你的衬衫，把自己拉上刀刃。 他咧嘴一笑，露出了血淋淋的牙齿。%SPEECH_ON%你自己去吧，雇佣兵。 我会在另一边等你。%SPEECH_OFF%他松开手，向后倒去，你的剑离开他的时候，一股血色喷涌而出。 突然，%randombrother% 高声向你叫喊。%SPEECH_ON%先生，我们快跑吧！士兵，看！%SPEECH_OFF%站在附近一座山上的是 %noblehouse% 的骑手，他们无疑看到了你的所作所为。 你尽可能大声喊叫，命令士兵们迅速撤退。 虽然你设法逃脱了，但毫无疑问，你换来了你未来雇主的好意。 | 当你向那个士兵施加压力时，他笑了。 当你用剑刺入他的胸膛时，他笑了。 当你取回你的利刃时，他笑了，一个最后的，疲倦的大笑。 他的目光越过你凝视着附近的一座小山头，很明显，他知道你的事情败露了：贵族的士兵站在山头上，看到了你的所作所为。\n\n你迅速大喊，命令 %companyname% 的同伴们撤退，免得整个敌人大军压过来，把你们杀干净。 在仓皇逃窜的途中，你放弃了刚刚杀人所获得的奖赏。 这样做都是为了能把你的脑袋安稳的放在肩膀上。 | 你用剑猛的划开了那个人的喉咙。 他用手捂住伤口，但是他的生命还是从指缝间悄悄溜走了。 就在他倒下时，%randombrother% 向你大喊。%SPEECH_ON%先生，快看！%SPEECH_OFF%那个贵族士兵的战友正站在远处的一座小山上，毫无疑问，他们看到了你刚才的所作所为。 你迅速命令 %companyname% 开始撤退，在整个军队冲到你们面前之前，尽快离开这个地区。 在疯狂的撤退中，你没有时间为你的血腥行为拿任何奖品。}",
			Image = "",
			Characters = [],
			List = [],
			Banner = "",
			Options = [
				{
					Text = "狂妄！活下来才能拥有一切！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationOffense, "杀了他们的一个人");
			}

		});
	}

	function addLoot( _list )
	{
		local item;
		local banner = this.m.NobleHouse.getBanner();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			item = this.new("scripts/items/weapons/arming_sword");
		}
		else if (r == 2)
		{
			item = this.new("scripts/items/weapons/morning_star");
		}
		else if (r == 3)
		{
			item = this.new("scripts/items/weapons/military_pick");
		}
		else if (r == 4)
		{
			item = this.new("scripts/items/weapons/warbrand");
		}

		this.World.Assets.getStash().add(item);
		_list.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			item = this.new("scripts/items/armor/special/heraldic_armor");
			item.setFaction(banner);
		}
		else if (r == 2)
		{
			item = this.new("scripts/items/helmets/faction_helm");
			item.setVariant(banner);
		}
		else if (r == 3)
		{
			item = this.new("scripts/items/armor/mail_shirt");
		}
		else if (r == 4)
		{
			item = this.new("scripts/items/armor/mail_hauberk");
			item.setVariant(28);
		}

		item.setCondition(44.0);
		this.World.Assets.getStash().add(item);
		_list.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local candidates = [];

		foreach( h in nobleHouses )
		{
			if (h.isAlliedWithPlayer())
			{
				candidates.push(h);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.NobleHouse = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
	}

});

