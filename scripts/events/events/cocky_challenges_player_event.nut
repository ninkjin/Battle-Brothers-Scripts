this.cocky_challenges_player_event <- this.inherit("scripts/events/event", {
	m = {
		Cocky = null
	},
	function create()
	{
		this.m.ID = "event.cocky_challenges_player";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_26.png[/img]在篝火旁加入战队时，%cocky% 站起来，满脸通红地说话。%SPEECH_ON%我不知道你们这些可怜虫怎么想，但我想我比任何人都能更好地管理这个队伍！ 尤其是比他好！%SPEECH_OFF%他用手指着你。\n\n你在他旁边坐了下来。他盯着你, 等待着你的回答。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你完全正确。 你应该说了算。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "是时候收拾你了。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "这里我说了算！ 这是我的战队！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cocky.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_26.png[/img]你把脚伸前，两腿岔开，双手放在膝盖上。 点着头，你对那个人说话。%SPEECH_ON%好吧，%cocky%。你现在就是那个人。 你每天早晚都要清点存货。 我知道你不是垃圾，但你要学。 不要让这些优秀的战士上战场的时候少几支箭。%SPEECH_OFF%你向几个帐篷挥手。%SPEECH_ON%你还要对你的队员心里有数。 他们可不容易控制，你可能会发现有点讽刺－也许不。%SPEECH_OFF%看着你的手，这几天已经满是老茧和擦伤，你继续说。%SPEECH_ON%你需要发出号令，这不仅是为了让他们听到－也是为了让他们活着和呼吸。 你知道，就像你自己和坐在你身边的人。 所以，是的，接受这份工作，%cocky%。它现在是你的。%SPEECH_OFF%演讲一结束，一群兄弟立刻站起来请求你继续领导他们。%cocky%，看到这一切，在“你来负责”的欢呼声中乖乖的退缩了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你说得对极了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cocky.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getMoodState() < this.Const.MoodState.Neutral && this.Math.rand(1, 100) <= 33)
					{
						bro.improveMood(1.0, "对你的领导有信心");

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
			ID = "C",
			Text = "[img]gfx/ui/events/event_26.png[/img]营火在你脸上映出橙色的光芒。你边点头，边走向%cocky%。他向后退了一步，但在你伸出手臂并扳住他肩膀之前你已经扭转身体，一个腿扫堂腿，把他绊倒摔在地上。你扑下来按住他，一只手扼住他的喉咙，另一只手指着他说。%SPEECH_ON%你是个好人%cocky%，但也很愚蠢，如果像你这样的人掌管大局，你们十天半个月内就会全部死光！%SPEECH_OFF%你帮助%cocky%站起来，他对你冷笑一下，狠狠踢开一堆桶子离去。不久前箭击中你的地方发出一阵疼痛，但你咬紧牙关，尽量不表露出什么，重新坐下。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我还能坚持！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cocky.getImagePath());
				_event.m.Cocky.worsenMood(3.0, "在战队面前感到丢脸");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cocky.getMoodState()],
					text = _event.m.Cocky.getName() + this.Const.MoodStateEvent[_event.m.Cocky.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_26.png[/img]你马上跳起来，开始大吼。%SPEECH_ON%我是这里的唯一领袖！我！ 谁有钱？我！ 如果不是我，你们甚至都不会在这里！ 不管你们以前过着怎样的生活，你们都会陷入困境！ 你们应该在我的领导下，我会为你们找到机会！ 而且 %cocky%，如果你再敢和我较劲，我发誓我会用鞭子抽死你，明白吗？%SPEECH_OFF%这次爆发立即使整个营地安静下来。%cocky% 点头，走掉了。 在你重新坐下时，几个人在窃窃私语。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "情况变得很好了，不是么？",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cocky.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (this.Math.rand(1, 100) <= 33)
					{
						bro.worsenMood(1.0, "对你的领导失去信心");

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
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];
		local grumpy = 0;

		foreach( bro in brothers )
		{
			if (bro.getMoodState() < this.Const.MoodState.Neutral)
			{
				grumpy = ++grumpy;

				if (bro.getSkills().hasSkill("trait.cocky"))
				{
					candidates.push(bro);
				}
			}
		}

		if (candidates.len() == 0 || grumpy < 3)
		{
			return;
		}

		this.m.Cocky = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 3 + grumpy * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cocky",
			this.m.Cocky.getName()
		]);
	}

	function onClear()
	{
		this.m.Cocky = null;
	}

});

