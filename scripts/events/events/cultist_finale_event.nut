this.cultist_finale_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Sacrifice = null
	},
	function create()
	{
		this.m.ID = "event.cultist_finale";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]%cultist% 进入你帐篷，一阵强劲、凛冽的风紧随其后，刮起你的卷轴和其他文件。 他走上前，双手交叉在胸前，看起来相当虔诚地走近。%SPEECH_ON%先生，我被喻示了，而且是件我被赋予责任的大事。%SPEECH_OFF%你问他到底在说谁。 异教徒虔诚的向前鞠躬只敢低声下气的说话。%SPEECH_ON%达库尔，先生。%SPEECH_OFF%唉，当然，还有谁？ 你让他解释一下他到底需要什么。这个人回答道。%SPEECH_ON%不，不是我，是达库尔。 达库尔是救世主-他需要鲜血和祭品。%SPEECH_OFF%你告诉那个人，如果事情如此重要，战队可以在下一个城镇停一下，买些鸡、羊或者他需要的任何东西。%cultist% 摇了摇头。%SPEECH_ON%某个淘气野兽的血？ 不，他要的是勇士的血。 他有真正的战斗精神，他相信我能找到一个如此重要的人－而我确实找到了。%SPEECH_OFF%异教徒直起身子，帐篷里的烛光突然变幻无常。%SPEECH_ON%达库尔需要鲜血，需要牺牲 %sacrifice%。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我是否该同意这种疯狂的做法呢？",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]走到一根摇曳的蜡烛前，%cultist% 将手放在火焰上，火焰静止不动，笔直的指向上方。 你见过的冰柱似乎比它更生动。 他凝视着火光。%SPEECH_ON%如果我们这样做，达库尔会很高兴的。 如果不，那好吧，我们走着瞧。 甚至我都不知道那时候会发生什么事。%SPEECH_OFF%你告诉异教徒，他要你去杀自己的队员。 他需要更强大才行。 听到这话，他走过来抓住你的肩膀。 帐篷渐渐融化，消失在无边无际、永恒不变的黑暗之中。 异教徒离开了。 在他的之前的位置上是一件黑色斗篷，它保护你的双肩，一片花岗岩作为头部，它的边缘破碎并裂开着。 在这张面具的背后似乎有什么东西，在这徒劳的努力背后保护你的思想不受其真实面目的影响。 一个声音在说话，一个喉音，洪亮的声音，却又变细成却又变窄成只有你能听到的粗野的低语。%SPEECH_ON%我将赐予你死亡，凡人，和它温暖的慰藉，死亡将会造访你的敌人们。%sacrifice% 不会消失，他与你同在，这是我向你保证的。%SPEECH_OFF%一阵白茫茫的风迎面扑来，帐篷的顶篷向外卷起，烛光不可思议地没有熄灭，空气中弥漫着你第一次呼吸时的那种冰冷的凉意。%cultist% 不见了。 你迅速站起来，触摸你的脸和皮肤，确保你就是你本来的样子。 然而，幻象依然存在，其波动的印记留下了一个可怕的现实问题，需要认真衡量异教徒提出的建议。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做必须要做的事。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "绝对不行！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]你让自己变得心如铁石，因为如果不从，达库尔肯定会不高兴。 但是 %sacrifice% 也获得了你的一句道别。 收拾好你的脸，走出帐篷，去和那个人说话。 也许仅仅是听到他的声音，也会在你的脑海中产生堕入无尽深渊的疯狂场景，这些毫无疑问是被召唤出来的。\n\n 当你到达他的帐篷时，你会注意到它的帆布门已经打开，并在风中轻轻飘动。 你走进去，发现佣兵躺在床上，身上盖着毯子。 你坐下来，说了几句话，内心深处希望他会在你们中间醒来。%SPEECH_ON%你做得很好，%sacrifice_short%，比我要求的还要好。 %companyname% 中的真正男儿，任何一位队长都会引以为傲的斗士。\n\n嘿，别让我在这儿闲扯。 我知道你会醒的，你这只百灵鸟。%SPEECH_OFF%你伸手去拿毯子，把它拉回来。 你跳了起来，几乎把整个帐篷都撞倒了。 躺在床上的不是 %sacrifice%，而是而是一具躯干，它的肉被撕成碎片，缠在不知名的金属制成的盔甲上，牙齿用来做铆钉，肌腱用来做皮带，骨头用来做肩铠，这绝对是一副杀戮的铠甲。%cultist% 站在帐篷的入口处。%SPEECH_ON%达库尔非常高兴，死亡为我们带来光明。%SPEECH_OFF%这…不是你所期望的。 你甚至不知道你在期待什么，但现在这一切无法想象和接受。 过去的事无法挽回，愿 %sacrifice% 的灵魂安息。 你不会再这么做了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "愿古老的神明今晚不会看到我。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sacrifice.getImagePath());
				local dead = _event.m.Sacrifice;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "献祭给达库尔",
					Expendable = dead.getBackground().getID() == "background.slave"
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Sacrifice.getName() + "是死了"
				});
				_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Sacrifice.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Sacrifice);
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/armor/legendary/armor_of_davkul");
				item.m.Description = "达库尔(Davkul)的恐怖面相，这是一种来自异世界的古老力量，也是最后的遗迹。" + _event.m.Sacrifice.getName() + "它从一个人的身体塑造而来，永远不会破裂，而是在原地不断地再生它那伤痕累累的皮肤";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						bro.improveMood(2.0, "抚慰达库尔");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else
					{
						bro.worsenMood(3.0, "被死亡吓坏了，死的是 " + _event.m.Sacrifice.getName());

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
			ID = "D",
			Text = "[img]gfx/ui/events/event_33.png[/img]尽管你刚刚目睹了可怕的事情，你仍然决定 %sacrifice% 应该活下来。 正当你准备去告诉 %cultist% 这件事时，房间里一半的蜡烛突然熄灭了。 缕缕青烟袅袅而上，像一团扭曲的烟雾，你发誓你只在片刻之间，能看到一张棱角分明、怒火如焚的面容，转眼便消失不见了。 你会有这样一种感觉，%cultist% 早就已经知道你的选择了。 你呆在帐篷里，把倒下的蜡烛重新点上了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "在路上的某个地方，战队走错了方向。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						bro.worsenMood(2.0, "被剥夺了抚慰达库尔的机会");

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

		if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 12)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local sacrifice_candidates = [];
		local cultist_candidates = [];
		local bestCultist;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				cultist_candidates.push(bro);

				if ((bestCultist == null || bro.getLevel() > bestCultist.getLevel()) && bro.getBackground().getID() == "background.cultist")
				{
					bestCultist = bro;
				}
			}
			else if (bro.getLevel() >= 11 && !bro.getSkills().hasSkill("trait.player") && !bro.getFlags().get("IsPlayerCharacter") && !bro.getFlags().get("IsPlayerCharacter"))
			{
				sacrifice_candidates.push(bro);
			}
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist.getName()
		]);
		_vars.push([
			"sacrifice",
			this.m.Sacrifice.getName()
		]);
		_vars.push([
			"sacrifice_short",
			this.m.Sacrifice.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
		this.m.Sacrifice = null;
	}

});

