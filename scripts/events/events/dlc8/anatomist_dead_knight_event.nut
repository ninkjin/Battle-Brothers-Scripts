this.anatomist_dead_knight_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Noble = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_dead_knight";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_75.png[/img]{%anatomist% 解剖学家发现主路旁边有一些闪闪发光的东西。你走过去看了看。有个黑色的金属物体在远处。也许是个骑士的尸体？尽管这会让你想知道他是如何独自到达那里的。%anatomist% 暗想这个显然有伟大的武艺的尸体上或许可以发现点什么。你摇了摇头。%SPEECH_ON%骑士很少独自死去，如果他们这样做了，他们肯定不会将盔甲带在身边。整件事就闻起来像是一个陷阱。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们去取它。",
					function getResult( _event )
					{
						if (_event.m.Noble != null)
						{
							return "C";
						}
						else if (this.World.FactionManager.isUndeadScourge())
						{
							return "E";
						}
						else if (this.Math.rand(1, 100) <= 30)
						{
							return "D";
						}
						else
						{
							return "B";
						}
					}

				},
				{
					Text = "No.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_46.png[/img]{不顾自己的判断，你走过去看看。穿过敞开的地面走向骑士时，你感到很暴露，就像一个贼从过道里一直摸到那边的货架上。当你来到骑士跟前，你停下来四处张望。你周围的土地上没有任何活动。没有强盗把陷阱放开。没有狼群找到它们的猎物。你耸了耸肩，低下头。这个人穿着体面的盔甲，拿着一把好看但用旧了的剑。他的脸干燥，眼睛已经没了。他胸甲上的鸟粪结痂了。 你命令%anatomist%把他从盔甲里解放出来，把所有东西都拿回马车上。%SPEECH_ON%什么？为什么是我？%SPEECH_OFF%你告诉他，如果他想研究这具尸体，那么代价就是必须首先剥去它的盔甲。离开时，你告诉他，当他把它放在清单里时，一定要小心不要压坏任何食物，因为那套盔甲看起来有点沉。还要确保清除鸟粪。%anatomist%叹了口气，但他仍然很高兴能接触到一个“英雄”的尸体。有时你会想，如果解剖学家像这样发现你死了，他会怎么做...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很容易。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local armor_list = [
					"decayed_coat_of_scales",
					"decayed_reinforced_mail_hauberk"
				];
				local item = this.new("scripts/items/armor/" + armor_list[this.Math.rand(0, armor_list.len() - 1)]);
				item.setCondition(item.getConditionMax() / 2 - 1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/arming_sword");
				item.setCondition(item.getConditionMax() / 2 - 1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Anatomist.improveMood(0.75, "得检查一下一位英勇骑士的尸体。");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_78.png[/img]{你去了一堆盔甲那里，希望这并不像看起来的那样是个陷阱。%anatomist%几乎跟在你身边，他的眼睛默默地吞噬着那些前景的“科学”，手里拿着一本书正在狂热地写着。\n\n出乎意料的是，%noble%也来了，这位高贵血统的男子似乎认出了这堆盔甲本身。确实，当你们靠近时，他惊呼着说这是他从过去的日子里认识的好朋友。你郑重地点了点头，但仍然说这些盔甲最好与战团一起使用，而不是在这里荒废。这位男子点了点头。%SPEECH_ON%我想他会同意的。我会把它从他身上取下来。%SPEECH_OFF%在他开始之前，%noble%转向%anatomist%，告诉他最好不要碰他的朋友。你回到马车上，让解剖学家负责运送这些盔甲。现在已经出汗的解剖学家很难过，因为他没有机会看到尸体，而%noble%显然很难过，因为尸体本身是他的好朋友。总的来说，这个该死的死人所引起的痛苦可能比他本身值得的还要多。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少我们得到了盔甲。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Noble.getImagePath());
				local armor_list = [
					"armor/decayed_reinforced_mail_hauberk",
					"helmets/decayed_closed_flat_top_with_mail"
				];
				local item = this.new("scripts/items/" + armor_list[this.Math.rand(0, armor_list.len() - 1)]);
				item.setCondition(item.getConditionMax() / 2 - 1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Anatomist.worsenMood(1.0, "被拒绝了检查一具有潜力的尸体的机会。");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Noble.worsenMood(2.0, "看到了一位老朋友腐烂的遗骸。");

				if (_event.m.Noble.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Noble.getMoodState()],
						text = _event.m.Noble.getName() + this.Const.MoodStateEvent[_event.m.Noble.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_21.png[/img]{你决定去看一看。当你穿过看似开阔的平原时，你感到有人在注视着你。所有这些都感觉不对劲。中途，你转身对%anatomist%说是时候折回去了。他摇了摇头说，既然来到这里就不要轻易放弃。在你回答之前，一支箭从你耳边掠过，解剖学家倒在地上抓住肩膀。\n\n你将他扶起，拖回到马车上。箭矢落在你周围的地上，尘土飞扬，直到他们开始击中马车。集结队伍进行反击，你看到这些伏击者对比起来更好的机会，开始逃跑，其中几个拿着骑士的盔甲。正如你所预料的，整个事情都是个陷阱。%anatomist%还活着，谢天谢地，他已经在他的书中写下了这次经历，或者根据他对箭伤的着迷，写下了关于他惨痛伤口的经历。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "下次我会听我的直觉。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local injury = _event.m.Anatomist.addInjury(this.Const.Injury.Accident2);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Anatomist.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Anatomist.improveMood(1.0, "得近距离观察一个有趣的伤口");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_184.png[/img]{尽管你内心觉得不妙，还是走过去仔细看了看。你感觉自己在赤裸裸的开阔地上走过去，就像一个窃贼在过道上伸手偷窃。走近尸体，你回头问解剖学家%anatomist%他对这具尸体的计划是什么。你看到解剖学家僵硬地站在那里，头仰向后，眼睛睁开，一只紧张而瑟瑟发抖的手指向前。当你回头看尸体时，它开始动了，缓慢地从地上起来，呻吟着，嘶嘶作响。头盔从缝隙处流出污物。你拔出剑。\n\n黑骑士从地上爬了起来，它的手套破碎，露出皮肤。它转过身来看着你，那把泡沫般的头盔里有一点微红的光。你猛然一剑，生物的头颅掉在了地上，空气从脖子的洞里喷出。你将剑收起来，告诉%anatomist%如果他想研究什么，那么，就是那个了%SPEECH_ON%另外也把它的盔甲放到车上。弯腰时要用你的腿，不要弄伤你的后背或其他任何地方。%SPEECH_OFF%你走过解剖学家的身边。他怔住了，然后合上嘴巴，拿出了一支羽毛笔和一些卷轴。他的恐惧被抛到了脑后，他的自然状态又恢复过来了。%SPEECH_ON%一个新鲜的标本，近距离的观察，最近死亡的，或者说是死而复生的？无论哪种情况......我们可以从中学到很多东西。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你也可以学着用膝盖弯曲，砍砍。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local armor_list = [
					"armor/decayed_reinforced_mail_hauberk",
					"helmets/decayed_closed_flat_top_with_mail"
				];
				local item = this.new("scripts/items/" + armor_list[this.Math.rand(0, armor_list.len() - 1)]);
				item.setCondition(item.getConditionMax() / 2 - 1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Anatomist.addXP(200, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		if (this.World.getTime().Days <= 25)
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local noble_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
			else if (bro.getBackground().isNoble())
			{
				noble_candidates.push(bro);
			}
		}

		if (noble_candidates.len() > 0)
		{
			this.m.Noble = noble_candidates[this.Math.rand(0, noble_candidates.len() - 1)];
		}

		if (anatomist_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Score = 5 + anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"noble",
			this.m.Noble != null ? this.m.Noble.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Noble = null;
	}

});

