this.bird_shits_on_sellsword_event <- this.inherit("scripts/events/event", {
	m = {
		Victim = null,
		Superstitious = null,
		Archer = null,
		Historian = null
	},
	function create()
	{
		this.m.ID = "event.bird_shits_on_sellsword";
		this.m.Title = "在途中…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{在旅行途中，%birdbro%被鸟屎击中。它打在他的剑手上，并溅到他的盔甲上。%SPEECH_ON%啊，啊！%SPEECH_OFF%他的手臂像鸡翅膀一样大张，看着伤口。%SPEECH_ON%该死的，真是我倒霉！%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是啊，别老想着了，我们走吧。",
					function getResult( _event )
					{
						if (_event.m.Historian == null)
						{
							return "Continue";
						}
						else
						{
							return "Historian";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());

				if (_event.m.Superstitious != null)
				{
					this.Options.push({
						Text = "这是个预兆吗？",
						function getResult( _event )
						{
							return "Superstitious";
						}

					});
				}

				if (_event.m.Archer != null)
				{
					this.Options.push({
						Text = "有人打倒了那个冒失的家伙！",
						function getResult( _event )
						{
							return "Archer";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Continue",
			Text = "%terrainImage%{%birdbro% 点点头。%SPEECH_ON%当然。只是有点毁了我的好心情。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "啊，好吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
				_event.m.Victim.worsenMood(0.5, "粘到了鸟屎");

				if (_event.m.Victim.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Victim.getMoodState()],
						text = _event.m.Victim.getName() + this.Const.MoodStateEvent[_event.m.Victim.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Superstitious",
			Text = "%terrainImage%{老迷信鬼%superstitious%用正确鉴定家的眼光分析着这坨鸟屎。他噘起嘴点了点头，这是关于鸟屎的一个很满意的总结。他说：%SPEECH_ON%这是一件好事.%SPEECH_OFF%在十分怀疑的人们面前，这个人冷静地解释说被鸟屎砸中是一个好兆头。一些雇佣兵似乎已经相信了这个观念。如果一只鸟选择在所有地球下方落脚，这是相当壮观的。你点点头，说%birdbro%下次应该张嘴等更特别的好运。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "幸运的家伙。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
				this.Characters.push(_event.m.Superstitious.getImagePath());
				_event.m.Victim.improveMood(1.0, "幸运的粘到了鸟屎");

				if (_event.m.Victim.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Victim.getMoodState()],
						text = _event.m.Victim.getName() + this.Const.MoodStateEvent[_event.m.Victim.getMoodState()]
					});
				}

				_event.m.Superstitious.improveMood(0.5, "目睹(Witnessed)" + _event.m.Victim.getName() + "被鸟屎砸中");

				if (_event.m.Superstitious.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Superstitious.getMoodState()],
						text = _event.m.Superstitious.getName() + this.Const.MoodStateEvent[_event.m.Superstitious.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Archer",
			Text = "[img]gfx/ui/events/event_10.png[/img]{%archer%抬头看向天空，用手遮住眼睛，伸出舌头。他看到了鸟，点了点头。抬起一根手指，试探了一下空气，然后再次点头。射手露出笑容，扣住了箭。%SPEECH_ON%犯罪必受惩罚。%SPEECH_OFF%雇佣兵们哼哼唧唧、嘲笑他在道德上的宣讲，但他平静地举起弓，放开了箭。箭矢迅猛飞向高空，几乎看不清轨迹。但你看到鸟突然向一侧倾斜、开始在空中旋转。神射手点了点头，看向了战团。%SPEECH_ON%你们现在还笑得出来吗？%SPEECH_OFF%这仅仅带来更多的嘲笑。射手嘴里嘀咕着他的重要性，这引起了前线和后方士兵之间激烈的辩论。你告诉这些人如果他们想争出哪个更优秀，那就去战场上证明它。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "射的好！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
				this.Characters.push(_event.m.Archer.getImagePath());
				_event.m.Victim.improveMood(0.5, "报复一只鸟");

				if (_event.m.Victim.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Victim.getMoodState()],
						text = _event.m.Victim.getName() + this.Const.MoodStateEvent[_event.m.Victim.getMoodState()]
					});
				}

				_event.m.Archer.improveMood(1.0, "向那只拉屎的鸟复仇" + _event.m.Victim.getName() + "精准地");

				if (_event.m.Archer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Archer.getMoodState()],
						text = _event.m.Archer.getName() + this.Const.MoodStateEvent[_event.m.Archer.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Archer.getID() || bro.getID() == _event.m.Victim.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "目睹(Witnessed)" + _event.m.Archer.getName() + "队长精湛的射箭技艺");

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
			ID = "Historian",
			Text = "%terrainImage%{您告诉%birdbro%被鸟屎糊身是生活的一部分，准备好继续前进。但一位谦虚的%historian%走上来告诉这个不幸的自由军雇佣兵先不要清理鸟屎。历史学家仔细看了看鸟屎，然后抬头看了看鸟。%SPEECH_ON%是的，我知道那只鸟！那只神奇的生物！%SPEECH_OFF% 雇佣兵们仰望着那只鸟，就像他们是被困在海上的水手发现一样。%historian%指着%birdbro%。%SPEECH_ON%你被一只红蓝色的Mockingbird（一种鸟）拉屎了！我就是想说这个，真的。我很久没见到这种鸟了。你……你现在可以清理了。%SPEECH_OFF% 雇佣兵们目瞪口呆，然后爆发出笑声。%birdbro%抓住历史学家，用他的袖子擦掉鸟屎，这引来了更多人的欢呼。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "所以谜团就解开了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Victim.getImagePath());
				this.Characters.push(_event.m.Historian.getImagePath());
				_event.m.Victim.worsenMood(0.5, "粘到了鸟屎");

				if (_event.m.Victim.getMoodState() <= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Victim.getMoodState()],
						text = _event.m.Victim.getName() + this.Const.MoodStateEvent[_event.m.Victim.getMoodState()]
					});
				}

				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getID() == _event.m.Victim.getID() || bro.getID() == _event.m.Historian.getID())
					{
						continue;
					}

					if (this.Math.rand(1, 100) <= 25)
					{
						bro.improveMood(1.0, "感到愉快来自 " + _event.m.Historian.getName());

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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type == this.Const.World.TerrainType.Snow)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		local candidates_victim = [];
		local candidates_archer = [];
		local candidates_super = [];
		local candidates_historian = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.historian")
			{
				candidates_historian.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.superstitious"))
			{
				candidates_super.push(bro);
			}
			else if (bro.getBackground().getID() == "background.hunter" || bro.getCurrentProperties().RangedSkill > 70)
			{
				candidates_archer.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.lucky") && bro.getBackground().getID() != "background.slave")
			{
				candidates_victim.push(bro);
			}
		}

		if (candidates_victim.len() == 0)
		{
			return;
		}

		this.m.Victim = candidates_victim[this.Math.rand(0, candidates_victim.len() - 1)];

		if (candidates_historian.len() != 0)
		{
			this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		}

		if (candidates_archer.len() != 0)
		{
			this.m.Archer = candidates_archer[this.Math.rand(0, candidates_archer.len() - 1)];
		}

		if (candidates_super.len() != 0)
		{
			this.m.Superstitious = candidates_super[this.Math.rand(0, candidates_super.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"birdbro",
			this.m.Victim.getNameOnly()
		]);
		_vars.push([
			"superstitious",
			this.m.Superstitious != null ? this.m.Superstitious.getName() : ""
		]);
		_vars.push([
			"archer",
			this.m.Archer != null ? this.m.Archer.getName() : ""
		]);
		_vars.push([
			"historian",
			this.m.Historian != null ? this.m.Historian.getName() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Victim = null;
		this.m.Superstitious = null;
		this.m.Archer = null;
		this.m.Historian = null;
	}

});

