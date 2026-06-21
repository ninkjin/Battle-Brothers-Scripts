this.brawler_throw_fight_event <- this.inherit("scripts/events/event", {
	m = {
		Brawler = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.brawler_throw_fight";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_51.png[/img]{没有提前通知你，斗士%brawler%自作主张地参加了一场武斗比赛，并已经进入了决赛。他在第一轮比赛中轻易地击败了所有对手，成为夺冠的热门人选。 \n\n然而，一些非常强大的博彩经纪人对%brawler%已经让他们损失了大量的资金感到不满。知道他与你在一起，他们请求你告诉%brawler%放弃比赛并故意输掉比赛。作为回报，你将获得他们的获胜份额，这无疑会相当可观...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你需要接受失败。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "他不会认输。",
					function getResult( _event )
					{
						local outcome = this.Math.rand(1, 100);

						if (outcome <= 39 + _event.m.Brawler.getLevel())
						{
							return "D";
						}
						else if (outcome <= 80)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				},
				{
					Text = "什么？根本就不会有战斗！",
					function getResult( _event )
					{
						return "G";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你让 %brawler% 故意输掉比赛。不出所料，他对此不满，但你提醒他，你是战团的队长，虽然上场打架的是他。但现在因为第三方与你做生意，所以这场比赛也就成了战团的事情。他叹了口气并点了点头。\n\n打斗后，正如指示的那样，%brawler% 故意吃了几个拳头，然后“假装”被击倒，避开了一招弱弱的拳击。观众欢呼，弱者欢呼，在擂台上跑来跑去，举手欢呼。比赛结束后，赌博经纪人过来为刚刚”交易“支付了 %reward% 克朗。其中一位经纪人瞥向 %brawler%。%SPEECH_ON%该死，伙计，如果刚刚被人识穿了得引发骚乱。你真应该去学学怎样演戏，刚刚 KO 你的那拳还不如媳妇打屁股。下次等到有力的勾拳才演，好吗？%SPEECH_OFF% 格斗家笑了笑，但他的笑容很勉强。他为了一些克朗而丢尽了自尊。在 %townname% 某个地方，你能听到人们欢呼着另一位格斗家的名字。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他会克服的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				this.World.Assets.addMoney(400);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]400[/color] 克朗"
				});
				_event.m.Brawler.worsenMood(0.5, "被告知放水。");
				_event.m.Brawler.worsenMood(2.0, "输掉了一场战斗比赛。");

				if (_event.m.Brawler.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Brawler.getMoodState()],
						text = _event.m.Brawler.getName() + this.Const.MoodStateEvent[_event.m.Brawler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你让%brawler%倒下。他预料到了这个结果，但你提醒他你是战团的队长，而他的打斗是你的事情，事实上一个第三方进入你的业务，也成为了他的业务。他叹了口气点点头。\n\n当打斗开始时，%brawler%按照指示倒下，只要被一拳击中。他从擂台地上盯着你，眼中燃烧着火焰。你告诉他别再起来，但他却站起来，很快用一连串的勾拳和上勾拳将另一位斗士击败。他赢得了比赛，被人群抬出了竞技场。你急忙跟着他们去看他去哪里，却在小巷里找到他被打得面目全非。他冲你露出了一个微笑。%SPEECH_ON%那些博彩经纪人不高兴了，但去他们的。他们本应该在我的荣誉上下注。%SPEECH_OFF% 他失去了知觉。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我已经厌倦了赌博，我自己也是。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				_event.m.Brawler.addHeavyInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Brawler.getName() + "遭受重伤"
				});
				_event.m.Brawler.worsenMood(0.5, "被告知放水。");
				_event.m.Brawler.improveMood(2.0, "轻松赢得搏斗锦标赛。");

				if (_event.m.Brawler.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Brawler.getMoodState()],
						text = _event.m.Brawler.getName() + this.Const.MoodStateEvent[_event.m.Brawler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你告诉赌博经纪人%brawler%会打他想打的方式。经纪人不想惹麻烦，没有进一步争论这个问题。他们在你还没有带着自己的人下注之前就离开了。现在知道有一场比赛，你去看%brawler%彻底击倒了%townname%最好的斗殴者。这场大打击败的比赛如此明显将会发生以至于每个人都押在%brawler%身上，赌博经纪人不堪重负。冲突爆发，一些赌徒和经纪人开始互相殴打。虽然这场比赛没有赚到钱，但%brawler%很高兴能成为%townname%的冠军。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				local resolve_boost = this.Math.rand(2, 4);
				local initiative_boost = this.Math.rand(2, 4);
				local melee_skill_boost = this.Math.rand(1, 3);
				local melee_defense_boost = this.Math.rand(1, 3);
				_event.m.Brawler.getBaseProperties().Bravery += resolve_boost;
				_event.m.Brawler.getBaseProperties().Initiative += initiative_boost;
				_event.m.Brawler.getBaseProperties().MeleeSkill += melee_skill_boost;
				_event.m.Brawler.getBaseProperties().MeleeDefense += melee_defense_boost;
				_event.m.Brawler.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Brawler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] 决心"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Brawler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative_boost + "[/color] 主动性"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Brawler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + melee_skill_boost + "[/color] 近战技能"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_defense.png",
					text = _event.m.Brawler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + melee_defense_boost + "[/color] 近战防御"
				});
				_event.m.Brawler.improveMood(0.5, "被允许以自己的方式战斗。");
				_event.m.Brawler.improveMood(2.0, "轻松赢得搏斗锦标赛。");

				if (_event.m.Brawler.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Brawler.getMoodState()],
						text = _event.m.Brawler.getName() + this.Const.MoodStateEvent[_event.m.Brawler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你告诉赌博经纪人，%brawler% 会随心所欲地打战斗。他们不想和雇佣军队长纠缠在一起，只是点了点头，退了回去。正如预料的那样，%brawler% 赢得了这场战斗，而且结果很明显。他成了%townname%的话题，你让他去和农民们一起庆祝。几个小时过去了，你意识到你有一段时间没有见到他了。你走进城里去找他，发现他躺在一个小巷里，膝盖被砸碎了，主手已经被锤成了肉泥，眼睛肿成了一条缝。你向他喊话并跑过去。他抬起头来。%SPEECH_ON%队长？Ayy队长，很高兴听到你的声音。不用担心我，这是值得的。%SPEECH_OFF%他晕了过去。你把他带回了战团考虑追杀经纪人，但是你知道他们不会这么做，除非他们事先准备好了后路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Damn.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				local injury = _event.m.Brawler.addInjury(this.Const.Injury.Concussion);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Brawler.getName() + " 遭受 " + injury.getNameOnly()
				});
				injury = _event.m.Brawler.addInjury([
					{
						ID = "injury.broken_knee",
						Threshold = 0.0,
						Script = "injury_permanent/broken_knee_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Brawler.getName() + " 遭受 " + injury.getNameOnly()
				});
				local initiative_boost = this.Math.rand(2, 4);
				local melee_skill_boost = this.Math.rand(1, 3);
				_event.m.Brawler.getBaseProperties().Initiative += initiative_boost;
				_event.m.Brawler.getBaseProperties().MeleeSkill += melee_skill_boost;
				_event.m.Brawler.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Brawler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative_boost + "[/color] 主动性"
				});
				this.List.push({
					id = 16,
					icon = "ui/icons/melee_skill.png",
					text = _event.m.Brawler.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + melee_skill_boost + "[/color] 近战技能"
				});
				_event.m.Brawler.improveMood(0.5, "被允许以自己的方式战斗。");
				_event.m.Brawler.improveMood(2.0, "轻松赢得搏斗锦标赛。");

				if (_event.m.Brawler.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Brawler.getMoodState()],
						text = _event.m.Brawler.getName() + this.Const.MoodStateEvent[_event.m.Brawler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你告诉赌博经纪人，%brawler%会按他的意愿打架。经纪人们不想与雇佣兵为敌，不再争论这个问题。他们离开了，甚至没有让你下注。然而，你现在知道了有一个比赛，于是你去观看比赛。%brawler%这个家伙没有任何关心他对手的技巧，开始随意左右扔钩拳。没有一个左勾拳可以让他的对手防备，他的对手紧张起来，然后尖叫着扔了一个绝望的勾拳。%brawler%的头转向旁边，他失去了意识倒在地上。群众欢呼雀跃，至少那些没有输了一堆克朗的人欢呼。一名赌徒数他的钱时走到你面前，面带微笑地说到。%SPEECH_ON%最好还是去接你的家伙吧。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那本来可以更好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				local injury = _event.m.Brawler.addInjury(this.Const.Injury.Concussion);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Brawler.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Brawler.improveMood(0.5, "被允许以自己的方式战斗。");
				_event.m.Brawler.worsenMood(2.0, "在搏斗锦标赛中遭到重创。");

				if (_event.m.Brawler.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Brawler.getMoodState()],
						text = _event.m.Brawler.getName() + this.Const.MoodStateEvent[_event.m.Brawler.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_64.png[/img]{你突然宣布 %brawler% 不再参加比赛。两个派系都感到震惊。经纪人们轻松了口气并叹了口气。他们损失巨大，但至少现在有一些模糊的理由来止损。至于 %brawler%，他对你的决定非常失望。你跟他解释说 %companyname% 需要他们所有的战斗人员在最佳状态下完成实际任务。你不能冒着他在某个乡间冠军争夺战中受伤的风险。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "还会有很多机会让你战斗，%brawler%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Brawler.getImagePath());
				_event.m.Brawler.worsenMood(2.0, "被拒绝参加战斗比赛。");

				if (_event.m.Brawler.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Brawler.getMoodState()],
						text = _event.m.Brawler.getName() + this.Const.MoodStateEvent[_event.m.Brawler.getMoodState()]
					});
				}
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
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
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
		local brawler_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.brawler" && !bro.getSkills().hasSkill("injury.severe_concussion") && !bro.getSkills().hasSkill("injury.broken_knee"))
			{
				brawler_candidates.push(bro);
			}
		}

		if (brawler_candidates.len() == 0)
		{
			return;
		}

		this.m.Brawler = brawler_candidates[this.Math.rand(0, brawler_candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 3 * brawler_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"brawler",
			this.m.Brawler.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
		_vars.push([
			"reward",
			400
		]);
	}

	function onClear()
	{
		this.m.Brawler = null;
		this.m.Town = null;
	}

});

