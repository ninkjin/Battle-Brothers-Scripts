this.undead_zombie_in_granary_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.undead_zombie_in_granary";
		this.m.Title = "在 %town%…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]你偶然碰到一个正大声呼救的人，歇斯底里叫着，似乎完全不在意会引起全副武装的佣兵的注意，明明佣兵不效忠于任何贵族家族或者他们制定的法律。%SPEECH_ON%拜托！帮助我！有一个…一具尸体！在谷仓里！%SPEECH_OFF%他抬起拇指朝身后一个巨大的木质建筑指了指。 建筑的前门好像回应似的刚刚好嘎吱响了起了。 那个人吓坏了。%SPEECH_ON%就是那个东西！那个怪物！ 拜托了，请去杀掉他！ 我们不能失去里面的所有食物！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "最好把谷仓烧掉。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
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
					Text = "我会派一个人进去处理掉这个事。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "D";
						}
						else
						{
							return "E";
						}
					}

				},
				{
					Text = "我们没有时间做这个。",
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
			Text = "[img]gfx/ui/events/event_30.png[/img]你抓住那个人的肩膀，盯着他说到。%SPEECH_ON%我们准备烧掉这个谷仓。 你听到了吗，里面到底有什么食物？ 我接下来要说的，听好了。 那里面的食物已经异变，不能再食用了。 没有什么需要挽救的。%SPEECH_OFF%那个农民好像受凉了般哆嗦着让开路。 他双手捂着脸，难以接受地看着你的两个佣兵拿着火把上前把谷仓点燃。\n\n那扇门一时停了下来，接着又开始发着咯吱声音打开，几乎要把铰链损坏了。 随着烟从底部冒出来，有什么人开始尖叫起来。%SPEECH_ON%开玩笑！开玩笑！ 拜托，让我出去！啊，啊啊！%SPEECH_OFF%%dude% 冲过去并砸开了那扇门。 一个小男孩跑出来，火炬一样燃着上半身，四肢扭动着带出弓型的火焰。 他一倒在地上，佣兵们就尝试扑灭他身上的火焰。 当火焰扑灭时，只留下了无声燃烧着的余烬。 那个农民看起来一定是吓坏了。%SPEECH_ON%我…不知道，我原以为那是…那东西一直在发出低嗥。%SPEECH_OFF%你对此摇摇头，告诉队伍迅速回去继续赶路。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，该死。",
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
					if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(0.5, "你让一个男孩被意外的烧死了");

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
			ID = "C",
			Text = "[img]gfx/ui/events/event_30.png[/img]毫无疑问那些食物如今已经在恶疾中损坏了，整座建筑可能都被人类无法估量的邪恶所感染。 你慢慢地向那个男人解释你将烧掉他的谷仓。 他没反对，只飞快点头。%SPEECH_ON%我知道了，我想，我只是不想亲自动手，或许是一直指望着有什么人不是来告诉我我应该做什么，而是说些我希望听到的话吧。%SPEECH_OFF%几个佣兵把火把放在谷仓角落，没过多长时间，火焰就蔓延到墙和屋顶上。 一分钟后整个建筑就已经在燃烧之中。 但前门毁坏后，一个僵尸拖着腿越过了沟口，他的整个身体都在火焰和烟雾里扭曲着。 骨头几乎都被烧黑了，皮肤粘稠的一块块从它的骨架上滴下来。%dude% 轻巧的把他的头砍了下来。 那个农民目睹着他剩下的谷仓倒塌，脸颊上的泪水在火光中明灭闪耀。%SPEECH_ON%好吧，我想就这样了。谢谢你，佣兵。%SPEECH_OFF%他给你一笔不多的克朗，你很乐意为你的“服务”而接受。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Gross.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.World.Assets.addMoney(50);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]50[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_79.png[/img]你决定就像是在战场上遭遇那样解决这个僵尸的问题。%dude% 踢开前门，刺中了看到的第一个东西。 那个亡灵尸体摇摇晃晃，冲击的势头让它的躯体朝着利刃弯曲着。 接着你看到：血沿着刃身慢慢滴落。 雇佣兵退后一步，亮光照出的尸体并不是亡灵，而是一个普通的男孩。 嘴里满是血，睁大了眼睛，双手对着伤口颤抖。%SPEECH_ON%我…我只是在这玩…%SPEECH_OFF%那名佣兵十分难过的抽出了武器。 小男孩倒下了。你转向农民。 他举起双手。%SPEECH_ON%我…我不知道！ 他弄出了响声！ 他一直，我听到了，在低嗥！ 一直在低嗥！我不知…%SPEECH_OFF%那人跪了下来。 你看向已经没救的小男孩，随着一道绯红的线从他的伤口中飞射而出他的皮肤变得更加苍白了。 你摇摇头，告诉你的人，在事情变得更糟之前，赶快回到路上去。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Dude.worsenMood(2.0, "意外杀了一个小男孩");

				if (_event.m.Dude.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Dude.getMoodState()],
						text = _event.m.Dude.getName() + this.Const.MoodStateEvent[_event.m.Dude.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_79.png[/img]你派 %dude% 去谷仓里解决这个问题。 他拍拍肩膀放松了一下。%SPEECH_ON%一个僵尸正在前来。%SPEECH_OFF%这个佣兵踢开门冲了进去。 当他和邪恶和黑暗斗争时，响起了武器的声音，同时雇佣兵武器上的金属闪过了一道光。 一会儿，他出来了，擦着额头上的汗水说到。%SPEECH_ON%解决了。有些食物溅了血，但是吃没问题。%SPEECH_OFF%你转向农民伸出手。 他不情愿的递给了你一小包克朗。%SPEECH_ON%谢谢你…雇佣兵。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.World.Assets.addMoney(50);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]50[/color] 克朗"
					}
				];
				_event.m.Dude.improveMood(0.25, "救了一个农民");

				if (_event.m.Dude.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Dude.getMoodState()],
						text = _event.m.Dude.getName() + this.Const.MoodStateEvent[_event.m.Dude.getMoodState()]
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

		local brothers = this.World.getPlayerRoster().getAll();
		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 2)
			{
				continue;
			}

			local d = playerTile.getDistanceTo(t.getTile());

			if (d < bestDistance)
			{
				bestDistance = d;
				bestTown = t;
			}
		}

		if (bestTown == null || bestDistance > 3)
		{
			return;
		}

		this.m.Town = bestTown;
		this.m.Dude = brothers[this.Math.rand(0, brothers.len() - 1)];
		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"town",
			this.m.Town.getName()
		]);
		_vars.push([
			"dude",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
		this.m.Dude = null;
	}

});

