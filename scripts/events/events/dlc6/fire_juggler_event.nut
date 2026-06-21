this.fire_juggler_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
		Juggler = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.fire_juggler";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 160.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_163.png[/img]{一个玩火杂耍者吸引着 %townname% 的广场中所有人的目光。他有三套青铜把手的火把。 他的计划进行的不错，但他有一次掉了个火炬引来了些嘲讽。 下一幕他要在一个打开的油桶上摆上一个板子，双手两侧展开，除了这样要同时耍五个火把。\n\n总结一下，他的下一幕表演看起像自杀而且他毫不意外的看来有点畏惧。 但是人群继续着欢呼和讥讽，无疑就像条狼将一只鹿赶到了山崖边，而那个杂耍者，眼睛张开环视四周寻找着某种出路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看他怎么做。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "C" : "D";
					}

				},
				{
					Text = "我们得帮他！",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Juggler != null && this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
				{
					this.Options.push({
						Text = "%juggler%，你能变戏法，你能帮他吗？",
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
			Text = "[img]gfx/ui/events/event_163.png[/img]{你叹气着走上前，大声向杂耍者叫着，假装你是他的经理，告诉他他还做到这样的表演。 人群安静下来，困惑，然后向你讥讽起来。 你半拔的剑使他们安静了下来，然后其他人嘟囔道“逐币者”，引起一系列的嘘声。 但他们最终散开了。 玩火杂耍者走下他的舞台来反复感谢你。%SPEECH_ON%我没准备好，我没准备好，而你用你鹰一般的眼看出来了，友好的陌生人！ 这儿，我今天的所得，都收下吧，毕竟如果我走上去死了这些克朗就都没意义了！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "保重。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(1, 40);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你将手叉在胸前等着表演。 玩火杂耍者深深咽下一口气并走上了桶。 他放下火把并让一个村民点燃它，但是当他收回火把村民假装把他们自己的火丢进油桶。 杂耍者被短暂的吓到了，人群嘲笑他的同时他露出了小丑的笑容。\n\n 但是小丑做到了。 五个火把转啊转，几次有一点余烬掉到油桶的边缘，但他掌控这情况，而人群的讥讽变成欢呼并在他表演完了后给予他掌声之后就慢慢的散开，前往下一个娱乐项目。 其中一个人给杂耍者的手中放下几枚克朗，就这样。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好哇！",
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
					if (this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(0.5, "被一个玩火杂耍者逗乐了");

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
			ID = "D",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你将手叉在胸前等着表演。 玩火杂耍者深深咽下一口气并走上了桶。 他放下火把并让一个村民点燃它，但是当他收回火把村民假装把他们自己的火丢进油桶。 杂耍者被短暂的吓到了，人群嘲笑他的同时他露出了小丑的笑容。\n\n 当玩火杂耍者开始他的表演时，他把自己点着了。 确实的，第一根火把就从他手上滑落直接掉到罐中引起一束火焰，其中无法分辨人与火除了尖叫。 他爬下“舞台”，群众们只是后退指着他笑。 当他死去，他的克朗都被一个居民拿走了。 他们将金子举向天，顺便提到镀金者，然后就把克朗丢进了火里。 他的遗体被留给狗。 在这一切之后，你在灰烬中踢来踢去找到一块融化了的金子。 没有多少价值，但是总得值点钱，你在没人－连狗都没－看着的时候拿走了它。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "金子就是金子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local money = this.Math.rand(1, 40);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_163.png[/img]{%juggler%，战队里的前杂耍者，走上前。 他走到危险的悬在油罐上的“舞台”。 两个人交谈了几具，然后 %juggler% 留在了上面。 他开始了表演－一个他从没练习或看过的－并完美的完成了它。 尽管，人群很安静。 他们只是看着，时不时的瞟两眼你和你的战队。 当 %juggler% 结束表演他张开他的手臂，但是没有欢呼。%SPEECH_ON%镀金者只会向逐币者吐唾沫，入侵者，你不为任何人跳舞。 还有你，玩火杂耍者，你有什么要为你说的吗？%SPEECH_OFF%%townname%的玩火杂耍者思考了一会然后转向你。%SPEECH_ON%我说我厌倦这些了，如果镀金者如此厌恶我们，我就加入这个战队里让他鄙视。 你说呢，逐币者的队长，你会带上我吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎来到%companyname%战团。",
					function getResult( _event )
					{
						return "F";
					}

				},
				{
					Text = "这里不适合你。",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"juggler_southern_background"
				]);
				_event.m.Dude.setTitle("火焰玩偶师(the Fire Juggler)");
				_event.m.Dude.getBackground().m.RawDescription = "你在街头发现了%name%" + _event.m.Town.getName() + "，准备进行一场激烈的火焰杂耍表演，打破纪录，甚至可能冒着失去生命的风险。幸运的是，" + _event.m.Juggler.getName() + "之后，队长跳进去和他一起完成任务，可能救了他的命。后来，%name%终于厌倦了这种生活，主动加入了你的战团。";
				_event.m.Dude.getBackground().buildDescription(true);
				local trait = this.new("scripts/skills/traits/fearless_trait");

				foreach( id in trait.m.Excluded )
				{
					_event.m.Dude.getSkills().removeByID(id);
				}

				_event.m.Dude.getSkills().add(trait);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.improveMood(1.0, "被一位同行杂技师从可能的火海中救出。");
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你点了点头。%SPEECH_ON%玩火者，逐币者，随便什么。现在一起在 %companyname%。%SPEECH_OFF%人群再次发出嘘声，但你告诉他们滚远点，用你剑的反光给恐吓加点料以防他们没有明白。%firejuggler%，玩火杂耍者，郑重的感谢你并快速的走到队伍中，那里伙计们像欢迎所有新兵一样不情愿的欢迎他。 至于 %townname%的居民，他们很快厌倦了这点戏剧性回到日常生活中去了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "表演结束了，伙计们。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
				local meleeSkill = this.Math.rand(1, 3);
				_event.m.Juggler.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Juggler.getSkills().update();
				_event.m.Juggler.improveMood(1.0, "上演一出精彩的玩火表演");
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Juggler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
				});

				if (_event.m.Juggler.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Juggler.getMoodState()],
						text = _event.m.Juggler.getName() + this.Const.MoodStateEvent[_event.m.Juggler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你摇了摇头。 玩火杂耍者放低了他的声音。%SPEECH_ON%噢，我以为我们可以做到点什么。%SPEECH_OFF%咬住嘴唇，你再次摇了摇头。%SPEECH_ON%不...这里没有什么可以“做到”的。 我只是不想你加入我的战队，与你个人无关。 继续，呃，练习。你懂得，耍火什么的，还有棍子，你总有天会做到的我相信你。%SPEECH_OFF%玩火杂耍者点头。%SPEECH_ON%当然。以及尽管你拒绝了我，我相信镀金者会让我们都到达我们应到的位置的，而他的目的不会让我们的交错毫无意义。 无论我走到哪里，我一定会高度评价你的战队的！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "愿镀金者给我们的道路如同你希望的一般友好。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Juggler.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
				local meleeSkill = this.Math.rand(1, 3);
				_event.m.Juggler.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Juggler.getSkills().update();
				_event.m.Juggler.improveMood(1.0, "上演一出精彩的玩火表演");
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Juggler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
				});

				if (_event.m.Juggler.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Juggler.getMoodState()],
						text = _event.m.Juggler.getName() + this.Const.MoodStateEvent[_event.m.Juggler.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.getTile().getDistanceTo(currentTile) <= 4 && t.isAlliedWithPlayer())
			{
				this.m.Town = t;
				break;
			}
		}

		if (this.m.Town == null)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_juggler = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.juggler")
			{
				candidates_juggler.push(bro);
			}
		}

		if (candidates_juggler.len() != 0)
		{
			this.m.Juggler = candidates_juggler[this.Math.rand(0, candidates_juggler.len() - 1)];
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"juggler",
			this.m.Juggler != null ? this.m.Juggler.getNameOnly() : ""
		]);
		_vars.push([
			"火焰杂技师(firejuggler)",
			this.m.Dude != null ? this.m.Dude.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
		this.m.Juggler = null;
		this.m.Dude = null;
	}

});

