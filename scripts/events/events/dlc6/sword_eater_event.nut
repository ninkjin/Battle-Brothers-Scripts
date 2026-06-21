this.sword_eater_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
		Wildman = null
	},
	function create()
	{
		this.m.ID = "event.sword_eater";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_163.png[/img]{一个食剑者在 %townname% 的广场边跳着舞。他拿起一把差不多有你小拇指厚的利刃。%SPEECH_ON%在镀金者的注视下，我将会吃下这些钢铁！%SPEECH_OFF%那人声明了他的目的，并接着迅速行动了起来：他弓起腰，拧着刀，并把它滑入了他的嘴，越来越深，他的围绕着铁褶皱着就好像他在吸面条。 群众一开始深吸一口气，但是吞咽者举起两个大拇指，旁观者欢呼了起来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "好哇！ 这儿，几个硬币，给你的。",
					function getResult( _event )
					{
						return "B";
					}

				});

				if (_event.m.Wildman != null)
				{
					this.Options.push({
						Text = "好哇！ 替我给这个人几个硬币，%wildman%。",
						function getResult( _event )
						{
							return "C";
						}

					});
				}

				this.Options.push({
					Text = "有趣的讨生活方式。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你丢给他几克朗。 他拔出剑并把它放到他的头顶上。 群众再次欢呼。 笑着，他一边平衡着剑一边说道。%SPEECH_ON%我看到了你的旗帜，逐币者。 我不是一个战士，但我是个旅行者和一个不错的演讲者。 尽管我是为了个人利益表演，我会时不时为你们这些追逐硬币的恶棍说几句好话的。%SPEECH_OFF%吞剑者张开他的双臂并快速的点头。 刀从他头顶快速落下并安静的落入他腰间的刀鞘。 再一次，群众欣赏的欢呼起来而你不得不忍痛这个艺人会信守承诺。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我的剑并没那么锋利，但是我团里的娘炮们连这都做不到？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-5);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]5[/color] 克朗"
					}
				];
				_event.m.Town.getOwner().addPlayerRelation(5.0, "当地的演艺人员将你的名字传遍了。");
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你给了 %wildman% 几个硬币告诉他教给艺人。 他嘟囔着走过去了，然后你意识到了那个佣兵不是别人，而是野人 %wildman%！ 在你能阻止他之前，他把吞剑者推倒。 哭喊，尖叫还有血吐出来的声音，但是群众聚集到现场前遮挡了视线。 结果是锋刃从吞剑者的胸口穿了出来，上面挂着食管或胃的带子。 你知道这些，因为野人自己把剑拿了回来而你必须得让人把它洗干净。\n\n 至于他怎么把利刃在一片腥风血雨中取回来超出你的想象，但是你想他靠着意志，信念，还有对道德的完全无知使他躲过了人群的攻击，最后一个让每一个有基本认知的人恐惧不已。 你要几个佣兵把野人藏起来，因为他恐怕得避避风头了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好，但也不太好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
				this.World.Assets.addMoney(-5);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]5[/color] 克朗"
					}
				];
				local item = this.new("scripts/items/weapons/fencing_sword");
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Town.getOwner().addPlayerRelation(-10.0, "有传言说当地一个艺人被你的人杀了");
				this.World.Flags.set("IsSwordEaterWildmanDone", true);
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert || !this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		if (this.World.Assets.getMoney() < 100)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.getTile().getDistanceTo(currentTile) <= 4 && t.isAlliedWithPlayer())
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
		local candidates_wildman = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (this.Const.DLC.Wildmen && !this.World.Flags.get("IsSwordEaterWildmanDone") && bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
		}

		if (candidates_wildman.len() != 0)
		{
			this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman != null ? this.m.Wildman.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
		this.m.Wildman = null;
	}

});

