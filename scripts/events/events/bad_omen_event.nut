this.bad_omen_event <- this.inherit("scripts/events/event", {
	m = {
		Superstitious = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.bad_omen";
		this.m.Title = "在途中…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_12.png[/img]哭喊声像狂风的怒号一样从人群中呼啸而过。 在视野里没有一个敌人，所以你不知道是什么发出的声音。 你走在队伍里，发现 %superstitious% 几乎趴在地上哭泣。 他一只手抓着胸口，另一只手指向天空，手指因恐惧而颤抖。%otherguy% 解释说，这家伙看到了星星旁边燃起熊熊大火。 很明显，这个可怜的傻瓜把它当成了一个征兆，当然，这不是一个好兆头。 不管它是什么，它不会把你带到你需要去的地方，所以你命令队员们继续行军。 | [img]gfx/ui/events/event_12.png[/img] 他们的影子开始以奇怪的方式向外和向内呈现。 你转过身去，看到太阳正在变黑，一个巨大的黑环在它上面移动。 很快就没有太阳了。%superstitious% 哭着说世界末日就要到了，但是在他的号啕大哭能够传染你的其他队员之前，巨大的阴影再次遮蔽了太阳，光明又出现了，就好像什么都没有发生一样。 你叫那个可怜的傻瓜站起来。 你有行军的目的地，眼泪肯定屁用没有，不会带你到达目的地。 | [img]gfx/ui/events/event_11.png[/img] %superstitious% 他正在把剑刺入一个兔子洞时突然大哭起来。 他从兔子洞里旁边跳起来，尖叫着说里面有一只双头兔。 显然这是一个不好的兆头。 你所能想到的是，两个脑袋只是意味着有更多肉可以炖。 | [img]gfx/ui/events/event_11.png[/img]你从一棵树下经过，那棵树的树枝上既有一只黑猫，也有一只白乌鸦。%superstitious% 一看到就开始哭，说这肯定是世界末日的前兆。 为什么是，因为它就是。 这些都不是好事的征兆，对吧？是的。 | [img]gfx/ui/events/event_11.png[/img] 你偶遇到一个鹿的头骨。 一开始你认为它毫无意义，但是 %superstitious% 一脸认真地捡起它。 当他反复转动鹿头骨的时候，无声的灰尘从里面倾泻而出。 他双手颤抖着，把鹿头骨从手里扔出去。 它在地面上砰砰作响，应该滚到了一个有棱角的地方。 这个吓坏了的人说，曾经有一个占卜者告诉他，他会遇到这样一个头骨。\n\n这里有很多这样的头骨，你争执道，因为事物都会走向死亡。 你的话对他毫无用处，因为他慢慢地，紧张地，拖着脚步回到了行军的行列。 | [img]gfx/ui/events/event_11.png[/img] 在行军途中，几个人玩起了在云中寻找形状的游戏。 他们来来回回地开着狗和胖女人的玩笑，甚至开着关于家的玩笑，但是当 %superstitious% 看到一朵奇形怪状的云后跪下来的时候，乐事就发生了疯狂的转变。 他哭着说，这团乌云是个不祥之兆，厄运很快就会降临到战队头上。 值得庆幸的是，这种恐惧并没有影响到战队的其他成员，恰恰相反，他们很快开始争论这朵云是否真的代表 %randombrother%的惊人天赋。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{你给我振作起来！ | 我以为只有孩子才会有这种愚蠢的恐惧。}",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Superstitious.getImagePath());
				local effect = this.new("scripts/skills/effects_world/afraid_effect");
				_event.m.Superstitious.getSkills().add(effect);
				_event.m.Superstitious.worsenMood(1.0, "看到了一个坏兆头");
				this.List.push({
					id = 10,
					icon = effect.getIcon(),
					text = _event.m.Superstitious.getName() + "是害怕的"
				});

				if (_event.m.Superstitious.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Superstitious.getMoodState()],
						text = _event.m.Superstitious.getName() + this.Const.MoodStateEvent[_event.m.Superstitious.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2 || !this.World.getTime().IsDaytime)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if ((bro.getSkills().hasSkill("trait.superstitious") || bro.getSkills().hasSkill("trait.mad")) && !bro.getSkills().hasSkill("effects.afraid"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Superstitious = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 10;

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Superstitious.getID())
			{
				this.m.OtherGuy = bro;
				break;
			}
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"superstitious",
			this.m.Superstitious.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.Superstitious = null;
		this.m.OtherGuy = null;
	}

});

