this.come_across_ritual_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null
	},
	function create()
	{
		this.m.ID = "event.come_across_ritual";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]在你的旅途中发现一具尸体并不罕见。 然而，这一次却不同寻常。%randombrother% 看了很久。%SPEECH_ON%他胸前的是什么？%SPEECH_OFF%你蹲下来，把尸体的衬衫扔回去。 他全身的伤疤都是纵向的，排列的形状很熟悉：森林，河流，山脉。%randombrother% 走上前。%SPEECH_ON%这不是一道风景么。 是狼干的还是其他什么东西？%SPEECH_OFF%你站起来。%SPEECH_ON%我想是他自己干的。%SPEECH_OFF%血淋淋的脚印致使我离开现场…",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们跟着这些脚印。",
					function getResult( _event )
					{
						return "Arrival";
					}

				},
				{
					Text = "这与我们无关。",
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
			ID = "Arrival",
			Text = "[img]gfx/ui/events/event_140.png[/img]当你跟着脚印走的时候，你开始听到低声吟唱的声音。 你告诉队员们在你偷偷前进的时候休息一下，最后发现一大堆篝火，附近围绕着穿着斗篷的人。 他们跺着脚，举起双手，对他们的古老神明达库尔喊着象征性的话。 这是一场野蛮的仪式，到处是咆哮和吼叫声，人们穿着超大号的衣服跳舞，如同黑暗的灵魂的怒火，对于这个已经被他们抛弃的世界。%randombrother% 爬到你身边，摇了摇头。%SPEECH_ON%刚刚下面到底发生了什么事？ 我们应该怎么做？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们需要马上阻止他们。进攻！",
					function getResult( _event )
					{
						return "Attack1";
					}

				},
				{
					Text = "我们等待看看发生什么了。",
					function getResult( _event )
					{
						return "Observe1";
					}

				},
				{
					Text = "是时候离开了,马上动身。",
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
			ID = "Observe1",
			Text = "[img]gfx/ui/events/event_140.png[/img]你决定等待看看会发生什么。 就像你刚才说的，异教徒们把一个老人拖到火前。 他在火焰前低下头，张开双臂，然后跳了进去。 并没有尖叫声。 另一个人被拉上前。 他对一个异教徒低声耳语，他俩都点头，所以这个人也把自己置身在火焰中。 第三个人被推出去了，但与其他的人不同的是，他被束缚着，眼睛睁得大大的。 他对着异教徒们尖叫。%SPEECH_ON%我操你们的神，他狗屁不是！ 他就是个骗子！%SPEECH_OFF%一张脸呈现在火焰中，它的形状是球状的，在烟和火中翻腾。 他是残酷的化身，火焰和黑暗本身都不能更好地描绘它。 它转身着咧嘴一笑。 其中一个异教徒大喊。%SPEECH_ON%达库尔即将降临到你！%SPEECH_OFF%但是这个囚犯踢了其中一个看守他的人，试图逃跑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我看不下去了。我们需要帮助他，马上！",
					function getResult( _event )
					{
						return "Attack2";
					}

				},
				{
					Text = "等一等，我们看看接下来会发生什么。",
					function getResult( _event )
					{
						return "Observe2";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Cultist != null)
				{
					this.Options.push({
						Text = "%cultist%，这不是你的宗教么？",
						function getResult( _event )
						{
							return "Cultist";
						}

					});
				}

				this.Options.push({
					Text = "是时候离开了,马上动身。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Observe2",
			Text = "[img]gfx/ui/events/event_140.png[/img]你决定等待看看会发生什么。 篝火的脸转了回来，当这个犯人被推向前的时候，一个巨大的岩浆巨口张开了。 他尖叫着向后弯腰，但是没有用。 他的衣服被烧光了，成了一堆橘红色的碎片向后飞扬。 他的皮肤开始剥落了，好像不是火干的，而是无数的手术刀在他身上划过。 他被锋利的白色火焰剥皮了。 他的头盖骨露了出来，像蛇蜕皮一样蠕动和颤抖。他的眼睛却永远保留着，看着身体的其他部分被剥去，肉，器官和骨头。 当他只是一个有眼睛的骷髅时，篝火中的那张脸闭上了嘴，献祭中的巨大哀嚎声一时间沉寂了下来。 篝火在一瞬间熄灭了，那个人，或者说他剩下的东西，掉在了地上。 那双眼睛里燃烧着明亮的光芒，像滚烫的烙铁一样慢慢消失。\n\n 一个异教徒弯下腰捡起了那个头骨。 他轻松把他掰成两半，把这个曾经是一张脸的东西翻转过来，脑壳朝上。 当他把头骨拿向外时，骨头变黑了并倒转过来，形成了一个被一圈骨头环绕着的黑暗残酷面孔。 他把他带在头上，开始离开。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在我们进攻！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];

						for( local i = 0; i < 25; i = ++i )
						{
							local unit = clone this.Const.World.Spawn.Troops.Cultist;
							unit.Faction <- this.Const.Faction.Enemy;
							properties.Entities.push(unit);
						}

						properties.Loot = [
							"scripts/items/helmets/legendary/mask_of_davkul"
						];
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				},
				{
					Text = "我们最好离开。",
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
			ID = "Cultist",
			Text = "[img]gfx/ui/events/event_140.png[/img]你问 %cultist% 他是否能做些什么。 他只是从你身边走过，然后下山。 异教徒们转过身来看着他。 他穿过人群走向囚犯。 他们谈话。他低声耳语，囚犯点头。 当他们谈话结束，%cultist% 向这群异教徒们点头。 一个成员走上前，脱下衣服，把自己扔进火里，没有尖叫，也没有抗议。 另一个异教徒把耙子伸进火焰里，把什么东西从火焰里扯出来，交给 %cultist%。这个囚犯，他的生命表面上在一场交换中幸免了，被释放了并且你看到 %cultist% 抓着他，把他带回到山上。 他说话时把这个男人推向前。%SPEECH_ON%你已经被从达库尔身边带走了，但你欠达库尔的已经支付了。%SPEECH_OFF%你问他手里拿的是什么东西。 异教徒举起从火焰中捡回来的东西。 那是一个用人品遮盖的头盖骨，紧绷在脸上的是一张新烧焦的脸，大概是那个把自己扔进火里的人的脸。 这张脸轻微地扭曲着，嘴巴半掩着，残酷的黑暗使他看上去奇丑无比。 仍然高举着它，像一个土著人炫耀珍贵的头皮，%cultist% 直言不讳。%SPEECH_ON%达库尔即将降临到我们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是什么？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/helmets/legendary/mask_of_davkul");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Attack1",
			Text = "[img]gfx/ui/events/event_140.png[/img]你下令进攻。 你的人武装起来向前冲去。 火瞬间就熄灭了，只剩下滚滚浓烟中的灰烬。 旦它消失了，诡异的人群张开双臂，异口同声地说道。%SPEECH_ON%达库尔即将降临。让我们来迎接他。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];

						for( local i = 0; i < 25; i = ++i )
						{
							local unit = clone this.Const.World.Spawn.Troops.Cultist;
							unit.Faction <- this.Const.Faction.Enemy;
							properties.Entities.push(unit);
						}

						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "Attack2",
			Text = "[img]gfx/ui/events/event_140.png[/img]你不会容忍这种不公正的行为并决定冲锋去救那个人。 当你站起来举起你的剑下达命令时，篝火喷出一只巨大的岩浆触手，抓住被锁住的人，把他拖进火焰里。 只有很短的尖叫声，然后他就不见了。 大火凝聚成一根柱子，很快就倒塌了。 一缕灰烬向外飘散。 那个人不见了，就好像根本没有火一样。 天空中甚至没有烟。\n\n 这些异教徒转向你，指着你异口同声说道。%SPEECH_ON%带来死亡，你们的或者我们的，达库尔即将降临到我们。%SPEECH_OFF%你震惊了一会儿，然后下令冲锋。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.CivilianTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];

						for( local i = 0; i < 25; i = ++i )
						{
							local unit = clone this.Const.World.Spawn.Troops.Cultist;
							unit.Faction <- this.Const.Faction.Enemy;
							properties.Entities.push(unit);
						}

						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 200)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d >= 4 && d <= 10)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 11 && (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		if (candidates.len() != 0)
		{
			this.m.Cultist = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
	}

});

