this.undead_necrosavant_event <- this.inherit("scripts/events/event", {
	m = {
		Witchhunter = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_necrosavant";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_76.png[/img]路边有一堆碎石。 在它的前面，有一个灰胡子老头正在专注地盯着那些石头。 他思考太过投入，大概根本不会注意到你刚刚路过。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们瞧瞧他到底在干嘛。",
					function getResult( _event )
					{
						if (_event.m.Witchhunter != null)
						{
							if (this.Math.rand(1, 100) <= 50)
							{
								return "B";
							}
							else
							{
								return "D";
							}
						}
						else if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "我们继续前进。",
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
			Text = "[img]gfx/ui/events/event_17.png[/img]你不能把这个可怜的老家伙一个人留在这儿。 你悄悄走到他身边，问他在做什么。 他看着你，他的皮肤至少要七十个冬天才能磨砺的褶皱斑斑。他笑着说。%SPEECH_ON%我试图了解这一切。 死者正在从地下爬起来，眼看着我随时都可能被迫步入自己的坟墓，我想，何不确保自己不会成为他们中的一员呢？ 这里曾是一个神殿，当我还是个孩子的时候，在这里接受洗礼。 这里也是我结婚，以及看着我惟一的儿子结婚的地方。%SPEECH_OFF%激起了你的好奇心，你又问是什么摧毁了这个建筑。 那人又笑了。%SPEECH_ON%人们带着和我同样的问题来这里。 显示神威，重生死者是只有神才能解决的问题。 他们却找到暴力这个答案，于是他们决定一块一块地拆除它。 我原想就此告诫他们，但这也不过是自欺欺人罢了。 如果有办法的话，我可能也会像他们那样做的，但是，你明白吧，我老得要命，除了抬抬手，什么也干不了。 当一只苍蝇都能肆无忌惮舔你的鼻子时，你就只能成为和平主义者对吧。%SPEECH_OFF%他衷心地笑了。 他给你一个银碗。%SPEECH_ON%我找到了这个碗。 僧侣们过去常常用它泼圣水消除病瘴。 这不是我要找的答案，但是，拿去吧。 这东西这对我没什么用，。 不仅是当前。从各种意义上都没有。 祝你好运，另外如果，你知道吧，下次看到我是“那个”样子的话，请把我从痛苦中解脱出来。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "祝你好运，陌生人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/loot/silver_bowl_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_29.png[/img]即使对那些身强力壮的人来说，这也是一个危险的时代，对一个可能已经神志不清的糟老头来说，绝对不会很安全。 你走过去大声叫他。 他立刻扭过头来，眼睛睁得圆圆的，浮肿的瞳孔让他的眼睛变成没有神色的深渊。 他用手指着你。%SPEECH_ON%你的血。把它给我。%SPEECH_OFF%陌生人慢慢地站了起来。 他的披风从身上掉了下来，裸露出一具只有很薄一层皮肉裸露的骨架。 他颤颤巍巍地向你走来。 他的嘴是张开的，但没有发音。 声音像是从另一个世界传来的一样。%SPEECH_ON%我的审判，你深红色的，我的审判，你深红色的。%SPEECH_OFF%%randombrother% 手里拿着武器跳出来。%SPEECH_ON%他是个巫师！%SPEECH_OFF%人们武装起来，亡灵巫师向后仰着身子，披风从地上飘起，重新盖住他的身子，就好像风在听从他的召唤。 突然，尸体从地下冒出来，咆哮着，哀号着。 他从帽沿下慢慢地垂下眼睛，凝视着你。%SPEECH_ON%就这样吧。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						if (this.World.FactionManager.isUndeadScourge())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnPartyDestroyed);
						}

						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.UndeadTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Zombies, this.Math.rand(80, 120), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID());
						properties.Entities.push({
							ID = this.Const.EntityType.Necromancer,
							Variant = 0,
							Row = 2,
							Script = "scripts/entity/tactical/enemies/necromancer",
							Faction = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getID(),
							Callback = null
						});
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_76.png[/img]突然之间，一把弩越过你的肩膀上发射，在如此之近的地方发射，以至于你能感受到到绳子的当啷声中剧烈振动的空气。 弩箭穿透了老人的脑袋，他向前一倾，屁股朝上一头栽进在泥里，双手以一种颓萎的姿势向后翻着。\n\n你转过身看到女巫猎人 %witchhunter% 站在你后面。 他放下弩，走到尸体跟前，抓住尸体的后颈，把一根木桩楔进尸体的背部。 尸体惨叫一声在斗篷里爆裂开，把衣服撑得鼓了起来，一团旋动的粉尘迅速从斗篷里飞了出来，就好像冒充别人被抓了现行。\n\n 女巫猎人转向你。%SPEECH_ON%吸血鬼。罕见。极其危险。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "呃哏。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witchhunter.getImagePath());
				local item = this.new("scripts/items/misc/vampire_dust_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Witchhunter.improveMood(1.0, "在路上杀了一个吸血鬼");

				if (_event.m.Witchhunter.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Witchhunter.getMoodState()],
						text = _event.m.Witchhunter.getName() + this.Const.MoodStateEvent[_event.m.Witchhunter.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.witchhunter")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Witchhunter = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"witchhunter",
			this.m.Witchhunter != null ? this.m.Witchhunter.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Witchhunter = null;
	}

});

