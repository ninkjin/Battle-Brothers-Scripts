this.killer_vs_others_event <- this.inherit("scripts/events/event", {
	m = {
		Killer = null,
		OtherGuy1 = null,
		OtherGuy2 = null
	},
	function create()
	{
		this.m.ID = "event.killer_vs_others";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]当你正在研究如何重绘一幅精度很差的地图时，刀刃被拔出鞘的声音闯入了你的耳中。 你把面前的地图卷起来然后将它收入袖口然后着手去解决那场骚乱。\n\n%killerontherun% 被一个兄弟用膝盖压着，并且看起来 %otherguy1% 和 %otherguy2% 正准备砍下他的脑袋。 看到你的到来，这些人冷静了一些。 他们向你解释这件事情的起因是这个杀手准备杀掉他们其中的一员。 事实上，这个兄弟的脖子上有一道伤痕。 如果它再深点那么现在就会有其他东西伴随着他的话一起从嘴里出来。 这些人要求对 %killerontherun% 处以绞刑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "对他处以鞭刑。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "对他处以绞刑。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "这是你的家庭。 不要再胆敢做出同样的事！",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 3);

						if (r == 1)
						{
							return "D";
						}
						else if (r == 2)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy1.getImagePath());
				this.Characters.push(_event.m.Killer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_38.png[/img]你命令鞭打这个人。%killerontherun% 唾弃着你当那几个兄弟把他绑在树上的时候。 你说你如果再继续这样的话你会挨更多的鞭子。 他们扯下他的衬衫轮流用鞭子抽他你站在一旁，数数。 第一鞭抽下他背部被剥去了一条直线的皮肤。 那人往后一缩你听到捆绑他的绳子绷得紧紧的他的双手也紧握成拳头。 到第五下鞭打的时候他已经坚持不住了。 到第十下的时候他已经昏了过去。 鞭子在这之后又打了五次你叫着些人把他带下去好好照料。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我希望这能给你上一课。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy1.getImagePath());
				this.Characters.push(_event.m.Killer.getImagePath());
				_event.m.Killer.addLightInjury();
				_event.m.Killer.worsenMood(3.0, "被你命令鞭打了");
				this.List = [
					{
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Killer.getName() + "遭受轻伤"
					}
				];

				if (_event.m.Killer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Killer.getMoodState()],
						text = _event.m.Killer.getName() + this.Const.MoodStateEvent[_event.m.Killer.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_02.png[/img]你将这个人判处以绞刑。 战队里面有一半的人在欢呼而 %killerontherun% 听到你下的命令以后适时的发出了尖叫。 他们把那个人拖到树下。 绳子被扔到树枝上，缠了一圈又一圈，往下一拉收紧它。 一个人绑好绞索而其他人则欢呼、鼓掌、喝啤酒。 凳子放好了死刑犯被迫站在凳子上。 当 %killerontherun%的头被放进绞索里面以后，他说他有些话想对你们所有人说，但是 %otherguy1% 从他下面踢出凳子他要说的话就被打断了。\n\n这可不是一个好的死法。 这个经常出现在行刑者手上或者他的表演单上。 通常从平台上掉下来的人会摔断脖子，甚至直接被斩首。 这个人喘不过气来不停地踢腿。 你可以听见他的肺发出像坏掉的鼓风箱一样的声音，但是那些新鲜的空气很难通过他的喉咙。 几分钟过去了他还在挣扎。%otherguy2% 走到这个垂死的人身边，抓住他抽搐的一只脚不让他动，然后用另一只手刺向 %killerontherun% 的心脏。就这样。\n\n{令人惊讶的是，这兄弟俩同意把这个人从树上解下来埋了。 | 当战队的旅程重新开始时，这个人被留在那里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们继续前进。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy1.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Killer.getName() + "是死了"
				});
				_event.m.Killer.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Killer.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Killer);
				_event.m.OtherGuy1.improveMood(2.0, "满意于" + _event.m.Killer.getNameOnly() + "的绞刑");

				if (_event.m.OtherGuy1.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.OtherGuy1.getMoodState()],
						text = _event.m.OtherGuy1.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy1.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_64.png[/img]当你试图为一群互相争斗的人之间带来和平时，你试图保持中立的做法似乎激怒了某些人。 尤其是那个脖子上有伤口的男人，他怒火中烧骂骂咧咧还把东西踢翻了。 其他一些人则因为缺乏纪律而大声疾呼。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们继续前进。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy1.getImagePath());
				this.Characters.push(_event.m.Killer.getImagePath());
				_event.m.OtherGuy1.worsenMood(4.0, "对你指挥下缺乏的公正感到愤怒");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OtherGuy1.getMoodState()],
					text = _event.m.OtherGuy1.getName() + this.Const.MoodStateEvent[_event.m.OtherGuy1.getMoodState()]
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Killer.getID() || bro.getID() == _event.m.OtherGuy1.getID())
					{
						continue;
					}

					bro.worsenMood(1.0, "担心缺乏纪律");

					if (bro.getMoodState() < this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getNameOnly() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_64.png[/img]当 %killerontherun%的尸体被发现的时候，似乎冷静下来的要求已经失败了。 {好像有人在背后捅了他一刀。 | 有人用一根结实的细麻布把那人勒死。 | 他几乎被劈成了两半，可以看出出手的人有多愤怒。 | 他的头被发现搁在他的胸前，他的手摆成托举的样子，举着它。 | 必须强调“身体”这个词，因为他的头不见了。 | 有人在夜里割破了他的喉咙。 | 身上的瘀伤和手上的刀伤意味着一场搏斗，但不管怎样到底是谁把这个人的内脏掏出来的。} 你很容易猜出是谁干的，但似乎没有一个人对这个人的死那么难过任何调查都无法提供确凿的证据。 虽然可能真的像你想的那样的但你仍然命令被怀疑是凶手的兄弟帮忙埋葬死者。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "现在没什么可做的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy1.getImagePath());
				local dead = _event.m.Killer;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "被他的兄弟们谋杀了",
					Expendable = dead.getBackground().getID() == "background.slave"
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Killer.getName() + "是死了"
				});
				_event.m.Killer.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Killer.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Killer);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.OtherGuy1.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						continue;
					}

					bro.worsenMood(1.0, "担心缺乏纪律");

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
			ID = "F",
			Text = "好吧，虽然 %killerontherun% 没有死，但是他被你打的遍体鳞伤之后站在你的身前。 得让他知道对于他犯下的罪行审判最终还是降临在了他的头上。 他要求对那些有伤害嫌疑的兄弟进行惩罚因为他们违背了你的命令。 你考虑一下，然后问这个男人如果你继续这样的暴力循环将会发生什么。 满脸的瘀伤将他脸变得黑紫交错这让人很难看清他的脸，眼睛藏在皱巴巴的眼睑后面，最后他小心翼翼地点了点头。 你是对的，他说。 最好让这件事平息下来，以免失控。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们继续前进。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OtherGuy1.getImagePath());
				this.Characters.push(_event.m.Killer.getImagePath());
				local injury = _event.m.Killer.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 13,
					icon = injury.getIcon(),
					text = _event.m.Killer.getName() + " 遭受 " + injury.getNameOnly()
				});
				injury = _event.m.Killer.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 13,
					icon = injury.getIcon(),
					text = _event.m.Killer.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Killer.worsenMood(2.0, "被战队的人打了");

				if (_event.m.Killer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Killer.getMoodState()],
						text = _event.m.Killer.getName() + this.Const.MoodStateEvent[_event.m.Killer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Killer.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 50 && bro.getID() != _event.m.OtherGuy1.getID())
					{
						continue;
					}

					bro.worsenMood(1.0, "担心缺乏纪律");

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
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 10)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local killer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getHireTime() + this.World.getTime().SecondsPerDay * 60 >= this.World.getTime().Time && bro.getBackground().getID() == "background.killer_on_the_run" && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				killer_candidates.push(bro);
			}
		}

		if (killer_candidates.len() == 0)
		{
			return;
		}

		this.m.Killer = killer_candidates[this.Math.rand(0, killer_candidates.len() - 1)];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Killer.getID() && bro.getBackground().getID() != "background.slave")
			{
				other_candidates.push(bro);
			}
		}

		if (other_candidates.len() == 0)
		{
			return;
		}

		this.m.OtherGuy1 = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Killer.getID() && bro.getID() != this.m.OtherGuy1.getID())
			{
				other_candidates.push(bro);
			}
		}

		if (other_candidates.len() == 0)
		{
			return;
		}

		this.m.OtherGuy2 = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"killerontherun",
			this.m.Killer.getName()
		]);
		_vars.push([
			"otherguy1",
			this.m.OtherGuy1.getName()
		]);
		_vars.push([
			"otherguy2",
			this.m.OtherGuy2.getName()
		]);
	}

	function onClear()
	{
		this.m.Killer = null;
		this.m.OtherGuy1 = null;
		this.m.OtherGuy2 = null;
	}

});

