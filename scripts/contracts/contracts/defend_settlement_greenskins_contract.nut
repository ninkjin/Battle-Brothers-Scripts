this.defend_settlement_greenskins_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Reward = 0,
		Kidnapper = null,
		Militia = null
	},
	function create()
	{
		this.contract.create();
		this.m.Type = "contract.defend_settlement_greenskins";
		this.m.Name = "保卫城镇";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 5.0;
		this.m.MakeAllSpawnsResetOrdersOnContractEnd = false;
		this.m.MakeAllSpawnsAttackableByAIOnceDiscovered = true;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 900 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();

		if (this.Math.rand(1, 100) <= 33)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else
		{
			this.m.Payment.Completion = 1.0;
		}

		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"保卫 %townname% 及其郊区免受掠夺"
				];

				if (this.Math.rand(1, 100) <= this.Const.Contracts.Settings.IntroChance)
				{
					this.Contract.setScreen("Intro");
				}
				else
				{
					this.Contract.setScreen("Task");
				}
			}

			function end()
			{
				this.World.Assets.addMoney(this.Contract.m.Payment.getInAdvance());
				local r = this.Math.rand(1, 100);
				local nearestOrcs = this.Contract.getNearestLocationTo(this.Contract.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements());
				local nearestGoblins = this.Contract.getNearestLocationTo(this.Contract.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getSettlements());

				if (nearestOrcs.getTile().getDistanceTo(this.Contract.m.Home.getTile()) + this.Math.rand(0, 6) <= nearestGoblins.getTile().getDistanceTo(this.Contract.m.Home.getTile()) + this.Math.rand(0, 6))
				{
					this.Flags.set("IsOrcs", true);
				}
				else
				{
					this.Flags.set("IsGoblins", true);
				}

				if (this.Math.rand(1, 100) <= 25 && this.Contract.getDifficultyMult() >= 0.95)
				{
					this.Flags.set("IsMilitia", true);
				}

				local number = 1;

				if (this.Contract.getDifficultyMult() >= 0.95)
				{
					number = number + this.Math.rand(0, 1);
				}

				if (this.Contract.getDifficultyMult() >= 1.1)
				{
					number = number + 1;
				}

				local locations = this.Contract.m.Home.getAttachedLocations();
				local targets = [];

				foreach( l in locations )
				{
					if (l.isActive() && !l.isMilitary() && l.isUsable())
					{
						targets.push(l);
					}
				}

				number = this.Math.min(number, targets.len());
				this.Flags.set("ActiveLocations", targets.len());

				for( local i = 0; i != number; i = ++i )
				{
					local party;

					if (this.Flags.get("IsGoblins"))
					{
						party = this.Contract.spawnEnemyPartyAtBase(this.Const.FactionType.Goblins, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}
					else
					{
						party = this.Contract.spawnEnemyPartyAtBase(this.Const.FactionType.Orcs, this.Math.rand(80, 110) * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
					}

					party.setAttackableByAI(false);
					local c = party.getController();
					c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(false);
					c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
					local t = this.Math.rand(0, targets.len() - 1);

					if (i > 0)
					{
						local wait = this.new("scripts/ai/world/orders/wait_order");
						wait.setTime(4.0 * i);
						c.addOrder(wait);
					}

					local move = this.new("scripts/ai/world/orders/move_order");
					move.setDestination(targets[t].getTile());
					c.addOrder(move);
					local raid = this.new("scripts/ai/world/orders/raid_order");
					raid.setTime(40.0);
					raid.setTargetTile(targets[t].getTile());
					c.addOrder(raid);
					targets.remove(t);
				}

				this.Contract.m.Home.setLastSpawnTimeToNow();
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(false);
			}

			function update()
			{
				if (this.Contract.m.UnitsSpawned.len() == 0 || this.Flags.get("IsEnemyHereDialogShown"))
				{
					local isEnemyGone = true;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.getDistanceTo(this.Contract.m.Home) <= 1200.0)
						{
							isEnemyGone = false;
							break;
						}
					}

					if (isEnemyGone)
					{
						if (this.Flags.get("HadCombat"))
						{
							this.Contract.setScreen("ItsOver");
							this.World.Contracts.showActiveContract();
						}

						this.Contract.setState("Return");
						return;
					}
				}

				if (!this.Flags.get("IsEnemyHereDialogShown"))
				{
					local isEnemyHere = false;

					foreach( id in this.Contract.m.UnitsSpawned )
					{
						local p = this.World.getEntityByID(id);

						if (p != null && p.isAlive() && p.getDistanceTo(this.Contract.m.Home) <= 700.0)
						{
							isEnemyHere = true;
							break;
						}
					}

					if (isEnemyHere)
					{
						this.Flags.set("IsEnemyHereDialogShown", true);

						foreach( id in this.Contract.m.UnitsSpawned )
						{
							local p = this.World.getEntityByID(id);

							if (p != null && p.isAlive())
							{
							}
						}

						if (this.Flags.get("IsGoblins"))
						{
							this.Contract.setScreen("GoblinsAttack");
						}
						else
						{
							this.Contract.setScreen("OrcsAttack");
						}

						this.World.Contracts.showActiveContract();
					}
				}
				else if (this.Flags.get("IsKidnapping") && !this.Flags.get("IsKidnappingInProgress") && this.Contract.m.UnitsSpawned.len() == 1)
				{
					local p = this.World.getEntityByID(this.Contract.m.UnitsSpawned[0]);

					if (p != null && p.isAlive() && !p.isHiddenToPlayer() && !p.getController().hasOrders())
					{
						local c = p.getController();
						c.getBehavior(this.Const.World.AI.Behavior.ID.Attack).setEnabled(true);
						c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(true);
						this.Contract.m.Kidnapper = this.WeakTableRef(p);
						this.Flags.set("IsKidnappingInProgress", true);
						this.Flags.set("KidnappingTooLate", this.Time.getVirtualTimeF() + 60.0);
						this.Contract.setScreen("Kidnapping1");
						this.World.Contracts.showActiveContract();
						this.Contract.setState("Kidnapping");
					}
				}

				if (this.Flags.get("IsMilitia") && !this.Flags.get("IsMilitiaDialogShown"))
				{
					this.Flags.set("IsMilitiaDialogShown", true);
					this.Contract.setScreen("Militia1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

			function onCombatVictory( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

		});
		this.m.States.push({
			ID = "Kidnapping",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"营救被劫走的俘虏",
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = false;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(false);

				if (this.Contract.m.Kidnapper != null && !this.Contract.m.Kidnapper.isNull())
				{
					this.Contract.m.Kidnapper.getSprite("selection").Visible = true;
				}
			}

			function update()
			{
				if (this.Contract.m.Kidnapper == null || this.Contract.m.Kidnapper.isNull() || !this.Contract.m.Kidnapper.isAlive())
				{
					if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() <= 5.0)
					{
						this.Flags.set("IsKidnapping", false);
						this.Contract.setScreen("Kidnapping2");
					}
					else
					{
						this.Contract.setScreen("Kidnapping3");
					}

					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
				else if (this.Contract.m.Kidnapper.isHiddenToPlayer() && this.Time.getVirtualTimeF() > this.Flags.get("KidnappingTooLate"))
				{
					this.Contract.setScreen("Kidnapping3");
					this.World.Contracts.showActiveContract();
					this.Contract.setState("Return");
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

			function onCombatVictory( _combatID )
			{
				this.Flags.set("HadCombat", true);
			}

		});
		this.m.States.push({
			ID = "Return",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"返回" + this.Contract.m.Home.getName()
				];
				this.Contract.m.Home.getSprite("selection").Visible = true;
				this.World.FactionManager.getFaction(this.Contract.getFaction()).setActive(true);

				if (this.Contract.m.Kidnapper != null && !this.Contract.m.Kidnapper.isNull())
				{
					this.Contract.m.Kidnapper.getSprite("selection").Visible = false;
				}
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					local locations = this.Contract.m.Home.getAttachedLocations();
					local numLocations = 0;

					foreach( l in locations )
					{
						if (l.isActive() && !l.isMilitary() && l.isUsable())
						{
							numLocations = ++numLocations;
						}
					}

					if (numLocations == 0 || this.Flags.get("ActiveLocations") - numLocations >= 2)
					{
						if (this.Flags.get("IsKidnapping") && this.Flags.get("IsKidnappingInProgress"))
						{
							this.Contract.setScreen("Failure2");
						}
						else
						{
							this.Contract.setScreen("Failure1");
						}
					}
					else if (this.Flags.get("ActiveLocations") - numLocations >= 1)
					{
						if (this.Flags.get("IsKidnapping") && this.Flags.get("IsKidnappingInProgress"))
						{
							this.Contract.setScreen("Success4");
						}
						else
						{
							this.Contract.setScreen("Success2");
						}
					}
					else if (this.Flags.get("IsKidnapping") && this.Flags.get("IsKidnappingInProgress"))
					{
						this.Contract.setScreen("Success3");
					}
					else
					{
						this.Contract.setScreen("Success1");
					}

					this.World.Contracts.showActiveContract();
				}
			}

		});
	}

	function createScreens()
	{
		this.importScreens(this.Const.Contracts.NegotiationDefault);
		this.importScreens(this.Const.Contracts.Overview);
		this.m.Screens.push({
			ID = "Task",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_20.png[/img]{当你看到%employer%的时候，他的汗水顺着脸颊淌下，用一块精美绣花的布擦拭，但似乎没有任何作用。%SPEECH_ON%雇佣兵，见到你真是太好了！请，请进来听我说些什么。%SPEECH_OFF%你小心翼翼地走进房间，坐了下来，瞥了一眼，确保门角或书架后面没有人藏着。%employer%把一张地图推到桌上。%SPEECH_ON%看到那些绿色标记了吗？那是我的侦察队发现的绿皮兽人行踪。有时他们会告诉我，有时他们根本不会告诉我。那些侦察队员只是……突然消失。不过并不需要什么天才就知道他们真正发生了什么，不是吗？%SPEECH_OFF%你问这个人想要什么。他猛地砸了一下地图，拍在了%townname%上。%SPEECH_ON%你看不到吗？他们正在往这边靠近，我需要你来帮助我们抵御！%SPEECH_OFF% | [%employer%]紧张地咬着指甲，当你找到他的时候。此刻他的指甲早已磨得只剩下皮肤和点点鲜血。%SPEECH_ON%雇佣兵，谢谢你赶来。我想坦白告诉你，绿皮族来了。%SPEECH_OFF%他用手比划着高度，你问是哪种绿皮族，大的还是带角的。%employer%耸了耸肩。%SPEECH_ON%我不知道。我的侦查员不断失踪，而到来的村民们也不是最准确的见证人。你需要知道的是，我们需要你的帮助，因为那些绿皮族正朝我们这个方向来。%SPEECH_OFF% | %employer%（雇主）正喝醉了，深深地躺在椅子里。他用拇指指向桌子上打开的一本书。%SPEECH_ON%你听说过“诸多名战役”吗？那是大约十年前发生的一场战役，当兽人涌入人类领域时，人类组成军队并说：不。%SPEECH_OFF%你点点头，深刻知道那场战斗，以及它帮助结束的战争。然后这个人继续说话。%SPEECH_ON%不幸的是，我们有理由相信，他们要回来了。绿皮肤，不知道是什么类型的，不知道多高或什么样子，但他们确实要来。%SPEECH_OFF%他把剩下的饮料倒进嗓子里，吞咽着，好像是行刑官移除他的头之前最后一件事。%SPEECH_ON%你愿意留在这里保护我们吗？当然，要有合适的价格。我还没有忘记你的现状。%SPEECH_OFF% | %employer%正在他的窗户旁等你进来。%SPEECH_ON%你听到了吗？%SPEECH_OFF%街上一群人几乎在咆哮着，有些人无动于衷，有些人则直接尖叫惊恐。%SPEECH_ON% 绿皮兽来的时候你会听到这样的声音。%SPEECH_OFF%那人关上窗户并转向你。%SPEECH_ON%虽然这让人们非常不安，但我们有钱，所以还是问问吧。你能帮忙保护%townname%吗？%SPEECH_OFF% | %employer%正在与人群搏斗，你找到了他。%SPEECH_ON%大家冷静一点！冷静下来！%SPEECH_OFF%有人扔了一个洋葱，那个人头上挨了一下，酸涩的蔬菜汁让他感到撕心裂肺。另一个人迅速跑过去捡起来咬了一口。%employer%在人群中找到了你。%SPEECH_ON%佣兵！我很高兴你来了！%SPEECH_OFF%他冲过人群，凑近你的耳朵，却还要高声喊叫才能被听到。%SPEECH_ON%我们有钱！我们有你需要的东西！只要帮助保护这个城镇免受绿皮兽的侵袭！%SPEECH_OFF% | %employer%的员工正在他的房间里搜刮卷轴和书籍，然后匆忙离开到某个你不知道的地方。他本人只是坐在他的椅子上，偶尔喝着酒杯，同时观看地图。他挥手示意你进来。%SPEECH_ON%坐下。别在意我的工人们。%SPEECH_OFF%你按照要求做了，但周围的狂热很难被忽视。%employer%向后靠着椅背，交叉着手，放在肚子上。%SPEECH_ON%我相信你已经注意到这里的事情相当不寻常。那是因为发现了一大群绿皮，他们正在往这边走，屠杀和摧毁所有挡在他们面前的东西。很明显，我希望你能帮忙保卫%townname%，这样我们就不会最后成为某位文士笔下的注脚了，明白吗？%SPEECH_OFF% | 你进入%employer%的住所，不禁注意到地板上都是泥巴，火坑里的火也被扑灭了。他的一些工人手里都拿着卷轴，你几乎看不到他们头顶上的纸张。你看到%employer%站在混乱中心，简单地指挥着他的员工做这个或那个。当你走到他身边，他只是点了点头。%SPEECH_ON%绿皮兽来了。是什么类型的？我不知道。但我知道如果我不能帮助保卫这座城镇会发生什么，这就是我们在这里做一些准备的原因，你明白吗？%SPEECH_OFF%你也点点头，然后问他还有什么需要。%SPEECH_ON%当然是帮我们打这些绿皮兽。显然，这会给你带来很多钱。%SPEECH_OFF% | 农民们来到%employer% 的住所。 他们背着一大堆东西，一路上拖着小担架，如此急迫地逃离，甚至不费力气地拾起任何东西。 %employer% 本人透过他的窗户看到了你，并向你招手让你从侧门进来。当你偷偷摸摸地进去时，他只是在他的椅子上瘫坐下来，给你倒了一杯饮料。%SPEECH_ON%绿皮兽人要来了，我认为手头没有足够的士兵来保卫 %townname%。 显然，我愿意请求并支付您的服务，以帮助保护 %townname%，免受这种绿色威胁。%SPEECH_OFF% | 一个男人站在%employer%的住所外面，身上裹着两块彩绘的木板。每块木板上都写着一些预言性的厄运故事。你忽略了那个男人，走进了房子。%employer%正在那里笑着摇头。%SPEECH_ON%那个站在外面的家伙没错。我的侦查员一直在报告绿皮族在这一带活动。我本应该听从他们的。可是已经一个星期了，我的侦查员没有任何消息。很可能是被那些绿皮族干掉了。现在普通人带着恐怖的故事来找我，说有大批可怕的生物向这边靠近。%SPEECH_OFF%他转向你，咧嘴一笑，眼神中透着疯狂。%SPEECH_ON%那么，你愿意和我做笔交易，让那个厄运预言者闭嘴吗？你会帮忙保护%townname%吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{%townname%为了他们的安全准备好支付多少报酬？ | 这应该对你来说值不少克朗，对吧？ | 对抗绿皮族可不便宜。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{恐怕你要一个人了。 | 恐怕这对 %companyname% 来说不值得。 | 我祝你好运，但我们不会参与其中。}",
					function getResult()
					{
						if (this.Math.rand(1, 100) <= 60)
						{
							this.World.Contracts.removeContract(this.Contract);
							return 0;
						}
						else
						{
							return "Plea";
						}
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "Plea",
			Title = "谈判",
			Text = "[img]gfx/ui/events/event_43.png[/img]{拒绝了%employer%的请求，你遇到了一个笑着摇头的人。 %SPEECH_ON%嘿，现在，兽人不是那样子的，除非，当然，那是你的计划，你这个没用的懦夫。 %SPEECH_OFF%你拔出剑，让它的钢划过剑鞘。那人笑了。 %SPEECH_ON%哦，那你要用它做什么？杀了我吗？好吧。做得比兽人还糟，我敢打赌。%SPEECH_OFF%一个女人跑出来，抓住那个男人，把他拉回来。 %SPEECH_ON%快叫孩子们，带上他们，我们得马上走！%SPEECH_OFF%那对缩在一起的人走了，但是你的脑子还充满了乡下人对懦夫的指控。 | 乡下人已经开始收拾路了，离开%townname%。几个人瞥了你一眼，甚至有一个走了过来，一位拄着拐杖的老人。%SPEECH_ON%你瞧，今天的世界就是这样！所有优秀的男人都死了，只剩下像这个所谓的剑客这样的懦夫。%SPEECH_OFF%%randombrother%走了过来，挥舞着他的武器，看起来准备杀人。 %SPEECH_ON%你敢辱骂%companyname%吗？我会割掉你的舌头，然后砍下你的头，老年人！%SPEECH_OFF%你抓住佣兵的肩膀。这些人最不需要的是暴力，但是那个人说得好像很响亮。现在你在想是谁听到了他的话，谁将活下来传播他的话。 | 一个女人紧紧抓住你，当你试图回到队伍时。%SPEECH_ON%先生，请！您不能把我们留下来面对这个命运！您不知道兽人会对我们做什么！%SPEECH_OFF%你其实有一个非常强烈的想法，但是你把它藏在心里。那个女人跪了下来，紧紧抓住你的脚踝。你设法挣脱出她的掌握。她短暂地爬行着，穿过泥浆，然后停下来哭泣。%SPEECH_ON%你不知道这是什么感觉，永远不会变好。对我来说。%SPEECH_OFF%天哪，这是多么可悲，但你在内心深处找到了一点同情。 | 当你拒绝了%employer%的请求时，一个男人走出了他的住所。他在摸摸一只鸡，眼中有泪水。%SPEECH_ON%先生，如果您留下来，您可以得到她。%SPEECH_OFF%农民吻着鸡，它毫无意义地尖叫着，不完全反映出它主人脸上的痛苦。%SPEECH_ON%留下来帮忙拯救这座城吧。你可以拥有她。请留下，请。%SPEECH_OFF%哦天哪，这就是结果？ | 一位蓬头垢面、非常老的人走向你。%SPEECH_ON%所以，你决定不帮忙了？我不能怪你。%SPEECH_OFF%他向旁边站着的几个乡下人挥了挥手。他们手拿着货箱，里面塞满了东西，从发霉的蔬菜到一两只鸡，或者这两只鸡是一只又小又咯咯叫的小羊。%SPEECH_ON%这些人想要你留下来帮忙。但我理解你不想。我曾经在“许许多多名字之战”中。我知道和那些野兽战斗的感受。我不怪你。需要一个非常有能力的人去面对它。没错，对的，先生，我不会怪你的。%SPEECH_OFF%他慢慢地蹒跚离开，那时你注意到他的腿中有一条是木制腿。几个孩子跑向他，他跟乡下人交谈。他看着你，然后又回头看着他们，摇了摇头。你几乎能感到悲伤和失望淹没了你。}",
			Image = "",
			List = [],
			ShowEmployer = false,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{该死，我们不能让这些人死去。 | 好吧，好吧，我们不会离开 %townname%。至少让我们谈论一下报酬。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{我相信你能挺过去的。让开。 | 我不会冒险去救一些挨饿的农民，况且不能让%companyname%冒险。}",
					function getResult()
					{
						this.World.Contracts.removeContract(this.Contract);
						return 0;
					}

				}
			],
			function start()
			{
			}

		});
		this.m.Screens.push({
			ID = "OrcsAttack",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_49.png[/img]绿皮兽人出现了！准备战斗，保卫城镇！",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "GoblinsAttack",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_48.png[/img]绿皮兽人出现了！准备战斗，保护城镇！",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOver",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_22.png[/img]{战斗结束了。%employer%毫无疑问会很高兴再次见到你。 | 战斗结束了，士兵们暂时休息。%employer%在城里等你。 | 战斗结束，你俯瞰着遍地的尸体。这是一个恐怖的景象，但出于某种原因，这激励了你的斗志。死掉的人们只提醒你世间依旧充满活力。像%employer%这样的人应该来看看，但他不会来，所以你必须去找他。 | 血肉和骨头散落在战场上，几乎无法分辨属于哪个人。黑色的秃鹫在上空盘旋，死者身上呈V字形的阴影在尸体上荡漾。这些鸟儿等待着哀悼者离开。%randombrother%走到你身边询问是否要开始返回%employer%。你离开战场的景象，点点头。 | 死亡制造了和平的废墟，仿佛这是它们的自然状态，僵硬而永久失去，而它们整个生命只是一个短暂的意外事件。%randombrother%走过来问你是否一切安好。老实说，你不确定，只是回答该去见%employer%了。 | 毁坏的人和扭曲的尸体弥漫在地面上，战争让死者无权掌控自己的最后安息方式。那些没有身体的头看起来最为安详，因为在战斗中，没有人或野兽有时间去真正地砍断一个脖子，它只能来自最快和最锋利的刀锋。你希望自己也能够有如此的瞬间终结，但另一部分希望你有机会将杀手拖垮。\n\n%randombrother%走到你身边并要求命令。你背过身去告诉%companyname%准备好返回%employer%。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们回市政厅！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "ItsOverDidNothing",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_30.png[/img]烟雾弥漫在空气中，烟和燃烧的木头，燃烧的生计的腐蚀性气味。%townname%的人们将所有希望寄托在雇佣%companyname%上，这是致命的错误。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "计划走了偏路...",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia1",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_80.png[/img]{在准备保卫%townname%的过程中，当地的民兵已经归附于你的一方。他们会遵从你的命令，并询问你将他们派往最需要的地方。 | 看起来当地的民兵已经加入了战斗！虽然这是一支杂乱无章的农民队伍，但是他们仍然会有所作为。现在的问题是，要将他们派往哪里？ | %townname% 的民兵已经加入了战斗！虽然是一支装备简陋、武器不好的部队，但是他们非常渴望保护家园。他们会遵从你的命令，并信任你将他们派往最需要的地方。 | 你并不是孤军奋战！%townname%的民兵已经加入了你们。他们热切希望参战，并询问你将他们派往哪里他们可以发挥最大的作用。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "排好队，你将听从我的指挥。",
					function getResult()
					{
						return "Militia2";
					}

				},
				{
					Text = "前往保卫%townname%的市政厅。",
					function getResult()
					{
						local home = this.Contract.m.Home;
						local party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(home.getTile(), home.getName() + " Militia", false, this.Const.World.Spawn.Militia, home.getResources() * 0.7);
						party.getSprite("banner").setBrush(home.getBanner());
						party.setDescription("勇敢的人用生命保卫家园。农夫、工匠、技工，但没有一个真正的士兵。");
						party.setFootprintType(this.Const.World.FootprintsType.Militia);
						this.Contract.m.Militia = this.WeakTableRef(party);
						local c = party.getController();
						local guard = this.new("scripts/ai/world/orders/guard_order");
						guard.setTarget(home.getTile());
						guard.setTime(300.0);
						local despawn = this.new("scripts/ai/world/orders/despawn_order");
						c.addOrder(guard);
						c.addOrder(despawn);
						return 0;
					}

				},
				{
					Text = "去保卫%townname%的郊区。",
					function getResult()
					{
						local home = this.Contract.m.Home;
						local party = this.World.FactionManager.getFaction(this.Contract.getFaction()).spawnEntity(home.getTile(), home.getName() + " Militia", false, this.Const.World.Spawn.Militia, home.getResources() * 0.7);
						party.getSprite("banner").setBrush(home.getBanner());
						party.setDescription("勇敢的人用生命保卫家园。农夫、工匠、技工，但没有一个真正的士兵。");
						party.setFootprintType(this.Const.World.FootprintsType.Militia);
						this.Contract.m.Militia = this.WeakTableRef(party);
						local c = party.getController();
						local locations = home.getAttachedLocations();
						local targets = [];

						foreach( l in locations )
						{
							if (l.isActive() && !l.isMilitary() && l.isUsable())
							{
								targets.push(l);
							}
						}

						local guard = this.new("scripts/ai/world/orders/guard_order");
						guard.setTarget(targets[this.Math.rand(0, targets.len() - 1)].getTile());
						guard.setTime(300.0);
						local despawn = this.new("scripts/ai/world/orders/despawn_order");
						c.addOrder(guard);
						c.addOrder(despawn);
						return 0;
					}

				},
				{
					Text = "去躲起来，别挡路。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Militia2",
			Title = "在 %townname%",
			Text = "[img]gfx/ui/events/event_80.png[/img]现在你决定要指挥当地人，他们问你如何为即将到来的战斗武装自己。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿上弓，你会从后方进行射击。",
					function getResult()
					{
						for( local i = 0; i != 4; i = ++i )
						{
							local militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest_ranged");
							militia.setFaction(1);
							militia.setPlaceInFormation(19 + i);
							militia.assignRandomEquipment();
						}

						return 0;
					}

				},
				{
					Text = "拿上剑和盾，你将在前线战斗。",
					function getResult()
					{
						for( local i = 0; i != 4; i = ++i )
						{
							local militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest");
							militia.setFaction(1);
							militia.setPlaceInFormation(19 + i);
							militia.assignRandomEquipment();
						}

						return 0;
					}

				},
				{
					Text = "你们可以随意武装。",
					function getResult()
					{
						for( local i = 0; i != 4; i = ++i )
						{
							local militia;

							if (this.Math.rand(0, 1) == 0)
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest");
							}
							else
							{
								militia = this.World.getGuestRoster().create("scripts/entity/tactical/humans/militia_guest_ranged");
							}

							militia.setFaction(1);
							militia.setPlaceInFormation(19 + i);
							militia.assignRandomEquipment();
						}

						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "MilitiaVolunteer",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_80.png[/img]{战斗结束后，一名参与防御的民兵亲自来找你，弯腰递上他的剑。%SPEECH_ON%队长，我与%townname%镇的时间已经结束，但%companyname%的能力真的是令人惊叹的。如果有机会，队长，我愿意和您以及您的士兵并肩作战。%SPEECH_OFF% | 随着战斗的结束，来自%townname%的一名民兵表示他愿意为%companyname%而战。部分原因是他对雇佣兵团的战斗印象深刻，部分原因是被征召到镇上的防御既没有经济效益也不健康。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "欢迎加入 %companyname%！",
					function getResult()
					{
						return 0;
					}

				},
				{
					Text = "这里不适合你。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Kidnapping1",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_30.png[/img]{在警戒这些绿皮兽人的同时，一个农民过来告诉你，兽人袭击了附近，似乎劫持了一群人质。你不敢相信这些野兽是如何偷偷潜入并做到这一点的？这位凡人也摇了摇头。%SPEECH_ON%我认为你们应该帮助我们。你们为什么什么都没做？%SPEECH_OFF%你问兽人是否已经逃远了。农民耸了耸肩，但他认为他们仍然足够近。看来你仍然有机会在这些可怜人遭受不可预知的命运之前把他们救回来。 | 一个穿着破烂衣服，手持损坏的钢叉跑向你的战团。他跌倒在地，痛苦地哭泣着。%SPEECH_ON%兽人袭击了！哦，他们就像我祖父说的那样！你们都在哪里？他们杀了人...烧了一些...还...我认为他们吃了一些...哦，天啊。但这不是最糟糕的！兽人抓住了一些可怜的人质！拯救他们，请！%SPEECH_OFF% 你望着%randombrother%，点了点头。%SPEECH_ON%准备好士兵，我们需要追击这些邪恶的兽人，在他们完全逃走之前。%SPEECH_OFF% | 你的眼睛紧盯着地平线，寻找任何肮脏的兽人的痕迹或声音。突然，%randombrother%带着一个女人走向你。他把她往前推了推，点了点头。她抱着胸口哭泣着，讲述了兽人已经袭击了近郊的村庄的故事。她解释说，他们不仅残忍地杀死了人，而且还抓住了一些人质。这位佣兵点了点头。%SPEECH_ON%看起来他们趁我们不备溜走了，长官。%SPEECH_OFF%现在你只有一个选择，那就是去把那些人救回来！ | 在%townname%附近的一个地方，你等待着兽人的袭击。你以为这会很容易，但一个疯狂的凡人的突然出现表明情况并非如此。农民解释说，那些丑恶的掠夺者已经伏击了最近一个偏远的村庄。他们屠杀了每个人，然后，血腥行径完成后，抓住了几个男人、女人和孩子。这位农民，无论是喝醉了还是处于震惊状态，语无伦次地求你们帮忙。%SPEECH_ON%赶紧……赶快救回他们，行吗？%SPEECH_OFF% | 几个愤怒的农民沿着公路走来，涌向你，愤怒的情绪席卷而来。%SPEECH_ON%我以为我们雇佣了你来保护我们！你们都在哪里？%SPEECH_ON%他们浑身是血。有些人半穿着衣服。一个男人抱着他的胸口。他失去了一只手。你询问这群人在说什么。一位妇女挺身而出，孩子们缩在她脚边。她捂住他们的耳朵。%SPEECH_ON%我们在谈论什么？你们这些该死的雇佣兵！绿皮兽人来了，没有别的！你们本应该保护我们，但肯定在忙于互相调情和犯蠢才发现他们已经溜走了！我们逃脱了，但那些没能逃脱的人被他们抓走了！你知道那些被兽人抓走的人会发生什么吗？我是说，我不知道，但我怀疑那不是一首歌和一块馅饼！你让这位女人闭嘴，否则她的嘴巴将承载她无法承受的痛苦。%SPEECH_ON%我们会把他们救回来的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "抓住他们！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Kidnapping2",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_22.png[/img]{收起剑，你命令%randombrother%去解救囚犯。一群困惑的农民被从皮制绳索、铁链和狗笼中解救出来。他们感谢你及时赶到。其中一人用手抓着腕部的伤口，那里曾经被锁链勒着。%SPEECH_ON%感激不尽，雇佣兵。%SPEECH_OFF%他点了指向火堆上一个干瘪的黑色尸体的地方。%SPEECH_ON%可惜你来晚了，来不及救她。她曾是个真正的美人。现在，看看她。%SPEECH_OFF%那个人一边苦笑着一边哭了出来。 | 被诅咒的绿皮兽全部被杀死了。你让你的士兵们去解救他们能找到的每个农民。他们一起拥抱、哭泣，嗨疯了，因为他们幸存于这可怕的劫难中。 | 在杀死了最后一个绿皮兽之后，你命令同伴们解救人质。每个人一个接一个地来找你，有的吻你的手，有的吻你的脚。你告诉他们回到%townname%的市政厅，因为你也要去那里。 | 在杀死最后一个绿皮兽之后，你命令众人解救人质。他们跌跌撞撞地从战斗的废墟中爬出来，完全失去了思维。有些人在绿皮兽的营地里翻找着什么。你看着一个{男人 | 女人}举起一堆冒着烟雾的焦黑骨头。他们只是凝视着遗骸，放下它们，然后继续向荒野深处走去。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "看起来这结束了。",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Kidnapping3",
			Title = "靠近 %townname%",
			Text = "[img]gfx/ui/events/event_53.png[/img]{不幸的是，绿皮兽人带着人质逃走了。愿神保佑这些可怜的灵魂。 | 你没有救回那些可怜的农民。现在只有神知道他们将会面临什么。实际上，你也知道，但你会装傻，只为了能够安稳地入睡。 | 可悲的是，那些恶兽带着人类战利品逃走了。这些可怜的人现在只能自谋生路。然而，你听到的故事告诉你，他们将会遭遇到可怕的命运。 | 绿皮兽人带着他们的俘虏一起逃走了。你不知道这些人现在会发生什么，但你知道那不是好事。奴役、折磨、死亡。你不确定哪一个更糟糕。 | 绿皮兽人和他们不幸的人质逃走了。你祝愿这些人一切安好，但当风转向，吹出空荡而僵硬的歌声时，你很清楚，没有任何祝福或祈祷能够拯救这些可怜的灵魂。 | 好吧，绿皮兽人逃走了。嚼过的人骨和撕下的肉堆高如山，证明了你的失败。 | 你拾起一块布料，发现它曾被搁在一堆骨头上。%SPEECH_ON%该死。%SPEECH_OFF%地面上留下了一串残羹剩饭的痕迹。绿皮兽人逃跑了，可怜的俘虏也消失了。 | %randombrother%喊你过去。当你站在他身旁时，他指着地上的一堆粪便。你耸了耸肩。%SPEECH_ON%是啊，有臭味。还有呢？%SPEECH_OFF%他踢了一片白色东西，从粪便中拾起看起来像是一根骨头的东西。%SPEECH_ON%那可是人类的骨头。俘虏被吃掉了，先生。%SPEECH_OFF%你向草地四处张望，发现更多的人骨。足迹从现场指向远方，绿皮兽人显然逃脱了你的追捕。你叹了口气，告诉众人准备离开。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{他们在%townname%不会喜欢这个…… | 希望他们能快速死去。}",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer%用%reward%克朗的宝箱欢迎你的归来。%SPEECH_ON%佣兵，你赢得了这个，我不得不说。镇上的任何一个部分，恩... 任何重要的部分都没有被触碰过。%SPEECH_OFF%他停顿了一下，你凝视着宝箱。这次战斗是艰苦而不易的。你只是期望得到更多。有时候作为一名佣兵的简单方式真的让你感到麻烦。 | 你看到%employer%在喂养他的某些狗。他一遍又一遍地抚摸着其中一只。%SPEECH_ON%我真的以为我得放弃了。%SPEECH_OFF%他朝着那只狗的方向伸出一只手最后轻轻地拍了一下，然后把目光转向了你。%SPEECH_ON%谢谢你，佣兵。你不仅仅保护了这座城镇，也保护了一种生活方式。没有你，我们要么就是全部死光，否则就是熬过明天令人发指的恐怖。%SPEECH_OFF%你点点头，向前走去抚摸了其中一只狗，但它咆哮着瞪着你。%employer%笑了起来。%SPEECH_ON%请原谅它的无知。%SPEECH_OFF% | 在房间里围着%employer%的是一群男男女女。当你走进房间时，他们几乎异口同声地转向你。他们盯着你看了一会儿，然后欢呼并冲向你，拥抱你，流泪等。你挣扎着脱离他们，找到了手中拿着一个小包的%employer%。%SPEECH_ON%这是为拯救%townname%而奖励给你的，佣兵。老实说，它不像应该那么沉，但这是我们所有的东西了。%SPEECH_OFF% | 当你回到他那里时，%employer%正朝窗外看着。外面，民兵在奔跑，镇上的居民也相互拥抱着。 %SPEECH_ON%没有一个“绿皮”进入市中心。%SPEECH_OFF%他笑着递给你一个小包的物品。%SPEECH_ON%你今天做得非常出色，佣兵。%SPEECH_OFF% | 寻找%employer%并不容易: 整个城镇都在欢呼喧哗中。他们杀鸡杀得飞快，有时鸟儿还能逃走，拖着半根羽毛在路上乱窜，孩子们在后面追赶。在庆典热闹中，%employer%成功地走到你身边。%SPEECH_ON%有很多悲伤需要面对，但我们将其留到明天。今天，我们要庆祝生命和你的功绩，佣兵。%SPEECH_OFF%这个人递给了你一个沉甸甸的小包。 | 你发现%employer%正在整理书架。他似乎正在重新进货，认真地清点和编号他的商品，就像一个商贩一样。你进门时，门砰的一声关上，他吓了一跳。%SPEECH_ON%啊，佣兵！你吓了我一跳。%SPEECH_OFF%他从书架上拿出一个箱子递给你。%SPEECH_ON%我打算拿走所有这些书，所有这些卷轴，然后一溜烟跑路。但是，现在，我不需要了，这全都要感谢你。%SPEECH_OFF%他的笑容稍稍变得有点苦涩。%SPEECH_ON%并不是每个人都幸运到能看到这一天、看到你的胜利。今晚我必须安排他们有一个合适的葬礼。%SPEECH_OFF%}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{%companyname%会好好利用这个。 | 辛苦工作的报酬。}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractSuccess, "保卫小镇抵御绿皮");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isGreenskinInvasion())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCommonContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion();
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.m.SituationID = this.Contract.resolveSituation(this.Contract.m.SituationID, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{%employer%愁眉苦脸。你指着他的窗户说：%SPEECH_ON%镇子被救了，你为什么哭丧着脸？%SPEECH_OFF%他抬起头看了你一眼。%SPEECH_ON%是啊，大部分人都活了下来，我想这是真的。但这并不意味着绿皮族没有在这该死的城镇中开了很多口子。%SPEECH_OFF%他在桌子上推了一个货箱，然后用拇指抚摸着他的额头。%SPEECH_ON%对于显得这么忧郁，我要向你道歉，雇佣兵。我相信你会理解的，至少我希望如此。%SPEECH_OFF%你确实理解，但你假装自己根本不关心。 | 你在 %employer%的房子后面找到了他。他手里拿着一把铁锹，正在打发几个农民。这里这里有新鲜的泥土堆。%SPEECH_ON%见到你真是太好了，雇佣兵。%SPEECH_OFF%他的手扶在铁锹杆上。%SPEECH_ON%只是，嗯，正在为那些没能活下来的人埋葬。你干得很出色，我不想让你有任何误解，但很多人都没有活下来。我完全没有责怪你的意思，绿皮族是一个强大的对手，期望完美是不明智的。%SPEECH_OFF%你点了点头，他也回了一下。他拿起一个挂在一堆弄脏的铁锹中间的小包，里面的泥巴都掉在地上，飞出一条泥痕。你接住了它，再次点头后离开了这个人去完成你的任务。离开时你听到他的铁锹无聊的划出了刺耳的声音。 | %employer%正在研究一张地图。他把手指放在一个地方，然后几乎用他的话去导航手指。%SPEECH_ON%这个地方没保住。这个地方被烧掉了。这些人死了。我们在树林里找到这些人。我想他们想躲藏，但他们刚刚有了一个新生儿。我猜这就是暴露他们的原因。%SPEECH_OFF%他向前倾，手掌扶在桌子上。%SPEECH_ON%你干得很好，雇佣兵，但并不能拯救所有人。就像他们说的，它就是它，我不会责怪你。只要我和其他很多人还活着。%SPEECH_OFF%他扔给你一袋克朗。你接过来，也回了一下头。就是它，而且它的确是一次不错的支付。 | 你发现%employer%正在慢慢地翻阅一个卷轴。他对着自己嗡嗡地哼唱着。%SPEECH_ON%你知道读着死去邻居的名字是什么感觉吗？%SPEECH_OFF%你知道，但不打算打断他。%SPEECH_ON%这是一种奇怪的感觉，我认识他们，但现在，我无法再看到他们的面孔。我只是认出他们的名字，像单词，不再特别于任何其他。他们只是一大堆词汇而已。我想这就是一个记忆的描述吧。%SPEECH_OFF%他看着你，然后将纸卷丢在一边，拿起一个小包丢给你。%SPEECH_ON%该死，我不是要打扰你，雇佣兵。这是你应得的酬金。%SPEECH_OFF% | %employer%正在指导一个拿着画笔的人绘画。他们的画布是一张厚纸和一块玻璃的混合物。你好奇地问这是在干什么。%SPEECH_ON%我正在给这场战斗奉献。纪念一下。%SPEECH_OFF%他指着一段建筑正在燃烧的地方。%SPEECH_ON%看到了吗？当你去打绿皮族时，他们烧了那个地方。还有那个也是。我们将铭记这一切，以免我们忘记。%SPEECH_OFF%那个人给你一组克朗，然后很快回到艺术创作中。凝视着画面，你没有在画面中看到你的战团的影子。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{那只是我们约定的一半！ | 没办法，已经这样了...}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractPoor, "保卫小镇抵御绿皮");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success3",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{%employer%欢迎你带着一箱%reward%克朗的回归。%SPEECH_ON%你干得很不错，雇佣兵。不幸的是，绿皮族绑架了我们的一些人。我会扣留部分薪水，以帮助那些把生命交给你的人补偿。%SPEECH_OFF%当你盯着箱子看时,他停了下来。你点了点头,都理解这些农民的处境,但认识到争吵在这里不适合你的未来前景。 | 你发现%employer%在喂他的狗。毒唯独一直在叼着晚饭的渣滓享用,得到了主人的不断抚摸。%SPEECH_ON%我真的以为我要放弃这一切。%SPEECH_OFF%他给了这条混种狗一个最后的抚摸,然后把目光转向了你。%SPEECH_ON% 但是我们中不是所有人都能活下来，你的薪水在那边，但会比协定的要少。我必须照顾那些被绑架者的家属的需要，你知道我为什么要从你那里拿那些钱。%SPEECH_OFF% | %employer%周围围着一群男女。当你走进房间时，他们不自然地向你转身。%employer%正在递给他们克朗，同时对你说话。%SPEECH_ON%你的薪水在外面跟我的一名卫兵在一起。这次会轻一些，因为已经拿去帮助了那些在战斗中失踪的人们。%SPEECH_OFF%你看着房间里的可怜灵魂徘徊。他们一定和绿皮族绑架的人有关系。 | %employer%在窗口向外看着，镇上的民兵正在四处奔跑，镇民正在互相拥抱。%SPEECH_ON%市区得到了拯救，但我不得不遗憾地告诉你，以后走在这些街道上的人将更少。%SPEECH_OFF%他微笑着递给你一个装满克朗的包，这感觉轻了一点。%SPEECH_ON%你今天做得非常出色，但不是所有人都能得救。被绿皮族绑架的人留下了家属，我将寻求在这个危急时刻帮助那些家庭。%SPEECH_OFF% | 找到%employer%并不容易：整个城镇在庆祝声中喧闹。他们剥鸡的速度很快，鸡有时会溜走，半裸露的鸟在孩子们的疯狂追逐下在街道上奔跑。%employer%趁着庆祝活动的闹哄哄，从中溜了出来找到了你。他递给你一个装满货物的包，它在你的手中沉甸甸的。%SPEECH_ON%并非所有人都能这么高兴，雇佣兵。那些被绑架的灵魂，你无法拯救吗？他们留下了家庭，你的薪水中有一部分要送给这些家庭。我相信你理解。%SPEECH_OFF% | 你发现%employer%正在整理书架。他似乎在补货物，仔细地计算和编号他的商品，像个店主一样。门突然被一下子关上时，他吓了一跳。%SPEECH_ON%啊，雇佣兵！你吓到我了。%SPEECH_OFF%他从书架上拿下一个箱子递给你。%SPEECH_ON%我曾经计划拿走所有这些书，所有这些卷轴，然后跑路。现在，我无需如此，所有这都要归功于你。%SPEECH_OFF%他的笑容变酸了。%SPEECH_ON%并非所有人都有那么好的运气能活到今天。当地人告诉我发生了什么事情，那些被绿皮族绑架的人，你救不了。未能救助他们是可以理解的，但我相信你个人明白为什么我从你那里拿了一些薪水来帮助那些幸存的家庭。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{那只是我们约定的一半！ | 没办法，已经这样了...}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractPoor, "保卫小镇抵御绿皮");
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Success4",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{%employer%以比预期更轻的行囊欢迎您的归来。他解释说。%SPEECH_ON%城市的外围几乎被摧毁，许多人被绑架。很抱歉，佣兵，但我需要这些钱来帮助这个城镇恢复。如果你想要威胁我，那就这样吧。%SPEECH_OFF%你决定接受这次损失并继续前进。 | 你发现%employer%正在勘测城镇。一些火灾在城市外围燃烧，喷出黑色烟雾。疲惫的农民沿着道路跋涉。他们带着能带的东西，一些人负责运送其他人的伤员。%employer%点头赞许。%SPEECH_ON%可怕的破坏，佣兵。你和我都知道，我雇佣你是为了拯救整个城镇和保护它的居民。但是现在都没有真正实现，但至少我们还在谈论，所以你还会得到应有的奖励。%SPEECH_OFF%他递给你一只克朗行囊，比原定的轻，但出于未来的前景，你不与他争吵。 | %employer%正在窗户外观望。他手中拿着卷轴和笔，时而做笔记。他一边说话，一边不看着你。%SPEECH_ON%我们还活着，很好。不好的是那些在城市外围肆虐的火灾，还有那些醜陋的新闻，被绿皮兽绑架了一些我们自己的人。%SPEECH_OFF%最后，他把写好的笔记停下来，稍微转过头看着你。%SPEECH_ON%你的报酬在大厅里，比你预期的要少。如果你想争argument论它，我就侧耳倾听。%SPEECH_OFF%你意识到为薪酬而争论是毫无意义的，所以只拿了你赚到的。}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{那只是我们约定的一半！ | 没办法，已经这样了...}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion() / 2);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(0);
						this.World.Contracts.finishActiveContract();
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.m.Reward = this.Contract.m.Payment.getOnCompletion() / 2;
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Reward + "[/color] 克朗"
				});
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{当你进入%employer%的房间时，他告诉你把门关上。就在门闩响起的一瞬间，他开始对你连篇大骂，你都来不及记下。渐渐冷静下来，他的语气和用语变得有些正常。%SPEECH_ON%我们整个边境都被摧毁了。你觉得我雇你来做什么？现在你给我滚出去。%SPEECH_OFF% | 当你进入%employer%的房间时，他正在狂饮。他的窗外传来暴怒农民的哭嚎声。%SPEECH_ON%听到了吗？如果我付你钱，他们就会把我的头割下来，佣兵。你只有一项任务，保护这座城镇，但你却连这都做不到。所以现在你要做的一件正确的事只有一个：给我滚蛋。%SPEECH_OFF% | %employer%双手合十放在桌子上。%SPEECH_ON%你期待在这里得到什么？我很惊讶你居然还敢回到我这里。城镇的一半被烧毁，而另一半已经成了灰烬。我雇你不是让你生产烟和废墟的，佣兵，给我走人。%SPEECH_OFF% | 当你回到%employer%的时候，他正在拿着一杯啤酒。他的手在颤抖着，脸涨得通红。%SPEECH_ON%我真的很想把这个泼在你脸上。%SPEECH_OFF% 为了防止意外，他一口喝光了杯中的酒。然后他狠狠地把杯子摔在桌子上。%SPEECH_ON%这座城镇期待你保护他们，但是你一无是处！ 你让那些绿皮族群集结在城镇周围，就像他们在享受假期！我不会让绿皮们摧毁我的城镇，佣兵，你给我滚蛋！%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{该死的农民！ | 我们需要要求更多的预付款... | 该死的！}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能成功地抵御绿皮族入侵该市镇。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_30.png[/img]{%employer%不知所踪。他的一名护卫走到你面前。%SPEECH_ON%如果你在找我的老板，你最好打消这个念头。这个城镇的一半都被毁了，他正在尽力修复它。%SPEECH_OFF%你询问自己的薪水。那人发出沉重、粗糙的笑声。%SPEECH_ON%薪水？对不起，你这个卖剑的乞丐，他不是来让你失败的。而且那些钱也会投入到城镇建设中去。%SPEECH_OFF% | 你在%townname%的废墟中搜寻着%employer%。你发现他正在从一个烟雾弥漫的废墟中拖出被烤焦的尸体。他把一个烧焦的尸体扔在地上，几乎盯着你打了个眼神。%SPEECH_ON%你想干嘛，佣兵？我希望不是来要薪水，因为这种事情不是我雇佣你做的。%SPEECH_OFF% | %employer%站在窗边看着外面。整个地平线都着火了，好像这个世界上有两个太阳要下山一样。他看见你就摇了摇头。%SPEECH_ON%你到底是想干嘛？我们同意让城镇化为灰烬来给你发工资了吗？我想没有吧，佣兵。快走吧。%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "{该死的农民！ | 我们需要要求更多的预付款... | 该死的！}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationCivilianContractFail, "未能成功地抵御绿皮族入侵该市镇。");
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.addSituation(this.new("scripts/entity/world/settlements/situations/raided_situation"), 3, this.Contract.m.Home, this.List);
			}

		});
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"reward",
			this.m.Reward
		]);
	}

	function onHomeSet()
	{
		if (this.m.SituationID == 0)
		{
			this.m.SituationID = this.m.Home.addSituation(this.new("scripts/entity/world/settlements/situations/greenskins_situation"));
		}
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.World.FactionManager.getFaction(this.getFaction()).setActive(true);
			this.m.Home.getSprite("selection").Visible = false;

			if (this.m.Kidnapper != null && !this.m.Kidnapper.isNull())
			{
				this.m.Kidnapper.getSprite("selection").Visible = false;
			}

			if (this.m.Militia != null && !this.m.Militia.isNull())
			{
				this.m.Militia.getController().clearOrders();
			}

			this.World.getGuestRoster().clear();
		}

		if (this.m.Home != null && !this.m.Home.isNull() && this.m.SituationID != 0)
		{
			local s = this.m.Home.getSituationByInstance(this.m.SituationID);

			if (s != null)
			{
				s.setValidForDays(4);
			}
		}
	}

	function onIsValid()
	{
		local nearestOrcs = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getSettlements());
		local nearestGoblins = this.getNearestLocationTo(this.m.Home, this.World.FactionManager.getFactionOfType(this.Const.FactionType.Goblins).getSettlements());

		if (nearestOrcs.getTile().getDistanceTo(this.m.Home.getTile()) > 20 && nearestGoblins.getTile().getDistanceTo(this.m.Home.getTile()) > 20)
		{
			return false;
		}

		local locations = this.m.Home.getAttachedLocations();

		foreach( l in locations )
		{
			if (l.isUsable() && l.isActive() && !l.isMilitary())
			{
				return true;
			}
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.m.Flags.set("KidnapperID", this.m.Kidnapper != null && !this.m.Kidnapper.isNull() ? this.m.Kidnapper.getID() : 0);
		this.m.Flags.set("MilitiaID", this.m.Militia != null && !this.m.Militia.isNull() ? this.m.Militia.getID() : 0);
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
		this.m.Kidnapper = this.WeakTableRef(this.World.getEntityByID(this.m.Flags.get("KidnapperID")));
		this.m.Militia = this.WeakTableRef(this.World.getEntityByID(this.m.Flags.get("MilitiaID")));
	}

});

