this.supposed_witch_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null,
		Cultist = null,
		Witchhunter = null
	},
	function create()
	{
		this.m.ID = "event.supposed_witch";
		this.m.Title = "在路上…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]你穿过小路来到一个小村庄。 这是一个相当普通的地方，除了一个女人被绑在即将点燃的篝火处。 她被一群农民包围着，这是处于这种地位的女人通常的状况。 一个来自乌合之众的修道士诵读了一本圣经，显然是想更有道义性地让每个人都知道她的罪行。 另一名男子拿着火把筒尽职地站在旁边，他已经巴不得要动手了。\n\n 看到你，那个女人大喊救命。%SPEECH_ON%他们要把我烧了！ 你必须做点什么！ 我在这里没有做错任何事！%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们释放她。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 80)
						{
							return "Good";
						}
						else
						{
							return "Bad";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Witchhunter != null)
				{
					this.Options.push({
						Text = "一个女巫猎人对这事会说什么，%witchhunterfull%？",
						function getResult( _event )
						{
							return "Witchhunter";
						}

					});
				}

				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "古老神明有什么喻示，%monkfull%？",
						function getResult( _event )
						{
							return "Monk";
						}

					});
				}

				if (_event.m.Cultist != null)
				{
					this.Options.push({
						Text = "你奇怪的神会对此做些什么，%cultistfull%？",
						function getResult( _event )
						{
							return "Cultist";
						}

					});
				}

				this.Options.push({
					Text = "这不是我们的问题。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "[img]gfx/ui/events/event_79.png[/img]当一个无辜的女人因为虚构的罪行而被烧死时，你不会袖手旁观的。 手里拿着利刃，你爬上柴火堆，割断绳子救了她。 她急忙跑开，寻找安全的地点。 人群被激怒了，立刻向战队进攻。 农民和佣兵之间的混战对前者来说结局并不好，但却造成了一定的伤害。\n\n 因为失去了对人群的控制，你打了那个僧侣，还有那个拿火把的人。 有几个兄弟认为这么做是对的，他们很满意你的决定。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我希望她能找到一个安全的地方。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(3);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25)
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							local injury = bro.addInjury(this.Const.Injury.Brawl);
							this.List.push({
								id = 10,
								icon = injury.getIcon(),
								text = bro.getName() + " 遭受 " + injury.getNameOnly()
							});
						}
						else
						{
							bro.addLightInjury();
							this.List.push({
								id = 10,
								icon = "ui/icons/days_wounded.png",
								text = bro.getName() + "遭受轻伤"
							});
						}
					}

					if (this.Math.rand(1, 100) <= 25 && bro.getBackground().getID() != "background.witchhunter")
					{
						bro.improveMood(1.0, "你把一个女人从火刑柱上救了出来");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_79.png[/img]当一个无辜的女人因为虚构的罪行而被烧死时，你不会袖手旁观的。 手里拿着利刃，你爬上柴火堆，割断绳子救了她。 当她获救的时候，她俯下身来用手拥抱你。 她的皮肤光滑而无雀斑。%SPEECH_ON%谢谢你，佣兵。%SPEECH_OFF%她吻了你一下，感觉嘴唇像冰一样。 你看着她从柴火堆上飘下去。呃哦。\n\n 村里的僧侣往后退，试图躲在人群中，但女巫尖叫起来，把人群分开，只留下僧侣一个人在地上。 他慢慢地滑过泥土，然后站起来，就像被一种看不见的力量推着。 他试图再次后退，但是徒劳的。 她吻了他，就像吻你一样，但男人的眼睛在他的脑袋里翻滚，你看到他的血管充血，猛烈地泛着紫色，当他颤抖的时候，他全身的每一个毛孔都流出血来。 他尖叫着，但这声音马上消失了，女巫呻吟着把用嘴在吃他。 当她松开手时，他倒在地上，变成一具湿透的红色尸体。\n\n 村民们四散而去，而你的人则试图与邪恶作斗争。 她大笑着缩进衣服中央，斗篷裹成一团，从中射出一个咯咯叫的幽灵。 它飞到最近的树林边，很可能永远不会再被看到了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "噢，该死。",
					function getResult( _event )
					{
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(3);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 25 || bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk" || bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.mad"))
					{
						bro.worsenMood(1.0, "你释放了一个邪灵");

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
			ID = "Witchhunter",
			Text = "[img]gfx/ui/events/event_79.png[/img]%witchhunter% 带着怀疑的眼光向前走。 他看着那个拼命说“请”的女人。 女巫猎人上下打量着她，然后转过身，用一把利刃刺穿了那个拿着火把的人。 他把刀刺进那个人喉咙里，双手使劲想把刀拔出来。%SPEECH_ON%不要再胡闹了，你骗不了我的。%SPEECH_OFF%女巫猎人说道。 他猛地拔出了刀，手持火把的人在那里站了一会儿，但他睁大的眼睛慢慢地平静下来，“血”在一瞬间停止了。 他的脸变宽了，皮肤绷得紧紧的，就像一个木偶师把最可怕的玩偶融化了的脸。 它的声音在尖叫，每一个音节都是垂死的猫的音调。%SPEECH_ON%我不是最后一个！ 你们永远都摆脱不了我们！%SPEECH_OFF%与此同时，%witchhunter% 将他的武器插入恶魔的头骨。 在剥落之前，皮肤会像沙漠里的泥土一样变硬。\n\n 那个女人被减免罪行并被释放了。 这名僧侣被愤怒的暴民剥去法衣，因为他们无处可去。 他赤身裸体，受尽屈辱，因为他的错误指控而被赶出了村子。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真正的恶魔很擅长隐藏自己。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witchhunter.getImagePath());
				local resolve = 1;
				local initiative = 1;
				_event.m.Witchhunter.getBaseProperties().Bravery += resolve;
				_event.m.Witchhunter.getBaseProperties().Initiative += initiative;
				_event.m.Witchhunter.getSkills().update();
				_event.m.Witchhunter.improveMood(2.0, "杀了一个邪灵");

				if (_event.m.Witchhunter.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Witchhunter.getMoodState()],
						text = _event.m.Witchhunter.getName() + this.Const.MoodStateEvent[_event.m.Witchhunter.getMoodState()]
					});
				}

				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Witchhunter.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Witchhunter.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] 主动性"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() != _event.m.Witchhunter.getID() && (this.Math.rand(1, 100) <= 25 || bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk" || bro.getSkills().hasSkill("trait.superstitious")))
					{
						bro.improveMood(1.0, "看到一个邪灵被终结");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
			ID = "Monk",
			Text = "[img]gfx/ui/events/event_79.png[/img]这个僧侣，%monk%，和城镇的僧侣坐在一起谈了一会儿。 当他们完成时，向拿着火把负责点燃柴火堆的人点头。 女人尖叫着求饶，但火焰没有给她机柜，慢慢地，她的脚先动了起来。 这是一个可怕的场景，只有当烟雾变成令人窒息的云时，垂死的女人才会沉默。 当镇上的其他人都在欢呼雀跃时，大火把她烧得精光。%monk% 说她显然是个女巫，必须除掉。 你不确定。你所看到的只是一个被活活烧死的女人，但你相信他比你更了解古老的神明与巫术邪恶之间的战争。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "铲除邪恶绝非易事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				local resolve = this.Math.rand(2, 3);
				_event.m.Monk.getBaseProperties().Bravery += resolve;
				_event.m.Monk.getSkills().update();
				_event.m.Monk.improveMood(2.0, "有个女巫被烧死了");

				if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}

				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Monk.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() != _event.m.Monk.getID() && (bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk" || bro.getSkills().hasSkill("trait.superstitious")))
					{
						bro.improveMood(1.0, "看到一个女巫在火刑柱上燃烧");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
			ID = "Cultist",
			Text = "[img]gfx/ui/events/event_79.png[/img]%cultist% 走上前去，上下打量着村民。他摇了摇头。%SPEECH_ON%你们都该自杀。%SPEECH_OFF%村里的僧侣把斗篷晃的沙沙作响。%SPEECH_ON%你说啥？%SPEECH_OFF%异教徒开始释放女人。 你的一些雇佣兵站出来阻止任何人的抗议。 当她自由后，被允许逃往安全的地方，%cultist% 又说了一遍。%SPEECH_ON%自尽吧。你们每个人。今晚。 你们激怒了达库尔，他的愤怒是你们最好的债务。%SPEECH_OFF%僧侣张开嘴想说点什么，但他的鼻子裂开了，就像被一块看不见的石头压出的凹痕。 他踉踉跄跄，鼻孔里血流不止。%cultist% 点头。%SPEECH_ON%哼，他比我想象的更生气。 达库尔即将降临到我们，但他现在就在你们的门前。%SPEECH_OFF%僧侣尖叫着倒在了地上，下巴裂成两半，嘴巴永远半掩着。 村民们尖叫着四散而逃就像兔子看到了鹰的影子。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Disturbing.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				local resolve = 2;
				_event.m.Cultist.getBaseProperties().Bravery += resolve;
				_event.m.Cultist.getSkills().update();
				_event.m.Cultist.improveMood(2.0, "见证了达库尔的力量");

				if (_event.m.Cultist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}

				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Cultist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() != _event.m.Cultist.getID() && (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist"))
					{
						bro.improveMood(1.0, "见证了达库尔的力量");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().getID() == "background.witchhunter" || bro.getBackground().getID() == "background.monk" || bro.getSkills().hasSkill("trait.superstitious"))
					{
						bro.worsenMood(1.0, _event.m.Cultist.getName() + " 释放了一个女巫");

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
		if (this.World.getTime().Days <= 15)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
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
		local candidate_witchhunter = [];
		local candidate_monk = [];
		local candidate_cultist = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.witchhunter")
			{
				candidate_witchhunter.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk")
			{
				candidate_monk.push(bro);
			}
			else if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				candidate_cultist.push(bro);
			}
		}

		if (candidate_witchhunter.len() != 0)
		{
			this.m.Witchhunter = candidate_witchhunter[this.Math.rand(0, candidate_witchhunter.len() - 1)];
		}

		if (candidate_monk.len() != 0)
		{
			this.m.Monk = candidate_monk[this.Math.rand(0, candidate_monk.len() - 1)];
		}

		if (candidate_cultist.len() != 0)
		{
			this.m.Cultist = candidate_cultist[this.Math.rand(0, candidate_cultist.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"witchhunter",
			this.m.Witchhunter != null ? this.m.Witchhunter.getNameOnly() : ""
		]);
		_vars.push([
			"witchhunterfull",
			this.m.Witchhunter != null ? this.m.Witchhunter.getName() : ""
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"monkfull",
			this.m.Monk != null ? this.m.Monk.getName() : ""
		]);
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
		_vars.push([
			"cultistfull",
			this.m.Cultist != null ? this.m.Cultist.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Witchhunter = null;
		this.m.Monk = null;
		this.m.Cultist = null;
	}

});

