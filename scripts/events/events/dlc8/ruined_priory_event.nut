this.ruined_priory_event <- this.inherit("scripts/events/event", {
	m = {
		InjuryBro = null
	},
	function create()
	{
		this.m.ID = "event.ruined_priory";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_40.png[/img]{你发现一个僧侣站在一个修道院前。建筑的墙壁已经破碎，石块从地基上破裂，较小的石头在随后的坍塌中被化为粉末。他解释说，一场地震使整个地方都被推移了，破碎了大块物体，几乎使整个地方倒塌。他叹了口气。%SPEECH_ON%最糟糕的不仅仅是物质损失，最糟糕的是这场地震使信徒们受到了影响，他们没有了应对日常苦难的抵抗力。他们还没有回到我这里，因为他们担心旧神选择我们的地盘作为一种惩罚，针对他们之前未曾实现的错误。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们有黄金。你可以用2500克朗重建吗？",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 80 ? "B" : "C";
					}

				},
				{
					Text = "我们有工具。我想40个就足够了？",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 75 ? "D" : "E";
					}

				},
				{
					Text = "这不是我们的问题。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_40.png[/img]{你付给这个僧侣一些钱来修理修道院。他哭了起来，说他从没想到这个世界上还有这样有道德的人，更不用说亲自来见他了。你来到这里，而且如此慷慨，肯定是古老的神明没有惩罚他。%SPEECH_ON%这些克朗不仅可以让我重建，而且这样的慷慨将被当地人视为古老的神并没有惩罚我们的证据！这个，请拿去吧。它勉强在废墟中幸存下来，但也许你在以后能够比我们更好地利用它。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "工作而已。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(6);
				this.World.Assets.addMoney(-2500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]2500[/color] 克朗"
				});
				local item = this.new("scripts/items/weapons/noble_sword");
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(60, 80) * 0.01));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin")
					{
						bro.improveMood(0.75, "该战团帮助修复了一个修道院。");
					}
					else if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.5, "该战团帮助修复了一个修道院。");
					}

					if (bro.getMoodState() > this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 11,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你轻轻地在修道士的肩膀上拍了一下。他回过头，眼眶含泪地看了你一眼，然后瞥了一眼你伸出的皇冠钱袋。他拿起来，像他一生中从未得到过礼物一样温柔地握着它。%SPEECH_ON%这...这是用来修道院的吗？%SPEECH_OFF%你点了点头，告诉他用来重建这个地方。你还想建议加一个简单的钟楼，但就在你说起不太好的建筑涵义的时候，一个人沿着路尖叫着跑了过来，指着那名骗子的方向，脚踩着重重的步伐。%SPEECH_ON%千万别相信那只老鼠了！他是一个无耻的乞丐！%SPEECH_OFF%当你回头看时，那个所谓的修士已经跑开了，在跑道上飞奔，然后跳过一片荨麻和树丛消失不见，钱还在他的手中，笑声飘荡在空气中。这个人沿着路走了过来，举起双手。%SPEECH_ON%那个狡猾的家伙已经装病好几周了，这栋建筑物已经废弃十年了，自从绿皮兽破坏之后就没人住过了。我知道你们只是想做对的事，但这个世界上有很多人把你的慷慨视为一个大靶子。抱歉你们被骗了，伙计们。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Fark.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-2500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]2500[/color] 克朗"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin" && this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(0.5, "该战团的善良被人利用了。");
					}
					else
					{
						bro.worsenMood(0.75, "战团被一个江湖骗子骗走了一些克朗。");
					}

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

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_85.png[/img]{你认为%companyname%有完成任务的工具和人力。微笑着，你告诉僧侣们，他们将开始整修修道院。这位神圣的人被你和誓言者们感染了兴奋的情绪，一起整装待发开始工作。虽然耗费了几个小时的心血，但得到了回报。当你们完成时，一群农民出现了，他们不仅想起了祖先的信仰，也开始传颂%companyname%。毫无疑问，未来几天有许多人会听到誓言者们的故事。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该是这样的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(6);
				this.World.Assets.addBusinessReputation(100);
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				this.World.Assets.addArmorParts(-40);
				this.List.push({
					id = 11,
					icon = "ui/icons/asset_supplies.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]40[/color] 工具和补给"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin")
					{
						bro.improveMood(1.0, "帮助修复一座受损修道院。");
					}
					else
					{
						bro.improveMood(0.75, "帮助修复一座受损修道院。");
					}

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 11,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_40.png[/img]{你抓住那个僧侣，将他拉起来。你告诉他%companyname%会修复修道院。他激动地落泪了，尽管警告说这也许已经无法挽救。你微笑着，告诉他没有什么是誓言者做不到的。几秒钟后，%injurybro%向损坏的墙壁用力推，但是只听到下半部分发出的声音，最终把他压在瓦砾中。战团中的人们惊恐喊叫，赶去救他。随着他们的救援，整栋建筑物也崩塌了，石粉在一片哀鸣中散落。%injurybro%从瓦砾堆中获救，但带有相当沉重的伤害。%SPEECH_ON%好吧，我想这么做也算是有心吧。%SPEECH_OFF% 僧侣挠了挠头,%SPEECH_ON%也许是老神灵真的想惩罚我们。但无论如何，我认为你还是对的，尝试总是值得的，不是吗？我将为你，%companyname%，说好话。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那本来可以更好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(3);
				this.World.Assets.addBusinessReputation(35);
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				_event.m.InjuryBro.addHeavyInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.InjuryBro.getName() + "遭受重伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_64.png[/img]{你决定这不是你的事业。这个选择让一些人开始质疑你的领导能力。当然，誓言并非总是能够随时遵守，但连一滴汗水或一枚克朗都不肯为一个神圣之人和他的信徒效力？正是在忽视那些不需付出力气的小事情上，使一个人开始变得无情。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是的，是的。",
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
					if (bro.getBackground().getID() == "background.paladin")
					{
						bro.worsenMood(0.75, "你拒绝帮助一个需要帮助的和尚。");
					}
					else if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(0.5, "你拒绝帮助一个需要帮助的和尚。");
					}

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

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		if (this.World.Assets.getMoney() < 3000)
		{
			return;
		}

		if (this.World.Assets.getArmorParts() < 40)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		this.m.InjuryBro = brothers[this.Math.rand(0, brothers.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"injurybro",
			this.m.InjuryBro.getName()
		]);
	}

	function onClear()
	{
		this.m.InjuryBro = null;
	}

});

