this.drunk_nobleman_event <- this.inherit("scripts/events/event", {
	m = {
		Other = null,
		Servant = null,
		Thief = null,
		Townname = null
	},
	function create()
	{
		this.m.ID = "event.drunk_nobleman";
		this.m.Title = "在路上…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{当在行军的时候，你发现一个喝醉了的贵族在路上摇摇晃晃。 他的头发乱糟糟的，叶子和草还有看起来像鸟粪的东西卷在里面，就好像有人故意搅动这些材料来做恶作剧。 但是他的衣服是用上好的丝绸做的，他手指上的宝石在闪闪发光。 他的两手各拿一个瓶子，他一边把它们摆来摆去，一边唱着令人费解的酒吧歌曲。\n\n他像一块你从未见过的巨大的磁石一样吸引着所有人的注意来抢劫他。%randombrother% 撅了撅他的嘴，他看起来就像是一头盯着肥羊的狼一样。%SPEECH_ON%我啥也没说，先生，我只是。 我只是看看。 那有很多好处。 有很多好处就在路上慢慢行走着。 但是，再强调一遍，我什么也没有说。%SPEECH_OFF%你知道他在说什么。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们要抢劫他。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Servant != null)
				{
					this.Options.push({
						Text = "为什么他在盯着 %servant%？",
						function getResult( _event )
						{
							return "G";
						}

					});
				}

				if (_event.m.Thief != null)
				{
					this.Options.push({
						Text = "也许 %thief% 可以减轻他的负担。",
						function getResult( _event )
						{
							return "H";
						}

					});
				}

				this.Options.push({
					Text = "让他自己待会儿。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{你走近了那个人，帮助他坐了下来。 当他的一个瓶子叮当一声掉在地上，滚到一边去的时候，他咧嘴笑了出来。%SPEECH_ON%谢谢，先生，只是，不，好吧，你。%SPEECH_OFF%点着头，你把他的手张开，并朝他的手指上吐了口口水，然后把那些珠宝首饰扒拉了下来，装进包里。 他只是看着，就好像你是一个医生，在治疗疾病而已。 你剩下的佣兵把他扒光，扔给他一块羊皮布，然后就不管他了。 当你离开的时候他问你懂不懂喝酒。%SPEECH_ON%这不，这不是什么秘密，但是，先生，酒是个好东西。%SPEECH_OFF%是的，它是。 不幸的是，当你重新回到战队的时候 %randombrother% 报告，有个孩子看到了整个过程，并且迅速地跑开了。 你问他为什么不追上他。 他机智地看着你。%SPEECH_ON%我不是那种速度型的，先生。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好好休息吧，陌生人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local f = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
				f = f[this.Math.rand(0, f.len() - 1)];
				f.addPlayerRelation(-15.0, "传闻在路上抢劫了一个家族的成员");
				this.List.push({
					id = 10,
					icon = "ui/icons/special.png",
					text = "你与" + f.getName() + "遭受了"
				});
				local money = this.Math.rand(1, 100);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/loot/valuable_furs_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%terrainImage%{你走近了那个人，在一阵连续不断的嗝声中，他摇晃着后退，明显是被吓了一大跳。%SPEECH_ON%唔，你是谁？%SPEECH_OFF%一边告诉他你是个好朋友，你一边接近了他，准备抢走他的所有东西，但是当你走出下一步的同时他的眼睛马上清晰了起来，他扔掉了两个瓶子，并且马上把手伸进他的大衣里取出了一把弩。%SPEECH_ON%别再靠近了，白痴。 我有一帮兄弟就在那边看着呢。 我不想惹上麻烦。 我们不想让一帮佣兵感到不安。 我们是来这里抢劫旅行者的，没有正常的旅行者会那样，选择去抢劫一个醉汉！ 现在为什么我们不打破僵局，然后继续走我们的路，为了我们各自的目的。%SPEECH_OFF%当弩的木头在他的轻握下晃了晃的时候，它响了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Deal.",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "这可不行。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "E" : "F";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "%terrainImage%{你点头。%SPEECH_ON%当然可以。我猜你的那些东西都是仿制品，对吧？%SPEECH_OFF%这个人点头。%SPEECH_ON%当然了。这是在 %townname% 这里最好的合身的仿制品！ 但是这种无聊的恶作剧已经够多了。 感谢你能够保持克制，但是我们还有工作要做。%SPEECH_OFF%再次点了点头，你祝他们工作顺利。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该上路了。",
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
			ID = "E",
			Text = "%terrainImage%{你回头看了看战队，然后在你转回来的时候一并拔出了剑。 你把它举了起来，然后砍在了弩上，那人射击了，弩箭擦着你的肩膀飞了过去。 你把锋刃压了下来，绕过了板条直接砍断了弩弦，然后直接把剑刺入了男人的胸膛。 他顺理成章地倒下了，而你听见了不远处有一帮人在叫喊，但是他们是在尖叫，逃走。 像这样子的盗贼不知道该怎么和佣兵战斗。 你拿走了那个人到目前为止偷走的所有的东西。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看他有什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(1, 100);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/loot/valuable_furs_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "%terrainImage%{你回头看了看战队，然后在你转回来的时候一并拔出了剑。 你把它举了起来，然后砍在了弩上，那人射击了，弩箭擦着你的肩膀飞了过去。 你把锋刃压了下来，绕过了板条直接砍断了弩弦，然后直接把剑刺入了男人的胸膛。 他顺理成章地倒下了，而你听见了不远处有一帮人在叫喊，但是他们是在尖叫，逃走。 像这样子的盗贼不知道该怎么和佣兵战斗。 不幸的是，越过你肩膀的弩箭击中了 %hurtbro%。他会活下来的，但是那是很严重的伤。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看他有什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local injury = _event.m.Other.addInjury(this.Const.Injury.PiercingBody);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Other.getName() + " 遭受 " + injury.getNameOnly()
				});
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/loot/valuable_furs_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "%terrainImage%{当你接近那个贵族的时候，他睁大了他的眼睛，他指着仆人 %servant%。%SPEECH_ON%只是等一下下，我认识你。%SPEECH_OFF%你看了看身后。他真的认识吗？ 那个贵族用他那像剪刀一样岔开在两边的双腿摇摇晃晃的向前走着。%SPEECH_ON%你是在 %randomtown% 的那个愉快夜晚，我表弟的一个仆人。 你做的很棒！你是最棒的。最棒的。仆人。哈。 好吧-嗝-我觉得你可以把这些玩意都拿走因为我不觉得-嗝-我们给哩服了报酬，啊不是，我们给你付过了报酬。%SPEECH_OFF%贵族卸下了所有值钱的东西，把它们都扔了过来。 他看起来很高兴，因为他从那些东西的重压下解放了出来。%SPEECH_ON%如果你再一次遇见了我的-表弟，让，让他知道，我用，用，壁炉架，杀了他兄弟。 一点也没觉得-残酷。%SPEECH_OFF%就这些。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "没花多长时间嘛，做的不错。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Servant.getImagePath());
				_event.m.Servant.getBaseProperties().Bravery += 2;
				_event.m.Servant.getSkills().update();
				_event.m.Servant.improveMood(1.0, "回来的时候终于有了工作的报酬");
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Servant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
				});
				local item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "%terrainImage%{当你接近那个醉汉的时候，一声尖锐的口哨声突然打破了路上的寂静。 你和那个醉汉都看向了 %thief%，小偷站着，拿着一把武器对着后面的另一个人。%SPEECH_ON%那家伙不是贵族，甚至可能都没有喝醉。 他们是在一起工作的，就是袭击旅人或者敲诈他们。他们是强盗，先生。%SPEECH_OFF%你看了回来，却看到那个男人紧张地笑了。 他用一种简明扼要的说法解释道。%SPEECH_ON%我们不想抢劫佣兵，先生，我-我-我发誓我正要向你解释，在我康到了你的剑之后。%SPEECH_OFF%%thief% 叫了出来，他问那些赃物都在哪里。 你看回了那个人，告诉他让他把偷的所有东西都交出来。 他点了点头，并且问你如果他拒绝的话你会不会把他开膛破肚。 你点了点头，告诉他开膛破肚的整个过程会很漫长，而那时很让人放松。 那家伙被吓得晃了晃。%SPEECH_ON%好的先生明白了先生，都在这了。%SPEECH_OFF%} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "哦，小贼要被吓得哭鼻子了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Thief.getImagePath());
				local money = this.Math.rand(1, 100);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local item;
				item = this.new("scripts/items/loot/signet_ring_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/loot/silverware_item");
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
		if (!this.Const.DLC.Wildmen)
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

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_servant = [];
		local candidates_thief = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.servant" || bro.getBackground().getID() == "background.juggler")
			{
				candidates_servant.push(bro);
			}
			else if (bro.getBackground().getID() == "background.thief")
			{
				candidates_thief.push(bro);
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

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_servant.len() != 0)
		{
			this.m.Servant = candidates_servant[this.Math.rand(0, candidates_servant.len() - 1)];
		}

		if (candidates_thief.len() != 0)
		{
			this.m.Thief = candidates_thief[this.Math.rand(0, candidates_thief.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearest_town_distance = 999999;
		local nearest_town;

		foreach( t in towns )
		{
			local d = t.getTile().getDistanceTo(playerTile);

			if (d < nearest_town_distance)
			{
				nearest_town_distance = d;
				nearest_town = t;
			}
		}

		this.m.Townname = nearest_town.getName();
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hurtbro",
			this.m.Other.getNameOnly()
		]);
		_vars.push([
			"servant",
			this.m.Servant ? this.m.Servant.getNameOnly() : ""
		]);
		_vars.push([
			"thief",
			this.m.Thief ? this.m.Thief.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Townname
		]);
	}

	function onClear()
	{
		this.m.Other = null;
		this.m.Servant = null;
		this.m.Thief = null;
		this.m.Townname;
	}

});

