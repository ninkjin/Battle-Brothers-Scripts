this.wardogs_fight_each_other_event <- this.inherit("scripts/events/event", {
	m = {
		Houndmaster = null,
		Otherbrother = null,
		Wardog1 = null,
		Wardog2 = null
	},
	function create()
	{
		this.m.ID = "event.wardogs_fight_each_other";
		this.m.Title = "露营时…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_37.png[/img]一连串的狗吠声，接着是压抑的低吼，打断了你的工作。 你离开帐篷看见两条战犬，%randomwardog1% 和 %randomwardog2%在打架。 他们咬在一起争锋相对谁也不让谁。 几个队友试图劝架，但每次当他们出手干预时，战犬就会短暂分开同时向劝架的人咆哮，好像在说这是它们之间的战斗，谁也不许插手。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让猎犬自己解决吧。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "谁上去把猎犬分开！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Houndmaster != null)
				{
					this.Options.push({
						Text = "%houndmaster% 你是驯兽师，把它处理好了！",
						function getResult( _event )
						{
							return "I";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_37.png[/img]你选择后退一步不去干预它，顺其自然。 等到战斗结束，分出胜负，你再视情况而定。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "哦？",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 20)
						{
							return "E";
						}
						else if (r <= 35)
						{
							return "F";
						}
						else
						{
							return "G";
						}
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_37.png[/img]你冲着 %otherbrother% 喊把那两条狗分开。 他拿起一根长棍子，捣进激烈的混战中，试图把它们分开。 当棍子夹在混战的两狗中间时，它们大叫起来。 其中一只咬住了棍子一头，把它往前一扯，那个可怜的劝架队友被拖进了战场。 人和兽混战着，都在为自己拼命。 当战斗结束，你在估算谁还会活着。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "哦？",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 10)
						{
							return "E";
						}
						else if (r <= 50)
						{
							return "F";
						}
						else if (r <= 90)
						{
							return "G";
						}
						else
						{
							return "H";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Otherbrother.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_37.png[/img]不幸的是，两条狗都死了。 它们死的时候，嘴上咬着血淋淋的皮毛，每个人都分享着胜利和失败的经验。 你让 %randombrother% 埋葬它们的尸体，以免尸体的气味引来愤怒的野兽。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可怜的动物们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wardog1.getIcon(),
					text = "你失去了 " + _event.m.Wardog1.getName()
				});
				this.World.Assets.getStash().remove(_event.m.Wardog1);
				_event.m.Wardog1 = null;
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wardog2.getIcon(),
					text = "你失去了 " + _event.m.Wardog2.getName()
				});
				this.World.Assets.getStash().remove(_event.m.Wardog2);
				_event.m.Wardog2 = null;
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_27.png[/img]战斗结束后，你让 %randombrother% 看看战犬。 当他走近时，它们咆哮着，但没有进一步动作，它们早已斗到精疲力尽。 他报告说，狗儿有几颗牙齿坏了，每只都有点瘸了，但它们不是真的瘸了。 随着时间的推移，他们会变得像没瘸的一样能够战斗。 我希望，别再打架了…",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "本性使然。",
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
			ID = "G",
			Text = "[img]gfx/ui/events/event_37.png[/img]一只战犬一瘸一拐地从混战中逃离，留下一只死狗。 胜利者甚至没有吃或尝试吃失败者，这表明你需要重新认识一下这些动物。 你让 %randombrother% 照顾活下来的狗，而其他几个兄弟埋葬死狗的尸体。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可怜的动物。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.Wardog1.getIcon(),
					text = "你失去了 " + _event.m.Wardog1.getName()
				});
				this.World.Assets.getStash().remove(_event.m.Wardog1);
				_event.m.Wardog1 = null;
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_34.png[/img]%otherbrother% 设法在这两条狗互相残杀之前将它们分开。 不幸的是，他付出了沉重的代价。 他会活下来，但你发现他现在对狗充满戒备。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "它们是凶猛的野兽，好吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Otherbrother.getImagePath());
				local injury = _event.m.Otherbrother.addInjury(this.Const.Injury.DogBrawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Otherbrother.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_27.png[/img]你就命令驯兽师 %houndmaster% 做点什么阻止它们。 他点头，向前走去，平静地走在两只斗狗之间。 它们互相吠叫，互相攻击，但两狗都停下来看着进来的人。 一只在咆哮，但实际上慢慢坐下。 另一只后退了，它的尾巴拼命地摇着，虽然它任然有怒气。 那驯兽师蹲下来，摸摸狗头。 一只狗低下头，另一只跟着。\n\n 他慢慢地把两只狗拉在一起，先摸了摸鼻子，然后低声对它们说。 慢慢的，不错所料，狗的狂暴因子消失了，它们的温顺的性情似乎更适合看孩子，而不是在一个铁血交织的雇佣兵团战斗。 驯兽师站了起来，狗很高兴地跟着他。他点头。%SPEECH_ON%哈哈，只是狗儿之间的小吵闹。%SPEECH_OFF%他说完就走了，而队伍里的其他人惊掉下巴地看着他，就像是看到一种德鲁伊魔法。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这个大师的确手艺高超。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_houndmaster = [];
		local candidates_other = [];
		local candidates_wardog = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.houndmaster")
			{
				candidates_houndmaster.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();

		foreach( item in stash )
		{
			if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
			{
				candidates_wardog.push(item);
			}
		}

		if (candidates_wardog.len() < 2)
		{
			return;
		}

		this.m.Otherbrother = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_houndmaster.len() != 0)
		{
			this.m.Houndmaster = candidates_houndmaster[this.Math.rand(0, candidates_houndmaster.len() - 1)];
		}

		local r = this.Math.rand(0, candidates_wardog.len() - 1);
		this.m.Wardog1 = candidates_wardog[r];
		candidates_wardog.remove(r);
		r = this.Math.rand(0, candidates_wardog.len() - 1);
		this.m.Wardog2 = candidates_wardog[r];
		this.m.Score = candidates_wardog.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"otherbrother",
			this.m.Otherbrother.getName()
		]);
		_vars.push([
			"houndmaster",
			this.m.Houndmaster != null ? this.m.Houndmaster.getNameOnly() : ""
		]);
		_vars.push([
			"randomwardog1",
			this.m.Wardog1 != null ? this.m.Wardog1.getName() : ""
		]);
		_vars.push([
			"randomwardog2",
			this.m.Wardog2 != null ? this.m.Wardog2.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Houndmaster = null;
		this.m.Otherbrother = null;
		this.m.Wardog1 = null;
		this.m.Wardog2 = null;
	}

});

