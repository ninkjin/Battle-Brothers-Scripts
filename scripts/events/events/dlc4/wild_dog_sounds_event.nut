this.wild_dog_sounds_event <- this.inherit("scripts/events/event", {
	m = {
		Hunter = null,
		Wildman = null,
		Expendable = null
	},
	function create()
	{
		this.m.ID = "event.wild_dog_sounds";
		this.m.Title = "在途中…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]{营地里 %randombrother% 停下了手里的活并仔细聆听着什么。%SPEECH_ON%都听到那东西了吗？%SPEECH_OFF%是的。野狗在歇斯底里的狂吠。 你耸耸肩说没什么，但接下来那叫声变成了咆哮声你能感觉出这是只有战斗才能发出歇斯底里般的声音。 咆哮声逐渐变成了呜咽声。 一定有什么东西输了这场战斗。%randombrother% 转向你。%SPEECH_ON%声音听起来很近，我们应该检查一下吗？ 我可不想在这儿睡觉。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别理它。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Hunter != null)
				{
					this.Options.push({
						Text = "你是个猎人，%hunter%，你去看看吧。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "你是个野人，%wildman%，你去看看吧。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				if (_event.m.Expendable != null)
				{
					this.Options.push({
						Text = "看起来像是新来的人的工作。 去看看，%recruit%！",
						function getResult( _event )
						{
							return this.Math.rand(1, 100) <= 40 ? "F" : "G";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你告诉战队不要去理会这些声音。 这是个艰巨的任务，因为野狗的叫声越来越大，就这样直到它们停下来为止。 你的人神情呆滞，好像随便弄点声音出来就能让人感到该死的恐怖。 最后什么也没发生，但有几个人整夜难以入睡。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "加强警备，白痴们。",
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
					if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_hunter")
					{
						continue;
					}

					if (bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.barbarian")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.worsenMood(0.5, "没有睡好觉");
						local effect = this.new("scripts/skills/effects_world/exhausted_effect");
						bro.getSkills().add(effect);
						this.List.push({
							id = 10,
							icon = effect.getIcon(),
							text = bro.getName() + "是筋疲力尽的"
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你告诉大伙如果这声音让他们感到担忧，就把耳朵堵上。 大伙随即用蜡球堵上耳朵来应对野狗的狂吠声越来越大。 最终，他们又恢复到了往常傻不拉几的样子。 你也想缓解下，就拿了个蜡球堵上了一只耳朵，还没来得及堵另一只耳朵的时候仓库那边传来了巨大的碰撞声紧接着仓库帐篷坍塌了冒出大量的烟雾。 你清空了耳朵并且快速指挥着雇佣兵们分散开来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器，你们这群聋子！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.Entities = [];
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Unhold, this.Math.rand(80, 100), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
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
			Text = "[img]gfx/ui/events/event_14.png[/img]{加强警备似乎不会缓解这些人的情绪。%hunter% 决定去探明一下声音的问题，因为他觉得那不过是野狗为了争夺族群里的狗王才发出的声音。 你同意了，他冒险独自一人走进黑暗。 他一走进去那些狗就停止了叫声，紧接着你听到了类似低吼的声音从更高的地方传来。 整个营地甚至动都不敢动，一片死寂。\n\n 一个小时后他走进营地了，但没人听到他回来的动静。 他用泥巴和树叶把自己伪装起来。 帽子里插着树枝，看起来就像树林修女院院长。 大伙压低声音问他看到了什么。他耸耸肩。%SPEECH_ON%额。我看到了十几只死狗。 一些被撕碎了。一些在几个巨大的脚印坑里找到了，它们被踩死了，你懂的。 我还看见一些东西在树梢的阴影里移动，往另一个方向去了，我没跟着。 我发现有一只鹿撞在树上死了。 我想，管我看见的是什么我的心都害怕地发抖。 我已经竭尽所能。%SPEECH_OFF%他转过身来，掏出一吊子肉上面沾着树叶。%SPEECH_ON%有人饿了吗？%SPEECH_OFF%} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我觉得这是一趟地狱之旅。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Hunter.getImagePath());
				local item = this.new("scripts/items/supplies/cured_venison_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Hunter.getBaseProperties().Bravery += 1;
				_event.m.Hunter.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Hunter.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_hunter")
					{
						continue;
					}

					if (bro.getBackground().getID() == "background.wildman" || bro.getBackground().getID() == "background.barbarian")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 15)
					{
						bro.worsenMood(0.5, "担心外面有大事");
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_33.png[/img]{恐惧笼罩着营地，但是你把 %wildman% 叫到身边。 野人哼的一声揉揉鼻子，你的做法让他摸不着头脑。 他挑了挑眉毛看着你，你手舞足蹈的比划表明想让他去找到噪音。 你掏空心思表明清楚后，这家伙才嘟囔着跑进了树林。\n\n 你发誓他离你已经有一百多米远，但你还是能听到他在灌木丛中发出奔驰的声音，发出这世上最该死的噪音。 野狗停止了吠叫，但接着那地方传来了一声大的咆哮和狗的一小声惨叫。 你的人佛口蛇心的讨论着，你能感到大地在颤动。 之后颤动减弱了和叫声一起直到消失。 你开始担心起来，这时候野人回来了。 他做在营火旁打了个哈欠，一翻身就睡着了。 好像他就没出去过一样。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我想问题已经解决了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				_event.m.Wildman.improveMood(1.0, "睡个好觉");

				if (_event.m.Wildman.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Wildman.getMoodState()],
						text = _event.m.Wildman.getName() + this.Const.MoodStateEvent[_event.m.Wildman.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你环顾了一下战队。 一个年轻的 %recruit% 向后看。 他低下头避开你的眼神，好像他和自己内心争斗了一番，然后赶紧站起来。%SPEECH_ON%不用说了，队长。 我会找出这骚乱是什么的。%SPEECH_OFF%他收拾好，站在营火的光亮边缘，漆黑的森林在那头正望着他。 他再次低下头，拳头握了又松。%SPEECH_ON%好吧。好吧。%SPEECH_OFF%他抬头看看。%SPEECH_ON%就这么做吧。%SPEECH_OFF%他去了后你就再没见过这个人。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "派新手去也许不是一个好主意。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Expendable.getImagePath());
				local dead = _event.m.Expendable;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "失踪",
					Expendable = dead.getBackground().getID() == "background.slave"
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Expendable.getName() + "失踪了"
				});
				_event.m.Expendable.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Expendable.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Expendable);
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_33.png[/img]{你环顾了一下战队。 一个年轻的 %recruit% 向后看。 他低下头避开你的眼神，好像他和自己内心争斗了一番，然后赶紧站起来。%SPEECH_ON%不用说了，队长。 我会找出这骚乱是什么的。%SPEECH_OFF%他收拾好，站在营火的光亮边缘，漆黑的森林在那头正望着他。 他再次低下头，拳头握了又松。 他愤愤地迈步向前随即消失在阴影里。 过了段时间。他最终回来了。 他的衣服破烂不堪。 武器也不见了。 他唾沫横飞的讲了一个又一个故事。 什么魔戒，火山，巨鹰，满嘴疯言疯语。 不管他看到了什么，这家伙需要好好睡一觉了。 自从可怕的声音停下来后，他真得睡个好觉。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "睡吧孩子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Expendable.getImagePath());
				_event.m.Expendable.addXP(200, false);
				_event.m.Expendable.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Expendable.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				_event.m.Expendable.improveMood(3.0, "经历了一次极好的冒险");

				if (_event.m.Expendable.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Expendable.getMoodState()],
						text = _event.m.Expendable.getName() + this.Const.MoodStateEvent[_event.m.Expendable.getMoodState()]
					});
				}

				local items = _event.m.Expendable.getItems();

				if (items.getItemAtSlot(this.Const.ItemSlot.Mainhand) != null && items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Weapon) && !items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Legendary) && !items.getItemAtSlot(this.Const.ItemSlot.Mainhand).isItemType(this.Const.Items.ItemType.Named))
				{
					this.List.push({
						id = 10,
						icon = "ui/items/" + items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getIcon(),
						text = "你失去了 " + this.Const.Strings.getArticle(items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getName()) + items.getItemAtSlot(this.Const.ItemSlot.Mainhand).getName()
					});
					items.unequip(items.getItemAtSlot(this.Const.ItemSlot.Mainhand));
				}

				if (items.getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					items.getItemAtSlot(this.Const.ItemSlot.Head).setCondition(this.Math.max(1, items.getItemAtSlot(this.Const.ItemSlot.Head).getConditionMax() * this.Math.rand(10, 40) * 0.01));
				}

				if (items.getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					items.getItemAtSlot(this.Const.ItemSlot.Body).setCondition(this.Math.max(1, items.getItemAtSlot(this.Const.ItemSlot.Body).getConditionMax() * this.Math.rand(10, 40) * 0.01));
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen || !this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days < 20)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.SnowyForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_hunter = [];
		local candidates_wildman = [];
		local candidates_recruit = [];
		local others = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_hunter")
			{
				candidates_hunter.push(bro);
			}
			else if (bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
			else if (bro.getXP() == 0)
			{
				candidates_recruit.push(bro);
			}
			else
			{
				others.push(bro);
			}
		}

		if (candidates_hunter.len() == 0 && candidates_wildman.len() == 0 && candidates_recruit.len() == 0 || others.len() == 0)
		{
			return;
		}

		if (candidates_hunter.len() != 0)
		{
			this.m.Hunter = candidates_hunter[this.Math.rand(0, candidates_hunter.len() - 1)];
		}

		if (candidates_wildman.len() != 0)
		{
			this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		}

		if (candidates_recruit.len() != 0)
		{
			this.m.Expendable = candidates_recruit[this.Math.rand(0, candidates_recruit.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hunter",
			this.m.Hunter.getName()
		]);
		_vars.push([
			"wildman",
			this.m.Wildman ? this.m.Wildman.getName() : ""
		]);
		_vars.push([
			"recruit",
			this.m.Expendable ? this.m.Expendable.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Hunter = null;
		this.m.Wildman = null;
		this.m.Expendable = null;
	}

});

