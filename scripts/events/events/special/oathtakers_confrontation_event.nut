this.oathtakers_confrontation_event <- this.inherit("scripts/events/event", {
	m = {
		Bro1 = null,
		Bro2 = null,
		Bro3 = null
	},
	function create()
	{
		this.m.ID = "event.oathtakers_confrontation";
		this.m.Title = "在途中…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				if (this.World.Statistics.getFlags().getAsInt("OathbringerConfrontationTimesDelayed") > 0)
				{
					this.Text = "[img]gfx/ui/events/event_180.png[/img]{誓言守护者回来了。一个狰狞地笑着向前走来。%SPEECH_ON%我们是要见证年轻的安瑟姆的愿景，还是你们又要再次对神圣的领导权掉链子？%SPEECH_OFF%你看着你的队员做出了决定...}";
				}
				else
				{
					this.Text = "[img]gfx/ui/events/event_180.png[/img]{“我们还会再见面的”，他们说道，说得很温和就像老朋友一样，但是他们在玩真的，这是只有仇敌才会有的一种认真。 他们，那些誓言使者。现在就站在你的面前，身披闪亮的铠甲，趾高气昂并且武器出鞘，突显的仇恨，显示小安瑟姆死的真不是时候。  你本以为他们会人数更多一些，但是现在只有两个人在面对 %companyname%。向前跨出一步。 你看见小安瑟姆的下颌骨在他的脖子上晃悠。那个誓者使者点点头。%SPEECH_ON%我们分开那天我就知道再次遇到你就只是个时间问题。 我能看出来你们一直在打仗，我们也是一样。 很明显小安瑟姆的预言影响深远以至于整个世界都能见证我们最终某天宿命的相遇，考虑到那些强盗和绿皮怪物我们就不搞仪式了。 你和我都被命运保护着，披上了一种必然的不可战胜的外衣。 宣誓者。誓言使者。我们来一劳永逸地解决这个分歧吧。 接受小安瑟姆的裁决，选出你最强壮的战士，让我们来看看我们之间谁更有资格维护这神圣的誓言！%SPEECH_OFF%}";
				}

				local roster = this.World.getPlayerRoster().getAll();
				roster.sort(function ( _a, _b )
				{
					local score1 = _event.getBroScore(_a);
					local score2 = _event.getBroScore(_b);

					if (score1 > score2)
					{
						return -1;
					}
					else if (score1 < score2)
					{
						return 1;
					}

					return 0;
				});
				local e = this.Math.min(4, roster.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = roster[i];
					this.Options.push({
						Text = "{代表我们参与这场战斗 | 成为我们的冠军 | 夺回安瑟姆的颚骨 | 杀死这些誓言守护者}，" + bro.getName() + ".",
						function getResult( _event )
						{
							_event.m.Bro1 = bro;
							return "B";
						}

					});
					  // [054]  OP_CLOSE          0      5    0    0
				}

				this.Options.push({
					Text = "我们无法赢得这场战斗。放弃吧。",
					function getResult( _event )
					{
						if (this.World.Statistics.getFlags().getAsInt("OathbringerConfrontationTimesDelayed") > 0)
						{
							return "FightAvoided2";
						}
						else
						{
							return "FightAvoided1";
						}
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro1.getImagePath());

				if (_event.m.Bro2 != null)
				{
					this.Characters.push(_event.m.Bro2.getImagePath());
				}

				this.Text = "[img]gfx/ui/events/event_180.png[/img]誓者使者站在你面前，等待你挑选冠军。\n\n";

				if (_event.m.Bro2 != null)
				{
					this.Text += "你已经委派了 " + _event.m.Bro1.getName() + " 和 " + _event.m.Bro2.getName() + "去决斗。还有没有其他人可以帮助夺回小安瑟姆的下颌骨？";
				}
				else
				{
					this.Text += _event.m.Bro1.getName() + " 随时准备战斗。 谁能加入他？";
				}

				local raw_roster = this.World.getPlayerRoster().getAll();
				local roster = [];

				foreach( bro in raw_roster )
				{
					if (bro.getID() != _event.m.Bro1.getID() && (_event.m.Bro2 == null || bro.getID() != _event.m.Bro2.getID()) && (_event.m.Bro3 == null || bro.getID() != _event.m.Bro3.getID()))
					{
						roster.push(bro);
					}
				}

				roster.sort(function ( _a, _b )
				{
					local score1 = _event.getBroScore(_a);
					local score2 = _event.getBroScore(_b);

					if (score1 > score2)
					{
						return -1;
					}
					else if (score1 < score2)
					{
						return 1;
					}

					return 0;
				});
				local e = this.Math.min(4, roster.len());

				for( local i = 0; i < e; i = ++i )
				{
					local bro = roster[i];
					this.Options.push({
						Text = "{代表我们参与这场战斗 | 成为我们的冠军 | 夺回安瑟姆的颚骨 | 杀死这些誓言守护者}，" + bro.getName() + ".",
						function getResult( _event )
						{
							if (_event.m.Bro2 == null)
							{
								_event.m.Bro2 = bro;
								return "B";
							}
							else
							{
								_event.m.Bro3 = bro;
								local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
								properties.CombatID = "Event";
								properties.Music = this.Const.Music.NobleTracks;
								properties.IsAutoAssigningBases = false;
								properties.Entities = [];
								properties.Entities.push({
									ID = this.Const.EntityType.Oathbringer,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/humans/oathbringer",
									Faction = this.Const.Faction.Enemy
								});
								properties.Entities.push({
									ID = this.Const.EntityType.Oathbringer,
									Variant = 0,
									Row = 0,
									Script = "scripts/entity/tactical/humans/oathbringer",
									Faction = this.Const.Faction.Enemy
								});
								properties.Players.push(_event.m.Bro1);
								properties.Players.push(_event.m.Bro2);
								properties.Players.push(_event.m.Bro3);
								properties.IsUsingSetPlayers = true;
								properties.IsFleeingProhibited = true;
								_event.registerToShowAfterCombat("Victory", "Defeat");
								this.World.State.startScriptedCombat(properties, false, false, true);
								return 0;
							}
						}

					});
					  // [145]  OP_CLOSE          0      6    0    0
				}

				this.Options.push({
					Text = "我已经选好了所有我想选的人。 现在打败那些誓言使者！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.NobleTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.Entities.push({
							ID = this.Const.EntityType.Oathbringer,
							Variant = 0,
							Row = 0,
							Script = "scripts/entity/tactical/humans/oathbringer",
							Faction = this.Const.Faction.Enemy
						});
						properties.Entities.push({
							ID = this.Const.EntityType.Oathbringer,
							Variant = 0,
							Row = 0,
							Script = "scripts/entity/tactical/humans/oathbringer",
							Faction = this.Const.Faction.Enemy
						});
						properties.Players.push(_event.m.Bro1);

						if (_event.m.Bro2 != null)
						{
							properties.Players.push(_event.m.Bro2);
						}

						if (_event.m.Bro3 != null)
						{
							properties.Players.push(_event.m.Bro3);
						}

						properties.IsUsingSetPlayers = true;
						properties.IsFleeingProhibited = true;
						_event.registerToShowAfterCombat("Victory", "Defeat");
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Victory",
			Text = "[img]gfx/ui/events/event_87.png[/img]{两具躯体倒在地上，你总算卸下了心头的大石头。 不过…你觉得一切都会有所不同。 你并非对结果不满意，毕竟誓言使者已经不再对你构成威胁，但是你还是怅然若失。 这就好像你扑灭了一场即将烧毁你房子的大火，结果却发现你亲手扑灭的大火竟然是你在这个冰冷世界上唯一的温暖和慰藉。%SPEECH_ON%很好的解脱。%SPEECH_OFF%你的一个手下这样说道并朝尸体吐了一口唾沫。 盯着尸体，你意识到你开始沉迷于狩猎，沉迷于挑战，沉迷于不断变强。 你不会被一个威胁所拖累。 你曾经为了目标而战，而现在你已经迷失了。%randombrother% 弯腰捡起了小安瑟姆的下颌骨并且递给你。 你拿着它，把这部分拼接到小安瑟姆的颅骨上。 很轻松就拼接上去了，就好像长年的腐蚀磨损都没能使它们分开过。 大家欢呼起来。他们欢呼着宣誓者。 他们欢呼着你的名字。 他们为小安瑟姆欢呼在死后终于能被合为一体。 你最后一次看向誓言使者们并且点了点头。 他们也有目标，显然如此，但现在他们的目标已经完成了。 愿古神怜悯他们这些异教者的灵魂。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "致誓言使者之死…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();
				local found_skull = false;

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 75 || bro.getBackground().getID() == "background.paladin")
					{
						bro.improveMood(2.0, "夺回了小安瑟姆的下颌骨");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}

					local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

					if (item != null && item.getID() == "accessory.oathtaker_skull_01")
					{
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						found_skull = true;
						bro.getItems().unequip(item);
					}
				}

				if (!found_skull)
				{
					local stash = this.World.Assets.getStash().getItems();

					foreach( i, item in stash )
					{
						if (item != null && item.getID() == "accessory.oathtaker_skull_01")
						{
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "你失去了 " + item.getName()
							});
							stash[i] = null;
							found_skull = true;
							break;
						}
					}
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/accessory/oathtaker_skull_02_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Statistics.getFlags().set("OathbringerConfrontationTriggered", true);
			}

		});
		this.m.Screens.push({
			ID = "Defeat",
			Text = "[img]gfx/ui/events/event_87.png[/img]{你难以置信地看着你选择的战士被打倒在地。 你的大脑里飞快闪过一个念头想要干掉这个誓言使者，但是规矩就是规矩你不敢在一场公平决斗中违背小安瑟姆的誓言。 你看着一个誓言使者捡起小安瑟姆的下颌骨，把拇指插进下颚处，然后迅速地把这件圣物掰成两段。%SPEECH_ON%尽管我们赢了，甚至我们誓言使者都能看出来我们都有错误。 所以让分歧来解决分歧吧！ 我们立下的誓言失败了，并且环顾世界让我们在这个世界上找到真正的追随者…%SPEECH_OFF%那个誓言使者的目光从破碎的骨头间穿过盯着你，而他本人却因为已逝者的法令保护而使你徒呼奈何。%SPEECH_ON%只有小安瑟姆的指引得到了满足，他才能够被拼接成一个整体。%SPEECH_OFF%那个誓言使者转身离开。 你的心在不断闪过一个个念头想要在背后给他一刀，把小安瑟姆的遗体拼接完整，并且完成你的终极任务。 但这些念头最终还是全部烟消云散。 这么做会让你永受诅咒毁掉你最坚定的信念。 你只是看着那个誓言使者离开，你知道那个誓言和它所有的信徒也许终有一天能重现，但对于你来说已经是此生无望。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的！",
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
					if (this.Math.rand(1, 100) <= 75 || bro.getBackground().getID() == "background.paladin")
					{
						bro.worsenMood(1.5, "战团输给了誓约者。");

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

				this.World.Statistics.getFlags().set("OathbringerConfrontationTriggered", true);
			}

		});
		this.m.Screens.push({
			ID = "FightAvoided1",
			Text = "[img]gfx/ui/events/event_180.png[/img]{你的每一根神经都在反抗，但你还是拒绝了这场战斗。现实很简单： %companyname% 没有为这场战斗做好准备。毫不出奇地，誓言捍卫者并不特别高兴，事实上他们非常关心你会错过一次猎杀誓言布道者的机会。至于誓言布道者本身，在你离开时嘲笑着你。%SPEECH_ON%年轻的安塞姆(Anselm)看不到你的任何好处，誓言捍卫者们！你对他的幻象都是谎言！你们的整个存在都是谎言！我会说，在你们还能加入我们之前，加入我们吧，但我们不想和你们这些蠕虫有任何关系！%SPEECH_OFF%你祈祷在接下来的日子里，你能够向你的士兵证明你在这里做出了正确的决定。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这就是必然。",
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
					if (this.Math.rand(1, 100) <= 25 || bro.getBackground().getID() == "background.paladin")
					{
						bro.worsenMood(2.0, "你有机会却拒绝与誓言守护者战斗。");

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

				this.World.Statistics.getFlags().increment("OathbringerConfrontationTimesDelayed");
			}

		});
		this.m.Screens.push({
			ID = "FightAvoided2",
			Text = "[img]gfx/ui/events/event_180.png[/img]{战团还没有准备好。你担心他们会全部离开你，愤怒地离去，但你宁愿他们生气，也不愿看到他们躺在地下。心里沉重，听着队长的训话，你命令战团再次撤出战斗。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你还没准备好！",
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
					if (this.Math.rand(1, 100) <= 50 || bro.getBackground().getID() == "background.paladin")
					{
						bro.worsenMood(2.5, "你拒绝对抗誓约者，且已经有多次机会。");

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

				this.World.Statistics.getFlags().increment("OathbringerConfrontationTimesDelayed");
			}

		});
	}

	function getBroScore( bro )
	{
		local bro_score = 0;

		if (bro.getBackground().getID() == "background.paladin")
		{
			bro_score = bro_score + 2;
		}

		if (bro.getLevel() >= 11)
		{
			bro_score = bro_score + 5;
		}
		else if (bro.getLevel() >= 7)
		{
			bro_score = bro_score + 2;
		}
		else if (bro.getLevel() >= 5)
		{
			bro_score = bro_score + 1;
		}
		else
		{
			bro_score = bro_score - 3;
		}

		if (bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
		{
			bro_score = bro_score - 2;
		}

		if (bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
		{
			bro_score = bro_score - 5;
		}

		if (bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body) == null)
		{
			bro_score = bro_score - 5;
		}
		else
		{
			bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getCondition() < bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body).getConditionMax() / 2;
		}

		bro_score = bro_score - 2;
		return bro_score;
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

		if (this.World.Statistics.getFlags().get("OathbringerConfrontationTriggered"))
		{
			return;
		}

		if (this.World.Ambitions.hasActiveAmbition() && (this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_camaraderie" || this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_dominion" || this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_righteousness" || this.World.Ambitions.getActiveAmbition().getID() == "ambition.oath_of_vengeance"))
		{
			return;
		}

		local oathTimer = 6 + this.World.Statistics.getFlags().getAsInt("OathbringerConfrontationTimesDelayed") * 2;

		if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Normal)
		{
			oathTimer = oathTimer + 1;
		}
		else if (this.World.Assets.getCombatDifficulty() == this.Const.Difficulty.Easy)
		{
			oathTimer = oathTimer + 3;
		}

		if (oathTimer > this.World.Statistics.getFlags().getAsInt("OathsCompleted"))
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		this.m.Score = 1000;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Bro1 = null;
		this.m.Bro2 = null;
		this.m.Bro3 = null;
	}

});

