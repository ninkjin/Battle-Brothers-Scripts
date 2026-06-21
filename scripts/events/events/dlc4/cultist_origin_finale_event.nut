this.cultist_origin_finale_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Sacrifice = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_finale";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]%cultist% 进入你帐篷，一阵强劲、凛冽的风紧随其后，刮起你的卷轴和其他文件。 他走上前，双手交叉在胸前，看起来相当虔诚地走近。%SPEECH_ON%先生，我被喻示了，而且是件我被赋予责任的大事。%SPEECH_OFF%你举起手来，叫他安静。 小心地，你走到帐篷里的每一根蜡烛前面，把它们一一熄灭，直到有一根还剩下。 你把蜡烛拿到面前…",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "对我说话，达库尔。",
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
			Text = "[img]gfx/ui/events/event_33.png[/img]你跪在蜡烛前，把手放在火焰上，火就停了下来，笔直而不动。 你见过的冰柱似乎比它更生动。 你凝视着夜光，帐篷融化了，堕入一片无尽的黑暗中。 异教徒离开了。 在他的之前的位置上是一件黑色斗篷，它保护你的双肩，一片花岗岩作为头部，它的边缘破碎并裂开着。 在这张面具的背后似乎有什么东西，在这徒劳的努力背后保护你的思想不受其真实面目的影响。 你伸手去拿面具，但是一些看不见的力量阻止了你。%SPEECH_ON%在一个好时候，你会看到我的全部。%SPEECH_OFF%这声音是隆隆的，但变小成一种只有你才能听到的粗野的低语。%SPEECH_ON%我将赐予你死亡，凡人，和它温暖的慰藉，死亡将会造访你的敌人们。%sacrifice% 不会消失，他与你同在，这是我向你保证的。%SPEECH_OFF%一股白浪卷回你身上，一阵狂风，帐篷的襟翼向外卷曲，蜡烛的火焰倾斜着，难以置信的没有熄灭，当你开始用喉咙呼吸的时候，感到阵阵凉意。%cultist% 不见了踪影。 你迅速站起来，触摸你的脸和皮肤，确保你就是你本来的样子。 令你失望的是，达库尔走了，而你还是你。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这场献祭一定要进行。",
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
			Text = "[img]gfx/ui/events/event_33.png[/img]达库尔会对你的不服从感到最不高兴，不是因为你除了按要求去做之外，还有其他的要求。 你和 %cultist% 一起去了 %sacrifice%的帐篷。 他探起身子，就好像已经在等着你了，他看着你们部队马车上的刀，目光坚定的点头。%cultist% 跪在这个人旁边，你意识到他们在此之前已经谈过了，这个问题对你来说很可能是对你是否忠于达库尔的考验。 你很高兴你通过了考验。\n\n%sacrifice% 解开了他的衬衫扣子，%cultist% 刺穿了他的胸膛，就好像他把钥匙插进了锁里一样，他还是拧开了锁。 这种献祭让人喘不过气来，也让人紧张，因为任何对达库尔的忠诚都无法抛开死亡的可能，那是一种痛苦和折磨。 但他微笑着，眼中的光芒并没有很快消失，一种你从未见过的黑暗，取代了它。 就这样，他死了。\n\n %cultist% 开始在仍然温暖的尸体上工作，沿着皮肤和坚硬的肌肉把尸体上的肉快速切成薄片。 他把尸体的胸腔拉开。 刀锋的每一个动作都带着一团黑雾，似乎在每一个动作之后都欢快地摇摆着。当 %cultist% 完成后，%sacrifice% 变成了一块盔甲，肉体被撕裂和拉伸，牙齿变成了铆钉，肌腱变成了捆扎带，骨头变成了肩甲，一个绝对屠杀的胸甲。 它像脉搏一样跳动着，好像它仍然有生命力一样。%cultist% 转向你，双手被鲜血染红了。%SPEECH_ON%达库尔即将降临到我们。%SPEECH_OFF%你点头并拥抱你的战友。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "它被做出来了，而且它很好。",
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
				this.World.getPlayerRoster().remove(_event.m.Sacrifice);
				this.World.Assets.getStash().makeEmptySlots(1);
				local item = this.new("scripts/items/armor/legendary/armor_of_davkul");
				item.m.Description = "达库尔(Davkul)的一个可怕方面，这是来自异世界的古老力量，以及最后的遗迹。" + _event.m.Sacrifice.getName() + " 是由身体制成的。它永远不会破裂，而是在原地不断地再生它那伤痕累累的皮肤。";
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
			Text = "[img]gfx/ui/events/event_33.png[/img]你觉得这是个考验。 没有人会用牺牲其中一个战友的方法来通过考验，这是绝对应该反对的。 达库尔可能派了错误的信徒来查看你是否按他们说的做了，仅仅因为他们说过。 你不知道你是怎么知道这些的，你只知道，这正是一个男人最应该遵循的。 正当你准备告诉 %cultist% 你的决定时，房间里的一半蜡烛突然熄灭了。 缕缕青烟在残留的黑暗中飘荡，那是一种扭曲的烟雾，你发誓，在那烟雾中，你能看到一张发黑的脸，一会儿就从帐篷的出口消失了。 你会有这样一种感觉，%cultist% 早就已经知道你的选择了。 你呆在帐篷里，等着达库尔的出现。 当感觉不到的时候，你只是再次点燃蜡烛，对着空无一人的房间说话。%SPEECH_ON%达库尔即将降临到我们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "还有和他在一起的，黑暗。",
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days <= 150)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
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

				if (bro.getLevel() >= 11)
				{
					sacrifice_candidates.push(bro);
				}
			}
		}

		if (cultist_candidates.len() <= 5 || bestCultist == null || bestCultist.getLevel() < 11 || sacrifice_candidates.len() < 2)
		{
			return;
		}

		for( local i = 0; i < sacrifice_candidates.len(); i = ++i )
		{
			if (bestCultist.getID() == sacrifice_candidates[i].getID())
			{
				sacrifice_candidates.remove(i);
				break;
			}
		}

		this.m.Cultist = bestCultist;
		this.m.Sacrifice = sacrifice_candidates[this.Math.rand(0, sacrifice_candidates.len() - 1)];
		this.m.Score = cultist_candidates.len();
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

