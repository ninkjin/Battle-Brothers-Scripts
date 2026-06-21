this.childrens_crusade_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null,
		Traveller = null
	},
	function create()
	{
		this.m.ID = "event.childrens_crusade";
		this.m.Title = "在路上…";
		this.m.Cooldown = 300.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_97.png[/img]在路上，你遇到一小群孩子。 其中最年长的和最强壮的至多十五岁，长着一堆蓬乱的橙色头发，拿着一支长矛当武器。 他率领着一支部队，一支比任何村子或城镇巡逻队都弱小的杂牌军。 当他们在路上与你相遇时，这个小领袖抬头看向你。%SPEECH_ON%让路！我们正在进行正义的行军，不该被阻挡！%SPEECH_OFF%你很好奇，问他们要去哪里。 那孩子回答，好像不相信你不知道似。%SPEECH_ON%好吧，让我告诉你，佣兵。 我们正穿过冰冻的荒地向北行进。 无知的的和未开化的部落需要了解古老的神明，要么用语言，要么用剑。%SPEECH_OFF%一支欢快的“战歌”从这支军队中响起。 看来是某种宗教狂热控制了这个流浪的、无害的，因此会自杀的群体。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "你们应该回家和父母团聚，孩子们。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "%monk%, 你是古老神明的代言人。你有什么想说的？",
						function getResult( _event )
						{
							return "Monk";
						}

					});
				}

				if (_event.m.Traveller != null)
				{
					this.Options.push({
						Text = "%walker%，你曾经去过那里。说点什么吧。",
						function getResult( _event )
						{
							return "Traveller";
						}

					});
				}

				this.Options.push({
					Text = "我会帮你省下一段漫长的路程并且帮你处理掉这里的任何贵重物品。",
					function getResult( _event )
					{
						return "C";
					}

				});
				this.Options.push({
					Text = "祝你好运，我想。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_97.png[/img]你告诉孩子们回家和父母团聚。 小领袖笑了，其他人也跟着笑，就像小朋友很容易被他们的大哥哥打动一样。他摇了摇头。%SPEECH_ON%为什么你认为我们已经走了这么远？ 我们的父母知道我们在哪里，他们知道我们在哪里是绝对正确的。 古老的神明需要在这片土地上被知晓！现在，把路让开！%SPEECH_OFF%孩子们向前挤去。 一条小旗帜从你身边飘过，他们的小武器叮当作响，主要是瓶子，弹弓和餐具。\n\n 毫无疑问他们在自取灭亡。 掠夺者和流浪汉会折磨他们，就像老鹰对老鼠那样，奴隶们也不介意让那些表面上是孤儿的孩子们“消失。”他们还面临更大的威胁，北方荒原将为他们提供一个冰冻的棺材，让他们在里面死去。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Godspeed.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(1);
			}

		});
		this.m.Screens.push({
			ID = "Monk",
			Text = "[img]gfx/ui/events/event_97.png[/img]%monk% 僧侣走上前，把孩子们拉到一起。 他们立即尊重这个人，因为他在某种程度上代表了他们希望发扬的事业。 他屈膝。%SPEECH_ON%是古老神明让你出来做这件事的吗？%SPEECH_OFF%小领袖点头。%SPEECH_ON%他们在我睡觉时对我说话。%SPEECH_OFF%僧侣也点了点头，摩挲着下巴沉思着。 他拍了拍男孩的头。%SPEECH_ON%古老的神明对我说话而我是他们的代言人。 解读他们的信息需要多年的研究，让我告诉你！ 你确定那就是你，小家伙，注定要担起这个重担吗？ 也许你是来送信的，不是吗？ 看看我们，我们是勇士。 合适的，战士能够杀死那些轻视和亵渎古老神明的人。 你现在还不能像我们这样，但是你已经拥有强大的话语权和真正领袖的担当。 我相信古老的神明想运用你的魅力，而不是你的肌肉。%SPEECH_OFF%僧侣顽皮地推了一下男孩。 他笑了，意识到僧侣说的是实话。 小领袖告诉他的军队，他们要回家，因为僧侣肯定是对的。 一些队员感到很欣慰，因为这些孩子被从真正的地狱里劝了回来。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一群傻孩子。.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.World.Assets.addMoralReputation(2);
				local resolve = this.Math.rand(1, 2);
				_event.m.Monk.getBaseProperties().Bravery += resolve;
				_event.m.Monk.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Monk.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				_event.m.Monk.improveMood(1.0, "把一些孩子从某种灾难中解救出来");

				if (_event.m.Monk.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Monk.getMoodState()],
						text = _event.m.Monk.getName() + this.Const.MoodStateEvent[_event.m.Monk.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() != _event.m.Monk.getID() && this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(0.5, "很高兴" + _event.m.Monk.getName() + "拯救了孩子们免于灾难");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "Traveller",
			Text = "[img]gfx/ui/events/event_97.png[/img]%walker% 脱下靴子，向孩子们展示他的脚底板。 他们向后退缩，作呕或捂住嘴巴。 一个小女孩长长的发出“呕”的一声，真正地说明了这一点。 那人晃着脚，露出令人作呕的长满老茧的皮肤。%SPEECH_ON%我在路上花了几年的时间，大部分时间都没有好的鞋可以穿。 我知道外面是什么样子。 我已经看到了危险。 人们趁对方睡着的时候捅刀子。 为了一小口饼干杀人。 陌生人把你当朋友是为了以后出卖你。 这些都算是好的！ 当变得不好的时候，那真是…好吧，那真是糟糕。 你们这些孩子不该来这里。 你会被强奸、谋杀、奴役、折磨、喂狗、被野猪、熊、狼吃掉，所有这些都让你看起来就像在用两条腿吃午餐。 回家吧，你们作够了。%SPEECH_OFF%那群孩子在他们中间窃窃私语。 一个说他要回他妈妈那里去了。 一个小女孩说她根本就不想出来，也从来没有得到过答应给她的东西。 感觉到士气受到了打击，小领袖尝试稳住这些孩子，但是没有用。 人群散开了，谢天谢地，他们开始回家了。 有些队员松了一口气，因为他们不希望看到小家伙们继续他们地狱般的旅程。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你真应该检查一下你的脚。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Traveller.getImagePath());
				this.World.Assets.addMoralReputation(2);
				local resolve = this.Math.rand(1, 2);
				_event.m.Traveller.getBaseProperties().Bravery += resolve;
				_event.m.Traveller.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Traveller.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				_event.m.Traveller.improveMood(1.0, "把一些孩子从某种灾难中解救出来");

				if (_event.m.Traveller.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Traveller.getMoodState()],
						text = _event.m.Traveller.getName() + this.Const.MoodStateEvent[_event.m.Traveller.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() != _event.m.Traveller.getID() && this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(0.5, "很高兴" + _event.m.Traveller.getName() + "拯救了孩子们免于灾难");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_97.png[/img]你不相信你能说服这些孩子，但是如果你爸爸的教育方式可以作为参考的话，你很可能揍他们一顿。 你迅速下了命令，让同伴们袭击孩子们，把他们打倒在地，拿走他们的东西。 小领袖试图用长矛刺向佣兵，却因为自己惹麻烦而被打得鼻青鼻肿。\n\n 这不是最好的解决方法，如果有人看到战队打孩子，那真是太糟糕了，但是这样“结束”他们的十字军远征远比他们在路上再遇麻烦要好。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "吃土吧，你们这帮小杂种。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-4);
				local item = this.new("scripts/items/loot/silverware_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/weapons/militia_spear");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 11,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.worsenMood(1.0, "对你下令抢劫儿童感到震惊");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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
		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y < this.World.getMapSize().Y * 0.2)
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
		local candidates_monk = [];
		local candidates_traveller = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk")
			{
				candidates_monk.push(bro);
			}
			else if (bro.getBackground().getID() == "background.messenger" || bro.getBackground().getID() == "background.vagabond" || bro.getBackground().getID() == "background.refugee")
			{
				candidates_traveller.push(bro);
			}
		}

		if (candidates_monk.len() != 0)
		{
			this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		}

		if (candidates_traveller.len() != 0)
		{
			this.m.Traveller = candidates_traveller[this.Math.rand(0, candidates_traveller.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getName() : ""
		]);
		_vars.push([
			"walker",
			this.m.Traveller != null ? this.m.Traveller.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Monk = null;
		this.m.Traveller = null;
	}

});

