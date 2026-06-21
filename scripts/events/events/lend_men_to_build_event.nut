this.lend_men_to_build_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.lend_men_to_build";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]当你们接近 %townname% 时，一个当地人朝你们挥手。 他站在一座磨坊的骨架旁。 他看起来非常生气，他解释说他的工人今天没有来但是他需要在当地一位男爵到来之前把磨坊完工。 如果他不能完成的话男爵可能就不会再给他一份合同了。 你的战队里面有些成员以前是工人。 也许可以叫他们来帮助这个人？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你建筑，我们杀人。 另找别人去。",
					function getResult( _event )
					{
						return 0;
					}

				},
				{
					Text = "好吧，我会派一到几个人。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_79.png[/img]你同意派 %companyname% 中几个建筑好手来帮助这个人。 他们很快就回归到了老本行中就像他们一直都是干这个的，迅速地四处搜集资源，敲打，砌砖，安装门的路径？ 不管什么东西需要装门，他们总可以非常迅速的完成它。 当所要求的一切都完成以后，当地人笑着向你走来。 他递过一个袋子。%SPEECH_ON%这是你应得的，好心的先生！ 更重要的是，你赢得了我的信任－只要我能我将在任何时候传播你的仁慈！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "别太习惯这种工作了，伙计们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationFavor, "你借出一些人帮助建了一个磨坊");
				this.World.Assets.addMoney(150);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]150[/color] 克朗"
					}
				];
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					local id = bro.getBackground().getID();

					if (id == "background.daytaler" || id == "background.mason" || id == "background.lumberjack" || id == "background.miller" || id == "background.farmhand" || id == "background.gravedigger")
					{
						if (this.Math.rand(1, 100) <= 33)
						{
							local effect = this.new("scripts/skills/effects_world/exhausted_effect");
							bro.getSkills().add(effect);
							this.List.push({
								id = 10,
								icon = effect.getIcon(),
								text = bro.getName() + "是筋疲力尽的"
							});
						}

						if (this.Math.rand(1, 100) <= 50)
						{
							bro.improveMood(0.5, "帮助建了一个磨坊");

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
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_79.png[/img]你同意帮助这个人。 但不幸的是，这个人似乎没有安排好工地的一切。 你的第二个“工人”踩在屋顶上屋顶塌了下来，把这个人送进了一个由瓦片组成的天坑。 另一名男子用锤子将一颗钉子钉在木架上木架正好被砸成两半，木片砸在了他的脸上。 松动的砖块脱落下来，让人滑倒的潮湿的泥土，各种各样的灾难结束了整个工程。\n\n 当地人一边不停地道歉一边想着如何对付男爵。 他咬着自己的指头，他打响指惊叫着说只要给他钱就行了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这些克朗是属于我们的！",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "那么只能祝那个男爵好运。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_79.png[/img]当这个人不断地思考如何解决问题并且最后找到解决方法时，你打响你的手指把带他回到残酷的现实。%SPEECH_ON%那些克朗是属于我们的，农民。 这是一开始就定好的。%SPEECH_OFF%那人摇着头双颊上下抽动着。%SPEECH_ON%但是这个磨坊…它根本就没有完工！%SPEECH_OFF%你耸耸肩。%SPEECH_ON%不是我们的问题。在我让你成为我们的麻烦之前，把它交出来。%SPEECH_OFF%那人无奈的点了点头，遵循的将装满克朗的袋子递给你。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "祝你下次好运。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(-this.Const.World.Assets.RelationFavor, "你极力要求一个有影响的居民为你帮助建造的一座磨坊支付报酬");
				this.World.Assets.addMoney(200);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]200[/color] 克朗"
					}
				];
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					local id = bro.getBackground().getID();

					if (id == "background.daytaler" || id == "background.mason" || id == "background.lumberjack" || id == "background.miller" || id == "background.farmhand" || id == "background.gravedigger")
					{
						if (this.Math.rand(1, 100) <= 33)
						{
							local effect = this.new("scripts/skills/effects_world/exhausted_effect");
							bro.getSkills().add(effect);
							this.List.push({
								id = 10,
								icon = effect.getIcon(),
								text = bro.getName() + "是筋疲力尽的"
							});
						}

						if (this.Math.rand(1, 100) <= 50)
						{
							bro.improveMood(0.5, "帮助建了一个磨坊");

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
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_79.png[/img]在之后一小段时间内，你总会想象到一幅你自己用剑刺穿斜眼男人的画面。 这真的会让他意识到世界的现实，但你却给了他一个喘息的机会。 参加过这一个灾难工程的工人都不太高兴。 希望所学到的经验能使他们坚强起来。",
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
				this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationFavor, "你借出一些人帮助建了一个磨坊");
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					local id = bro.getBackground().getID();

					if (id == "background.daytaler" || id == "background.mason" || id == "background.lumberjack" || id == "background.miller" || id == "background.farmhand" || id == "background.gravedigger")
					{
						if (this.Math.rand(1, 100) <= 33)
						{
							local effect = this.new("scripts/skills/effects_world/exhausted_effect");
							bro.getSkills().add(effect);
							this.List.push({
								id = 10,
								icon = effect.getIcon(),
								text = bro.getName() + "是筋疲力尽的"
							});
						}

						if (this.Math.rand(1, 100) <= 33)
						{
							bro.worsenMood(1.0, "帮助建了一个磨坊却没有得到报酬");

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
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getMoney() > 3000)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 2)
			{
				continue;
			}

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
		local candidates = [];

		foreach( bro in brothers )
		{
			local id = bro.getBackground().getID();

			if (id == "background.daytaler" || id == "background.mason" || id == "background.lumberjack" || id == "background.miller" || id == "background.farmhand" || id == "background.gravedigger")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() < 2)
		{
			return;
		}

		this.m.Town = town;
		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

