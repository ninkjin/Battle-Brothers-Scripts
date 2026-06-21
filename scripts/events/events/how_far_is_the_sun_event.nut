this.how_far_is_the_sun_event <- this.inherit("scripts/events/event", {
	m = {
		Historian = null,
		Monk = null,
		Cultist = null,
		Archer = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.how_far_is_the_sun";
		this.m.Title = "露营时…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]在休息的时候，伙计们开启了一个关于太阳有多远的话题。%otherbrother% 抬头看着，咬紧牙关、呲牙咧嘴地，在眼镜快被亮瞎之前完成了测量。 最后，他低下头来。%SPEECH_ON%我敢打赌，它离我们大概十到十五英里远。%SPEECH_OFF%他在自认为非常正确的结论中点了点头。%SPEECH_ON%没错，甚至可能没有那么远。 我听说过这么一个故事，在遥远的国度里甚至有个弓箭手用弓箭击中了太阳。%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [],
			function start( _event )
			{
				if (_event.m.Historian != null)
				{
					this.Options.push({
						Text = "%historianfull%，你有什么要说的？",
						function getResult( _event )
						{
							return "Historian";
						}

					});
				}

				if (_event.m.Monk != null)
				{
					this.Options.push({
						Text = "我敢打赌 %monkfull% 知道真相。",
						function getResult( _event )
						{
							return "Monk";
						}

					});
				}

				if (_event.m.Cultist != null)
				{
					this.Options.push({
						Text = "我看见你在思考，%cultistfull%。你说呢？",
						function getResult( _event )
						{
							return "Cultist";
						}

					});
				}

				if (_event.m.Archer != null)
				{
					this.Options.push({
						Text = "%archerfull%，你为什么不射一下试试？",
						function getResult( _event )
						{
							return "Archer";
						}

					});
				}

				this.Options.push({
					Text = "闲聊结束。 该上路了。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Historian",
			Text = "[img]gfx/ui/events/event_05.png[/img]%historian% 历史学家开始加入这个话题。%SPEECH_ON%我对那个用弓射击的说法的真实性表示质疑。 我曾读过一个更加真实的故事：在东方的大山中，有一群人用大型望远镜观测夜空。 他们认为太阳离我们非常远。 甚至至少有一万英里远。 他们还认为，群星是其他的太阳，而非已故英雄们的灵魂。%SPEECH_OFF%%otherbrother% 站了起来。%SPEECH_ON%嘴上有点把门的，傻子，别说咱祖宗的坏话。%SPEECH_OFF%历史学家点了点头。%SPEECH_ON%当然这只是一个观点。%SPEECH_OFF%狗屁，你这什么“聪明的” %historian% 就是一坨狗屎。其他兄弟开始嘲笑历史学家这个愚蠢的观点。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他真是个笑柄。",
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
					if (bro.getID() == _event.m.Historian.getID() || bro.getBackground().getID() == "background.historian" || bro.getSkills().hasSkill("trait.bright"))
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.5, "被逗乐于" + _event.m.Historian.getName() + "的关于太阳的愚蠢想法");

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
			ID = "Monk",
			Text = "[img]gfx/ui/events/event_05.png[/img]%monk% 僧侣开始加入这个话题。%SPEECH_ON%太阳既不远也不近。 它是诸神之眼，是照向我们的诸神之镜。%SPEECH_OFF%%otherbrother% 点了点头，然后好奇地问道，那月亮呢。 僧侣自信地笑着。%SPEECH_ON%你认为诸神整天都照耀着我们？ 他们当然要调低一点亮度，给我们这些凡人一个美好的夜晚来睡觉。%SPEECH_OFF%你点头。这些古老的神明一直在照顾着我们。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "祝福他们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getEthnicity() == 1 || bro.getID() == _event.m.Monk.getID() || bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist" || bro.getBackground().getID() == "background.historian")
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.5, "受到鼓舞于" + _event.m.Monk.getName() + "的布道");

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
			ID = "Cultist",
			Text = "[img]gfx/ui/events/event_05.png[/img]%cultist% 异教徒站了起来，看着太阳。 在他注视着太阳的时候，一片阴影渐渐浮现在他的脸上，就好像有什么东西帮他遮住了阳光。 突然，他举起双手，开始在手上绘制一些宗教图案。 你敢发誓他脸上的阴影开始动了起来，就像他绘制的印记，一种移动的纹身。 当他结束之后，他坐了下来。%SPEECH_ON%太阳正在死亡。%SPEECH_OFF%伙计们很担心，一个人插嘴道。%SPEECH_ON%正在死亡？这话怎么说？%SPEECH_OFF%%cultist% 盯着他。%SPEECH_ON%达库尔的意志一切终将消亡。%SPEECH_OFF%一个人问这个所谓的“达库尔”是否也会死。异教徒点头。%SPEECH_ON%当万物消亡之后，达库尔便会陷入沉睡。 一个残酷的神将逝去。 达库尔的恩赐在于他将最后一个离去，这也是我们赞美他的地方。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "额，好吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Cultist.getID())
					{
						bro.improveMood(1.0, "享受谈论垂死的太阳的机会");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().getID() == "background.cultist")
					{
						bro.improveMood(0.5, "喜爱的" + _event.m.Cultist.getName() + "的关于垂死的太阳的演讲");

						if (bro.getMoodState() >= this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getEthnicity() == 1)
					{
						bro.worsenMood(1.0, "对异端言论感到愤怒来自 " + _event.m.Cultist.getName());

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.mad"))
					{
						bro.worsenMood(1.0, "对即将死去的太阳感到恐惧");

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
			ID = "Archer",
			Text = "[img]gfx/ui/events/event_05.png[/img]%archer% 拿出他的弓和一对箭，开始了尝试。 舔了舔手指，他举起手来。%SPEECH_ON%现在的风向正好适合来一箭。%SPEECH_OFF%弓箭手搭上一只箭，拉紧弓弦，然后瞄准。 炙热的阳光顿时让他感觉非常刺眼。%SPEECH_ON%妈的，我看不见了。%SPEECH_OFF%黑斑开始覆盖他的视线，他的瞄准变得摇摆不定。 弓箭丢失了它的目标，向着远离太阳的方向飞去。非常远。 他看向自己的同伴，眼中一片模糊，不得不在视力恢复之前伸出手来保持平衡。%SPEECH_ON%我击中它了吗？%SPEECH_OFF%%otherbrother% 停止了偷笑。%SPEECH_ON%正中靶心！%SPEECH_OFF%伙计们开始大笑起来。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一次优秀的射击，先生！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Archer.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(0.5, "被逗乐于" + _event.m.Archer.getName() + "的尝试射击太阳。");

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
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidate_historian = [];
		local candidate_monk = [];
		local candidate_cultist = [];
		local candidate_archer = [];
		local candidate_other = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.historian")
			{
				candidate_historian.push(bro);
			}
			else if (bro.getBackground().getID() == "background.monk")
			{
				candidate_monk.push(bro);
			}
			else if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				candidate_cultist.push(bro);
			}
			else if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.sellsword")
			{
				candidate_archer.push(bro);
			}
			else if (bro.getEthnicity() != 1 && bro.getBackground().getID() != "background.slave")
			{
				candidate_other.push(bro);
			}
		}

		if (candidate_other.len() == 0)
		{
			return;
		}

		local options = 0;

		if (candidate_historian.len() != 0)
		{
			options = ++options;
		}

		if (candidate_monk.len() != 0)
		{
			options = ++options;
		}

		if (candidate_cultist.len() != 0)
		{
			options = ++options;
		}

		if (candidate_archer.len() != 0)
		{
			options = ++options;
		}

		if (options < 2)
		{
			return;
		}

		if (candidate_historian.len() != 0)
		{
			this.m.Historian = candidate_historian[this.Math.rand(0, candidate_historian.len() - 1)];
		}

		if (candidate_monk.len() != 0)
		{
			this.m.Monk = candidate_monk[this.Math.rand(0, candidate_monk.len() - 1)];
		}

		if (candidate_cultist.len() != 0)
		{
			this.m.Cultist = candidate_cultist[this.Math.rand(0, candidate_cultist.len() - 1)];
		}

		if (candidate_archer.len() != 0)
		{
			this.m.Archer = candidate_archer[this.Math.rand(0, candidate_archer.len() - 1)];
		}

		this.m.Other = candidate_other[this.Math.rand(0, candidate_other.len() - 1)];
		this.m.Score = options * 3;
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
		_vars.push([
			"historianfull",
			this.m.Historian != null ? this.m.Historian.getName() : ""
		]);
		_vars.push([
			"monk",
			this.m.Monk != null ? this.m.Monk.getNameOnly() : ""
		]);
		_vars.push([
			"monkfull",
			this.m.Monk != null ? this.m.Monk.getName() : ""
		]);
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
		_vars.push([
			"cultistfull",
			this.m.Cultist != null ? this.m.Cultist.getName() : ""
		]);
		_vars.push([
			"archer",
			this.m.Archer != null ? this.m.Archer.getNameOnly() : ""
		]);
		_vars.push([
			"archerfull",
			this.m.Archer != null ? this.m.Archer.getName() : ""
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Historian = null;
		this.m.Monk = null;
		this.m.Cultist = null;
		this.m.Archer = null;
		this.m.Other = null;
	}

});

