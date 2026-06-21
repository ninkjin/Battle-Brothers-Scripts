this.cultist_origin_sacrifice_event <- this.inherit("scripts/events/event", {
	m = {
		Sacrifice = null,
		Sacrifice1 = null,
		Sacrifice2 = null,
		LastTriggeredOnDay = 0
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_sacrifice";
		this.m.Title = "露营时…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_140.png[/img]{大多数人会认为这个梦是一场噩梦：黑暗包围着你，一片漆黑，你伸手就能摸到它。 那个声音说的是一种你以前从未听过的语言，但你至少能听懂。 在无尽的阴影中出现了两个面孔：%sac1% 和 %sac2%。那些人似乎离你很近，但当你伸出手去时，他们却退缩了，仿佛你的手指无限地伸入虚空。\n\n 一醒来，你就知道该做什么了。 但你在此时获得一种信任，达库尔的信任。 但是这种信任不是一般人能承受得起的：做出一个选择。 | 达库尔的出现是在一场营火中。 其余的人都消失在无尽的黑暗之中，取而代之的是一个奇怪的实体。 一个你看不见的实体，但它的存在只是一团混沌的阴影。 它要求一次献祭，不是通过对你说话，而是通过展示：%sac1% 和 %sac2%。第一个人的幻象不见了，然后另一个重复这个过程，直到两人都伸出手闭上眼睛。 这很清楚了，达库尔相信你的选择。 \n\n 当影子啪的一声消失时，营火变得很刺眼。%sac1% 和 %sac2% 正盯着你。%SPEECH_ON%准备好了么，先生？%SPEECH_OFF% | 你去了那个地方。 你知道你在睡觉，但你知道得很清楚，你还是去了那里，超越了你的思想，超越了你的身体，越过了大地，越过了河流，越过了干涸的大地，越过了即将崩塌的群山。 在那里你找到了达库尔。永恒的黑暗，迷人的暗影。\n\n %sac1% 和 %sac2% 已经在那里了，站在离你最近的地方，达库尔的身影在他们的影子后面快速地变换着。 一只黑色的雾手把一个人往前推了推，又把他拉了回来，然后又对另一个人重复了一遍。 你点头表示理解。献祭是必须的，你必须做出选择。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "%sac1% 将会获得去见达库尔的荣耀。",
					function getResult( _event )
					{
						_event.m.Sacrifice = _event.m.Sacrifice1;
						return "B";
					}

				},
				{
					Text = "%sac2% 将会获得去见达库尔的荣耀。",
					function getResult( _event )
					{
						_event.m.Sacrifice = _event.m.Sacrifice2;
						return "B";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sacrifice1.getImagePath());
				this.Characters.push(_event.m.Sacrifice2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_140.png[/img]{%sacrifice% 被捆绑并投入火中。 空气中弥漫着肉烧焦的味道，你周围的人眼里充满了泪水。 你看到一张扭曲的脸，在祭品的烟雾中，那是一副赞许的表情。 这些人受到了鼓舞。 | %sacrifice% 被切成了碎片直到只剩躯干和头部。 血已经流遍了整个地面，但他的眼睛里仍然有光，脸上还带着一丝狡黠的微笑。 你拿把斧头砍进他的喉咙，直到他死去。 他身体每一部分都被分开了，挂在一根杆子上，涂上油脂，点燃。 你和队员们在柴堆下跳舞，从夜晚来临持续到夜晚离去。 | 过程是这样的：%sacrifice% 被活着剥皮，用削尖的木棍刺穿祭品的四肢，举在高处，呈鹰状摊在火上，把祭品烤熟，直至死亡。 队员们静静地看着他的死亡，但是当他的一条腿烧断了，他的尸体倒在火焰中时，有人开始欢呼雀跃，有的在祈祷，有的在 %sacrifice% 的灰烬中打滚，有的在舔手指就像舔糖果一样。 真是一个美好的夜晚。 | 一根长棍从 %sacrifice% 的脖子后面穿过去。 他仰面朝天，被一个人扶着，其他人则用长矛刺穿他的身体，直到他的尸体像一个简陋帐篷的顶端。 圆锥形的尸体被草和泥土覆盖，直到建起一个尸观，%sacrifice% 的头和剩下的部分都用上了，如果你进入尸观，你发现他的腿悬挂在天花板上。 这个尸观应该预示着这帮家伙的未来，或者说是个标志，他们应该接受那个等着我们所有人的东西。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个对我们所有人的预示。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Sacrifice.getImagePath());
				local dead = _event.m.Sacrifice;
				local fallen = {
					Name = dead.getName(),
					Time = this.World.getTime().Days,
					TimeWithCompany = this.Math.max(1, dead.getDaysWithCompany()),
					Kills = dead.getLifetimeStats().Kills,
					Battles = dead.getLifetimeStats().Battles,
					KilledBy = "献祭给达库尔",
					Expendable = dead.getBackground().getID() == "background.slave"
				};
				this.World.Statistics.addFallen(fallen);
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Sacrifice.getName() + "是死了"
				});
				_event.m.Sacrifice.getItems().transferToStash(this.World.Assets.getStash());
				this.World.getPlayerRoster().remove(_event.m.Sacrifice);
				local brothers = this.World.getPlayerRoster().getAll();
				local hasProphet = false;

				foreach( bro in brothers )
				{
					if (bro.getSkills().hasSkill("trait.cultist_prophet"))
					{
						hasProphet = true;
						break;
					}
				}

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
					{
						bro.improveMood(2.0, "抚慰达库尔");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}

						if (this.Math.rand(1, 100) > 50)
						{
							continue;
						}

						local skills = bro.getSkills();
						local skill;

						if (skills.hasSkill("trait.cultist_prophet"))
						{
							continue;
						}
						else if (skills.hasSkill("trait.cultist_chosen"))
						{
							if (hasProphet)
							{
								continue;
							}

							hasProphet = true;
							this.updateAchievement("VoiceOfDavkul", 1, 1);
							skills.removeByID("trait.cultist_chosen");
							skill = this.new("scripts/skills/actives/voice_of_davkul_skill");
							skills.add(skill);
							skill = this.new("scripts/skills/traits/cultist_prophet_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_disciple"))
						{
							skills.removeByID("trait.cultist_disciple");
							skill = this.new("scripts/skills/traits/cultist_chosen_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_acolyte"))
						{
							skills.removeByID("trait.cultist_acolyte");
							skill = this.new("scripts/skills/traits/cultist_disciple_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_zealot"))
						{
							skills.removeByID("trait.cultist_zealot");
							skill = this.new("scripts/skills/traits/cultist_acolyte_trait");
							skills.add(skill);
						}
						else if (skills.hasSkill("trait.cultist_fanatic"))
						{
							skills.removeByID("trait.cultist_fanatic");
							skill = this.new("scripts/skills/traits/cultist_zealot_trait");
							skills.add(skill);
						}
						else
						{
							skill = this.new("scripts/skills/traits/cultist_fanatic_trait");
							skills.add(skill);
						}

						if (skill != null)
						{
							this.List.push({
								id = 10,
								icon = skill.getIcon(),
								text = bro.getName() + "现在是" + this.Const.Strings.getArticle(skill.getName()) + skill.getName()
							});
						}
					}
					else if (!bro.getSkills().hasSkill("trait.mad"))
					{
						bro.worsenMood(4.0, "被献祭吓坏了，献祭的是 " + _event.m.Sacrifice.getName());

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
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.getTime().Days <= 5)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 4)
		{
			return;
		}

		brothers.sort(function ( _a, _b )
		{
			if (_a.getXP() < _b.getXP())
			{
				return -1;
			}
			else if (_a.getXP() > _b.getXP())
			{
				return 1;
			}

			return 0;
		});
		local r = this.Math.rand(0, this.Math.min(2, brothers.len() - 1));
		this.m.Sacrifice1 = brothers[r];
		brothers.remove(r);
		r = this.Math.rand(0, this.Math.min(2, brothers.len() - 1));
		this.m.Sacrifice2 = brothers[r];
		this.m.Score = 50 + (this.World.getTime().Days - this.m.LastTriggeredOnDay);
	}

	function onPrepare()
	{
		this.m.LastTriggeredOnDay = this.World.getTime().Days;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"sac1",
			this.m.Sacrifice1.getName()
		]);
		_vars.push([
			"sac2",
			this.m.Sacrifice2.getName()
		]);
		_vars.push([
			"sacrifice",
			this.m.Sacrifice != null ? this.m.Sacrifice.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Sacrifice1 = null;
		this.m.Sacrifice2 = null;
		this.m.Sacrifice = null;
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU16(this.m.LastTriggeredOnDay);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 62)
		{
			this.m.LastTriggeredOnDay = _in.readU16();
		}
	}

});

