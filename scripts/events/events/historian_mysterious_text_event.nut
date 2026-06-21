this.historian_mysterious_text_event <- this.inherit("scripts/events/event", {
	m = {
		Historian = null
	},
	function create()
	{
		this.m.ID = "event.historian_mysterious_text";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_57.png[/img]你遇见了一个被遗弃的小教堂。 蜘蛛们在它的裂缝处结网，鸟儿们在它的角落里筑巢。 里面的座位要么翻倒在地，要么已经被劈开做了柴火。 那些古老的神明肯定已经放弃了这个地方。\n\n %historian% 这个历史学家手里拿着一份布满灰尘的稿件来到了你的身边。%SPEECH_ON%你能看看这个吗？古老的手稿！%SPEECH_OFF%他吹开卷轴上已经变黑的泥土和灰尘。%SPEECH_ON%你见过这么令人惊叹的东西吗？ 虽然我还不知道里面写了什么，但是这是一个非常有趣的发现！%SPEECH_OFF%好吧，随便了。",
			Image = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "读一下，然后告诉我上面写了什么。",
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
				this.Characters.push(_event.m.Historian.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_15.png[/img]在你在神殿外宿营的时候，历史学家 %historian% 走进了你的帐篷。%SPEECH_ON%先生，我觉得你可能会对这个感兴趣。%SPEECH_OFF%他把从教堂里找到的卷轴夹在胳膊里，然后将一些展开在你的办公桌上。 在那些卷轴上面你看到了历史学家潦草的字迹。 他的笔记是用一种你看不懂的语言写的，但是你可以轻松地通过他在文章里划的箭头将不同的段落联系在一起。 接着他展开了另一个卷轴，一个崭新的，对所有内容进行了翻译的卷轴。%SPEECH_ON%这些是古老的训练手册。 他们谈到了一些我从没听过的技术。 我应不应该把他们在伙计们之间推广开来？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "去推广吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Historian.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.getBaseProperties().RangedDefense += 1;
					bro.getSkills().update();
					this.List.push({
						id = 16,
						icon = "ui/icons/ranged_defense.png",
						text = bro.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 远程防御"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_15.png[/img]在你坐在这个被遗弃的神殿外的帐篷里的时候，历史学家 %historian% 不情愿地走进了你的帐篷。 在他的手里拿着几天之前他在小教堂里发现的那些卷轴。%SPEECH_ON%先生，呃，这些卷轴…它们很有趣。%SPEECH_OFF%你无聊地问了问它究竟有多“有趣”。他解释道。%SPEECH_ON%呃，它们是用一种非常古老的语言写的。 我对它不是很擅长，但是我能清楚地读懂这部分和那部分。%SPEECH_OFF%你问他接下来想干什么。%SPEECH_ON%我想继续阅读这些卷轴，但是我现在不太敢继续读下去了。 你能祝福这些文章吗？ 那是我的老师在做任何大事之前都会做的事。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，继续读吧。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "D";
						}
						else
						{
							return "E";
						}
					}

				},
				{
					Text = "如果你对阅读它如此恐惧的话，那我们最好不要继续下去了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Historian.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_12.png[/img]%historian% 拿起了卷轴。 他舔了舔他的嘴唇，清了清他的喉咙，然后大声地朗读起来。 从他嘴里传出的词语你无法轻易的辨认。 它们听起来是如此的懒散，使得他就像一个刚刚从沉睡中被吵醒的人一样，而且还带来了那些栖息在梦境里的怪物。\n\n 他停了下来然后向上看去。%SPEECH_ON%就是这样。你感觉到什么了吗？%SPEECH_OFF%你挑了挑眉毛。感觉到什么？为什么要－\n\n 疯狂。你看见一团螺旋形的暗影盘旋在一处活跃的阴影里：那些渴求死亡的生物的尖啸幽灵，在这些螺旋形的怪物中，面容狰狞，嘶叫狂吼，就像残忍的木偶的主人，咽喉幽邃而深远，他们剔除着这个邻域里仅剩的光芒，他们微笑着的但是畸变的新月形月亮开始吞噬它们自己。%SPEECH_ON%无知的凡人，汝可认为达库尔未曾听见？%SPEECH_OFF%你突然被 %historian%的尖叫惊醒。 他说各种各样的怪物已经在准备了。一刻也不能浪费，你要在所有的地狱和那些还不为人所知的人挣脱之前警告人们。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "拿起武器！",
					function getResult( _event )
					{
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.BeastsTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.PlayerDeploymentType = this.Const.Tactical.DeploymentType.Center;
						properties.EnemyDeploymentType = this.Const.Tactical.DeploymentType.Circle;
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Direwolves, this.Math.rand(40, 70), this.Const.Faction.Enemy);
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Ghouls, this.Math.rand(40, 70), this.Const.Faction.Enemy);
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Historian.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_15.png[/img]%historian% 拿起了卷轴并开始朗读起来。 这种语言听起来即让人熟悉又感觉非常的古老。 它听起来让人耳朵发痒，就像毒蛇在沙子上摩擦，而且有一种无法言说的恐惧感。 当他结束时，历史学家抬头看去。%SPEECH_ON%感觉到什么了吗？%SPEECH_OFF%突然，一只漆黑的，柔软的手从他身后环绕住他，并且弯曲着伸向他的腰部。%SPEECH_ON%噢，人类。我们还以为你们存活不了这么久，自从我们签订契约以来，已经过去了如此漫长的时间。%SPEECH_OFF%轻柔的，飘忽不定的生物悄然滑进帐篷里，好像它们就是风本身一样。 在帐篷外，你听见战队的其他人被这些生物诱惑所发出的呢喃低语。 一个生物朝你走来，她的外形在你这一生所见过的所有女性中不断变化，并且测试着你的反应，在你心中一动的时候，她的外形确定在一个曾经打动了你的心的年轻姑娘。 这个女妖从你头顶飘下。%SPEECH_ON%别在意我，人类，这是给你的奖励。放轻松。%SPEECH_OFF%你放任愉悦感充斥着你的身体。\n\n 不知道多久之后，你醒了过来，发现下半身没有穿着裤子，而 %historian% 在角落里揉着他的头。%SPEECH_ON%这真是太神奇了，但是卷轴却消失了。 我认为它在我念出上面写着的内容之后就焚毁了。 噢，旧神啊，希望我还记得那上面写了什么！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Incredible.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Historian.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(1.0, "有一次愉快的超自然体验");

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
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 10)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 8)
			{
				nearTown = true;
				break;
			}
		}

		if (nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_historian = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getBackground().getID() == "background.historian")
			{
				candidates_historian.push(bro);
			}
		}

		if (candidates_historian.len() == 0)
		{
			return;
		}

		this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"historian",
			this.m.Historian != null ? this.m.Historian.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Historian = null;
	}

});

