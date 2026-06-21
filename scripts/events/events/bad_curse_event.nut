this.bad_curse_event <- this.inherit("scripts/events/event", {
	m = {
		Cursed = null,
		Monk = null,
		Sorcerer = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.bad_curse";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%superstitious% 走进你的帐篷手里拿着帽子。 帽子的边缘在他的手指间一圈又一圈地转着，好像他在拔帽子的羽毛。 即使你一个字也没说，那个男人还是狂怒地点头，他的眼睛扫视四周，好像在寻找要说的话。\n\n你放下羽毛笔，问是什么问题。 他舔了舔嘴唇，又点头，开始解释他的困境。 他说得很快，是当地的一个女巫诅咒他，说他是性无能，大概意思就是这样。\n\n你摇着头，问那女巫想要什么，%superstitious% 说 %payment% 克朗，以免自己一辈子都受到诅咒。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "如果必须要如此…那就去做吧。 这是那些数目的克朗。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "这不会发生的。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "让 %monk% 这个僧侣替你看一下。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Sorcerer != null)
				{
					this.Options.push({
						Text = "让 %sorcerer% 这个巫师替你看一眼。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Characters.push(_event.m.Cursed.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]你用拇指和手指夹住自己的眼皮，你想知道这是不是你想要的的生活。 杀人很容易，但是这个事？无所谓吧。 你把手举起来，从椅子上站起来，拿起一个装着克朗的袋子。 那个迷信的人用脚尖蹒跚着站起来。%SPEECH_ON%请把它数出来！ 一定不要少克朗了！%SPEECH_OFF%你不情愿地把袋子放在桌子上，开始数钱。 一旦有了合适的数目，你就把钱放到钱包里，然后把它扔给 %superstitious%。他鞠躬，感谢你和你的仁慈。 你挥手示意他赶快离开你的帐篷。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这事我忍了…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				_event.m.Cursed.improveMood(3.0, "被诅咒治愈");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cursed.getMoodState()],
					text = _event.m.Cursed.getName() + this.Const.MoodStateEvent[_event.m.Cursed.getMoodState()]
				});
				this.World.Assets.addMoney(-400);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + 400 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]你很快用一些坏消息把一脸可怜相的 %superstitious% 弄糊涂了：你没有给任何一个女巫任何东西。%SPEECH_ON%这是一些奇怪女人在森林里的玩笑，不能作为一场生意的依据。 你所听到的是一个婊子企图骗你呢，雇佣兵。 你不能听这种废话，尤其是一个婊子的废话，因为婊子的废话就是为了某个人的硬币。%SPEECH_OFF%这些话对 %superstitious% 毫无用处，因为他很快就逃出了帐篷，也许是去找另一个可以借给他钱的雇佣兵。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有些人真是无药可救。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				local effect = this.new("scripts/skills/effects_world/afraid_effect");
				_event.m.Cursed.getSkills().add(effect);
				this.List = [
					{
						id = 10,
						icon = effect.getIcon(),
						text = _event.m.Cursed.getName() + "是害怕的"
					}
				];
				_event.m.Cursed.worsenMood(2.0, "为你感到失望");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cursed.getMoodState()],
					text = _event.m.Cursed.getName() + this.Const.MoodStateEvent[_event.m.Cursed.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]想到 %monk% 这个僧侣可能会帮上忙，你马上去找这个圣徒。\n\n他说他确实能帮上忙，因为古老的神明们总是与魔鬼和其他邪恶的巫师战斗。 在他开始长篇大论这个古老神明或另一个之前，你溜走了把他留给 %superstitious%。有几分钟的实践，你的帐篷里宁静又祥和。 但是你知道这不会持续太久，因为你就像一个人在岩石下呼吸，等待着刻着他名字的滚落的石头。\n\n 然而，%superstitious% 没有回来。 又过了几分钟，你才意识到他还没有来捣乱。 事实上，他的缺席让你感到不安，仿佛沉默本身也可能是一种长篇大论。 你离开帐篷，发现僧侣和所谓的被诅咒的家伙正在进行宗教谈话。 微笑着，你回到了你的帐篷。 如果有一件事是圣徒们所擅长的话，那就是营造一种宁静的氛围。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那个事就应该这样收场。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				this.Characters.push(_event.m.Monk.getImagePath());

				if (!_event.m.Cursed.getFlags().has("resolve_via_curse"))
				{
					_event.m.Cursed.getFlags().add("resolve_via_curse");
					_event.m.Cursed.getBaseProperties().Bravery += 1;
					_event.m.Cursed.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Cursed.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
					});
				}

				if (!_event.m.Monk.getFlags().has("resolve_via_curse"))
				{
					_event.m.Monk.getFlags().add("resolve_via_curse");
					_event.m.Monk.getBaseProperties().Bravery += 1;
					_event.m.Monk.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Monk.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_05.png[/img]你打着响指，突然想起 %sorcerer%，这个所谓的巫师。 你不想再多花一分钟来参与这件荒谬的事情，就向巫师提及 %superstitious%。 他很快就离开了，但不幸的是几分钟后他又回来了，解释说 %sorcerer% 已经帮他解除了诅咒。%SPEECH_ON%我力所能及的做了…%SPEECH_OFF%你举起手，让他的故事就此打住。 他问你想不想听剩下的部分，你坚决地拒绝了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那个事就应该这样收场。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cursed.getImagePath());
				this.Characters.push(_event.m.Sorcerer.getImagePath());
				_event.m.Cursed.improveMood(3.0, "被诅咒治愈");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cursed.getMoodState()],
					text = _event.m.Cursed.getName() + this.Const.MoodStateEvent[_event.m.Cursed.getMoodState()]
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

		if (this.World.Assets.getMoney() < 1000)
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
		local candidates_cursed = [];
		local candidates_monk = [];
		local candidates_sorcerer = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() != "background.slave" && bro.getSkills().hasSkill("trait.superstitious"))
			{
				candidates_cursed.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				candidates_monk.push(bro);
			}
			else if (bro.getBackground().getID() == "background.sorcerer")
			{
				candidates_sorcerer.push(bro);
			}
		}

		if (candidates_cursed.len() == 0)
		{
			return;
		}

		this.m.Cursed = candidates_cursed[this.Math.rand(0, candidates_cursed.len() - 1)];

		if (candidates_monk.len() != 0)
		{
			this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		}

		if (candidates_sorcerer.len() != 0)
		{
			this.m.Sorcerer = candidates_sorcerer[this.Math.rand(0, candidates_sorcerer.len() - 1)];
		}

		this.m.Town = town;
		this.m.Score = candidates_cursed.len() * 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"superstitious",
			this.m.Cursed.getNameOnly()
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"sorcerer",
			this.m.Sorcerer != null ? this.m.Sorcerer.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"payment",
			"400"
		]);
	}

	function onClear()
	{
		this.m.Cursed = null;
		this.m.Monk = null;
		this.m.Sorcerer = null;
		this.m.Town = null;
	}

});

