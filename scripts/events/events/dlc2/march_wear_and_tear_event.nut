this.march_wear_and_tear_event <- this.inherit("scripts/events/event", {
	m = {
		Tailor = null,
		Other = null,
		Vagabond = null,
		Thief = null
	},
	function create()
	{
		this.m.ID = "event.march_wear_and_tear";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{周游世界对士兵们造成了一定的磨损。每当雇佣兵脱下靴子时，你都能看到血液透过他的袜子渗出来。他们积累了疮痛和疖子。一名士兵剥下他的脚趾肉，表示他后悔这样做，你点了点头。总的来说，这是长期在路上付出的代价。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "忍一时，风平浪静。",
					function getResult( _event )
					{
						return "End";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Tailor != null)
				{
					this.Options.push({
						Text = "也许我们可以用现有的东西做些新鲜的包装？",
						function getResult( _event )
						{
							return "Tailor";
						}

					});
				}

				if (_event.m.Vagabond != null)
				{
					this.Options.push({
						Text = "你周游了世界，%travelbro%。建议？",
						function getResult( _event )
						{
							return "Vagabond";
						}

					});
				}

				if (_event.m.Thief != null)
				{
					this.Options.push({
						Text = "Wait. %streetrat%，你看起来有话要说？",
						function getResult( _event )
						{
							return "Thief";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "End",
			Text = "%terrainImage%{下一站并不远。你希望士兵们能够一直坚持走到那里。你会根据需要使用你所拥有的绷带。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "穿上你的靴子。",
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
					if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.messenger")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}

				local amount = brothers.len();
				this.World.Assets.addMedicine(-amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 医疗用品"
				});
			}

		});
		this.m.Screens.push({
			ID = "Tailor",
			Text = "%terrainImage%{%tailor% 裁缝用两根手指摩擦下巴，终于伸手指向前方。%SPEECH_ON%我想到了！各位，把你们所有没用或破烂的衣服都给我。每一件都要。拿过来。没错，那确实是破烂，%otherbrother%。你最喜欢的衬衫？见神就拜，还是先给我。谢谢。%SPEECH_OFF%裁缝收集了一大堆废弃的衣服，并开始他的工作。他剪来剪去，不时停顿。常常不确定自己的工作。但是最终他展示了成果。一堆新的袜子和足够的小碎布撕成可以用来绷带的大小。他还穿着一套令人惊讶的花哨新装，你完全不知道他是如何制造的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "如果我以前见过的话现在那是一个魔法师。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Tailor.getImagePath());
				_event.m.Tailor.improveMood(1.0, "用布屑给自己做点好东西");

				if (_event.m.Tailor.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Tailor.getMoodState()],
						text = _event.m.Tailor.getName() + this.Const.MoodStateEvent[_event.m.Tailor.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();
				local amount = brothers.len();
				this.World.Assets.addMedicine(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + amount + "[/color] 医疗用品"
				});
			}

		});
		this.m.Screens.push({
			ID = "Vagabond",
			Text = "%terrainImage%{在行走这个世界方面，%travelbro%可谓老当益壮。他嘲笑着身为佣兵的同伴们的困境。%SPEECH_ON%啊，这才像话！别管疼痛，伙计们，拥抱酸痛吧！%SPEECH_OFF%战团一致反驳他，但这名路人却高高兴兴地蹬动着脚趾。你甚至没有注意到他脱下了鞋，他的脚已经被老茧包裹着，让你误以为是鞋子的皱褶和骨头隆起！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "穿上你那该死的靴子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Vagabond.getImagePath());
				_event.m.Vagabond.improveMood(1.0, "在路上享受生活");

				if (_event.m.Vagabond.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Vagabond.getMoodState()],
						text = _event.m.Vagabond.getName() + this.Const.MoodStateEvent[_event.m.Vagabond.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.messenger")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}

				local amount = brothers.len();
				this.World.Assets.addMedicine(-amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 医疗用品"
				});
			}

		});
		this.m.Screens.push({
			ID = "Thief",
			Text = "%terrainImage%{%thief% 小偷靠近你，你走开，把手放进口袋里，问他想干啥。他咧嘴一笑，回答道。%SPEECH_ON%好吧，队长，我跟你说实话。上次我们在镇上停留时，我拿了一个盲和平主义者的东西。什么？我有个疼牙。没必要花钱修复老天爷给我的东西。不过，我把我的牙齿修好了。看见了吗? 真是个好笑容，对吧？但是，之后我觉得浑身都疼，真的哪儿都疼！所以我又去拜访了那个和平主义者，然后…%SPEECH_OFF% 你打断了这个男人，询问他偷了多少东西。他拿出了一袋药物。他骄傲地双手叉腰，用他扭曲的笑容凝视着这个世界。%SPEECH_ON%不用多说，我现在不再疼了。%SPEECH_OFF%} ",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们又在抱怨什么了？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Thief.getImagePath());
				local amount = this.Math.rand(5, 15);
				this.World.Assets.addMedicine(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_medicine.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]-" + amount + "[/color] 医疗用品"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 5)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		if (this.World.Assets.getMedicine() < brothers.len())
		{
			return;
		}

		local candidates_tailor = [];
		local candidates_vagabond = [];
		local candidates_thief = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.tailor")
			{
				candidates_tailor.push(bro);
			}
			else
			{
				candidates_other.push(bro);

				if (bro.getBackground().getID() == "background.thief")
				{
					candidates_thief.push(bro);
				}
				else if (bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.messenger")
				{
					candidates_vagabond.push(bro);
				}
			}
		}

		if (candidates_tailor.len() != 0 && candidates_other.len() != 0)
		{
			this.m.Tailor = candidates_tailor[this.Math.rand(0, candidates_tailor.len() - 1)];
			this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		}

		if (candidates_vagabond.len() != 0)
		{
			this.m.Vagabond = candidates_vagabond[this.Math.rand(0, candidates_vagabond.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"tailor",
			this.m.Tailor != null ? this.m.Tailor.getName() : ""
		]);
		_vars.push([
			"otherbrother",
			this.m.Other != null ? this.m.Other.getName() : ""
		]);
		_vars.push([
			"travelbro",
			this.m.Vagabond != null ? this.m.Vagabond.getName() : ""
		]);
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Tailor = null;
		this.m.Other = null;
		this.m.Vagabond = null;
		this.m.Thief = null;
	}

});

