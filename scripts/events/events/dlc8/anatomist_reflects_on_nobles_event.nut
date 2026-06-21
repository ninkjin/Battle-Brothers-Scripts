this.anatomist_reflects_on_nobles_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_reflects_on_nobles";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_39.png[/img]{解剖学家%anatomist%坐在篝火旁，精神恍惚。你心想这是个问他问题的好机会，“你在想什么？”这个全宇宙最烦人的问题。解剖医生捏紧眼睛，长叹一口气。%SPEECH_ON%我在沉思这个世界的实体，尤其是那些上层和下层的人。明白吗，你这个家伙，“我们在旅途中遇到了许多皇室成员，但他们给我的印象都是沮丧的。野生动物的运行方式都是平等的，因为那些吃东西的和那些被迫四处寻找的动物都是通过他们天生的才华来区分的。那么成为最好的动物的公理是否也只能适用于动物的世界？我一直以为我们的统治者，现在是我们的恩人，将反映这些现实。然而，我一遍又一遍地遇到了这些小丑。他们最主要的才能是权衡。太多了，百姓们会因为奢侈而生气；太少，教徒们会认为他们的统治者在浪费他们过于幸运的生命。我的评估每天都在下降。我敢说，我敢说，家伙……家伙，你在听吗？%SPEECH_OFF%当你听到自己的名字时，你正在玩火棍。转过头去告诉他，你并不陌生这些想法，但它们只是想法。尽管周围的环境非常压抑，你仍然可以决定自己的想法。如果这让他如此困扰，那他应该把它放在一边。他毕竟无法控制这个世界，这样的想法不会带来更大的改变。这只是抱怨而已。解剖师盯着你看了一会儿，然后点了点头。%SPEECH_ON%我认为我不再长时间沉浸在这些事情中是一个不错的选择，因为它们的错误并不是我造成的，也不可能由我修复。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好样的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local resolve_boost = this.Math.rand(2, 4);
				_event.m.Anatomist.getBaseProperties().Bravery += resolve_boost;
				_event.m.Anatomist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve_boost + "[/color] 决心"
				});
				_event.m.Anatomist.improveMood(1.0, "更好地理解他的意志限制。");

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
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

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 1500)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Score = 3 * anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
	}

});

