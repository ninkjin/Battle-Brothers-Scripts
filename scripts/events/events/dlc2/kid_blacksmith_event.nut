this.kid_blacksmith_event <- this.inherit("scripts/events/event", {
	m = {
		Juggler = null,
		Apprentice = null,
		Killer = null,
		Other = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.kid_blacksmith";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你正逛着%townname%的商店，感到一阵拉扯。你转身发现一个孩子，他的脸涂黑了，两只闪亮的白眼睛盯着你。他问你是否知道关于剑的任何事情。你指向了插在你身旁的那一把。他拍了拍手。%SPEECH_ON%太好了！我为一家铁匠店工作，但他正在去取铁锭。他要我看守这把特殊的剑，但它，嗯，它掉下来了。然后就碎了。它自己掉下来的，也自己碎的。你能帮我把它修好吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "有人帮帮孩子吧。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 70)
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
				if (_event.m.Juggler != null)
				{
					this.Options.push({
						Text = "看来 %juggler% 想帮你。",
						function getResult( _event )
						{
							return "Juggler";
						}

					});
				}

				if (_event.m.Apprentice != null)
				{
					this.Options.push({
						Text = "看来 %apprentice% 想帮你。",
						function getResult( _event )
						{
							return "Apprentice";
						}

					});
				}

				if (_event.m.Killer != null)
				{
					this.Options.push({
						Text = "看来 %killer% 想帮你。",
						function getResult( _event )
						{
							return "Killer";
						}

					});
				}

				this.Options.push({
					Text = "不！快跑，孩子。",
					function getResult( _event )
					{
						return "No";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "No",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你让那个孩子滚开。反正他十有八九是个骗子。说到这个，你检查了一下自己的口袋，确保里面的东西还在。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "真让人宽慰，似乎没有什么遗漏。",
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
			ID = "Good",
			Text = "[img]gfx/ui/events/event_97.png[/img]{%other%被请去帮助这个孩子。他帮忙将刀柄和刀片组合在一起，孩子靠自己的技艺轻松地把剑修好了。你惊叹于他的技艺，不禁想知道这位铁匠自己的手艺如何，如果他的徒弟都这么厉害的话。修好后，这个孩子提出为%companyname%修理一些武器，你很高兴地接受了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "干好的。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local stash = this.World.Assets.getStash().getItems();
				local items = 0;

				foreach( item in stash )
				{
					if (item != null && item.isItemType(this.Const.Items.ItemType.Weapon) && item.getCondition() < item.getConditionMax())
					{
						item.setCondition(item.getConditionMax());
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你的(Your)" + item.getName() + "已修复"
						});
						items = ++items;

						if (items > 3)
						{
							break;
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_97.png[/img]{%other%你让他去帮助那个孩子完成工作后叹了口气。他懒洋洋地走到铁匠的砧板前，砧板造型像一个牙齿，支撑它的是细铁支架。铁匠的物品挂在由旧铁栏杆制成的临时墙壁上，支架向外弯曲，以便更好地吸收金属加工的力量。孩子拍手欢呼。%SPEECH_ON%现在不要碰别的东西，只帮我完成这个。%SPEECH_OFF% %other%感到困惑，打断一周迹象后回头一看就把铁砧踢倒了。铁砧开始倾斜，孩子赶紧赶过去扶住它，尽管只是为了阻止这一天遭受的麻烦。巨大的重量把孩子压扁在鹅卵石路面上，他的四肢短暂地向天空伸展，就像是一只被拇指压扁的蟋蟀。你从远处看到了这一切，赶紧示意雇佣兵回来，以免麻烦。他趁早离开，只有几个路人开始注意。他耸了耸肩。%SPEECH_ON%我们没有做错什么，对吧，先生？%SPEECH_OFF%你点了点头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你应该保持低调一段时间。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				_event.m.Other.worsenMood(1.5, "不小心把一个小男孩弄残废了");

				if (_event.m.Other.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Other.getMoodState()],
						text = _event.m.Other.getName() + this.Const.MoodStateEvent[_event.m.Other.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Juggler",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你的对于杂耍演员志愿提供帮助的怀疑得到了证实，因为你很快就看到他将匕首和斧头扔向空中，惊艳了大众。看到人群聚集，他把帽子放在鹅卵石上，继续表演节目。他们投了很多硬币，而当他演出了同时抛接五个钉棒的终极演出时，掌声更是雷鸣。他鞠躬之后拿起了帽子，匆匆忙忙地走回来。%SPEECH_ON% 很充实的一天，没错吧，先生？%SPEECH_OFF% 你点点头，问起那个男孩断掉的剑。他擦了擦额头上的汗水。%SPEECH_ON% 什么，先生？回到队里吗？是的，先生，我现在就归队。%SPEECH_OFF% 你嘴唇抿紧，向铁匠铺看去，看到男孩俯在一个铁砧上，接受着被回来的铁匠用皮鞭抽打的惩罚。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "表演就是表演。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				_event.m.Juggler.improveMood(1.0, "沉浸在人群的赞美中");

				if (_event.m.Juggler.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Juggler.getMoodState()],
						text = _event.m.Juggler.getName() + this.Const.MoodStateEvent[_event.m.Juggler.getMoodState()]
					});
				}

				local money = this.Math.rand(10, 100);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "Apprentice",
			Text = "[img]gfx/ui/events/event_97.png[/img]{%apprentice%这个年轻的学徒被派去帮助那个孩子。他慢悠悠地走到铁匠铺，开始帮这个孩子。但他所做的不仅仅是帮忙：他以一种比开始时更强的方式将剑重新拼合起来。铁匠回来发现了这件手艺活，迫不及待地要知道如何做到，几乎是恳求着。%apprentice%笑了。%SPEECH_ON%你给我这把剑，我就会告诉你我的大师传给我的秘密。%SPEECH_OFF%你甚至不知道这个学徒知道如何做到这一切，但这个小伙子在学习方面是个海绵。与铁匠达成了交易，双方都离开得非常开心。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我想你学过投篮？",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				_event.m.Apprentice.improveMood(1.0, "带着他的铁匠技能去承受");

				if (_event.m.Apprentice.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}

				local item = this.new("scripts/items/weapons/arming_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Killer",
			Text = "[img]gfx/ui/events/event_97.png[/img]{你请求%killer%这个杀人犯帮助这个孩子。这个人带着微笑满足了你的要求，但孩子似乎直觉上感到受到了冒犯。他向后退了几步，挥手拒绝帮助。%SPEECH_ON%不用了先生，我还好。毕竟，做一个男人，必须要做的事得去做，对吧？%SPEECH_OFF%杀人犯微笑着蹲下来，手指抚摸着孩子的脸颊，保持这个姿势。%SPEECH_ON%对，孩子，没错。做一个人需要做的事。%SPEECH_OFF%现在你觉得有些冒犯了，于是你让%killer%去数清库存。他摸了摸孩子的头然后站起身离开了。孩子跑了过来，手里拿着一把匕首。%SPEECH_ON%请，这是给你的。请防止这个家伙再靠近我。你说好不让他再靠近我。明白了吗？我不想再跟他打交道，我宁愿去找一个铁匠藏起来都不愿意再看到他。你拿了这个武器，你保护我。成交了吗？成交，好吧？拿着它！%SPEECH_OFF%你觉得这个孩子似乎是第一次进行这种交易，或者说这是他第一次感觉到自己的生命处于危险之中。无论如何，你接受了匕首。孩子松了一口气，然后回到锻造工厂继续工作，始终在观察附近。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你是一个孩子的杀人犯，%killer%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Killer.getImagePath());
				local item = this.new("scripts/items/weapons/rondel_dagger");
				this.World.Assets.getStash().add(item);
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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
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

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates_other = [];
		local candidates_juggler = [];
		local candidates_apprentice = [];
		local candidates_killer = [];

		foreach( b in brothers )
		{
			if (b.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (b.getBackground().getID() == "background.juggler")
			{
				candidates_juggler.push(b);
			}
			else if (b.getBackground().getID() == "background.apprentice")
			{
				candidates_apprentice.push(b);
			}
			else if (b.getBackground().getID() == "background.killer_on_the_run")
			{
				candidates_killer.push(b);
			}
			else
			{
				candidates_other.push(b);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_juggler.len() != 0)
		{
			this.m.Juggler = candidates_juggler[this.Math.rand(0, candidates_juggler.len() - 1)];
		}

		if (candidates_apprentice.len() != 0)
		{
			this.m.Apprentice = candidates_apprentice[this.Math.rand(0, candidates_apprentice.len() - 1)];
		}

		if (candidates_killer.len() != 0)
		{
			this.m.Killer = candidates_killer[this.Math.rand(0, candidates_killer.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"other",
			this.m.Other.getName()
		]);
		_vars.push([
			"juggler",
			this.m.Juggler != null ? this.m.Juggler.getName() : ""
		]);
		_vars.push([
			"apprentice",
			this.m.Apprentice != null ? this.m.Apprentice.getNameOnly() : ""
		]);
		_vars.push([
			"killer",
			this.m.Killer != null ? this.m.Killer.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Juggler = null;
		this.m.Apprentice = null;
		this.m.Killer = null;
		this.m.Other = null;
		this.m.Town = null;
	}

});

