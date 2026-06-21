this.retired_gladiator_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Gladiator = null,
		Name = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.retired_gladiator";
		this.m.Title = "在 %townname%…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你在街上碰到一位老人。 他并不突出，除开他拥有一副非常不错的装备。 有点破旧了，但还不错。 当然，他作为一个老人还有这些东西不是他偷来的还能意味着别的什么。%SPEECH_ON%逐币者盯着，逐币者寻思着。%SPEECH_OFF%他一边说一边啃了一口面包。他抬头看着你。%SPEECH_ON%我的名字是 %retired%。我曾经在竞技场战斗，但是五年前退休了。 不是我选的，注意。 我拿到一个故意输掉的任务，但与之相对的我斩首了我的对手。 这个对手是维齐尔的一个儿子。 这个信息并没有被分享给我。 我刚才说的这五年？ 花在了地牢里。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们可以用上你。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "好吧，祝你好运。",
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
			Text = "[img]gfx/ui/events/event_163.png[/img]{你告诉他可以来 %companyname%。他笑道。%SPEECH_ON%战斗的年华对我而言已经是过去了。 我打算把这幅盔甲卖个好价钱然后永远离开这个城市。%SPEECH_OFF%他把盔甲转向前。%SPEECH_ON%你没法在任何地方找到这样的装备。 我只要1000克朗，一个角斗士的甲胄，你在什么普通铁匠铺可找不到这样的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们要这个盔甲，这是1000克朗。",
					function getResult( _event )
					{
						return "BuyArmor";
					}

				},
				{
					Text = "不了，谢谢，我们没事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Gladiator != null)
				{
					this.Options.push({
						Text = "或许 %gladiator% 能说服你加入我们。",
						function getResult( _event )
						{
							return "Gladiator";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "BuyArmor",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你把钱交给他，然后他把盔甲交给你。 他掂量着装着克朗的钱袋。%SPEECH_ON%我想这些足够我度过退休生活了。 武器最好留着。 这片土地可不是特别安全，一个像我一样危险的老人也可能需要点保护。%SPEECH_OFF%他说的没错。 你祝他好运并把盔甲放进了仓库。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "旅途平安。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local a = this.new("scripts/items/armor/oriental/gladiator_harness");
				local u = this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade");
				a.setUpgrade(u);
				this.List.push({
					id = 12,
					icon = "ui/items/armor_upgrades/upgrade_25.png",
					text = "你获得了一个 " + a.getName()
				});
				this.World.Assets.getStash().add(a);
				this.World.Assets.addMoney(-1000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]1,000[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Gladiator",
			Text = "[img]gfx/ui/events/event_163.png[/img]{%gladiator% 笑了笑。%SPEECH_ON%朋友，我曾经是个角斗士。 跟我们来吧，把整个世界当做你的角斗场。 我知道你有那种瘙痒。 我知道它在那下面。 找到它。那战斗的欣喜。 那胜利的力量。 跟我们这群战场兄弟分享吧。%SPEECH_OFF%年老的角斗士看着他的装备。 他的倒影也看向他，尽管布满尘土还有坑洼。他点头。%SPEECH_ON%你说的对。以镀金者之名我刚才都在想什么？ 我已经在贫穷中被欺凌了太久了。 如果你的战队愿意接受我，那么我将会以我过去生活过的方式度过我的日子：杀戮！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入。",
					function getResult( _event )
					{
						return "Recruit";
					}

				},
				{
					Text = "不了，谢谢。",
					function getResult( _event )
					{
						return "Deny";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Recruit",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你欢迎他加入。 他站起身。%SPEECH_ON%我更倾向于穿着我自己的装备战斗，但我也不是它的一部分。 毕竟，我刚刚还试着卖掉它，对吗？ 给我你认为最好的并把我指向合适的方向。 我会给他们看看竞技街之狼的本事！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "竞技街之狼？啊，好的。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"old_gladiator_background"
				]);
				_event.m.Dude.setTitle("狼");
				_event.m.Dude.getBackground().m.RawDescription = "%name%也被称为竞技场之狼，是个退休的角斗士，但也是一个在职的佣兵。他靠杀人获得克朗已经有很长一段时间了，这在他的经验和年龄上都有所体现。";
				_event.m.Dude.getBackground().buildDescription(true);
				local trait = this.new("scripts/skills/traits/old_trait");
				_event.m.Dude.getSkills().add(trait);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Deny",
			Text = "[img]gfx/ui/events/event_163.png[/img]{角斗士坐了下来。%SPEECH_ON%好吧，他妈的那些虚张声势的演讲是为了什么？%SPEECH_OFF%%gladiator% 向你道歉，在战队其他人笑的时候，他在言语间瞪了你一眼。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Sorry.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gladiator.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.5, "对一个退休的角斗士笑得很开心");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
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
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Assets.getMoney() < 1250)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.getTile().getDistanceTo(currentTile) <= 4 && t.isAlliedWithPlayer() && t.hasBuilding("building.arena"))
			{
				this.m.Town = t;
				break;
			}
		}

		if (this.m.Town == null)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gladiator")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Gladiator = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Name = this.Const.Strings.SouthernNames[this.Math.rand(0, this.Const.Strings.SouthernNames.len() - 1)];
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gladiator",
			this.m.Gladiator != null ? this.m.Gladiator.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"retired",
			this.m.Name
		]);
	}

	function onClear()
	{
		this.m.Town = null;
		this.m.Dude = null;
		this.m.Gladiator = null;
		this.m.Name = null;
	}

});

