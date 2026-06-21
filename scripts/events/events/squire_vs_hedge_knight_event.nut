this.squire_vs_hedge_knight_event <- this.inherit("scripts/events/event", {
	m = {
		Squire = null,
		HedgeKnight = null
	},
	function create()
	{
		this.m.ID = "event.squire_vs_hedge_knight";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img]%squire% 这个年轻的扈从正从一个安全的距离注视着 %hedgeknight%。野骑士正在磨他的利刃，用磨刀石在利刃上磨来磨去，把金属磨得闪闪发光。 发现扈从正盯着他，%hedgeknight%放下他的装备。%SPEECH_ON%你想成为一名骑士，是吗？%SPEECH_OFF%%squire%点头骄傲地回答。%SPEECH_ON%这是我的梦想，是的，总有一天会实现的。%SPEECH_OFF%野骑士站起来走了过去，来到这个年轻人身旁。%SPEECH_ON%你认为骑士会做什么？拯救美女？统治封地以获得农民的爱戴？效忠于他的领主？让我告诉你，那全是胡扯。像你这样高雅的扯淡狗屁不如，就是个米虫。你想成为骑士，就得学会杀戮。%SPEECH_OFF%扈从直起身子，把肩膀往后拉。%SPEECH_ON%杀人我没有问题。%SPEECH_OFF%野骑士只用一根手指把那个人往后推了推。%SPEECH_ON%是这样吗？你有没有在一个人倒在地上流血的时候把他的家人都杀了？ 因为你的主子下了命令，你就用手砸碎一个孩子的脑袋，这有什么关系呢？ 你会因为你的主人认为偷了一条面包而把女人的眼睛挖出来吗？ 你以为我是谁，扈从？你以为我生来就高大，吝啬，野蛮吗？不，小扈从，你必须杀戮，而且你先杀的不是别人，正是你自己。这就是你如何才能成为这些地方的骑士，在这个时代。%SPEECH_OFF%野骑士返回工作岗位。 扈从显然很震惊，但似乎在认真地思考他刚才听到的话。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "生活并不是骑士童话。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Squire.getImagePath());
				this.Characters.push(_event.m.HedgeKnight.getImagePath());
				_event.m.Squire.getFlags().set("squire_vs_hedge_knight", true);
				local resolve = this.Math.rand(1, 4);
				_event.m.Squire.getBaseProperties().Bravery += resolve;
				_event.m.Squire.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Squire.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
				});
				_event.m.Squire.worsenMood(1.5, "他的信仰被动摇了");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Squire.getMoodState()],
					text = _event.m.Squire.getName() + this.Const.MoodStateEvent[_event.m.Squire.getMoodState()]
				});
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

		local squire_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() <= 4 && bro.getBackground().getID() == "background.squire" && !bro.getFlags().has("squire_vs_hedge_knight"))
			{
				squire_candidates.push(bro);
			}
		}

		if (squire_candidates.len() == 0)
		{
			return;
		}

		local hk_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.hedge_knight")
			{
				hk_candidates.push(bro);
			}
		}

		if (hk_candidates.len() == 0)
		{
			return;
		}

		this.m.Squire = squire_candidates[this.Math.rand(0, squire_candidates.len() - 1)];
		this.m.HedgeKnight = hk_candidates[this.Math.rand(0, hk_candidates.len() - 1)];
		this.m.Score = (squire_candidates.len() + hk_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"squire",
			this.m.Squire.getNameOnly()
		]);
		_vars.push([
			"hedgeknight",
			this.m.HedgeKnight.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Squire = null;
		this.m.HedgeKnight = null;
	}

});

