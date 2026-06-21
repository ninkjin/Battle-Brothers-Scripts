this.troublemakers_bully_peasants_event <- this.inherit("scripts/events/event", {
	m = {
		Troublemaker = null,
		Peacekeeper = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.troublemakers_bully_peasants";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%townImage%在进入 %townname% 后不久，%troublemaker% 就开始骚扰当地人了。 他用手把他们手上的篮子打掉，把女人踹到泥地里去。 当一个老人反抗他的时候，佣兵拔出了他的武器。 其他农民请求你快点制止这一切。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我没时间处理这个。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "你必须马上停下，%troublemaker%，这对我们的战队有很不好的影响。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "让这些农民知道他们只是群贱民，然后把他们屋子里有价值的东西搜空！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Peacekeeper != null)
				{
					this.Options.push({
						Text = "%peacekeeperfull%，看看你能不能用你的智慧让 %troublemaker% 冷静下来。",
						function getResult( _event )
						{
							return this.Math.rand(1, 100) <= 70 ? "E" : "F";
						}

					});
				}

				this.World.Assets.addMoralReputation(-1);
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "你的一个手下在城里造成了祸患");
				this.Characters.push(_event.m.Troublemaker.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%townImage%你耸耸肩。%troublemaker% 并没有刺穿那个老人，但是他确实威胁要那样，他把他的武器举的高高的。 当老人因恐惧而退缩时，佣兵直截了当的给了他一拳，老人的牙洒落在地上就像下了一场白色的雨。 这引来了村民们的嘲讽，但他们知道不应再跟你的部队进行任何争执了。\n\n几个男人缓慢地拉起了老人，小孩和女人在一旁发出不满的嘘声。 甚至有一个小孩跑到了佣兵的面前，边指边喊“他是个坏人。”%troublemaker% 耸耸肩，把武器插入了鞘中。%SPEECH_ON%那个坏家伙还在这呢。 小家伙，你也想尝尝泥巴的味道吗？%SPEECH_OFF%孩子马上跑开了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在来进行一些真正重要的事…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.World.Assets.addMoralReputation(-3);
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "你的一个手下在城里造成了祸患");
				_event.m.Troublemaker.improveMood(1.0, "欺负屁民");

				if (_event.m.Troublemaker.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Troublemaker.getMoodState()],
						text = _event.m.Troublemaker.getName() + this.Const.MoodStateEvent[_event.m.Troublemaker.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%townImage%当 %troublemaker% 高举起他的武器的时候，你抓住了他的小臂，把它摁了下来。 他转了过来，死死地盯着你。 那个吓坏的老人向后退去，然后被看门人们带走，带回了房子里面，在他让自己受伤之前。\n\n有几个其他农民长时间围在周围，抱着极大的兴趣看着热闹。 你命令佣兵退下。 他是被雇佣来应该和你的人战斗的，不是一群过着自己日子的农民。\n\n 当 %troublemaker% 环顾四周时，你意识到你没有给他留下任何可以挽回面子的“机会”。 他的眼神告诉你，他有想要杀了你的想法。 那样的话他就完蛋了，他会和他那致命的骄傲一起完完整整地离开。 但是那种眼神马上消退了，尴尬和耻辱取而代之。 他收剑入鞘，啐了一口，解释说自己只是想找点乐子。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "省省吧，直到我们被付钱要那样做的时候。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				_event.m.Troublemaker.worsenMood(2.0, "在战队面前丢脸");

				if (_event.m.Troublemaker.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Troublemaker.getMoodState()],
						text = _event.m.Troublemaker.getName() + this.Const.MoodStateEvent[_event.m.Troublemaker.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_30.png[/img]你看了看围在你周围乞求着的农民。%SPEECH_ON%你们是谁啊，农民，你们觉得你们可以告诉我的人或者我该怎么做？%SPEECH_OFF%农民后退了一步，结结巴巴地说他只是想帮忙之类的话。 大笑着，你告诉你的人拿走任何他们想要的东西。 如果这个村子对全副武装的人的权威没有任何的尊重，那么你将不得不教会他们尊重。\n\n当你的命令从嘴里吐出来的时候，女人们尖叫了起来并且抱紧了她们的孩子。 她们跑开，有几个男人也加入了她们。 其他男人留在了后面，企图保卫他们的房子，但是 %companyname% 迅速瓦解了他们简单的反抗。 你的雇佣兵很快抢劫了每一户人家，在放声大笑中拿走了所有他们能拿走的东西。 今天是个好日子。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这会教会他们的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.World.Assets.addMoralReputation(-5);
				local f = _event.m.Town.getFactionOfType(this.Const.FactionType.Settlement);
				f.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "你抢劫了这个城镇");
				local money = this.Math.rand(100, 500);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getBackground().isCombatBackground())
					{
						bro.improveMood(1.0, "喜欢掠夺和抢劫");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.worsenMood(1.0, "对战队的行为感到震惊");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "%townImage%%peacekeeperfull% 站在了 %troublemaker% 和老人之间。 他摇了摇头“不”，十分庄重，但你不禁也看到了他使剑的那只手也放在了他武器的配重球上。 那个制造麻烦的佣兵看上去有那么一瞬间想要把他砍倒，但是之后一个微笑浮现在了他的脸上。 他一边收入武器，一边笑了。%SPEECH_ON%只是找点乐子而已，我的兄弟。%SPEECH_OFF%农民们慢慢地重新开始他们的工作，但是他们依然充满了警惕，并且在接下来他们都会注意你的人，只要你还在 %townname%。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.Characters.push(_event.m.Peacekeeper.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "%townImage%%peacekeeperfull% 走到了 %troublemaker% 和老人之间。 那个制造麻烦的佣兵边笑边收起了他的武器。 他回头走向了战队其余的人，一边咧嘴笑着，一边摇晃着他的头，但是你注意到了这笑容马上消失了。 在你来得及说任何事之前，%troublemaker% 转身无情地给了 %peacekeeper% 一拳，把他打倒在地。\n\n 好吧，那也算是一种安抚雇佣兵的方法。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我也许应该对战队的纪律做些什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Troublemaker.getImagePath());
				this.Characters.push(_event.m.Peacekeeper.getImagePath());
				local injury = _event.m.Peacekeeper.addInjury(this.Const.Injury.Knockout);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Peacekeeper.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Peacekeeper.worsenMood(2.0, "在战队面前丢脸");

				if (_event.m.Peacekeeper.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Peacekeeper.getMoodState()],
						text = _event.m.Peacekeeper.getName() + this.Const.MoodStateEvent[_event.m.Peacekeeper.getMoodState()]
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

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
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
		local candidates_troublemaker = [];
		local candidates_peacekeeper = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.brute") || bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.sellsword" || bro.getBackground().getID() == "background.hedge_knight" || bro.getBackground().getID() == "background.brawler")
			{
				candidates_troublemaker.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				candidates_peacekeeper.push(bro);
			}
		}

		if (candidates_troublemaker.len() == 0)
		{
			return;
		}

		this.m.Troublemaker = candidates_troublemaker[this.Math.rand(0, candidates_troublemaker.len() - 1)];

		if (candidates_peacekeeper.len() != 0)
		{
			this.m.Peacekeeper = candidates_peacekeeper[this.Math.rand(0, candidates_peacekeeper.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = candidates_troublemaker.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"troublemaker",
			this.m.Troublemaker.getName()
		]);
		_vars.push([
			"peacekeeper",
			this.m.Peacekeeper != null ? this.m.Peacekeeper.getNameOnly() : ""
		]);
		_vars.push([
			"peacekeeperfull",
			this.m.Peacekeeper != null ? this.m.Peacekeeper.getName() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Troublemaker = null;
		this.m.Peacekeeper = null;
		this.m.Town = null;
	}

});

