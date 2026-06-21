this.undead_frozen_pond_event <- this.inherit("scripts/events/event", {
	m = {
		Lightweight = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.undead_frozen_pond";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_143.png[/img]当你穿越寒冷的荒野时，你来到了一个结冰的池塘边。%randombrother% 发现有东西从里面伸出来。 你看到一个身体已经冻在臀部以下的骑士，但上半身还在活动。 它的眼睛红红的，手指被冻伤后变得乌黑，但仍然紧握着。 它的下颚是由冰来保持肌肉的，就好像它有腐烂的半透明的肌腱一样。\n\n %randombrother% 指向有着冰冻面孔的巨大僵尸。%SPEECH_ON%嘿，瞧！那个混蛋身上有一把大剑。 这可能值得一试，不是吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有志愿者么？",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
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
				if (_event.m.Lightweight != null)
				{
					this.Options.push({
						Text = "你有急速的双脚，%lightweightfull%。去试一下？",
						function getResult( _event )
						{
							return "Lightweight";
						}

					});
				}

				this.Options.push({
					Text = "这不值得。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Good",
			Text = "[img]gfx/ui/events/event_143.png[/img]%chosenbrother% 选择尝试去获得死去骑士的剑。 他在池塘上的第一步发出了一声冰冷的颤音，轻巧地踏上冰封的冰层。 他再次试探自己的立足点。 冰会移动，但不会破裂。 每走一步，佣兵都要估测自己的体重和冰层崩塌的可能性，同时还要确保自己不会踩到四处散落的尸体。 \n\n 他成功地找到了这个亡灵骑士。 冰柱悬在剑上，锋刃包裹着一层冰。 佣兵抓起利刃猛拉。 亡灵骑士的手臂向前一倾，从肘部断了下来，佣兵向后滑过池塘。 他滑到边上，你的人扶他起来。 这把剑需要加热才能把冰弄掉，但是这把剑绝对是有用的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local item = this.new("scripts/items/weapons/greatsword");
				item.setCondition(11.0);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Bad",
			Text = "[img]gfx/ui/events/event_143.png[/img]%chosenbrother% 测试冰面，把一只脚踩在池塘边的上。 一种柔和的颤音回荡在冰冷的池水深处，仿佛有人跳过了鼓鼓作响的岩石，穿过了这木桶形状的水面。 他回头看了看众人，耸耸肩。%SPEECH_ON%看起来还行。%SPEECH_OFF%他的下一步动作使他撞破了冰面。 当他伸手去抓取时一点东西的时候，碎片划破了他的手。 那些人迅速地扔给他一根绳子，把他拖了出来。\n\n 他浑身是血，瑟瑟发抖，%chosenbrother% 裹着毯子摇摇头。%SPEECH_ON%我－我－我－我相信这很－很－很－糟糕。 糟－糟－糟糕的主意，先生。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你已经尽力了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local injury = _event.m.Other.addInjury([
					{
						ID = "injury.split_hand",
						Threshold = 0.5,
						Script = "injury/split_hand_injury"
					}
				]);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Other.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
				local effect = this.new("scripts/skills/injury/sickness_injury");
				_event.m.Other.getSkills().add(effect);
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Other.getName() + "是生病了"
				});
			}

		});
		this.m.Screens.push({
			ID = "Lightweight",
			Text = "[img]gfx/ui/events/event_143.png[/img]%lightweight% 走上前去。%SPEECH_ON%冰？那不是事儿。 你可以像这样在上面滑动。%SPEECH_OFF%甚至没有停顿，这个人就跳上了结冰的池塘，在水面上滑行。 他的身后出现了裂痕，就像一个即将到来的坏消息的提醒，但他仍然泰然自若。 他从亡灵骑士身边荡过，抓住了冰冻的剑。 这个亡灵的胳膊在肘部断了，呻吟着。 那人愉快地滑回到池塘边，把剑交给你。%otherbrother% 走上前来，把亡灵那只冻僵的手臂从剑柄上折断，就像一个人折断了一只螃蟹的爪子。%SPEECH_ON%你看到这些了么？%SPEECH_OFF%他把手指压成碎片，粉末状的残留物上有一个图章。 一把剑和一件珠宝，有什么理由不喜欢这个结果呢？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Impressive.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Lightweight.getImagePath());
				local item = this.new("scripts/items/weapons/greatsword");
				item.setCondition(11.0);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/loot/signet_ring_item");
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
		if (!this.World.FactionManager.isUndeadScourge())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
		{
			return;
		}

		if (currentTile.HasRoad)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 6)
			{
				nearTown = true;
				break;
			}
		}

		if (nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_lightweight = [];
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getCurrentProperties().getInitiative() >= 130)
			{
				candidates_lightweight.push(bro);
			}
			else
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Lightweight = candidates_lightweight[this.Math.rand(0, candidates_lightweight.len() - 1)];
		this.m.Other = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 20;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"chosenbrother",
			this.m.Other.getNameOnly()
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getNameOnly()
		]);
		_vars.push([
			"lightweight",
			this.m.Lightweight != null ? this.m.Lightweight.getNameOnly() : ""
		]);
		_vars.push([
			"lightweightfull",
			this.m.Lightweight != null ? this.m.Lightweight.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Lightweight = null;
		this.m.Other = null;
	}

});

