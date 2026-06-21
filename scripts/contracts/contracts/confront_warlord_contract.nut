this.confront_warlord_contract <- this.inherit("scripts/contracts/contract", {
	m = {
		Destination = null,
		Dude = null,
		IsPlayerAttacking = false
	},
	function create()
	{
		this.contract.create();
		local r = this.Math.rand(1, 100);

		if (r <= 70)
		{
			this.m.DifficultyMult = this.Math.rand(95, 105) * 0.01;
		}
		else
		{
			this.m.DifficultyMult = this.Math.rand(115, 135) * 0.01;
		}

		this.m.Type = "contract.confront_warlord";
		this.m.Name = "挑战兽人军阀";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 7.0;
	}

	function onImportIntro()
	{
		this.importNobleIntro();
	}

	function start()
	{
		this.m.Payment.Pool = 1800 * this.getPaymentMult() * this.Math.pow(this.getDifficultyMult(), this.Const.World.Assets.ContractRewardPOW) * this.getReputationToPaymentMult();
		local r = this.Math.rand(1, 2);

		if (r == 1)
		{
			this.m.Payment.Completion = 0.75;
			this.m.Payment.Advance = 0.25;
		}
		else if (r == 2)
		{
			this.m.Payment.Completion = 1.0;
		}

		this.m.Flags.set("Score", 0);
		this.contract.start();
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"摧毁各种绿皮军队和营地来诱出他们的军阀",
					"杀死兽人军阀"
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
				this.Flags.set("MaxScore", 10 * this.Contract.getDifficultyMult());
				this.Flags.set("LastRandomTime", 0.0);
				local r = this.Math.rand(1, 100);

				if (r <= 10)
				{
					this.Flags.set("IsBerserkers", true);
				}

				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
			}

			function update()
			{
				if (this.Flags.get("Score") >= this.Flags.get("MaxScore"))
				{
					this.Contract.setScreen("FinalConfrontation1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("JustDefeatedGreenskins"))
				{
					this.Flags.set("JustDefeatedGreenskins", false);
					this.Contract.setScreen("MadeADent");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("LastRandomTime") + 300.0 <= this.Time.getVirtualTimeF() && this.Contract.getDistanceToNearestSettlement() >= 5 && this.Math.rand(1, 1000) <= 1)
				{
					this.Flags.set("LastRandomTime", this.Time.getVirtualTimeF());
					this.Contract.setScreen("ClosingIn");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBerserkersDone"))
				{
					this.Flags.set("IsBerserkersDone", false);

					if (this.Math.rand(1, 100) <= 50)
					{
						this.Contract.setScreen("Berserkers3");
					}
					else
					{
						this.Contract.setScreen("Berserkers4");
					}

					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsBerserkers") && !this.TempFlags.has("IsBerserkersShown") && this.Contract.getDistanceToNearestSettlement() >= 7 && this.Math.rand(1, 1000) <= 1)
				{
					this.TempFlags.set("IsBerserkersShown", true);
					this.Contract.setScreen("Berserkers1");
					this.World.Contracts.showActiveContract();
				}
			}

			function onLocationDestroyed( _location )
			{
				local f = this.World.FactionManager.getFaction(_location.getFaction());

				if (f.getType() == this.Const.FactionType.Orcs || f.getType() == this.Const.FactionType.Goblins)
				{
					this.Flags.set("Score", this.Flags.get("Score") + 4);
					this.Flags.set("JustDefeatedGreenskins", true);
				}
			}

			function onPartyDestroyed( _party )
			{
				local f = this.World.FactionManager.getFaction(_party.getFaction());

				if (f.getType() == this.Const.FactionType.Orcs || f.getType() == this.Const.FactionType.Goblins)
				{
					this.Flags.set("Score", this.Flags.get("Score") + 2);
					this.Flags.set("JustDefeatedGreenskins", true);
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Berserkers")
				{
					this.Flags.set("IsBerserkersDone", true);
					this.Flags.set("IsBerserkers", false);
					this.Flags.set("Score", this.Flags.get("Score") + 2);
				}
			}

		});
		this.m.States.push({
			ID = "Running_Warlord",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"杀死兽人军阀"
				];

				if (this.Contract.m.Destination != null && !this.Contract.m.Destination.isNull())
				{
					this.Contract.m.Destination.getSprite("selection").Visible = true;
					this.Contract.m.Destination.setOnCombatWithPlayerCallback(this.onCombatWithWarlord.bindenv(this));
				}

				this.Flags.set("IsWarlordEncountered", false);
			}

			function update()
			{
				if (this.Flags.get("IsWarlordDefeated") || this.Contract.m.Destination == null || this.Contract.m.Destination.isNull() || !this.Contract.m.Destination.isAlive())
				{
					this.Contract.setScreen("FinalConfrontation3");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatWithWarlord( _dest, _isPlayerAttacking = true )
			{
				this.Contract.m.IsPlayerAttacking = _isPlayerAttacking;

				if (!this.Flags.get("IsWarlordEncountered"))
				{
					this.Flags.set("IsWarlordEncountered", true);
					this.Contract.setScreen("FinalConfrontation2");
					this.World.Contracts.showActiveContract();
				}
				else
				{
					local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
					properties.Music = this.Const.Music.OrcsTracks;
					properties.AfterDeploymentCallback = this.OnAfterDeployment.bindenv(this);
					this.World.Contracts.startScriptedCombat(properties, this.Contract.m.IsPlayerAttacking, true, true);
				}
			}

			function OnAfterDeployment()
			{
				local all = this.Tactical.Entities.getAllInstances();

				foreach( f in all )
				{
					foreach( e in f )
					{
						if (e.getType() == this.Const.EntityType.OrcWarlord)
						{
							e.getAIAgent().getProperties().BehaviorMult[this.Const.AI.Behavior.ID.Retreat] = 0.0;
							e.getFlags().add("IsFinalBoss", true);
							break;
						}
					}
				}
			}

			function onActorKilled( _actor, _killer, _combatID )
			{
				if (_actor.getFlags().get("IsFinalBoss") == true)
				{
					this.Flags.set("IsWarlordDefeated", true);
				}
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
			}

			function update()
			{
				if (this.Contract.isPlayerAt(this.Contract.m.Home))
				{
					this.Contract.setScreen("Success1");
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
			Text = "[img]gfx/ui/events/event_45.png[/img]{你发现 %employer% 在他的马厩里走来走去。 他把手放在一边。%SPEECH_ON%你知不知道兽人可以用蛮力折断这个生物的脖子？ 我看过了。我知道，因为我的马死了，它的头被一个生气的绿皮拧成反的了。%SPEECH_OFF%回忆固然很好，但这不是你来这儿的原因。 你巧妙地让贵族直入主题。他示以感谢。%SPEECH_ON%对的。与绿皮的战争进行得不像我们希望的那么顺利，所以我得出结论，我们必须杀死他们的一个军阀。 让我们开诚布公吧，一个兽人在身体上比它所有的狗屁兄弟都要优越，这对有血有肉的人来说是一个噩梦。 最好的办法是尽可能多地干掉他的绿皮兄弟。 我知道这听起来很艰难，不过一旦我们承诺并做到了，我们赢得这场该死的战争的几率将大大提高。%SPEECH_OFF% | %employer% 欢迎您进入他的房间。他相当担心地看着地图。%SPEECH_ON%{我的侦察员报告说这个地区有个军阀，但我们不能完全确定他在哪里。 我有一种预感，如果你去那里给这些绿色的混蛋制造很多麻烦，他可能就会露面。明白吗？ | 我们接到报告说有个兽人军阀在各地游荡。 我相信如果我们能杀了他，兽人的士气就会下降，我们就有可能赢得这场该死的战争。 当然，他不容易找到。 你必须让那个大混蛋现身，我相信最好的办法就是用兽人的方式传达：尽可能多的杀。 当然，是杀绿皮。 不要随意的谈论这件事。 | 很高兴你来了，佣兵，因为我有个任务要交给你。 我们得到消息说有一个兽人军阀在这个地区，但我们不知道他在哪里。 我想让你去练习一下兽人式外交：尽可能多地杀死那些绿色的野蛮人，那个军阀肯定会彰示他的存在感的。 如果我们能把他从这场战争宏图中抹去，它对我们来说将会变得漂亮得多。}%SPEECH_OFF% | %employer% 被他的副官和一个穿着脏兮兮的靴子，脸上汗水淋漓，看起来很疲惫的孩子包围着。 他的一个指挥官走上前，把你带到一边。%SPEECH_ON%我们得到了一个兽人军阀的消息。 那个孩子的家人因为目睹军阀现身付出了的代价。%employer% 相信，我也同意阁下的看法，如果我们能杀死尽可能多的绿皮，我们就能让这个军阀现身。%SPEECH_OFF%你靠在椅背上回应。%SPEECH_ON%让我猜猜，你要我取它的头吗？%SPEECH_OFF%指挥官耸耸肩。%SPEECH_ON%我想这毫无疑问，对吧？ 我的君主愿意为这份工作付很多钱。%SPEECH_OFF% | %employer% 坐在一群筋疲力尽的狗中间。 它们的嘴里长着山鸡的羽毛，在呼噜声中颤动着。 大人招手让你进去。%SPEECH_ON%请进，佣兵。 我刚完成了一次狩猎。 巧的是，我要寄给你一张。%SPEECH_OFF%You take a seat. 其中一只狗抬起头，怒吼了一声，然后又低下头睡着了。 你问贵族想要什么。 他一边揉着杂狗的耳朵，一边迅速解释着。%SPEECH_ON%我得到消息，有个兽人军阀正在潜四处徘徊。 在哪里？我不知道。 但我认为你可以把他赶出来。 你知道该怎么做，对吧？%SPEECH_OFF%你点头回应。%SPEECH_ON%是的。不停地杀它的士兵，直到它被激怒出来亲自和你战斗。 但无论如何，这都不是一个便宜的要求，%employer%。%SPEECH_OFF%贵族咧着嘴笑了，张开双手，好像在说：“让我们谈正事吧。” 他的狗抬起头，好像在说：“除非那件事意味着你不停地挠我的耳朵。” | %employer% 坐在一张长办公桌后面，一张更长的地图甚至快拖到了地上。 他的一个书记员对着他的耳朵耳语，然后急忙跑向你。%SPEECH_ON%我的君主有一个请求。 我们相信一个兽人军阀就在这个地区，自然是，我们想要杀死这个野蛮人。 为了做到这一点，我们…%SPEECH_OFF%你举手打断他们。%SPEECH_ON%是的，我知道怎么吸引出来。 我们尽我们所能杀死这些狗娘养的，直到那个愤怒的绿小子出现。%SPEECH_OFF%书记员热情地笑了。%SPEECH_ON%噢，原来你也读过关于这个战术的书？太棒了！%SPEECH_OFF%你的眼神非常优雅地黯淡下来，但你继续向前，开始询问潜在的报酬。 | %employer% 在他的书房里遇到你。 他正在把书从书架上拿下来，每次拿下来都有一大片灰尘。%SPEECH_ON%来，请坐。%SPEECH_OFF%你去了，他带过来一本巨著。 他打开一页，指着一个巨大兽人的花哨图片。%SPEECH_ON%你知道这些，是吗？%SPEECH_OFF%你点头。它是一个军阀，一个兽人部队的首领，是噼啪席卷世界的旋风。 贵族点了点头，继续说。%SPEECH_ON%我正在对它们做一些研究，因为我的侦察员给我带来了它们的踪迹。 当然，我们永远不可能完全跟踪这个该死的东西。 它去它喜欢的地方，它去哪里，它就破坏哪里。%SPEECH_OFF%你打断了那个贵族，并向他解释了一个简单的策略：如果你杀死了足够多的绿皮，军阀就会发起进攻，或者可能会受到挑战的鼓舞，没有人真正知道，它会出来战斗。%employer% 微笑。%SPEECH_ON%你看，佣兵，这就是我喜欢你的原因。 你知道自己是个什么东西。 当然，我认为毫无疑问可以假定这件事非常难做。 付钱将超过一般标准。%SPEECH_OFF% | %employer% 正在研读书记员带进去的一堆卷轴。 他不停地摇头。%SPEECH_ON%这些都没说我们该怎么找到它的！ 如果我们不能可靠地找到它，我们怎么能可靠地杀死它？ 这是简单的数学！ 我还以为你懂数学呢！%SPEECH_OFF%书记员躲开了，一边抽着鼻子，一边盯着地板，急匆匆地走出了房间。 你问出了什么问题。%employer% 叹了口气，一个兽人军阀在该地区，但他们不知道如何停止它。 你笑着回答。%SPEECH_ON%很简单：你说他们的语言。 你尽你所能杀掉那些混蛋，直到那个军阀被迫出来见你。 兽人热爱暴力，他们生来就有暴力，甚至可能是由暴力而生的。 当然，杀死军阀并不是一件容易的事…%SPEECH_OFF%%employer% 向前倾斜，用帐篷遮住手指。%SPEECH_ON%是的，当然不是，但你听起来确实像是这个职位的最佳人选。 这项工作能真正使这场该死的战争转向对我们有利。来谈谈生意。%SPEECH_OFF% | 你发现 %employer% 在他的花园里闲逛。 他似乎特别喜欢植物的茎干。%SPEECH_ON%这很奇怪，不是吗？ 我们这里有这么多绿色的东西，而那些绿皮肤的混蛋也是绿色的，我不认为他们这辈子吃过什么该死的蔬菜。%SPEECH_OFF%你想说这是一个相当愚蠢的观察，但保持沉默。 相反，你会问绿色皮肤的问题是什么，因为这似乎是隐含的问题。%employer% 点头。%SPEECH_ON%当然，对吧。我的侦察员在这个地区发现了一个军阀。 问题是，我们不知道它在哪里，也不知道它要去哪里。 侦察兵不能坚持太久，否则他们会因为显而易见的原因而被杀。 我相信杀死这个军阀会帮助我们离结束这场该死的战争更近一步，但是我不知道该怎么做，你呢？%SPEECH_OFF%你点头回应。%SPEECH_ON%你们为什么想杀死那个军阀，因为他正在杀害你们的人民，对吗？ 那是什么让他想亲手杀了我们？ 那些混蛋你能杀多少就杀多少。%SPEECH_OFF%贵族拍了拍，扔给你一个鲜红色的西红柿。%SPEECH_ON%没错，这是个好想法，雇佣兵。来谈谈生意！%SPEECH_OFF% | 你发现 %employer% 和他的指挥官们站在一个地图周围。 当你进入房间时，他们会转向你，就像一群老鹰看到一只兔子一样。 贵族欢迎你进来。%SPEECH_ON%你好，佣兵，我们有点紧张。 我们的侦察员报告说，就在我们说话的时候，一个兽人军阀正在这个地区游荡。 问题是我们不能完全确定它的去向或如何找到它。 我的指挥官们相信如果我们杀死尽可能多的绿皮，军阀就会现身，然后我们就能杀死它。 你认为你能胜任这项工作吗？ 如果是这样的话，我们谈正事吧。%SPEECH_OFF% | 你踏入 %employer%的房间找他咨询和一群书记员。 他们明显在发抖，掐着他们的珠子项链，扭动着身体。 其中一个指着你。%SPEECH_ON%也许他有个主意？%SPEECH_OFF%其他人嗤之以鼻，你却问出了什么问题。%employer% 解释说，有一个兽人军阀漫游的土地，但他们无法跟踪。 你尽职地点头，然后解释一个非常简单的解决方案。%SPEECH_ON%杀死尽可能多的绿皮和军阀，但野兽的骄傲的本性，将出来与你战斗。 或者，在这种情况下，出来战斗…我吗？%SPEECH_OFF%%employer% nods.%SPEECH_ON%你的脑袋可真灵光，佣兵。我们来谈谈吧。%SPEECH_OFF% | %employer% 和他的指挥官们站在一些地图前面。%SPEECH_ON%我们给你安排了一项艰巨的任务，佣兵。 我们的侦察员发现一个军阀在这个地区游荡，我们需要你杀死尽可能多的绿皮，它就会凭空冒出来。 如果我们能拿下那个军阀的脑袋，我们离结束这场该死的战争就更近了。%SPEECH_OFF% | 当你进入 %employer%的房间时，他问你是否知道猎杀兽人军阀的事。 你耸耸肩答道。%SPEECH_ON%他们对暴力语言做出回应。 所以如果你想和它说话，你必须杀死它的许多兽人同胞。 可以说，这是让它出来的唯一方法。%SPEECH_OFF%贵族点头，表示理解。 他把一张纸从办公桌上滑过。%SPEECH_ON%那我可能会给你一些东西。 我们已经意识到在我们的地区有一个兽人军阀，但是很难找到他。 我要你把它找出来杀掉。 如果我们能做到这一点，我们打赢这场对那些绿色野蛮人的战争的几率将增加十倍！%SPEECH_OFF%}",
			Image = "",
			List = [],
			ShowEmployer = true,
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我相信你会为此付出很多。 | 如果报酬合适，一切都可以做。 | 用叮当作响的硬币说服我。}",
					function getResult()
					{
						return "Negotiation";
					}

				},
				{
					Text = "{这不值得。 | 我们还有别的地方要去。}",
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
			ID = "ClosingIn",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_46.png[/img]{你遇到一个刚被移除的人类头骨堆。%randombrother% 盯着痛苦的面孔的图腾，摇着自己的头。%SPEECH_ON%你以为他们认为这是艺术吗？ 就像其中一个野蛮人退一步说，是的，看起来不错。%SPEECH_OFF%你不确定。你们非常希望人类不是绿皮的画笔和画布。 | 你看到一片被屠杀的农场动物。 内脏像血灌一样从农场凹凸不平的土壤里流走了。 要么是一个农夫严重误读了天气，要么这就是兽人接近的确切信号。 | 尸体。有些被劈成两半，有些则很平静，只有几个飞镖在他们的背上。 这两种形式的结局都是绿皮们接近了的标志。 | 你来到一个废弃的绿皮营地。 有一个脑袋被压扁的哥布林。 也许它和一个更大更强的兽人打起来了。 一个可怕的东西正坐在一块烤肉叉上。 你只希望它不是你想的那样。%randombrother% 指着下面的余烬噼啪声。%SPEECH_ON%这是新鲜的。他们就在不远的地方，先生。%SPEECH_OFF% | 你来到一个谷仓，门在刺骨的寒风中嘎吱嘎吱地开了又关。%randombrother% 站在里面，然后迅速用手捂住他的鼻子。%SPEECH_ON%是的，绿皮来过这里。%SPEECH_OFF%你顾不得往仓里看一眼，就吩咐人预备打仗，因为战争肯定要来了。 | 你发现一个死去的兽人，背上横着一个死去的哥布林。 把两具尸体推倒，你发现下面有一个死去的农夫。%randombrother% 点了点头。%SPEECH_ON%嗯，他打了一架。 真可惜我们没有早点到这儿。%SPEECH_OFF%你指了指泥地里的新脚印。%SPEECH_ON%他寡不敌众，其余的人就在不远处。 告诉人们准备战斗。%SPEECH_OFF% | 你遇到一个男人，他被沉重的铁链捆着，显然被铁链勒死了。 他那被压成紫色的身体随着铁链的摆动而发出叮当的响声。%randombrother% 把尸体砍倒。 尸体从嘴里吐出黑色的血，佣兵跳开了。%SPEECH_ON%该死，这家伙真新鲜！ 干这事的人不远了！%SPEECH_OFF%你指着泥地里的脚印告诉他，这肯定是绿皮干的，真的，他们就在附近。 | 你在路上发现一个皮肉制的包。 里面是人的耳朵，被晒黑了，僵硬，有很多洞可以让钥匙链穿过。%randombrother% 捂住嘴。 你告诉那些人，绿皮就在不远处。 毫无疑问，一场战斗就要开始了！ | 你看到一间破屋的遗迹。 烧焦的废墟上，余烬噼啪作响。%randombrother% 发现了几具骷髅，注意到他们少了一半的尸体。 看到灰泥上有一些深深的脚印，你通知人们做好准备，因为毫无疑问，绿皮就在附近。 | 你发现一个男人在路边哭泣。 他盘腿坐着，身体前后摆动。 当你走近时，他扭过头，没有眼睛，没有鼻子，嘴唇也被切掉了。%SPEECH_ON%不要了！拜托，不要了！%SPEECH_OFF%他倒在一边，开始抽搐，然后就不动了。%randombrother% 围绕着身体站起来，摇着头。%SPEECH_ON%绿皮？%SPEECH_OFF%你指着泥地里深深的脚印点了点头。 | 你遇到一个为尸体号啕大哭的女人。 她浑身是血，膝盖下的身体已经完全陷下去了。 你蹲在她旁边。 她瞥着你，呻吟着。 你问这是谁干的。 女人清了清嗓子，回答道。%SPEECH_ON%绿皮。大的。小的。 他们一边做一边笑。 他们的棍棒一上一下，一遍又一遍，中间还不停地大笑。%SPEECH_OFF% | 你发现路边有一匹马死了，它的肚子朝向小路。 它的胸腔还在不停地滴水。%randombrother% 指出，心脏、肝脏和其他美味的部分缺失了。 你指了指那些大大小小的脚印，这些脚印在小路上留下了血迹。%SPEECH_ON%哥布林和兽人！%SPEECH_OFF%他们就在不远处。 你要让 %companyname% 做好战斗的准备。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "小心点！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "MadeADent",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_81.png[/img]{死了这么多绿皮，看来他们的军阀出来只是时间问题。 | 你留下了一串死去的绿皮。 他们的军阀很快就会听到你的风声。 | 绿皮的军阀现在肯定听说了他们的战士被砍倒的故事。 他一定嗅到你的气味了。 | 如果你是绿皮军阀，你可能已经准备好了去追捕那个砍到你部队的杂种。 继续这样的杀戮，你无疑会发现你和那个野蛮人的想法是多么相似。 | 野蛮人懂得暴力，而你无疑在这一地区留下了血淋漓的教导。 如果军阀是一个会学习的生物，毫无疑问它很快就会来到你身边。 | 根据更愤怒的估计，兽人军阀肯定是被激怒了，因为一些任性的人类搞砸了他的计划。 你料到那个野蛮的生物或早或晚就会来。 而且多半是前者。 | 随着这么多兽人和哥布林的被杀，他们的首领亲自来追杀你只是时间问题。 | 如果暴力是半兽人的语言，那么你已经在这个地区上上下下写了一封真正的情书了。 当然兽人军阀会有回报的心情。 | 如果暴力是兽人表达爱的语言，那么你已经站在他们军阀的院子里，向窗户扔了很多石头，试图引起它的注意。 但是，不是石头，而是士兵的四肢和脑袋。 那畜生现在一定会有反应的。 | 你留下了一长串死去的绿皮毫无疑问会引起他们的军阀的注意。 | 生意对秃鹰来说是好事：你已经开辟了一条由死绿皮铺就的道路，看来他们的军阀随时都会来亲自看看你在做什么。 | 像你这样杀死绿皮肯定能引起兽人军阀的注意，而且热度还在上升。 | 如果事情按照计划进行，也就是说不受阻碍地屠杀绿色野蛮人，那么兽人军阀亲自来见你只是时间问题。 | 一场踩踏事故几乎不会比你上个星期制造的噪音更大。 如果你继续到处屠杀绿皮，他们的军阀出现只是时间问题。 | 你有一种感觉，在这个地区的某个地方，有一个非常、非常疯狂的兽人军阀，正盯着你那粗糙的脸。 | 你喜欢认为你已经在绿皮肤的圈子里制造了你自己的“招聘”海报。 一个简笔画的男人，下面还有价码。 想死或死得很惨。 问题是你会继续杀死所有来找你的人，直到兽人军阀出现－你会有这样的感觉，很快就会发生。 | 现在绿皮一定是在他们的篝火旁分享你的故事。 一些该死的人恐吓他们的队伍。 毫无疑问，兽人军阀会听到这些故事，并觉得有必要亲自去看看这些故事是不是真的… | 继续像这样杀死绿皮，他们的军阀肯定会来的。 | 你现在是在冒险。 这么多的绿皮被杀，兽人军阀迟早会来的。 | 你有一种强烈的倾向，兽人军阀很快就会出现。 可能和你杀了他所有的士兵有关。只是一种预感。 | 你杀了小绿皮和大绿皮。 现在，是时候杀死他们当中最大的一个了：军阀。 那个野蛮人一定在这附近的某个地方… | 你对绿皮发动了战争，因此他们的军阀迟早会出现。 | 到处都是垂死的绿皮。 在某个时候，他们的军阀会意识到这不是自然原因。 一旦他搞清楚了，他会加倍偿还的。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{胜利！ | 该死的绿皮。}",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FinalConfrontation1",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_81.png[/img]{你听到很多来自乡下人的谣言，说一个兽人军阀正在集结他的士兵，朝你的方向前进。 如果这些谣言属实，则应尽力做好准备。 | 那么，有很多关于兽人军阀在该地区行军的消息。 正好是正朝着你的方向－你的计划已奏效！ %companyname% 应该为一场激烈的战斗做好准备。 | 有消息说兽人军阀朝着你来了！ 让 %companyname% 为进行一场激烈的战斗做准备吧！ | 你所路过的每个农民似乎都在传闻：兽人军阀要来了！ 这很可能不是巧合，%companyname% 应该相应地做好准备。 | 好吧，传来的消息是，%companyname% 正是由兽人军阀带着得一支小部队进军的目标。 你的计划似乎奏效了。 战队应该为即将来临的大战做好准备！ | 看起来，你经过的每个农民都想告诉你一个相同的消息：一个兽人军阀已经集结了一支小部队，而碰巧正好正朝着你行进。 %companyname% 应该为激烈的战斗做好准备！ | 一个小老太太走向你。 她解释说，每个人都在谈论一个正在前进的兽人军阀。 你不确定消息是否可靠，但是鉴于过去几天的目的，这肯定是巧合得过分了。%companyname% 应该为战斗做好准备。 | 好吧，%companyname% 应该做好准备或进行一场战斗。 你通过的每个人都在告诉你相同的故事：兽人军阀已经集结了一支小部队并正在前进！ | 杀戮似乎奏效了：有消息称，一个兽人军阀集结了队伍朝着你赶来并准备亲自料理你。 %companyname% 应该为战斗做好准备！ | 一个小孩接近你。 他瞥了眼 %companyname%的印记，然后看了你一眼。他笑了。%SPEECH_ON%我认为你们都需要帮助。%SPEECH_OFF%那也许是真的，但这听起来很奇怪。 你问他为什么，他回应。%SPEECH_ON%我父亲说，一个卑鄙的兽人会杀死你们所有人。 他说，商人一整整天都在说这个事！%SPEECH_OFF%哼，如果消息属实，则表示该策略已经奏效，%companyname% 应该为战斗做好准备。 你谢过小孩。他耸耸肩。%SPEECH_ON%我刚刚救了你一命耶，就只一个谢谢？你们这些人哪！%SPEECH_OFF%小孩啐了一口，一边踢着石头离开了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们需要为此做好准备。",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				local playerTile = this.World.State.getPlayer().getTile();
				local nearest_orcs = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getNearestSettlement(playerTile);
				local tile = this.Contract.getTileToSpawnLocation(playerTile, 9, 15);
				local party = this.World.FactionManager.getFaction(nearest_orcs.getFaction()).spawnEntity(tile, "Greenskin Horde", false, this.Const.World.Spawn.GreenskinHorde, 130 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult());
				party.getSprite("banner").setBrush(nearest_orcs.getBanner());
				party.getSprite("body").setBrush("figure_orc_05");
				party.setDescription("由一个可怖的兽人军阀领导的一大群绿皮。");
				party.setFootprintType(this.Const.World.FootprintsType.Orcs);
				this.Contract.m.UnitsSpawned.push(party);
				local hasWarlord = false;

				foreach( t in party.getTroops() )
				{
					if (t.ID == this.Const.EntityType.OrcWarlord)
					{
						hasWarlord = true;
						break;
					}
				}

				if (!hasWarlord)
				{
					this.Const.World.Common.addTroop(party, {
						Type = this.Const.World.Spawn.Troops.OrcWarlord
					}, false);
				}

				party.getLoot().ArmorParts = this.Math.rand(0, 35);
				party.getLoot().Ammo = this.Math.rand(0, 10);
				party.addToInventory("supplies/strange_meat_item");
				party.addToInventory("supplies/strange_meat_item");
				party.addToInventory("supplies/strange_meat_item");
				party.addToInventory("supplies/strange_meat_item");
				this.Contract.m.Destination = this.WeakTableRef(party);
				party.setAttackableByAI(false);
				local c = party.getController();
				c.getBehavior(this.Const.World.AI.Behavior.ID.Flee).setEnabled(false);
				local intercept = this.new("scripts/ai/world/orders/intercept_order");
				intercept.setTarget(this.World.State.getPlayer());
				c.addOrder(intercept);
				this.Contract.setState("Running_Warlord");
			}

		});
		this.m.Screens.push({
			ID = "FinalConfrontation2",
			Title = "当你接近时…",
			Text = "[img]gfx/ui/events/event_49.png[/img]{这个军阀是一群兽人和哥布林的首领。 他站在他周围大量的战士中。 你命令你的人走上战场，话一出口，军阀就怒吼起来，他的战士就向你跑来！ | 一大群兽人和哥布林站在你面前，他们的军阀站在前面。 他走上前，向你举起一个袋子。 它在空中展开，落地时打开。 一打脑袋滚出来，就像小孩玩具包里的弹子。 军阀举起武器，怒吼起来。 随着绿皮向你队伍迫近，你很快命令 %companyname% 组成阵型。 | 站在 %companyname% 面前的是一列列的绿皮：兽人，哥布林，还有他们的军阀，一个野兽状的生物即使在他的同类中也显得如此笨拙不和谐。 那个庞大的的战士举起武器咆哮，惊得鸟儿从树上飞出，小动物窜回洞里。\n\n当绿皮开始冲锋，你向你的人呼喊，让他们组成阵型并记住他们是谁：%companyname%！ | 你和 %companyname% 终于站到军阀和它的兽人和哥布林军队面前。 这像是一个场合或演讲，但在你能说一个字之前，野蛮人开始了冲锋！ | 最后，人类和野兽摆好架势。 面对 %companyname% 的是一个兽人和哥布林组成的小型军队，有一个野蛮军阀站在他们的前排。 你拔出剑，军阀也举起武器。 但愿有那么一瞬间，他们能理解，他们是勇士，今天只有勇士会逝去。 | 兽人军阀和他的军队开始冲锋！ 你告诉 %companyname%，这就是他们训练的目的。%SPEECH_ON%我们不会倒在这里，除非我们想要！%SPEECH_OFF%人们咆哮着，拔出他们的利刃组成阵型。 | 当一大群哥布林和兽人穿过战场，一个巨大的军阀在他们的头部，你告诉人们不要害怕。%SPEECH_ON%今晚我们有很多东西要庆祝，伙计们！%SPEECH_OFF%他们拔出武器，发出震耳欲聋的吼声，那些绿皮也听到了，他们第一次看到那一瞬间的惊讶。 | %randombrother% 向你走来，指示一支由兽人和地精组成的小军队向你冲来，一个军阀在他们的前面。%SPEECH_ON%并不是显而易见的，但绿皮在这里。%SPEECH_OFF%你向你的人点头并大喊。%SPEECH_ON%还有谁？%SPEECH_OFF%人们拔出了武器。%SPEECH_ON%The %companyname%!%SPEECH_OFF% | 你和 %randombrother% 看着一个兽人军阀向你冲去，后面是一小队兽人和哥布林。雇佣兵笑了。%SPEECH_ON%嗯，他们来了。%SPEECH_OFF%点头，你向人们讲话。%SPEECH_ON%他们因为害怕而冲锋。 因为他们没有立足之地。 但我们有，因为我们站在这里！%SPEECH_OFF%你把 %companyname% 的旗帜插在地上。 当人们怒吼着起死回生时，纹章在风中荡漾。 | 你看着由军阀带着冲锋的绿皮。 你拔出剑，对着那些人大喊。%SPEECH_ON%对任何一个拿着野人脑袋的人来说，这是一个美好的夜晚。 今晚谁睡得好？%SPEECH_OFF%当这些人拔出武器并叫喊时，金属嘎嘎作响。%SPEECH_ON%The %companyname%!%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult()
					{
						this.Contract.getActiveState().onCombatWithWarlord(this.Contract.m.Destination, this.Contract.m.IsPlayerAttacking);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "FinalConfrontation3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_81.png[/img]{军阀正躺在地上，他理应如此。 你看着其余的绿皮向山上走去。 你的雇主，%employer%，将非常满意 %companyname% 今天的工作。 | %companyname% 这一天获胜了！ 兽人首领死在泥泞中，他的军队四散到山上。 这是你的雇主，%employer%，最满意的结果。 | 你的雇主，%employer%，支付了最好的报酬，并且得到了：兽人军阀死了，它的野蛮人游荡队伍也逃走了。 失去领袖，毫无疑问，野兽们会四散而去，自生自灭。 你应该回到贵族那里拿你的报酬。 | 你把绿皮赶了出去，杀了他们的军阀，让他们跑到山上去。 Your employer, %employer%, will be most pleased with the %companyname%. | 半兽军阀死了，而且失去首领，绿皮帮的会像蛇一样因无头枯萎而死。 你的雇主，%employer%，将对这一消息感到非常高兴。 | 兽人军阀死了。 想起到它给这片土地带来的恐惧和混乱，它竟看起来出奇地平静。%randombrother% 走过来，笑了。%SPEECH_ON%它很大，但它也会死。 我觉得人们总是忘记后半句。%SPEECH_OFF%你点头，告诉他们准备回去找 %employer% 在 %townname%。 | 军阀死在你脚下，就在他应该在的地方。 %companyname% 已从 %employer% 挣得了发薪日。剩下的就是回到贵族那里把消息告诉他。. | %employer% 可能根本不相信你。 他可能没有预见到你，一个雇佣兵队长，站在一个死去的兽人军阀身边的时刻。 但这就是你今天所处的位置，因为 %companyname% 是不可小看的。 是时候回到那个贵族那里去了，为了你的发薪日。 | 兽人军阀死了，军队四散了。 你环顾四周，对你的人大喊。%SPEECH_ON%伙计们，我的朋友想杀死他最大的敌人，他应该找谁？%SPEECH_OFF%他们举起了拳头。%SPEECH_ON%The %companyname%!%SPEECH_OFF%你笑着继续说。%SPEECH_ON%一个老妇人要我们把她阁楼里的老鼠都杀了，她该找谁？%SPEECH_OFF%男人们，这次安静些。%SPEECH_ON%The %companyname%?%SPEECH_OFF%你咧开嘴笑着继续说。%SPEECH_ON%如果一个讲究的人怕墙上的蜘蛛，他应该找谁？%SPEECH_OFF%%randombrother% spits.%SPEECH_ON%让我们回到 %townname% 那个 %employer% 已经准备好了！%SPEECH_OFF% | 你看着绿皮像老鼠一样散开。%randombrother% 看起来准备好追了，但你阻止了他。%SPEECH_ON%让他们跑了。%SPEECH_OFF%这个雇佣兵摇摇头。%SPEECH_ON%但他们会提到我们的！ 他们知道我们是谁。%SPEECH_OFF%你咧嘴一笑，拍了拍那个人的肩膀。%SPEECH_ON%确切地。快点，让我们回到 %townname% 找 %employer%。%SPEECH_OFF% | 你走过死亡之丘，站在被杀的兽人军阀面前。 苍蝇已经扑到他身上了。%randombrother% 站在你旁边，低头看着野兽。%SPEECH_ON%他没那么坏。 我是说，好吧，他很吓人。 有点像会让我做噩梦的事情，但总的来说，还不错。%SPEECH_OFF%你微笑着拍拍他的肩膀。%SPEECH_ON%我希望有一天你能用它的故事吓吓你的孙子。%SPEECH_OFF% | 战场已定。 死去的人是他们一生都在前往的方向。 绿皮正在向山上跑去。 和 %companyname% 欢呼胜利。%employer% 最满意这些所发生的事。 | %companyname% 战胜了绿皮野蛮人。 你看不起兽人军阀，考虑到很多东西都得这样死去…它可能会死。 一个有着奇怪规则的奇怪世界，但事情就是这样。\n\n%employer% 会很高兴，给你很多报酬－硬币的世界是你最了解的。 | 你和 %randombrother% 看着兽人军阀的尸体。 苍蝇已经在它的舌头上忙碌着，互相摩擦着，传播着它们的瘟疫。 雇佣兵看着你笑了。%SPEECH_ON%那就是你自己看到的结局吗，一群昆虫在你那该死的脸上干这事？%SPEECH_OFF%你耸耸肩答道。%SPEECH_ON%裹在毯子里，在家人的陪伴下，我离死亡还有很长一段路要走，这是肯定的。%SPEECH_OFF%你在佣兵的胸口上拍了一下。%SPEECH_ON%得了，别说了。 让我们回去找 %employer%，拿我们的报酬。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "{%companyname%取得了胜利！ | 胜利！}",
					function getResult()
					{
						return 0;
					}

				}
			],
			function start()
			{
				this.Contract.setState("Return");
			}

		});
		this.m.Screens.push({
			ID = "Berserkers1",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_93.png[/img]在途中，%randombrother% 突然挺直身子并告诉所有人保持安静。 你蹲下身子，向他走去。 他指着一些灌木丛。%SPEECH_ON%那里。麻烦。麻烦大了。%SPEECH_OFF%你凝视着灌木丛，看到一个兽人狂暴者营地。 他们生了一堆小火，上面放着旋转的肉。 附近有一堆笼子，每个笼子里都有一只哀嚎的狗。 你会看到其中一个绿皮打开笼子，将狗拉出。 他拖着它，又踢又叫地向着火，把它举在火焰上。\n\n 雇佣兵瞥了你一眼。%SPEECH_ON%我们该怎么办，先生？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们在打仗，每一场战斗都很重要。拿起武器！",
					function getResult()
					{
						local p = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos(), true);
						p.CombatID = "Berserkers";
						p.Music = this.Const.Music.OrcsTracks;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Line;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Line;
						this.Const.World.Common.addUnitsToCombat(p.Entities, this.Const.World.Spawn.BerserkersOnly, 80 * this.Contract.getDifficultyMult() * this.Contract.getScaledDifficultyMult(), this.World.FactionManager.getFactionOfType(this.Const.FactionType.Orcs).getID());
						this.World.Contracts.startScriptedCombat(p, false, true, true);
						return 0;
					}

				},
				{
					Text = "这不是我们的战斗。",
					function getResult()
					{
						return "Berserkers2";
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Berserkers2",
			Title = "在途中…",
			Text = "[img]gfx/ui/events/event_93.png[/img]这不是你的战斗，永远也不会是。 你让这些人在营地周围转来转去，悄无声息地避免与一群狂暴的人发生一场很容易造成毁灭性打击的战斗。 狗的嚎叫似乎要把你赶走，即便你已经离开那个地方很久了还和几个人在那附近徘徊。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "保持头脑清醒，伙计们。",
					function getResult()
					{
						this.Flags.set("IsBerserkers", false);
						this.Flags.set("IsBerserkersDone", false);
						return 0;
					}

				}
			],
			function start()
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.houndmaster")
					{
						bro.worsenMood(1.0, "你没有阻止战犬被兽人吃掉");

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
		this.m.Screens.push({
			ID = "Berserkers3",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_32.png[/img]战斗结束后，你好好看看狂暴者的营地。 每一个笼子都是一只枯萎走投无路的狗的家。 当你打开其中一个笼子时，狗就会跳出来，一边狂吠，一边在山上飞奔，然后消失，就像这样。 其他大多数杂种狗也纷纷效仿。不过，还有两个。 你检查营地的其他地方时，他们跟着你。%randombrother% 指出它们是战犬。%SPEECH_ON%请看看看它们的大小。 又大又壮又恶心的臭屁。 他们的主人一定被兽人杀死了，现在，他们有理由信任我们。 欢迎来到我们队伍，小伙伴们。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "做得好，伙计们。",
					function getResult()
					{
						this.Flags.set("IsBerserkers", false);
						this.Flags.set("IsBerserkersDone", false);
						return 0;
					}

				}
			],
			function start()
			{
				local item = this.new("scripts/items/accessory/wardog_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/accessory/wardog_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Berserkers4",
			Title = "战斗之后…",
			Text = "[img]gfx/ui/events/event_32.png[/img]随着最后一个狂暴者被杀，你开始进入他们的营地。 你发现烧焦的狗骨头散落在营火上。 肉已经被摘得干干净净，一堆人头摇摇欲坠，就像一个有病的石堆。%randombrother% 走到四周去打开笼子。 所有的狗，在笼门打开的那一刻，就冲出去跑掉了。 雇佣兵设法抓住了一个，但它尖叫着，一瘸一拐地软倒了，死于极度的恐慌和恐惧。 除了失望和成堆的兽人屎外，营地的其他地方没有任何有价值的东西。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们在这里还是做得很好。",
					function getResult()
					{
						this.Flags.set("IsBerserkers", false);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success1",
			Title = "你回来后…",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你发现 %employer% 与他的将军交谈。 他笑着转向你，张开双臂。%SPEECH_ON%好吧，你做到了，佣兵。 我得承认，我原本认为你做不到。 杀死兽人很有意思吧。%SPEECH_OFF%这不是特别有趣，但是你还是点头。 贵族去拿了一个袋子，里面有 %reward_completion% 克朗，亲自交给你。%SPEECH_ON%工作很出色。%SPEECH_OFF% | %employer% 被发现和几个女人在床上。 他的警卫站在门口，耸耸肩，“你说让他进来”。 贵族向你招手。%SPEECH_ON%我有点忙，但我知道你在…努力中获得了成功。%SPEECH_OFF%他弹了弹手指，一个女人从毯子里滑了出来。 她优雅地走过冰冷的石头地面，拎起一个袋子，递给你。%employer% 再说一次。%SPEECH_ON%%reward_completion% 克朗, 不对吗? 我认为这是你所做工作的不错报酬。 我听说杀死兽人军阀并不是一件容易的事。%SPEECH_OFF%女人把钱交给你时，她凝视着你的眼睛。%SPEECH_ON%你杀死了兽人军阀？那真是太勇敢了…%SPEECH_OFF%你点了点头，这位轻巧的女士扭了扭她的脚趾。 贵族又弹了一声手指，她回到了他的床上。%SPEECH_ON%小心，雇佣兵。%SPEECH_OFF% | 一名警卫将你带到园艺 %employer%。他在蔬菜上剪了一下，然后放进了一个仆人拿着的篮子里。%SPEECH_ON%从你没有死来看，我的推理技能告诉我你成功地杀死了兽人军阀。%SPEECH_OFF%你回应道。%SPEECH_ON%这并不容易。%SPEECH_OFF%贵族点头，凝视着泥土，然后继续剪下来一系列西红柿。%SPEECH_ON%站在那边的警卫将支付你的报酬。我们同意的 %reward_completion% 克朗。 我现在很忙，但你应该知道我和这个镇上的人欠你很多。%SPEECH_OFF%而且“很多”，他的意思显然是 %reward_completion% 克朗。 | %employer% 欢迎你进入他的房间。%SPEECH_ON%这些天来，我的小鸟们这些天一直在叽叽喳喳地给我讲故事，说有个佣兵杀死了一个兽人军阀，并把他的军队驱散了。 而且我对自己想，嘿，我想我认识那个家伙。%SPEECH_OFF%贵族咧嘴笑笑，交出了一袋 %reward_completion% 克朗。%SPEECH_ON%做得好，雇佣兵。%SPEECH_OFF% | %employer% 用一袋 %reward_completion% 克朗向你打招呼。%SPEECH_ON%我的密探已经告诉我我需要知道的一切。 你是值得信赖的人，佣兵。%SPEECH_OFF% | 当你进入 %employer%的房间时，你发现贵族在听他的一位书记员的耳语。 看到你，那人挺直了身子。%SPEECH_ON%说到魔鬼，他就会来。 你是全城的焦点，佣兵。 杀死兽人军阀并分散其军队？ 好吧，我想说这值得我们同意的 %reward_completion% 克朗。%SPEECH_OFF% | %employer% 正经地盯着地图。%SPEECH_ON%我要重绘其中的一部分，谢谢你－我的意思是，这很好。 杀死那个兽人军阀可以让我们从他在这片土地上撒下的灰烬中重建家园。%SPEECH_OFF%你点了点头，但巧妙地询问了报酬。贵族笑了。%SPEECH_ON%%reward_completion% 克朗，不对吗？另外，你至少应该花一点时间听听对你的赞誉，佣兵。 钱不会飞了，但你现在的自豪感总有一天会褪去的。%SPEECH_OFF%你不同意。那笔钱蜕变成一品脱的美酒。 | %employer% 正在他的房间踌躇步子，而将军们则几乎尽职地沉默在路旁。 你问问题出在哪里，那人就挺直了腰杆。%SPEECH_ON%以旧神屁股的名义，我原以为你办不到。%SPEECH_OFF%你无视那张高涨的信任票，告诉贵族你所做的一切。 他连连点头，然后拿出一袋 %reward_completion% 克朗并将其交给你。%SPEECH_ON%这些干的很出色。很他妈出色。%SPEECH_OFF% | 你发现 %employer% 看着仆人砍木头。 看到你的影子，贵族转过身来。%SPEECH_ON%啊，时下的风云人物！ 我已经听过很多关于你所做的事情。 我们实际上是在庆祝－得准备做饭用的柴火和晚上的庆祝活动。 我很想邀请你，但这只限于贵族，我相信你能理解。%SPEECH_OFF%你耸耸肩并回应道。%SPEECH_ON%如果我拥有 %reward_completion% 克朗我们约好的，我会理解得更深的。%SPEECH_OFF%%employer% 大笑起来，对一个警卫打了个响指，他立马拿来了你的报酬。 | %employer% 被发现时正与另一个雇佣兵团的队长交谈。 那个队长是一个孱弱的领导者，也许才刚开始他的事业呢。 但是，见到你后，贵族迅速赶走了他并欢迎你。%SPEECH_ON%啊，见鬼，见到你太好了雇佣兵！ 事情在这里变得有些绝望。%SPEECH_OFF%你注意到，你刚才看到的队长大概不适合处理任何工作，更不用说寻找兽人军阀。 贵族递给你一个 %reward_completion% 克朗的袋子并回应。%SPEECH_ON%听着，让我们承认你今天做得很好。 我们终于可以开始重建那些该死的兽人野蛮人摧毁的东西，这才是重点。%SPEECH_OFF%虽然你认为手中的克朗才是关键所在，但决定不再纠缠于这一点。}",
			Image = "",
			Characters = [],
			List = [],
			ShowEmployer = true,
			Options = [
				{
					Text = "当之无愧的报酬。",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());
						this.World.FactionManager.getFaction(this.Contract.getFaction()).addPlayerRelation(this.Const.World.Assets.RelationNobleContractSuccess, "杀死了一个著名的兽人军阀");
						this.World.Contracts.finishActiveContract();

						if (this.World.FactionManager.isGreenskinInvasion())
						{
							this.World.FactionManager.addGreaterEvilStrength(this.Const.Factions.GreaterEvilStrengthOnCriticalContract);
						}

						return 0;
					}

				}
			],
			function start()
			{
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + this.Contract.m.Payment.getOnCompletion() + "[/color] 克朗"
				});
			}

		});
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			if (this.m.Destination != null && !this.m.Destination.isNull())
			{
				this.m.Destination.getSprite("selection").Visible = false;
				this.m.Destination.setOnCombatWithPlayerCallback(null);
			}

			this.m.Home.getSprite("selection").Visible = false;
		}
	}

	function onIsValid()
	{
		if (!this.World.FactionManager.isGreenskinInvasion())
		{
			return false;
		}

		return true;
	}

	function onSerialize( _out )
	{
		if (this.m.Destination != null && !this.m.Destination.isNull())
		{
			_out.writeU32(this.m.Destination.getID());
		}
		else
		{
			_out.writeU32(0);
		}

		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		local destination = _in.readU32();

		if (destination != 0)
		{
			this.m.Destination = this.WeakTableRef(this.World.getEntityByID(destination));
		}

		this.contract.onDeserialize(_in);
	}

});

