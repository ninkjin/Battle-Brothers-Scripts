this.warriors_death_event <- this.inherit("scripts/events/event", {
	m = {
		Gravedigger = null,
		Casualty = null
	},
	function create()
	{
		this.m.ID = "event.warriors_death";
		this.m.Title = "战斗之后…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_87.png[/img]战争结束后，你看看它所造成的破坏。%deadbrother% 仰卧在地上，眼睛呆滞地盯着天空。 其他兄弟残肢飞的到处都是。 它们形状畸形，破碎不堪，支离破碎，很快就会发臭。 这是一个大型绞肉机现场。 现在苍蝇聚集在一起，像只小鼹鼠似的盯着死去的人。 他们以不知羞耻的方式在冰冷的皮肤上交配，并开始在温暖的血河中产卵。%randombrother% 走上前问你，那些尸体怎么办。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别管尸体了。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "让我们给这些死者最后的体面！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Gravedigger != null)
				{
					this.Options.push({
						Text = "让掘墓人 %gravedigger% 来处理。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_87.png[/img]你抬头看看天空。 乌鸦和秃鹫在头顶盘旋。 当你离开的时候，他们就会呼啸而至，叽叽喳喳，开启盛宴。 你放下你的剑，点头示意了一下战场。%SPEECH_ON%收拾战利品，然后把死人留给鸟。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "毕竟，这是一个饥饿的世界。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local r;
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					local chance = 25;

					if (bro.getBackground().getID() == "background.monk")
					{
						chance = 100;
					}
					else if (bro.getSkills().hasSkill("trait.fainthearted") || bro.getSkills().hasSkill("trait.craven") || bro.getSkills().hasSkill("trait.dastard") || bro.getSkills().hasSkill("trait.pessimist") || bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.insecure") || bro.getSkills().hasSkill("trait.disloyal"))
					{
						chance = 75;
					}
					else if (bro.getSkills().hasSkill("trait.cocky") || bro.getSkills().hasSkill("trait.loyal") || bro.getSkills().hasSkill("trait.optimist") || bro.getSkills().hasSkill("trait.deathwish"))
					{
						chance = 10;
					}

					if (this.Math.rand(1, 100) > r)
					{
						continue;
					}

					bro.worsenMood(0.5, "战死的战友们被留在战场上腐烂而感到沮丧");

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

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_28.png[/img]你向死者点头致意。%SPEECH_ON%那些死去的都是不错的好人，好人就应该有好的葬礼。 我们会向他们致以崇高的敬意：一个可以睡觉的好地方，足够他们在天堂使用的克朗，和一次盛大的庆祝宴会。 我也希望死后能得到同样的待遇！%SPEECH_OFF%活下来的人欢呼并开始准备。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在我们找到了他们最后的安眠之地。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local r;
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					local chance = 50;

					if (this.Math.rand(1, 100) > r)
					{
						continue;
					}

					bro.improveMood(0.5, "很高兴看到倒下的战友们得到了美好的告别");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}

				this.World.Assets.addMoney(-60);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]60[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_28.png[/img]你把埋葬的任务分配给 %gravedigger%，他在这个行业里很有经验。 他一会儿就在地上挖了一个足够大的方坑。 他把尸体用亚麻布包起来，然后才小心地放在挖好的墓穴里。 当这一切说到做到的时候，坟墓就建好了，仿佛是栅栏被破坏了插在地上。 每堆土都有一根木桩，木头上刻着死去的兄弟的名字。%gravedigger% 把铲子插在地上，双手搭在把手上。 他对自己的工作满意地点头。%SPEECH_ON%他们埋得很深。%SPEECH_OFF%那个人吐了口唾沫。%SPEECH_ON%现在能打扰你们的只有虫子了。 他们说人一旦死了，无论到哪里都有一张嘴需要食物。 恐怕你烧了尸体，我摆了个姿势，但他们说即使这样，灵魂也会有舔食的感觉。 即使这样也有像吸入烟雾一样的灵魂食物，或者诸如此类的东西。%SPEECH_OFF%拾起铁锹，掘墓人转身离去，仿佛他的工作和言语都只是梦中的梦。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好…愿他们安息",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Gravedigger.getImagePath());
				local r;
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					local chance = 75;

					if (this.Math.rand(1, 100) > r)
					{
						continue;
					}

					bro.improveMood(0.5, "很高兴看到倒下的战友们得到了美好的告别");

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

		});
	}

	function onUpdateScore()
	{
		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 8.0)
		{
			return;
		}

		local fallen = [];
		local fallen = this.World.Statistics.getFallen();

		if (fallen.len() < 3)
		{
			return;
		}

		local f0;
		local f1;

		foreach( f in fallen )
		{
			if (f.Expendable)
			{
				continue;
			}

			if (f0 == null)
			{
				f0 = f;
			}
			else if (f1 == null)
			{
				f1 = f;
			}
			else
			{
				break;
			}
		}

		if (f0 == null || f1 == null)
		{
			return;
		}

		if (f0.Time < this.World.getTime().Days || f1.Time < this.World.getTime().Days)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_gravedigger = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.gravedigger")
			{
				candidates_gravedigger.push(bro);
			}
		}

		this.m.Casualty = f0.Name;

		if (candidates_gravedigger.len() != 0)
		{
			this.m.Gravedigger = candidates_gravedigger[this.Math.rand(0, candidates_gravedigger.len() - 1)];
		}

		this.m.Score = 500;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"gravedigger",
			this.m.Gravedigger != null ? this.m.Gravedigger.getNameOnly() : ""
		]);
		_vars.push([
			"deadbrother",
			this.m.Casualty
		]);
	}

	function onClear()
	{
		this.m.Gravedigger = null;
		this.m.Casualty = null;
	}

});

