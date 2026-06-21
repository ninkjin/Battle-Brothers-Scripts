this.noble_vs_lowborn_event <- this.inherit("scripts/events/event", {
	m = {
		Noble = null,
		Lowborn = null
	},
	function create()
	{
		this.m.ID = "event.noble_vs_lowborn";
		this.m.Title = "露营时…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img] 你发现贵族 %nobleman_short% 和另外一个衣衫褴褛的 %lowborn% 为最后一块食物在争吵。 很明显，这个出身卑微的人先用叉子拿到了这最后一块美味，但是这个贵族声称他良好的出身赋予了他获得这块烤肉的权力。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你们自己解决。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "在战队，没有人是卑微或高贵的。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "你知道这块土地的规矩，给这个贵族他想要的。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				this.Characters.push(_event.m.Lowborn.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_06.png[/img] 当这两个人同时向你寻求帮助时，你双臂交叉耸耸肩。 他们慢慢地转过身来面向对方。 营里的人都站起来，同时退后给即将上演的大战腾出空间。 出身卑微的人先拔出匕首。 这是一个相当简陋的武器，只有一个简单木制的把手和刀刃上很不自然的豁口。 贵族也拔出利刃来回敬他的对手，和他的对手不同的是在铁匠的良好保养与火光的照射下放出冷光。 防滑的雕纹如同两条金蛇缠绕在剑柄上最终交合成一个配饰。 它的持用者咧嘴一笑说乌合之众应该知道自己所处的位置。 和贵族相比那个出生卑微的人就像是一个从来没有练习过战斗的人一样。\n\n令人惊讶的是，两个人都把匕首扔进他们刚才坐着的树桩里握紧拳头，用最公平的方式角逐出胜利者。 在随后的战斗中那个烤肉的架子很快就被撞翻火焰开始不断的翻腾，灰烬被弄得到处都是并且倒下的食物现在有了灰烬和煤烟的味道。\n\n眼看着那两人的烤肉被毁了，其余的伙伴终于开始制止这场争斗，把两个人拉开。 他们互相威胁互相吐口水但几分钟后一切又都像没有发生过一样。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他们很快就会在接下来的战斗中成为兄弟。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				this.Characters.push(_event.m.Lowborn.getImagePath());
				local injury1 = _event.m.Noble.addInjury(this.Const.Injury.Brawl);
				local injury2 = _event.m.Lowborn.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury1.getIcon(),
					text = _event.m.Noble.getName() + " 遭受 " + injury1.getNameOnly()
				});
				this.List.push({
					id = 10,
					icon = injury2.getIcon(),
					text = _event.m.Lowborn.getName() + " 遭受 " + injury2.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_64.png[/img]%nobleman% 看起来目瞪口呆。他慢慢地把叉子从烤肉架上里拿起来然后 %lowborn% 立刻把最后一块肉铲进嘴里。 这个贵族起身并且向你走来。 他在你面前挺直身子，紧贴着你的你能感觉到他现在满腔的愤怒。 有几个人把他们的手放在了剑柄上面。%SPEECH_ON%{站在平民那一边，哏？ 我就应该猜到，毕竟你自己也是个贱民。 永远不要期望成为我们中的一员。 你这辈子只配做一个佣兵。记住这一点。 | 你至今为止所作的一切不就是希望得到一块土地，难道不是吗？ 我希望你能成功做到，因为在那之后我就会亲自拜访你并且告诉你一名真正的贵族应该如何对待他的同伴。}%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "离开我的视线。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				this.Characters.push(_event.m.Lowborn.getImagePath());
				_event.m.Noble.worsenMood(2.0, "在战队面前丢脸");

				if (_event.m.Noble.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Noble.getMoodState()],
						text = _event.m.Noble.getName() + this.Const.MoodStateEvent[_event.m.Noble.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_64.png[/img]%nobleman% 咧着嘴笑着把 %lowborn%的叉子敲开了。 这个贵族开始自己享受起了这个美味而那名出身卑微的人起身向你冲了过来。 当他走近时，有些人看起来准备拔出剑来，但是你挥了挥，制止了他们的行为。%SPEECH_ON%我以为你跟我们是一伙的，但是我发现我错了。 我猜你自己认为你有一天会成为那家伙的一员，哏？ 继续沉浸在你的美梦了。就像那个人跟我说的“有点自知之明”。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "离开我的视线。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Noble.getImagePath());
				this.Characters.push(_event.m.Lowborn.getImagePath());
				_event.m.Lowborn.worsenMood(2.0, "在战队面前丢脸");

				if (_event.m.Lowborn.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Lowborn.getMoodState()],
						text = _event.m.Lowborn.getName() + this.Const.MoodStateEvent[_event.m.Lowborn.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local noble_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() < 7 && bro.getBackground().isNoble())
			{
				noble_candidates.push(bro);
			}
		}

		if (noble_candidates.len() == 0)
		{
			return;
		}

		local lowborn_candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkill("trait.hesitant") && bro.getBackground().isLowborn() && bro.getBackground().getID() != "background.slave")
			{
				lowborn_candidates.push(bro);
			}
		}

		if (lowborn_candidates.len() == 0)
		{
			return;
		}

		this.m.Noble = noble_candidates[this.Math.rand(0, noble_candidates.len() - 1)];
		this.m.Lowborn = lowborn_candidates[this.Math.rand(0, lowborn_candidates.len() - 1)];
		this.m.Score = noble_candidates.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"nobleman",
			this.m.Noble.getName()
		]);
		_vars.push([
			"nobleman_short",
			this.m.Noble.getNameOnly()
		]);
		_vars.push([
			"lowborn",
			this.m.Lowborn.getName()
		]);
		_vars.push([
			"lowborn_short",
			this.m.Lowborn.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Noble = null;
		this.m.Lowborn = null;
	}

});

