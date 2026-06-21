this.hedgeknight_vs_hedgeknight_event <- this.inherit("scripts/events/event", {
	m = {
		HedgeKnight1 = null,
		HedgeKnight2 = null,
		NonHedgeKnight = null,
		Monk = null
	},
	function create()
	{
		this.m.ID = "event.hedgeknight_vs_hedgeknight";
		this.m.Title = "露营时…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%nonhedgeknight% 急着投胎似的冲进你的大帐，在固定桩上绊了一跤，险些把整个帐篷都扯倒。 豆大的汗珠不住地从他脸上滴下，打湿了你的地图。 你盯着他，让他解释一下这整的是哪一出。 他忙说 %hedgeknight1% 和 %hedgeknight2% 那俩野骑士闹起来了。 两人都抄着家伙，看架式多半是要玩命。 让队里块头最大的两个家伙打上一场对你甚至是对整个团队而言可都不是件…好事。 你连忙赶去现场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我去看看他们。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.NonHedgeKnight.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_35.png[/img]只见 %hedgeknight1% 紧紧握着一把大剑，%hedgeknight2% 如小孩耍木棍般舞着一柄巨斧。 其他队友都躲在一旁不敢上前。%nonhedgeknight% 解释说他俩 {之前在一场骑枪比赛里没分出胜负 | 之前在战场上交过手，现在还想再分个高下 | 起了点矛盾，不断加剧最终升级成了真人快打}. 一位兄弟站了出来，恳求两位野骑士放下隔阂，却被 %hedgeknight2% 一把推开。 鉴于他俩不像能劝得动，或许让他俩彻底的解决矛盾才是上策？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "愿最强者获胜。",
					function getResult( _event )
					{
						return _event.m.Monk == null ? "C1" : "C2";
					}

				},
				{
					Text = "听我说，想打人别在这打，等上了战场有的是人给你们打！",
					function getResult( _event )
					{
						return _event.m.Monk == null ? "C3" : "C4";
					}

				},
				{
					Text = "给你俩每人发一千奖金行不，别再闹了！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C1",
			Text = "[img]gfx/ui/events/event_35.png[/img]%nonhedgeknight% 请求你阻止这场争斗。 两个野骑士把视线转向你，壮硕的胸膛上下起伏。 你无动于衷。 他们微微点头，随后向对方发起猛冲。 金铁相交，碰撞声不绝于耳。 两人咆哮着试图杀死对方，声音之洪亮已经隐隐盖过了兵刃的破空声。 这把剑切住了巨大斧头的柄，两刃相互咬合。 两位野骑士恶狠狠地对视一眼，不约而同地掏出匕首，一下又一下地猛扎对方，直至一同摔倒在地。 看来哪怕是遍体鳞伤也不足以让这两头人形怪物停止争斗。 武器很快又从匕首换成了带着护套的拳头，鲜血与碎齿四下飞溅。\n\n队员们再次向你投来求助的眼神，显然，若不出手干预，这场争斗必定会以一位雇佣骑士的死亡收场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可就有点过头了。 大家一起上，拉开他们！",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "让我们看看谁在战斗中最强。",
					function getResult( _event )
					{
						return this.Math.rand(1, _event.m.HedgeKnight1.getLevel() + _event.m.HedgeKnight2.getLevel()) <= _event.m.HedgeKnight1.getLevel() ? "F" : "G";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				_event.m.HedgeKnight1.addLightInjury();
				_event.m.HedgeKnight2.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight1.getName() + "遭受轻伤"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight2.getName() + "遭受轻伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "C3",
			Text = "[img]gfx/ui/events/event_35.png[/img]两个野骑士对你的劝阻充耳不闻，只是死死盯着对方，壮硕的胸膛上下起伏。 少顷，他们向对方发起猛冲。 金铁相交，碰撞声不绝于耳。 两人咆哮着试图杀死对方，声音之洪亮已经隐隐盖过了兵刃的破空声。 这把剑切住了巨大斧头的柄，两刃相互咬合。 两位野骑士恶狠狠地对视一眼，不约而同地掏出匕首，一下又一下地猛扎对方，直至一同摔倒在地。 看来哪怕是遍体鳞伤也不足以让这两头人形怪物停止争斗。 武器很快又从匕首换成了带着护套的拳头，鲜血与碎齿四下飞溅。\n\n队员们再次向你投来求助的眼神，显然，若不出手干预，这场争斗必定会以一位雇佣骑士的死亡收场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可就有点过头了。 大家一起上，拉开他们！",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "让我们看看谁在战斗中最强。",
					function getResult( _event )
					{
						return this.Math.rand(1, _event.m.HedgeKnight1.getLevel() + _event.m.HedgeKnight2.getLevel()) <= _event.m.HedgeKnight1.getLevel() ? "F" : "G";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				_event.m.HedgeKnight1.addLightInjury();
				_event.m.HedgeKnight2.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight1.getName() + "遭受轻伤"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight2.getName() + "遭受轻伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "C2",
			Text = "[img]gfx/ui/events/event_35.png[/img]%nonhedgeknight% 请求你阻止这场争斗。 两个野骑士把视线转向你，壮硕的胸膛上下起伏。 你无动于衷。 他们微微点头，随后向对方发起猛冲。 金铁相交，碰撞声不绝于耳。 两人咆哮着试图杀死对方，声音之洪亮已经隐隐盖过了兵刃的破空声。 这把剑切住了巨大斧头的柄，两刃相互咬合。 两位野骑士恶狠狠地对视一眼，不约而同地掏出匕首，一下又一下地猛扎对方，直至一同摔倒在地。 看来哪怕是遍体鳞伤也不足以让这两头人形怪物停止争斗。 武器很快又从匕首换成了带着护套的拳头，鲜血与碎齿四下飞溅。\n\n队员们再次向你投来求助的眼神，显然，若不出手干预，这场争斗必定会以一位雇佣骑士的死亡收场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可就有点过头了。 大家一起上，拉开他们！",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "让我们看看谁在战斗中最强。",
					function getResult( _event )
					{
						return this.Math.rand(1, _event.m.HedgeKnight1.getLevel() + _event.m.HedgeKnight2.getLevel()) <= _event.m.HedgeKnight1.getLevel() ? "F" : "G";
					}

				},
				{
					Text = "%monk% 僧侣！ 你能找到一个和平的解决办法吗？",
					function getResult( _event )
					{
						return "H";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				_event.m.HedgeKnight1.addLightInjury();
				_event.m.HedgeKnight2.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight1.getName() + "遭受轻伤"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight2.getName() + "遭受轻伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "C4",
			Text = "[img]gfx/ui/events/event_35.png[/img]两个野骑士对你的劝阻充耳不闻，只是死死盯着对方，壮硕的胸膛上下起伏。 少顷，他们向对方发起猛冲。 金铁相交，碰撞声不绝于耳。 两人咆哮着试图杀死对方，声音之洪亮已经隐隐盖过了兵刃的破空声。 这把剑切住了巨大斧头的柄，两刃相互咬合。 两位野骑士恶狠狠地对视一眼，不约而同地掏出匕首，一下又一下地猛扎对方，直至一同摔倒在地。 看来哪怕是遍体鳞伤也不足以让这两头人形怪物停止争斗。 武器很快又从匕首换成了带着护套的拳头，鲜血与碎齿四下飞溅。\n\n队员们再次向你投来求助的眼神，显然，若不出手干预，这场争斗必定会以一位雇佣骑士的死亡收场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这可就有点过头了。 大家一起上，拉开他们！",
					function getResult( _event )
					{
						return "E";
					}

				},
				{
					Text = "让我们看看谁在战斗中最强。",
					function getResult( _event )
					{
						return this.Math.rand(1, _event.m.HedgeKnight1.getLevel() + _event.m.HedgeKnight2.getLevel()) <= _event.m.HedgeKnight1.getLevel() ? "F" : "G";
					}

				},
				{
					Text = "%monk% 僧侣，你能找到一个和平的解决办法吗？",
					function getResult( _event )
					{
						return "H";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				_event.m.HedgeKnight1.addLightInjury();
				_event.m.HedgeKnight2.addLightInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight1.getName() + "遭受轻伤"
				});
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.HedgeKnight2.getName() + "遭受轻伤"
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img]你掏出一袋沉甸甸的硬币。 两个野骑士转过头来，金子相互碰撞的声音吸引了他们的注意。%SPEECH_ON%一人一千克朗，怎么样？%SPEECH_OFF%他们交换了一眼。 他们耸耸肩。你点头。%SPEECH_ON%下不为例，明白吗？%SPEECH_OFF%他们也点头，接过了这一大笔简直是天上掉下来的横财。 其他兄弟们嫉妒得眼都红了，可能没想到打个架还有钱可拿。 终于，两位野骑士一致同意比起斗个你死我活，还是钱来得实在。 你只希望他们不会因为分赃不均而又“庆祝”一场。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这最好是最后一次。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				this.World.Assets.addMoney(-2000);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]2000[/color] 克朗"
					}
				];
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.HedgeKnight1.getID() || bro.getID() == _event.m.HedgeKnight2.getID())
					{
						continue;
					}

					if (bro.getSkills().hasSkill("trait.greedy"))
					{
						bro.worsenMood(2.0, "因为你贿赂人来阻止他们的斗争而生气");
					}
					else if (this.Math.rand(1, 100) <= 50)
					{
						bro.worsenMood(1.0, "担心你贿赂人来阻止他们的战斗");
					}

					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[bro.getMoodState()],
						text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_35.png[/img]你看够了，忙叫队员们去中止这场战斗。 队员们犹豫了，但你搬出雇佣合同上的条款劝服了他们。 他们拿来了大块的皮革和毯子还有各种锅碗瓢盆。 计划很简单：把这堆东西一股脑全扣在两个野骑士身上，趁他俩蒙圈的时候上去把他俩拉开。 但接下来的情况就像斗牛一样，男人们和野骑士们纠缠在一起，有人被掀翻到空中、有人被一脚踹了个满脸开花。 甚至还有倒霉蛋被两个野骑士夹在中间暴揍。\n\n终于，两位当事人消了气，给这场混乱画上了句号。 若是再晚一点，只怕所有人都要抄起武器了。 鼻青脸肿的队员们缓缓地爬起来，像是刚被台风刮过一般。 你连忙清点受伤的人数并为他们做紧急处理。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "终于结束了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.HedgeKnight1.getID() || bro.getID() == _event.m.HedgeKnight2.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 60)
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 75)
					{
						bro.addLightInjury();
						this.List.push({
							id = 10,
							icon = "ui/icons/days_wounded.png",
							text = bro.getName() + "遭受轻伤"
						});
					}
					else
					{
						local injury = bro.addInjury(this.Const.Injury.Brawl);
						this.List.push({
							id = 10,
							icon = injury.getIcon(),
							text = bro.getName() + " 遭受 " + injury.getNameOnly()
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_35.png[/img]你找了一截树桩坐下观赏这场战斗。 两人在地上滚来滚去，用足以打死一匹马的力道猛击对方的脸。 最终，%hedgeknight1% 压在 %hedgeknight2%的肩膀上。 %hedgeknight1% 见旁边有块大石头，便一把拿过来砸在对手的头上。 血肉模糊，隐隐露出了一些红白之物。 好石头举起又砸下的。 头盖骨砸成碎片，%hedgeknight2% 已经没了反击的力气。%hedgeknight1% 将拳头捣进头骨并掏出了一团猩红的东西。 你捂住了嘴，有几个队员直接转过身吐了一地。\n\n%hedgeknight1% 摇摇晃晃地起身，扔掉手中的那团东西。 擦了擦满头满脸的血，只说了一个词。%SPEECH_ON%完事。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少 %hedgeknight2% 也算是死得其所。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight1.getImagePath());
				local dead = _event.m.HedgeKnight2;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "在决斗中死于 " + _event.m.HedgeKnight1.getName(),
					Expendable = false
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.HedgeKnight2.getName() + "是死了"
				});
				_event.m.HedgeKnight2.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.HedgeKnight2.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.HedgeKnight2);
				local injury = _event.m.HedgeKnight1.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.HedgeKnight1.getName() + " 遭受 " + injury.getNameOnly()
				});

				if (this.Math.rand(1, 2) == 1)
				{
					local v = this.Math.rand(1, 2);
					_event.m.HedgeKnight1.getBaseProperties().MeleeSkill += v;
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.HedgeKnight1.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] 近战技能"
					});
				}
				else
				{
					local v = this.Math.rand(1, 2);
					_event.m.HedgeKnight1.getBaseProperties().MeleeDefense += v;
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.HedgeKnight1.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] 近战防御"
					});
				}

				_event.m.HedgeKnight1.getSkills().update();
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_35.png[/img]你刚在一截树桩上坐下又立马起身，才不至于被打过来的两个野骑士给波及到。%hedgeknight1%的脸磕在你刚才坐着的地方。 他迅速转身面对袭击他的人。 却被 %hedgeknight2%的靴子正中面门，皮革与血肉碰撞发出一声钝响。 %hedgeknight1% 咽下被打落的牙齿，嘲笑 %hedgeknight2% 是不是只有这点本事。 %hedgeknight2% 猛踢他的脸作为回答，每次抬起他的靴子，就会发现 %hedgeknight1% 的人处于更糟糕的状态，从血淋淋的红色到像噩梦般扭曲的肉体和眼睑，扁平的鼻子和恐怖的笑容，他的牙齿要么不见了，要么挂在充血的牙龈上，就像脱皮手指上的钉子。\n\n终于，脑壳不堪重负，发出的一连串碎裂声好似冬日里结霜的树枝弯折发出的怪响。 并非所有兄弟都像你一样有勇气看下去，甚至有人吐了。 只见 %hedgeknight2%的靴子捣进了对手的脑子里。 他一边骂脏话一边挣扎着想将脚拔出来。\n\n幸存的那位野骑士甚至得拽着大腿根方才将卡在脑壳里的脚给释放出来。 他转过身，将脚在地上擦了又擦，并像在野外玩了一整天的孩子那样，把脚往后翘起以确认脚后跟没有沾上什么不干净的东西。 靴子上还沾着一片大脑的碎块，他像剥玉米壳般轻描淡写地取下来并扔到一旁。 随后揉着肚子问大家饿不饿，并端着满满一大盘粗粮粥回了帐篷。\n\n当晚，在考虑要不要为了团队的安全处理掉他时，你发现 %hedgeknight2% 睡得宛如婴儿般香甜。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少 %hedgeknight1% 也算是死得其所。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HedgeKnight2.getImagePath());
				local dead = _event.m.HedgeKnight1;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "在决斗中死于 " + _event.m.HedgeKnight2.getName(),
					Expendable = false
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.HedgeKnight1.getName() + "是死了"
				});
				_event.m.HedgeKnight1.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.HedgeKnight1.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.HedgeKnight1);
				local injury = _event.m.HedgeKnight2.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.HedgeKnight2.getName() + " 遭受 " + injury.getNameOnly()
				});

				if (this.Math.rand(1, 2) == 1)
				{
					local v = this.Math.rand(1, 2);
					_event.m.HedgeKnight2.getBaseProperties().MeleeSkill += v;
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.HedgeKnight2.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] 近战技能"
					});
				}
				else
				{
					local v = this.Math.rand(1, 2);
					_event.m.HedgeKnight2.getBaseProperties().MeleeDefense += v;
					this.List.push({
						id = 16,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.HedgeKnight2.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + v + "[/color] 近战防御"
					});
				}

				_event.m.HedgeKnight2.getSkills().update();
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_05.png[/img]僧侣点头，冷静地走上前拦在两人之间。 他抬起手，摆出各种古老的宗教手势。 他开始讲述诸神如何根据人的本性和行为来评判世人。 有些神也许会认可这场争斗，但绝非大多数神。 更重要的是，僧侣说，如果他们真的想战斗，两人大可死后在冥间尽情比武。 若选择在人世时争斗，被杀者将被神护佑送往来生，而杀人者则不会，这样的结果对于胜者毫无意义。 令人惊讶的是，这些奇怪的宗教规矩似乎使两人冷静了下来。 僧侣邀请两人进一步细谈，他们三个并排走着，拱着背，挥着手，谈笑风生。 至于其他队员们，他们也挺高兴没闹出人命。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "感谢上帝。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());

				if (!_event.m.Monk.getFlags().has("resolve_via_hedgeknight"))
				{
					_event.m.Monk.getFlags().add("resolve_via_hedgeknight");
					_event.m.Monk.getBaseProperties().Bravery += 2;
					_event.m.Monk.getSkills().update();
					this.List = [
						{
							id = 16,
							icon = "ui/icons/bravery.png",
							text = _event.m.Monk.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
						}
					];
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 2000)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 4)
		{
			return;
		}

		local candidates = [];
		local candidates_other = [];
		local candidates_monk = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.hedge_knight")
			{
				candidates.push(bro);
			}
			else
			{
				candidates_other.push(bro);

				if (bro.getBackground().getID() == "background.monk")
				{
					candidates_monk.push(bro);
				}
			}
		}

		if (candidates.len() < 2 || candidates_other.len() == 0 && candidates.len() <= 2)
		{
			return;
		}

		local r = this.Math.rand(0, candidates.len() - 1);
		this.m.HedgeKnight1 = candidates[r];
		candidates.remove(r);
		r = this.Math.rand(0, candidates.len() - 1);
		this.m.HedgeKnight2 = candidates[r];
		candidates.remove(r);

		if (candidates_other.len() > 0)
		{
			this.m.NonHedgeKnight = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		}
		else
		{
			this.m.NonHedgeKnight = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		if (candidates_monk.len() != 0)
		{
			this.m.Monk = candidates_monk[this.Math.rand(0, candidates_monk.len() - 1)];
		}

		this.m.Score = (2 + candidates.len()) * 600;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hedgeknight1",
			this.m.HedgeKnight1.getName()
		]);
		_vars.push([
			"hedgeknight2",
			this.m.HedgeKnight2.getName()
		]);
		_vars.push([
			"nonhedgeknight",
			this.m.NonHedgeKnight.getName()
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.HedgeKnight1 = null;
		this.m.HedgeKnight2 = null;
		this.m.NonHedgeKnight = null;
		this.m.Monk = null;
	}

});

