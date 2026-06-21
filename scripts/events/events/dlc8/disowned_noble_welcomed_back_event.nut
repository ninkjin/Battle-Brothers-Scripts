this.disowned_noble_welcomed_back_event <- this.inherit("scripts/events/event", {
	m = {
		Disowned = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.disowned_noble_welcomed_back";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_20.png[/img]{在%townname%期间，你收到了一封信。信差告诉你不要阅读，但当他转角处离开时，你还是打破了一个蜡封皇家印章。信上写着，%disowned%这位被废黜的贵族不再流亡。相反，在他的已经重病的父亲去世后，他将有机会坐上家族的王位。\n\n你拿着这封信，不确定该怎么处理。%disowned%一直是%companyname%的成员。对于一些人来说，曾经在世界各地的皇家房间里生活过的人，现在却降为雇佣军战团的人，具有一种奇特的吸引力。但是，虽然血脉可能干涸，但血统永远不会真正消亡...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会给他看这封信。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我会烧掉这封信。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Disowned.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_82.png[/img]{你叹了口气意识到可能会发生什么，于是你决定去给他看这封信。他读了很长一段时间，然后抬起头来。%SPEECH_ON%我知道你已经读过它了。%SPEECH_OFF%他将这封信递回给你。%SPEECH_ON%我也知道你本可以让这封信烧掉。但你没有那样做，这已经向我显示了我所知道的： %companyname% 现在是我的家。如果你想让我留下，我就留下；如果你想让我离开，我就离开。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我觉得你应该留在我们这里。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "你应该回家看看你的家人。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Disowned.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_82.png[/img]{你拿回了信，然后将它靠近旁边的蜡烛。火焰很快燃烧，灰烬从你的指尖飘散，火从纸上攀升。%disowned%点了点头。%SPEECH_ON%我很高兴你这样做了。如果我的家园需要我，我只会在与%companyname%的工作完成后才会返回。但在那之前，你将拥有我的剑，我的汗水和我的血。%SPEECH_OFF%他咧嘴笑了起来。%SPEECH_ON%当然，前提是有合适的价格。我仍然是个雇佣兵。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "当然。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Disowned.getImagePath());
				local background = this.new("scripts/skills/backgrounds/regent_in_absentia_background");
				_event.m.Disowned.getSkills().removeByID("background.disowned_noble");
				_event.m.Disowned.getSkills().add(background);
				_event.m.Disowned.m.Background = background;
				background.buildDescription();
				this.List = [
					{
						id = 13,
						icon = background.getIcon(),
						text = _event.m.Disowned.getName() + "现在成为了一名缺席的摄政者。"
					}
				];
				local resolve_boost = this.Math.rand(10, 15);
				local initiative_boost = this.Math.rand(6, 10);
				local melee_defense_boost = this.Math.rand(2, 4);
				local ranged_defense_boost = this.Math.rand(3, 5);
				_event.m.Disowned.getBaseProperties().Bravery += resolve_boost;
				_event.m.Disowned.getBaseProperties().Initiative += initiative_boost;
				_event.m.Disowned.getBaseProperties().MeleeDefense += melee_defense_boost;
				_event.m.Disowned.getBaseProperties().RangedDefense += ranged_defense_boost;
				_event.m.Disowned.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative_boost + "[/color] 主动性"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + melee_defense_boost + "[/color] 近战防御"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/ranged_defense.png",
					text = _event.m.Disowned.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + ranged_defense_boost + "[/color] 远程防御"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_74.png[/img]{你将信纸推回给他。%SPEECH_ON%我认为一个远离家人的人更需要他们在他们召回时陪伴在身边，当然他们也一定非常需要他。你已经完成了你在%companyname%战团的使命。%SPEECH_OFF%一开始，这个被遗弃的贵族表现得很失落，但随后开始点头，表示同意你的评估，他的家人一定需要他，他不应该离开他们束手无策。他向你和战团里的其他人告别，但在彻底离开之前，他给你写了一封信。%SPEECH_ON%你有我的感激之情，队长。不要认为我会毫不在意地离开，因为你拯救了我的生命，无论你是否意识到这一点。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你很好，%disowned%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Disowned.getName() + "离开了" + this.World.Assets.getName()
				});
				_event.m.Disowned.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Disowned.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Disowned);
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnAmbition);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_98.png[/img]{你绝不会让%disowned%看到信件。你立刻把信和所有关于他被家族放逐的信息都给烧了。就在这时，他从拐角处走了过来，看上去有些困惑，问有什么事。你摇头，问他想不想帮忙盘点库存。%disowned%露出了笑容%。%SPEECH_ON%当然愿意，没有良好的库存管理，%companyname%也无法如此卓有成效，没有您的指挥，队长。%SPEECH_OFF%就在你转身加入他的时候，你看到了之前那位信使扯着什么东西向你走来。你让%disowned%去忙他的事，去拦住那个人，问他带来的是什么。他扯来一个沉重的箱子，擦了擦额头，说这也是用来送给那位被家族放逐的贵族的。你踢开箱子，里面装满了武器和盔甲，其中一些上面印有他家族的纹章。你感谢信使，让他离开，并且匆忙地打破了纹章，把徽标扔进了水沟，以免那位贵族亲眼看到它们。他好奇地大喊是否有什么不对劲的地方。你摇头。%SPEECH_ON%没有，只是有了新的装备发货，这就是全部了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这里没什么好看的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item;
				local stash = this.World.Assets.getStash();
				local armor_list = [
					"mail_hauberk",
					"reinforced_mail_hauberk"
				];

				if (this.Const.DLC.Unhold)
				{
					armor_list.extend([
						"footman_armor",
						"light_scale_armor",
						"sellsword_armor",
						"noble_mail_armor"
					]);
				}

				local weapons_list = [
					"noble_sword",
					"fighting_spear",
					"fighting_axe",
					"warhammer",
					"winged_mace",
					"arming_sword",
					"warbrand"
				];
				item = this.new("scripts/items/armor/" + armor_list[this.Math.rand(0, armor_list.len() - 1)]);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/" + weapons_list[this.Math.rand(0, weapons_list.len() - 1)]);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/" + weapons_list[this.Math.rand(0, weapons_list.len() - 1)]);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local disowned_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.disowned_noble" && bro.getLevel() >= 6)
			{
				disowned_candidates.push(bro);
			}
		}

		if (disowned_candidates.len() == 0)
		{
			return;
		}

		this.m.Disowned = disowned_candidates[this.Math.rand(0, disowned_candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 4 * disowned_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"disowned",
			this.m.Disowned.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Disowned = null;
		this.m.Town = null;
	}

});

