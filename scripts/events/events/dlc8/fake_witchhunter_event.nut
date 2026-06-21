this.fake_witchhunter_event <- this.inherit("scripts/events/event", {
	m = {
		Witchhunter = null
	},
	function create()
	{
		this.m.ID = "event.fake_witchhunter";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你看到一批怒气冲冲的农民围在一个黑色帽子男子周围，他手中拿着一张十字弩指向一名被缚住的人。不远处有一个柱子和柴火，场面骚乱。通过咳出的话语，你了解到了发生的事情：城里聘请的巫师猎人来了，经过调查驳回了这个女巫的指控，准备释放她。这引起了农民们的强烈不满。%SPEECH_ON%太不公了！是的，实在太不公了，我们付出那么多努力，准备一个完美的柴火，终于等到她了，却...却要放了她？！太不公了！但我们一定会让她付出代价，一定会！%SPEECH_OFF%众人咆哮着。看起来这名自称巫师猎人所犯的罪行，恐怕无法得到教会的宽恕。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们必须干预。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Witchhunter != null)
				{
					this.Options.push({
						Text = "女巫猎人%witchhunter%，你认识这个人吗？",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "这与我们无关。",
					function getResult( _event )
					{
						return "E";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_43.png[/img]{你走上前，解释了一项协议的规则，说明这个村庄一定是雇佣这个人杀死女巫的，如果他指向的人不是女巫，那么他就不能杀她。如果他仍然这样做了，那么他会被克朗所迫。如果他决定不杀她，而村庄撤销了协议，那么他以后将被迫简单地听从每个村庄的命令，以防止再次发生这种情况。通过一系列温和的解释，你表明该村庄有显示出不值得信任的危险，由于它所树立的榜样，只会招来那些目的是为了他们的金子而不是完成任务的骗子和恶棍。而且，如果有什么不同，猎人拒绝烧死无辜者显示了他的品德之所在。\n\n当你讲完后，人群大多都同意了你的说法，但有人却说：“还是烧了他！”于是大家重新愤怒起来。不过当他们回过头时，却发现猎魔人在你演说期间已经溜走了。农民们开始互相责怪没看好他。争吵很快就升级成打斗，于是你离开了。当你到达城镇边缘时，偶然遇见了这位“人物”。他给了你一些克朗作为感谢。你发现当有钱时一个人不愿意分享那是很不寻常的。他抬起了黑色的帽子，说他做猎魔这行不是因为钱。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "多奇怪的人。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(75);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]75[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_141.png[/img]{你跨前一步喊着挥舞双手。群众慢慢安静下来并开始关注你。你用谨慎的措辞解释了诚实交易的商业方式，“做生意应该诚实守信，如果付费雇佣某个人，又因为形势发生变化而背叛他，那么他们只会给自己带来一个不值得信赖的村庄，没人想和他们打交道。“在你还没来得及说完，就有人扔石头擦过你的头顶，另一个人冲上来，朝女猎人的胸口刺去。混乱中，你和%companyname%奋力与愤怒的农民拼斗，尽快撤离出了那里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的农民。",
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
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_141.png[/img]{%witchhunter%走了出来。他说黑帽子男子在猎女巫圈子里是个已知的骗子。%SPEECH_ON%我们已经找这个人有一段时间了，他的谎言损害了我们的行业声誉。我一直在寻找机会获得他的头颅。%SPEECH_OFF%话还没说完，%witchhunter%穿过人群出现在另一头，手里拿着一个农民的长叉，迅速将其刺进伪猎人的腿中。男子痛苦地弯下腰。伪猎人拔出十字弓，但%witchhunter%抓住了弩枪的枪管，向上一甩，一根箭无意间飞向了天空。他抢过弩枪，大声说这不属于他，并向着人群宣布该男子是个骗子。他将其摔倒在地，告诉人们想干什么就干什么。他们（指人群）开始对这个骗子进行报复，但因为人群激动难以确认所施加的恶行。%witchhunter%回来了，手里拿着十字弓，左看右看。这是你有一段时间以来见过的最令人难以置信的武器。女巫猎人解释道。%SPEECH_ON%这属于该地区的公会大师。我们认为这个傻瓜谋杀了他，拿走了他的衣服，并一直装扮成这个角色。船长，如果他的哭声打扰了你，只要记住他已经烧死了无辜的人，从绝望和混乱者那里偷走了无数克朗。该死的骗子。%SPEECH_OFF%你凝视着男子和人群。你只能看到男子被抬上火刑木和升起的烟。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们回到路上.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Witchhunter.getImagePath());
				local item = this.new("scripts/items/weapons/named/named_crossbow");
				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_43.png[/img]{虽然打醉的私刑团体是农民喜欢的娱乐方式，但你能嗅到空气中的危险气息，并将%companyname%移至镇边缘。你永远不知道这些事情何时会失控，凡夫俗子开始对周围每个人动手。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们离开这里。",
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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();
		local foundTown = false;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 2)
			{
				continue;
			}

			if (t.getTile().getDistanceTo(currentTile) <= 3)
			{
				foundTown = true;
				break;
			}
		}

		if (!foundTown)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.getTime().Days <= 25)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_witchhunter = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.witchhunter" && bro.getLevel() >= 4)
			{
				candidates_witchhunter.push(bro);
			}
		}

		if (candidates_witchhunter.len() != 0)
		{
			this.m.Witchhunter = candidates_witchhunter[this.Math.rand(0, candidates_witchhunter.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"witchhunter",
			this.m.Witchhunter != null ? this.m.Witchhunter.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Witchhunter = null;
	}

});

