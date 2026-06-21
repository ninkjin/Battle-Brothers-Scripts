this.civilwar_dead_knight_event <- this.inherit("scripts/events/event", {
	m = {
		Thief = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_dead_knight";
		this.m.Title = "在路上…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]你碰巧遇到一群孩子在草地上围着什么东西团团转，就像一堆屎上的苍蝇一样。%randombrother% 开始赶走这些孩子。%SPEECH_ON%你这个笨蛋。跑个什么跑！ 噢，该死的。先生，快过来看看！%SPEECH_OFF%一个胖胖的孩子对你大喊大叫。%SPEECH_ON%这是我最先发现的！它是我的！%SPEECH_OFF%你毫不费力地把他推开，看了一眼。 草地上躺着一个死了一段时间的骑士。 当蚂蚁在他的盔甲上爬来爬去时，他的盔甲发出一种轻柔的嘀嗒嘀嗒声。 一个小女孩一边捏着鼻子。 一边用手扇风，好像周围恶臭让她无法呼吸似的。%SPEECH_ON%让他们尝尝厉害，罗比！ 这些人很危险！ 是吗？你不也是危险人物吗？%SPEECH_OFF%%randombrother% 解开他的武器，并把它呼呼的舞了起来。%SPEECH_ON%小丫头说得对！ 你们最好在我们把你们扔进泥里之前离开，就像我们对待这个骑士一样！ 没错，这个骑士是我们杀的，现在我们来回头验收成果了！%SPEECH_OFF%孩子们尖叫着，哭喊着，像灌木丛中的小鸟一样四散奔逃。 罗比留在后面，斜视着灌木丛中他丢失的财宝。 你告诉手下，他没必要把他们吓得那么厉害。 他耸耸肩，开始收集骑士的装备。",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "仍然能用。",
					function getResult( _event )
					{
						if (_event.m.Thief != null)
						{
							return "Thief";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/helmets/faction_helm");
				item.setCondition(27.0);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Thief",
			Text = "[img]gfx/ui/events/event_97.png[/img]%thief% 发现罗比开始出汗了。 这个佣兵用手指着他。%SPEECH_ON%这可不只是胖才会这样，孩子。 你衬衫下面藏着什么？ 你骗不了我的，来，给我们看看！%SPEECH_OFF%罗比叹了口气，撩起衬衫，一串克朗哗啦哗啦的掉在草地上。这个人点头。%SPEECH_ON%我也是这么想的。现在你可以离开了。%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "好眼力。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Thief.getImagePath());
				local money = this.Math.rand(30, 150);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		if (!this.World.State.getPlayer().getTile().HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local nearTown = false;

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 10 && t.getTile().getDistanceTo(playerTile) >= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.thief" || bro.getSkills().hasSkill("trait.eagle_eyes"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Thief = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Thief = null;
	}

});

