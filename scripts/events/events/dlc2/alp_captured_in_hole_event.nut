this.alp_captured_in_hole_event <- this.inherit("scripts/events/event", {
	m = {
		Beastslayer = null
	},
	function create()
	{
		this.m.ID = "event.alp_captured_in_hole";
		this.m.Title = "在路上…";
		this.m.Cooldown = 170.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你发现一个人坐在地上的一个洞边上。他身边有一个铁桩，上面系着一条链子，链子伸进了洞里。洞口被山羊皮覆盖着。他挥手看着你，但说如果你想看就得付钱。你问他手上的东西是什么。他咧嘴一笑.%SPEECH_ON%这是一个奇特的东西，先生。%SPEECH_OFF%几个武装人员站在不远处，毫无疑问是这里任何阴谋的一部分。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，我花点钱去看看。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们没事。",
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
			Text = "[img]gfx/ui/events/event_51.png[/img]{你往那人手里掷了几枚硬币。他咬着硬币说道，你警告他小心点，这些硬币上有血迹。他耸耸肩，把钱收了起来。你来到洞口，那人掀开了帆布。一只相貌可怖的绿妖注视着你，嘶嘶作响，嘴里露出一排锐利的牙齿，脸上条帘般的皮肉苍白如雪。它的脖子上套着一只铁套，那人看到时吹起口哨，似乎是第一次看到有那样东西。%SPEECH_ON%真是个可怕的小家伙，不是吗？别靠近它，否则你会看到许多东西。除非你想这么做，当然有些人是想这么做的。但是如果你开始看到东西，并且你感到享受，那么你需要多付点钱！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你应该杀死它。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "好吧，呃，祝你好运。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = -10;
				this.World.Assets.addMoney(-10);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_51.png[/img]{这种丑陋的生物无法生存。你告诉这个人，它很可能会在某个时候摆脱洞穴并开始在世界上制造混乱，甚至可能出于原始的复仇心理而更疯狂。这个人吐了口口水。%SPEECH_ON%去你的吧。赶紧离开这里，你的钱别想要回。你要是走错一步，我可得捍卫自己和我的投资。抓住那玩意儿可真是个噩梦，你知道吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我将独自杀死它。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "好吧，让它活下来。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Beastslayer != null)
				{
					this.Options.push({
						Text = "%beastslayer%，你是这方面的专家。 你怎么看？",
						function getResult( _event )
						{
							return "F";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_60.png[/img]{你从一个士兵手中拿起了一支长矛，将其刺进了坑中，直接命中阿尔普的头脑。怪物那苍白的肉体像撞上了一堵巨大的幕布一样被压缩下去。奴役者拔出匕首准备来刺杀你。%randombrother%挡下了这一击并将这个人的喉咙割破。几个士兵投入了战斗，他们在快速而匆忙的战斗中全部死亡，但一些雇佣兵在混战中受了伤。在暴力事件结束后，你搜索到了奴役者身上所有的黄金。你将死者的尸体和阿尔普的尸体一起投入坑中，然后将坑填平。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(25, 100);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_51.png[/img]{你不会因这些人而争吵。一些你见过的最好的战士都在鲁莽和无意义的酒吧打斗中被杀害了。如果这些白痴想保留那个怪物，那就让他们自便吧。但战团的一些雇佣军对允许一个独眼巨人存活的想法并不满意，特别是当那个怪物盯着他们那无脸的眼神，并似乎点头表示以后还会遇见他们的时候。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.witchhunter" || bro.getSkills().hasSkill("trait.hate_beasts") || bro.getSkills().hasSkill("trait.fear_beasts") || bro.getSkills().hasSkill("trait.bloodthirsty") || bro.getSkills().hasSkill("trait.paranoid") || bro.getSkills().hasSkill("trait.superstitious"))
					{
						bro.worsenMood(0.75, "你让梦魇活下来，以后可能会闹鬼");

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
			ID = "F",
			Text = "[img]gfx/ui/events/event_122.png[/img]{兽之杀手%beastslayer%走近洞口，凝视着里面。他点了点头。%SPEECH_ON%你没有将它抓住。艾尔普斯无法被捕捉。%SPEECH_OFF%控制怪物的人看过来问怎么回事。兽之杀手笑了。%SPEECH_ON%因为那不是普通的生物。这个艾尔普斯在等待时机。你说它会给看进去的人发噩梦，对吧？是的，是的。恐惧是它的利刃，而它在尽力磨砺它。它在尽其所能地练习。艾尔普斯利用环境来放置它们的受害者，现在只能靠泥土。但是，最终你会看进去，它会仰视着你，准备好在恰当的时候袭击你，然后你就会和它在这个世界所剩无几的黑暗中被困在这个洞里。有多长时间？几天、几周。非常危险的艾尔普斯可以将你的思维囚禁数年。你会变成个傻子，破碎而口吐白沫，渴望死亡，前提是那时你还有说话的能力。%SPEECH_OFF%杀手从一个控制者的卫兵那里拿起一支弓。他把箭放在上面。艾尔普斯抬起头，嘴里露出了一排锋利的牙齿。杀手正对着嘴巴射击，立即将它击毙了。他还了弓，展开了他的学徒证明。%SPEECH_ON%这是我应得的报酬。多给你们挽救你们的灵魂和思想免遭艾尔普斯的收获。我还会带走艾尔普斯的皮肤。同意吗？%SPEECH_OFF%控制者急忙点头。%SPEECH_ON%好的，好的，当然同意！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你会和同伴分道扬镳的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Beastslayer.getImagePath());
				local money = 25;
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local item = this.new("scripts/items/misc/parched_skin_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().Days < 30)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad || currentTile.Type == this.Const.World.TerrainType.Snow)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_beastslayer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.beast_slayer")
			{
				candidates_beastslayer.push(bro);
			}
		}

		if (candidates_beastslayer.len() != 0)
		{
			this.m.Beastslayer = candidates_beastslayer[this.Math.rand(0, candidates_beastslayer.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"beastslayer",
			this.m.Beastslayer ? this.m.Beastslayer.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Beastslayer = null;
	}

});

