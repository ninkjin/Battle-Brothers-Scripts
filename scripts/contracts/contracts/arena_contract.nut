this.arena_contract <- this.inherit("scripts/contracts/contract", {
	m = {},
	function create()
	{
		this.contract.create();
		this.m.DifficultyMult = 1.0;
		this.m.Type = "contract.arena";
		this.m.Name = "竞技场";
		this.m.TimeOut = this.Time.getVirtualTimeF() + this.World.getTime().SecondsPerDay * 1.0;
	}

	function onImportIntro()
	{
		this.importSettlementIntro();
	}

	function start()
	{
		this.setup();
		this.contract.start();
	}

	function setup()
	{
		this.m.Flags.set("Number", 0);
		local pay = 550;

		if (this.m.Home.hasSituation("situation.bread_and_games"))
		{
			pay = pay + 100;
		}

		local twists = [];

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 5)
		{
			twists.push({
				R = 5,
				F = "IsSwordmaster",
				P = 50
			});
		}

		if (this.Const.DLC.Wildmen && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 15)
		{
			twists.push({
				R = 2,
				F = "IsSwordmasterChampion",
				P = 150
			});
		}

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 5)
		{
			twists.push({
				R = 5,
				F = "IsHedgeKnight",
				P = 50
			});
		}

		if (this.Const.DLC.Wildmen && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 15)
		{
			twists.push({
				R = 2,
				F = "IsExecutionerChampion",
				P = 150
			});
		}

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 5)
		{
			twists.push({
				R = 5,
				F = "IsDesertDevil",
				P = 50
			});
		}

		if (this.Const.DLC.Wildmen && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 15)
		{
			twists.push({
				R = 2,
				F = "IsDesertDevilChampion",
				P = 150
			});
		}

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 5)
		{
			twists.push({
				R = 5,
				F = "IsMercenaries",
				P = 0
			});
		}

		if (this.Const.DLC.Unhold && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 6)
		{
			twists.push({
				R = 5,
				F = "IsUnholds",
				P = 100
			});
		}

		if (this.Const.DLC.Lindwurm && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
		{
			twists.push({
				R = 5,
				F = "IsLindwurm",
				P = 200
			});
		}

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 3)
		{
			twists.push({
				R = 5,
				F = "IsSandGolems",
				P = 50
			});
		}

		if (this.Const.DLC.Wildmen && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 3)
		{
			twists.push({
				R = 15,
				F = "IsGladiators",
				P = 0
			});
		}

		if (this.Const.DLC.Wildmen && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 15)
		{
			twists.push({
				R = 5,
				F = "IsGladiatorChampion",
				P = 150
			});
		}

		if (this.Const.DLC.Unhold && this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") <= 5)
		{
			twists.push({
				R = 10,
				F = "IsSpiders",
				P = -75
			});
		}

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") <= 3)
		{
			twists.push({
				R = 10,
				F = "IsHyenas",
				P = 0
			});
		}
		else
		{
			twists.push({
				R = 10,
				F = "IsFrenziedHyenas",
				P = 0
			});
		}

		twists.push({
			R = 10,
			F = "IsGhouls",
			P = 0
		});
		twists.push({
			R = 15,
			F = "IsDesertRaiders",
			P = 0
		});
		twists.push({
			R = 10,
			F = "IsSerpents",
			P = 0
		});
		local maxR = 0;

		foreach( t in twists )
		{
			maxR = maxR + t.R;
		}

		local r = this.Math.rand(1, maxR);

		foreach( t in twists )
		{
			if (r <= t.R)
			{
				this.m.Flags.set(t.F, true);
				pay = pay + t.P;
				break;
			}
			else
			{
				r = r - t.R;
			}
		}

		this.m.Payment.Pool = pay * this.getPaymentMult() * this.getReputationToPaymentMult();
		this.m.Payment.Completion = 1.0;
	}

	function createStates()
	{
		this.m.States.push({
			ID = "Offer",
			function start()
			{
				this.Contract.m.BulletpointsObjectives = [
					"给最多三个你的手下装备角斗场项圈。",
					"再次进入竞技场开始战斗。",
					"这场战斗将会是生死之战，之后你将无法撤退或者调整装备。"
				];
				this.Contract.m.BulletpointsPayment = [
					"在竞技场中获胜得到" + this.Contract.m.Payment.getOnCompletion() + "克朗。"
				];

				if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
				{
					this.Contract.m.BulletpointsPayment.push("赢得一件角斗士装备。");
				}

				this.Contract.setScreen("Task");
			}

			function end()
			{
				this.Flags.set("Day", this.World.getTime().Days);
				this.Contract.setScreen("Overview");
				this.World.Contracts.setActiveContract(this.Contract);
			}

		});
		this.m.States.push({
			ID = "Running",
			function start()
			{
				this.Contract.m.Home.getSprite("selection").Visible = true;
			}

			function update()
			{
				if (this.Flags.get("IsVictory"))
				{
					this.Contract.setScreen("Success");
					this.World.Contracts.showActiveContract();
				}
				else if (this.Flags.get("IsFailure"))
				{
					this.Contract.setScreen("Failure1");
					this.World.Contracts.showActiveContract();
				}
				else if (this.World.getTime().Days > this.Flags.get("Day"))
				{
					this.Contract.setScreen("Failure2");
					this.World.Contracts.showActiveContract();
				}
			}

			function onCombatVictory( _combatID )
			{
				if (_combatID == "Arena")
				{
					this.Flags.set("IsVictory", true);
				}
			}

			function onRetreatedFromCombat( _combatID )
			{
				if (_combatID == "Arena")
				{
					this.Flags.set("IsFailure", true);
				}
			}

		});
	}

	function createScreens()
	{
		this.m.Screens.push({
			ID = "Task",
			Title = "在竞技场",
			Text = "",
			Image = "",
			List = [],
			ShowDifficulty = true,
			Options = [
				{
					Text = "{我们要用鲜血染红这片沙漠! | 我想听到人群高呼我们的名字! | 我们会像屠宰羔羊一样屠杀他们!}",
					function getResult()
					{
						return "Overview";
					}

				},
				{
					Text = "{这不是我想要的。 | 我会退出这个。 | 我会等待下一场战斗。}",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						return 0;
					}

				}
			],
			function start()
			{
				this.Text = "[img]gfx/ui/events/event_155.png[/img]数十名男子在竞技场入口处闲逛。有些人沉默不语，不想暴露出他们的能力。然而，其他人则毫不掩饰地吹嘘自己的功夫，或是希望自己的虚张声势掩盖他们的短板。";
				this.Text += "头发花白的竞技场的管理者，用取代了手的钩子敲着手上的一个卷轴。";
				local baseDifficulty = 30;

				if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
				{
					baseDifficulty = baseDifficulty + 10;
				}

				baseDifficulty = baseDifficulty * this.Contract.getScaledDifficultyMult();

				if (this.Flags.get("IsSwordmaster"))
				{
					if (baseDifficulty < this.Const.World.Spawn.Troops.Swordmaster.Cost + this.Const.World.Spawn.Troops.BanditRaider.Cost)
					{
						this.Flags.set("Number", 0);
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始与一名剑术大师的战斗。";
					}
					else
					{
						this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.BanditRaider, baseDifficulty - this.Const.World.Spawn.Troops.Swordmaster.Cost, 2));
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始与一名剑术大师和%amount%名劫掠者的战斗。";
					}

					this.Text += "%SPEECH_ON%他们在他的名字旁边标上了一颗星，这是盖尔德的标志。这意味着他的道路是镀金的。你需要知道的是，他是一个剑术大师。你可能会觉得他是一位年长者，但你不会是第一个我这样告诉的人，明白吗？愿你的道路像镀金一样，因为这位剑术大师的道路肯定是如此。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsHedgeKnight"))
				{
					if (baseDifficulty < this.Const.World.Spawn.Troops.HedgeKnight.Cost + this.Const.World.Spawn.Troops.BanditRaider.Cost)
					{
						this.Flags.set("Number", 0);
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始与一个野骑士的战斗。";
					}
					else
					{
						this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.BanditRaider, baseDifficulty - this.Const.World.Spawn.Troops.HedgeKnight.Cost, 2));
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始与一名野骑士和%amount%名劫掠者的战斗。";
					}

					this.Text += "%SPEECH_ON%我相信北方人称他为“仇恨骑士”。我可能说错了。不要告诉其他角斗场主人我在说北方垃圾的话，但这个骑士是我在这里见过的最危险的人之一，如果你希望你的道路继续被镀金，那么我建议你做好准备，在战斗前好好休息一下。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsDesertDevil"))
				{
					if (baseDifficulty < this.Const.World.Spawn.Troops.DesertDevil.Cost + this.Const.World.Spawn.Troops.NomadOutlaw.Cost)
					{
						this.Flags.set("Number", 0);
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场开始对抗一名刀锋舞者。";
					}
					else
					{
						this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, baseDifficulty - this.Const.World.Spawn.Troops.DesertDevil.Cost, 2));
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗一名刀锋舞者和%amount%名游牧民。";
					}

					this.Text += "竞技场管理者举起一张卷轴，用钩手轻轻叩了叩。%SPEECH_ON%大名鼎鼎的刀锋舞者正式登场。也许长得有点娘，但能获得“刀锋舞者”称号的人必须像风一样娴熟地舞动刀剑。当然，舞蹈技巧只是额外加分，但他们在这方面也毫不逊色。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsSandGolems"))
				{
					this.Flags.set("Number", this.Math.max(3, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.SandGolem, baseDifficulty, 3)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗%amount%个伊弗利特。";
					this.Text += "%SPEECH_ON%这页上没有什么，因为我害怕如果我敢照亮它最凶猛的存在，沙漠会惩罚我。你要打%number%个伊弗利特。我不知道他们是如何把他们带到这里的，我只知道这是炼金术士的所作所为。如果你问我，我宁愿你打他们，而不是伊弗利特。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsGhouls"))
				{
					local num = 0;

					if (baseDifficulty >= this.Const.World.Spawn.Troops.GhoulHIGH.Cost * 2)
					{
						num = num + 1;
						num = num + this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Ghoul, baseDifficulty - this.Const.World.Spawn.Troops.GhoulHIGH.Cost);
					}
					else
					{
						num = num + this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.GhoulLOW, baseDifficulty * 0.5);
						num = num + this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Ghoul, baseDifficulty * 0.5);
					}

					this.Flags.set("Number", num);
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗%amount%名食尸鬼。";
					this.Text += "%SPEECH_ON%炼金术士们称之为......我甚至无法发音。我的舌头不能构造出这个词汇，因为它需要专业的北方词典。我没有时间在肤浅的琐事上研究北方的用语。你看起来我像个语音学家吗？我们就称它们为“啮咬斩手”吧。它们是可怕的畜生，有%number%只，我看到过它们活生生地吃掉人，所以你最好希望基尔德尔在看着——我不认为他能在这些野兽的腹部里给你提供任何光亮！%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsUnholds"))
				{
					this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Unhold, baseDifficulty));

					if (this.Flags.get("Number") == 1)
					{
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗一只巨魔。";
					}
					else
					{
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗 %amount% 只巨魔。";
					}

					this.Text += "%SPEECH_ON%你们要对抗 %number% 只北方佬所说的”巨魔“。维齐尔掏出大把金子把它们带到这里，群众们十分喜欢这些巨型怪物。它们很擅长粉碎战士，有时甚至会把战士抛到人群中去。那真是太美妙了。我觉得有些巨魔在这里待得时间越长就越喜欢这种表演，好像它们懂得了如何赢得观众的尖叫和欢呼。这是一种残忍的表演。不管怎么样，愿吉尔德守护你们。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsDesertRaiders"))
				{
					this.Flags.set("Number", this.Math.max(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗 %amount% 游牧民。";
					this.Text += "%SPEECH_ON%你的对手将会是%number%名最近退役的沙漠土匪。我指的是被维齐尔的巡警抓走的“退役”，当然。没有土匪想自愿踏进这里，哈哈哈！%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsGladiators"))
				{
					this.Flags.set("Number", this.Math.max(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，与%amount%名角斗士开始战斗。";
					this.Text += "%SPEECH_ON%嗯，呵呵，吉尔德肯定有幽默感。你将面对%number%名角斗士。但坦白说，我是这么对他们说的。而且我每天都这么说。明白了吗？你应该尽你的能力做好准备。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsSpiders"))
				{
					this.Flags.set("Number", this.Math.max(3, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Spider, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗 %amount% 只织网蛛。";
					this.Text += "%SPEECH_ON%那不是无花果树，那是一只蜘蛛。炼金术士们称之为织网蛛，这只是愚蠢的北方名称，事实上他们就是蜘蛛。不过对你而言，这次上去一脚是不够的，因为他们有%number%只。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsSerpents"))
				{
					this.Flags.set("Number", this.Math.max(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Serpent, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场与%amount%条大蛇开始战斗";
					this.Text += "%SPEECH_ON%哈？你说你没看明白，这只是一个波浪线？不，看仔细咯，这是尾巴，那是头，这是一条蛇。你将对抗%number%条蛇。炼金术士们喜欢称之为'大蛇'，但如果我想画一条大蛇，我只要画出一个炼金师就行，哈哈哈！%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsHyenas"))
				{
					this.Flags.set("Number", this.Math.max(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Hyena, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，与%amount%只鬣狗战斗。";
					this.Text += "%SPEECH_ON%鬣狗。嘿嘿嘿。鬣狗。不上不下 %numberC%只傻笑的狗，好运，追随吉尔德之眼。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsFrenziedHyenas"))
				{
					this.Flags.set("Number", this.Math.max(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.HyenaHIGH, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场开始对抗 %amount% 只狂暴的鬣狗";
					this.Text += "%SPEECH_ON%鬣狗。嘿嘿嘿。鬣狗。不上不下 %numberC%只傻笑的狗，好运，追随吉尔德之眼。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsLindwurm"))
				{
					this.Flags.set("Number", this.Math.min(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Lindwurm, baseDifficulty - 30)));

					if (this.Flags.get("Number") == 1)
					{
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗一头林德虫。";
					}
					else
					{
						this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗两只琳德虫。";
					}

					this.Text += "%SPEECH_ON%你的对手是一只……一只……这是什么？一条蠕虫？它是绿色的。从未见过这么彩的蠕虫——哦！一条巨龙！不对，“wurm”。wurm? 一条林德巴姆！老实说，我不知道这是什么，但我想我们亲爱的媒人不会让你打一只普通的蠕虫。或许他们会让你为了我们的娱乐而吃掉它。或许他们不是媒人，而是品鉴家！Herghgheeagghheeehoogh. 哈。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsMercenaries"))
				{
					this.Flags.set("Number", this.Math.max(2, this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, baseDifficulty)));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗 %amount% 名雇佣兵。";
					this.Text += "%SPEECH_ON%像你这样的逐币者从北方冒险而来。在那里，他们被称为“雇佣兵”。嗬！这算是怎样的诗歌？他们不知道并非每个男人都使用剑吗？他们那里的人可不太聪明。这就是为什么我喜欢南方。阳光明媚，人们也因此而聪明。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsGladiatorChampion"))
				{
					this.Flags.set("Champion1", this.Const.World.Common.generateName(this.Const.World.Spawn.Troops.Gladiator.NameList) + (this.Const.World.Spawn.Troops.Gladiator.TitleList != null ? " " + this.Const.World.Spawn.Troops.Gladiator.TitleList[this.Math.rand(0, this.Const.World.Spawn.Troops.Gladiator.TitleList.len() - 1)] : ""));
					this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, baseDifficulty - this.Const.World.Spawn.Troops.Gladiator.Cost * 2, 2));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，与冠军 %champion1% 和 %amount% 名角斗士开始战斗。";
					this.Text += "%SPEECH_ON%认识这张脸吗？艺术家们在这本小册子上花费了时间，并将其分发给楼上的所有人。这是队长1号(%champion1%)，是这片土地上最伟大的斗士之一。也许有一天，如果大臣能找到一个如此有才华的人来挽救你那被毁掉的脑子，他们也会让你的脸看起来那么漂亮，hegheghegh。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsSwordmasterChampion"))
				{
					this.Flags.set("Champion1", this.Const.World.Common.generateName(this.Const.World.Spawn.Troops.Swordmaster.NameList) + (this.Const.World.Spawn.Troops.Swordmaster.TitleList != null ? " " + this.Const.World.Spawn.Troops.Swordmaster.TitleList[this.Math.rand(0, this.Const.World.Spawn.Troops.Swordmaster.TitleList.len() - 1)] : ""));
					this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Mercenary, baseDifficulty - this.Const.World.Spawn.Troops.Gladiator.Cost * 2, 2));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，与%champion1%和%amount%名雇佣兵战斗。";
					this.Text += "%SPEECH_ON%认识这张脸吗？艺术家们在这本小册子上花费了时间，并将其分发给楼上的所有人。这是队长1号(%champion1%)，是这片土地上最伟大的斗士之一。也许有一天，如果大臣能找到一个如此有才华的人来挽救你那被毁掉的脑子，他们也会让你的脸看起来那么漂亮，hegheghegh。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsExecutionerChampion"))
				{
					this.Flags.set("Champion1", this.Const.World.Common.generateName(this.Const.World.Spawn.Troops.Executioner.NameList) + (this.Const.World.Spawn.Troops.Executioner.TitleList != null ? " " + this.Const.World.Spawn.Troops.Executioner.TitleList[this.Math.rand(0, this.Const.World.Spawn.Troops.Executioner.TitleList.len() - 1)] : ""));
					this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Gladiator, baseDifficulty - this.Const.World.Spawn.Troops.Gladiator.Cost * 2, 2));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，与冠军 %champion1% 和 %amount% 名角斗士开始战斗。";
					this.Text += "%SPEECH_ON%认识这张脸吗？艺术家们在这本小册子上花费了时间，并将其分发给楼上的所有人。这是队长1号(%champion1%)，是这片土地上最伟大的斗士之一。也许有一天，如果大臣能找到一个如此有才华的人来挽救你那被毁掉的脑子，他们也会让你的脸看起来那么漂亮，hegheghegh。%SPEECH_OFF%";
				}
				else if (this.Flags.get("IsDesertDevilChampion"))
				{
					this.Flags.set("Champion1", this.Const.World.Common.generateName(this.Const.World.Spawn.Troops.DesertDevil.NameList) + (this.Const.World.Spawn.Troops.DesertDevil.TitleList != null ? " " + this.Const.World.Spawn.Troops.DesertDevil.TitleList[this.Math.rand(0, this.Const.World.Spawn.Troops.DesertDevil.TitleList.len() - 1)] : ""));
					this.Flags.set("Number", this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.NomadOutlaw, baseDifficulty - this.Const.World.Spawn.Troops.Gladiator.Cost * 2, 2));
					this.Contract.m.BulletpointsObjectives[1] = "再次进入竞技场，开始对抗冠军 %champion1% 和 %amount% 名游牧民。";
					this.Text += "%SPEECH_ON%认识这张脸吗？艺术家们在这本小册子上花费了时间，并将其分发给楼上的所有人。这是队长1号(%champion1%)，是这片土地上最伟大的斗士之一。也许有一天，如果大臣能找到一个如此有才华的人来挽救你那被毁掉的脑子，他们也会让你的脸看起来那么漂亮，hegheghegh。%SPEECH_OFF%";
				}

				if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
				{
					this.Text += "他停了一下。%SPEECH_ON%我们会迎来重要的客人，所以一切已经准备就绪，这一次你可以死得更加惨烈，明白吗？如果你不能做到，那么让你的人在比赛中用最壮观的方式击败他们的对手来取悦观众吧。做到这一点，我会在金币之外再奖励你一件真正的角斗士装备。%SPEECH_OFF%";
				}

				this.Text += "他指着几个看起来奇怪的项圈并继续说道。%SPEECH_ON%准备好了以后，给那三个参赛的人带上这些项圈。这样我们就知道谁要进入角斗场。不戴这些项圈的任何人都不会被允许进入，不管是你，还是维齐尔，甚至我敢说甚至吉尔德也可能会被拒绝。%SPEECH_OFF%";
			}

		});
		this.m.Screens.push({
			ID = "Overview",
			Title = "Overview",
			Text = "这场竞技场战斗的工作原理如下。 你同意这些条款吗？",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我接受。",
					function getResult()
					{
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/special/arena_collar_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/special/arena_collar_item"));
						this.World.Assets.getStash().add(this.new("scripts/items/accessory/special/arena_collar_item"));
						this.Contract.setState("Running");
						return 0;
					}

				},
				{
					Text = "我得考虑一下。",
					function getResult()
					{
						return 0;
					}

				}
			],
			ShowObjectives = true,
			ShowPayment = true,
			function start()
			{
				this.Contract.m.IsNegotiated = true;
			}

		});
		this.m.Screens.push({
			ID = "Start",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_155.png[/img]{等待轮到你的时候，人群的嗜血之情在黑暗中传播，灰尘从头顶落下，脚步声如雷鸣。他们期待着，杀戮声中狂欢。战斗之间的静谧只有短暂的片刻，这份寂静随着生锈的大门上升而消失，铁链摩擦发出响声，人群再次嗡嗡作响。你走出光线，如此雷鸣般的声音撞击着你的心脏，即使是一具僵尸也会动荡不安。 | 竞技场的观众肩并肩，大部分都喝醉了。他们尖叫着吼叫着，语言上既有本地的，也有外来的，但他们的血腥欲望不需要过多的口胡，只要看着他们狂热的脸庞和挥舞的拳头。现在，%companyname%的士兵们将满足这些疯狂的笨蛋。 | 清洁工人在竞技场中匆忙前行。他们拖走尸体，收集值得收集的东西，偶尔会把奖杯扔到人群中，引发一个模仿竞技场战斗的暴民骚动。%companyname%现在也是这场盛宴的一部分。 | 竞技场在等待，人群熊熊燃烧，%companyname%的胜利之际已经到来！ | 当%companyname%的士兵走进这个充满鲜血的坑时，人群轰鸣。尽管人民的快感来自于无意识的嗜血之情，但你无法控制自己内心的一丝自豪感，因为你知道这是你的战团准备上演一场盛大的表演。 | 大门升起，除了锁链的响声、滑轮的吱嘎声和奴隶劳作的呻吟外，什么声音也听不见。当%companyname%的人们走出竞技场的深处时，他们能听到脚底下沙子的声响，直到他们站在沙坑中央。一个陌生的声音从体育场的顶部尖叫着，是一种你无法理解的语言，但这些话语在人群中回响了一次，然后观众们就爆发出欢呼和咆哮声。现在，你的人将在平民的警觉眼神下证明自己。 | %companyname%的事务很少在那些希望与这样的暴力事件保持距离的人眼前完成。但在角斗场，平民们渴望死亡和痛苦，当你的人进入沙坑时，他们发出咆哮声，并准备好战斗时，则发出动物般的怒吼。 | 角斗场的形状像一个伤口的坑，其天花板被神撕裂开来，揭示了人类的虚荣、嗜血和野蛮。在那里，人们尖叫着，如果鲜血四溅到他们身上，他们会用那污物洗脸并互相冲着笑，好像那是一场玩笑。他们为了奖杯而互相搏斗，并为他人的疼痛而狂欢。%companyname%将在这些人的面前战斗，他们将为他们提供娱乐，并提供精彩的表演。 | 竞技场的观众群是阶级的混合物，有富人和穷人，只有高级官员才会把自己分离成站台。在%townname%的人民暂时团结起来，慷慨地聚在一起观看男人和怪物相互屠杀。%companyname%很高兴能够尽自己的一份力。 | 小男孩坐在父亲的肩膀上，年轻的女孩向角斗士扔花，妇女扇着自己，男人们在想着是否也能够这样做。这就是竞技场的人民——其他人都喝醉了大醉，乱喊乱叫的。希望%companyname%能够为这个疯狂的群体贡献至少一两个小时的娱乐。 | 当%companyname%的人走上沙坑时，观众群发出震耳欲聋的欢呼声。一个傻瓜会把兴奋和渴望混淆在一起，因为一旦掌声结束，就会有一些空啤酒杯和臭烂的番茄，还有那些观看这件事情的人的大笑。你在想%companyname%的人是否真的最好在这里度过，但随后认真考虑了一下可以获得的金钱和荣耀，而且在这一天结束时，看台上的那些杂碎们会回家过他们一样的狗日子，而你也会回家过你的狗日子，但至少你的口袋会更加充实。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "让我们给观众们呐喊的理由！",
					function getResult()
					{
						local p = this.Const.Tactical.CombatInfo.getClone();
						p.LocationTemplate = clone this.Const.Tactical.LocationTemplate;
						p.CombatID = "Arena";
						p.TerrainTemplate = "tactical.arena";
						p.LocationTemplate.Template[0] = "tactical.arena_floor";
						p.Music = this.Const.Music.ArenaTracks;
						p.Ambience[0] = this.Const.SoundAmbience.ArenaBack;
						p.Ambience[1] = this.Const.SoundAmbience.ArenaFront;
						p.AmbienceMinDelay[0] = 0;
						p.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Arena;
						p.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Arena;
						p.IsUsingSetPlayers = true;
						p.IsFleeingProhibited = true;
						p.IsLootingProhibited = true;
						p.IsWithoutAmbience = true;
						p.IsFogOfWarVisible = false;
						p.IsArenaMode = true;
						p.IsAutoAssigningBases = false;
						local bros = this.Contract.getBros();

						for( local i = 0; i < bros.len() && i < 3; i = ++i )
						{
							p.Players.push(bros[i]);
						}

						p.Entities = [];
						local baseDifficulty = 30;

						if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
						{
							baseDifficulty = baseDifficulty + 10;
						}

						baseDifficulty = baseDifficulty * this.Contract.getScaledDifficultyMult();

						if (this.Flags.get("IsSwordmaster"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Swordmaster);

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.BanditRaider);
							}
						}
						else if (this.Flags.get("IsHedgeKnight"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.HedgeKnight);

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.BanditRaider);
							}
						}
						else if (this.Flags.get("IsDesertDevil"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.DesertDevil);

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.NomadOutlaw);
							}
						}
						else if (this.Flags.get("IsSandGolems"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.SandGolem);
							}
						}
						else if (this.Flags.get("IsGhouls"))
						{
							if (baseDifficulty >= this.Const.World.Spawn.Troops.GhoulHIGH.Cost * 2)
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.GhoulHIGH);

								for( local i = 0; i < this.Flags.get("Number") - 1; i = ++i )
								{
									this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Ghoul);
								}
							}
							else
							{
								for( local i = 0; i < this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.GhoulLOW, baseDifficulty * 0.5); i = ++i )
								{
									this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.GhoulLOW);
								}

								for( local i = 0; i < this.Contract.getAmountToSpawn(this.Const.World.Spawn.Troops.Ghoul, baseDifficulty * 0.5); i = ++i )
								{
									this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Ghoul);
								}
							}
						}
						else if (this.Flags.get("IsUnholds"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Unhold);
							}
						}
						else if (this.Flags.get("IsDesertRaiders"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.NomadOutlaw);
							}
						}
						else if (this.Flags.get("IsGladiators"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Gladiator);
							}
						}
						else if (this.Flags.get("IsSpiders"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Spider);
							}
						}
						else if (this.Flags.get("IsSerpents"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Serpent);
							}
						}
						else if (this.Flags.get("IsHyenas"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Hyena);
							}
						}
						else if (this.Flags.get("IsFrenziedHyenas"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.HyenaHIGH);
							}
						}
						else if (this.Flags.get("IsLindwurm"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Lindwurm);
							}
						}
						else if (this.Flags.get("IsMercenaries"))
						{
							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Mercenary);
							}
						}
						else if (this.Flags.get("IsGladiatorChampion"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Gladiator, true, this.Flags.get("Champion1"));

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Gladiator);
							}
						}
						else if (this.Flags.get("IsSwordmasterChampion"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Swordmaster, true, this.Flags.get("Champion1"));

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Mercenary);
							}
						}
						else if (this.Flags.get("IsExecutionerChampion"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Executioner, true, this.Flags.get("Champion1"));

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.Gladiator);
							}
						}
						else if (this.Flags.get("IsDesertDevilChampion"))
						{
							this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.DesertDevil, true, this.Flags.get("Champion1"));

							for( local i = 0; i < this.Flags.get("Number"); i = ++i )
							{
								this.Contract.addToCombat(p.Entities, this.Const.World.Spawn.Troops.NomadOutlaw);
							}
						}

						for( local i = 0; i < p.Entities.len(); i = ++i )
						{
							p.Entities[i].Faction <- this.Contract.getFaction();
						}

						this.World.Contracts.startScriptedCombat(p, false, false, false);
						return 0;
					}

				},
				{
					Text = "我们不会接受的，我不想死！",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.State.getTownScreen().getMainDialogModule().reload();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnArenaCancel);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Success",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img]{竞技场主说话时好像连你的面孔都不记得，不过他可能确实不记得了。%SPEECH_ON%给你拿工钱来了，请下次再来。%SPEECH_OFF%今天的比赛结束了，不过你明天就可以再来。 | 竞技场主连头都没抬从一张纸草纸里取出一袋硬币给了你。%SPEECH_ON%听到观众的喝彩声，这是你应得的克朗，希望你能够再来角斗场。%SPEECH_OFF%今天的比赛已经结束，不过你明天就可以再来。 | 竞技场主正等着你呢。%SPEECH_ON%那可真是场不错的表演，队长。如果你下次再来我也毫不介意。%SPEECH_OFF%今天的比赛已经结束，不过你明天就可以再来。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "{胜利！ | 你们看的爽到了吗？！ | 杀了他！ | 一幅血腥的画面。}",
					function getResult()
					{
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
						this.World.Assets.addMoney(this.Contract.m.Payment.getOnCompletion());

						if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
						{
							return "Gladiators";
						}
						else
						{
							this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
							this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);
							this.World.Statistics.getFlags().increment("ArenaRegularFightsWon", 1);
							this.World.Contracts.finishActiveContract();

							if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
							{
								this.updateAchievement("Gladiator", 1, 1);
							}

							return 0;
						}
					}

				}
			],
			function start()
			{
				local roster = this.World.getPlayerRoster().getAll();
				local n = 0;

				foreach( bro in roster )
				{
					local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

					if (item != null && item.getID() == "accessory.arena_collar")
					{
						local skill;
						bro.getFlags().increment("ArenaFightsWon", 1);
						bro.getFlags().increment("ArenaFights", 1);

						if (bro.getFlags().getAsInt("ArenaFightsWon") == 1)
						{
							skill = this.new("scripts/skills/traits/arena_pit_fighter_trait");
							bro.getSkills().add(skill);
							this.List.push({
								id = 10,
								icon = skill.getIcon(),
								text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
							});
						}
						else if (bro.getFlags().getAsInt("ArenaFightsWon") == 5)
						{
							bro.getSkills().removeByID("trait.pit_fighter");
							skill = this.new("scripts/skills/traits/arena_fighter_trait");
							bro.getSkills().add(skill);
							this.List.push({
								id = 10,
								icon = skill.getIcon(),
								text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
							});
						}
						else if (bro.getFlags().getAsInt("ArenaFightsWon") == 12)
						{
							bro.getSkills().removeByID("trait.arena_fighter");
							skill = this.new("scripts/skills/traits/arena_veteran_trait");
							bro.getSkills().add(skill);
							this.List.push({
								id = 10,
								icon = skill.getIcon(),
								text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
							});
						}

						n = ++n;
					}

					if (n >= 3)
					{
						break;
					}
				}

				if (this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") > 0 && this.World.Statistics.getFlags().getAsInt("ArenaRegularFightsWon") % 5 == 0)
				{
					local r;
					local a;
					local u;

					if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 5)
					{
						r = 1;
					}
					else if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 10)
					{
						r = 3;
					}
					else if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") == 15)
					{
						r = 2;
					}
					else
					{
						r = this.Math.rand(1, 3);
					}

					switch(r)
					{
					case 1:
						a = this.new("scripts/items/armor/oriental/gladiator_harness");
						u = this.new("scripts/items/armor_upgrades/light_gladiator_upgrade");
						a.setUpgrade(u);
						this.List.push({
							id = 12,
							icon = "ui/items/armor_upgrades/upgrade_24.png",
							text = "你获得了一个 " + a.getName()
						});
						break;

					case 2:
						a = this.new("scripts/items/armor/oriental/gladiator_harness");
						u = this.new("scripts/items/armor_upgrades/heavy_gladiator_upgrade");
						a.setUpgrade(u);
						this.List.push({
							id = 12,
							icon = "ui/items/armor_upgrades/upgrade_25.png",
							text = "你获得了一个 " + a.getName()
						});
						break;

					case 3:
						a = this.new("scripts/items/helmets/oriental/gladiator_helmet");
						this.List.push({
							id = 12,
							icon = "ui/items/" + a.getIcon(),
							text = "你获得了一个 " + a.getName()
						});
						break;
					}

					this.World.Assets.getStash().makeEmptySlots(1);
					this.World.Assets.getStash().add(a);
				}
			}

		});
		this.m.Screens.push({
			ID = "Failure1",
			Title = "在竞技场",
			Text = "[img]gfx/ui/events/event_147.png[/img]{ %companyname% 的士兵被打败了，他们要么是痛快的死去, 或者更惨的是受到重伤而伤痕累累。但至少观众们很高兴。在竞技场下面，任何的表现，即使以死亡告终，都是好的表现。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "灾难！",
					function getResult()
					{
						local roster = this.World.getPlayerRoster().getAll();
						local n = 0;

						foreach( bro in roster )
						{
							local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

							if (item != null && item.getID() == "accessory.arena_collar")
							{
								bro.getFlags().increment("ArenaFights", 1);
								n = ++n;
							}

							if (n >= 3)
							{
								break;
							}
						}

						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Failure2",
			Title = "在竞技场",
			Text = "{[img]gfx/ui/events/event_155.png[/img]你的角斗比赛的时间已经到了，但你没有出现在那里。也许出现了更重要的事情，或者你只是像懦夫一样躲起来了。无论哪种情况，你的声誉都会因此受损。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "But...",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractFail);
						this.World.Contracts.finishActiveContract(true);
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Collars",
			Title = "在竞技场",
			Text = "{[img]gfx/ui/events/event_155.png[/img] 竞技场比赛的时间到了，但是你的士兵们没有佩戴竞技场项圈，所以他们被禁止进入。\n\n你应该决定谁去参加比赛，通过给他们佩戴竞技场项圈，一旦你再次进入竞技场比赛就会开始。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "好, 就这样！",
					function getResult()
					{
						return 0;
					}

				}
			]
		});
		this.m.Screens.push({
			ID = "Gladiators",
			Title = "在竞技场",
			Text = "{[img]gfx/ui/events/event_85.png[/img]战斗结束，你发现有几个女子在你和角斗士周围晃荡。她们几乎就要晕倒，脸上泛红，有男子特别关心她们。你自己也有点累了，让一名粉丝帮你清点库存。 | [img]gfx/ui/events/event_147.png[/img]战斗结束，但是忽然一道阴影出现在地面上。你一晃就拔出剑来，向天空挥去。鲜花瓣飘洒在你闪闪发光的身体上，你用牙齿接住剩下的花束。一名女子站在那里扇着扇子。%SPEECH_ON%我本来就在想你为什么不战斗。%SPEECH_OFF%她说。你将剑插回剑鞘，将花束系在腰带上。你告诉她，如果你战斗的话，根本不能叫做“战斗”。那名粉丝膝盖软了，找到地面上的安慰。在离开之前，你告诉她多喝水，确保早上拉伸身体。 | [img]gfx/ui/events/event_97.png[/img]%SPEECH_START%我能像你们男人一样学习战斗吗？%SPEECH_OFF%这声音吓了你一跳，你不知不觉地将剑架在了一个小男孩的脸前一寸。他闭上了眼睛，慢慢地睁开了一个。你将剑插回剑鞘，并笑了起来。%SPEECH_ON%不，我是什么样的人是无法学到的。%SPEECH_OFF%你用一点野战场上的灰烬和血液签署在男孩的衬衫上，然后离开了。 | [img]gfx/ui/events/event_97.png[/img]%SPEECH_START%你们是角斗士吗？%SPEECH_OFF%你看到一个男孩惊奇地站在那里。他几乎哭了，因为他太兴奋了。%SPEECH_ON%你真了不起！%SPEECH_OFF%你揉了揉男孩的头发，感谢他，然后离开了。 | [img]gfx/ui/events/event_97.png[/img]%SPEECH_START%你怎么这么厉害？%SPEECH_OFF%你转过身来看到一个男孩紧张地盯着你。微笑着，你给他一个真相。%SPEECH_ON%我和你一样大的时候，我就在杀同龄人了。%SPEECH_OFF%你回头冲他笑了笑，他问你如果他努力，他能成为像你一样的人吗？你点点头回答。%SPEECH_ON%你不试试怎么知道呢，孩子。现在回家吧。%SPEECH_OFF%男孩挥舞着一把黄油刀，狂奔着跑开了。他是个好孩子。}",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "{妙极了，我们太棒了。 | 我们是最好的。}",
					function getResult()
					{
						this.Contract.getHome().getBuilding("building.arena").refreshCooldown();
						this.World.Statistics.getFlags().increment("ArenaFightsWon", 1);
						this.World.Statistics.getFlags().increment("ArenaRegularFightsWon", 1);
						this.World.Contracts.finishActiveContract();

						if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= 10)
						{
							this.updateAchievement("Gladiator", 1, 1);
						}

						return 0;
					}

				}
			]
		});
	}

	function getBros()
	{
		local ret = [];
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.arena_collar")
			{
				ret.push(bro);
			}
		}

		return ret;
	}

	function getAmountToSpawn( _type, _resources, _min = 1, _max = 24 )
	{
		return this.Math.min(_max, this.Math.max(_min, _resources / _type.Cost));
	}

	function addToCombat( _list, _entityType, _champion = false, _name = "" )
	{
		local c = clone _entityType;

		if (c.Variant != 0 && _champion)
		{
			c.Variant = 1;
			c.Name <- _name;
		}
		else
		{
			c.Variant = 0;
		}

		_list.push(c);
	}

	function getScaledDifficultyMult()
	{
		local p = this.World.State.getPlayer().getStrength();
		p = p / this.World.getPlayerRoster().getSize();
		p = p * 12;
		local s = this.Math.maxf(0.75, 1.0 * this.Math.pow(0.01 * p, 0.95) + this.Math.minf(0.5, (this.World.getTime().Days + this.World.Statistics.getFlags().getAsInt("ArenaFightsWon")) * 0.01));
		local d = this.Math.minf(5.0, s);
		return d * this.Const.Difficulty.EnemyMult[this.World.Assets.getCombatDifficulty()];
	}

	function getReputationToPaymentMult()
	{
		local r = this.Math.minf(4.0, this.Math.maxf(0.9, this.Math.pow(this.Math.maxf(0, 0.003 * this.World.Assets.getBusinessReputation() * 0.5 + this.getScaledDifficultyMult()), 0.35)));
		return r * this.Const.Difficulty.PaymentMult[this.World.Assets.getEconomicDifficulty()];
	}

	function setScreenForArena()
	{
		if (!this.m.IsActive)
		{
			return;
		}

		if (this.getBros().len() == 0)
		{
			this.setScreen("Collars");
		}
		else if (this.World.getTime().Days > this.m.Flags.get("Day"))
		{
			this.setScreen("Failure2");
		}
		else
		{
			this.setScreen("Start");
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"numberC",
			this.m.Flags.get("Number") < this.Const.Strings.AmountC.len() ? this.Const.Strings.AmountC[this.m.Flags.get("Number")] : this.Const.Strings.AmountC[this.m.Flags.get("Number")]
		]);
		_vars.push([
			"number",
			this.m.Flags.get("Number") < this.Const.Strings.Amount.len() ? this.Const.Strings.Amount[this.m.Flags.get("Number")] : this.Const.Strings.Amount[this.m.Flags.get("Number")]
		]);
		_vars.push([
			"amount",
			this.m.Flags.get("Number")
		]);
		_vars.push([
			"champion1",
			this.m.Flags.get("Champion1")
		]);
	}

	function onClear()
	{
		if (this.m.IsActive)
		{
			this.m.Home.getSprite("selection").Visible = false;
			this.m.Home.getBuilding("building.arena").refreshCooldown();
			local roster = this.World.getPlayerRoster().getAll();

			foreach( bro in roster )
			{
				local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

				if (item != null && item.getID() == "accessory.arena_collar")
				{
					bro.getItems().unequip(item);
				}
			}

			local items = this.World.Assets.getStash().getItems();

			foreach( i, item in items )
			{
				if (item != null && item.getID() == "accessory.arena_collar")
				{
					items[i] = null;
				}
			}
		}
	}

	function isValid()
	{
		return this.Const.DLC.Desert;
	}

	function onSerialize( _out )
	{
		this.contract.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.contract.onDeserialize(_in);
	}

});

