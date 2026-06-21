this.cultist_origin_vs_old_gods_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		OldGods = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_vs_old_gods";
		this.m.Title = "露营时…";
		this.m.Cooldown = 20.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_06.png[/img]正在享用一片培根的时候，你听到一场争吵愈演愈烈。 你忽视它一段时间，但叫喊声只是越来越大，迅速上升让你无法安心享用一顿美餐。 被惹怒了，你站起来朝骚动的方向走去。 你发现 %cultist% 和 %oldgods% 正在对峙，这些异教徒和古老神明的追随者们显然发生了一些分歧，而后者显然无法真正开始理解这些差异。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们用最血腥的方式来尊敬古老神明吧！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "达库尔即将降临，我们不需要麻烦他。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OldGods.getImagePath());
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_06.png[/img]你退到一旁，让队员们用男人的方式解决分歧。 古老神明的追随者们挥舞着拳头为自己辩护，一次又一次地打击着异教徒。 但那个头上有疤的人只以咧嘴笑回应。 他的眼睛肿了起来，眼皮皱成紫色，遮住了他的视线。 然而，他仍然咧嘴一笑，从他流血的嘴里流出了恐怖的笑声。%SPEECH_ON%如此黑暗！达库尔一定很高兴！%SPEECH_OFF%焦虑的看了一眼，%oldgods% 离开了 %cultist% 并后退了。 他揉着血淋淋的指关节，意识到自己可能在这场看似一边倒的混战中弄断了几个。 但最刺伤他的是那个异教徒的话。%SPEECH_ON%人不是受到黑暗的诱惑，而是受到黑暗的召唤！ 失去了没有它！它的归来让人欣喜！%SPEECH_OFF%几乎不敢回头看，%oldgods% 匆忙离开，而异教徒留在后面，在草地上笑着。 你走过去抱起他，拍着他的肩膀。%SPEECH_ON%达库尔即将降临到我们，兄弟。你做的很好。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "愿黑暗永远永存。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OldGods.getImagePath());
				this.Characters.push(_event.m.Cultist.getImagePath());
				_event.m.OldGods.worsenMood(1.0, "失去镇静，诉诸暴力");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OldGods.getMoodState()],
					text = _event.m.OldGods.getName() + this.Const.MoodStateEvent[_event.m.OldGods.getMoodState()]
				});
				_event.m.OldGods.getBaseProperties().Bravery += -1;
				_event.m.OldGods.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.OldGods.getName() + "失去 [color=" + this.Const.UI.Color.NegativeEventValue + "]-1[/color] 决心"
				});
				local injury = _event.m.Cultist.addInjury(this.Const.Injury.Brawl);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Cultist.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Cultist.getBaseProperties().Bravery += 2;
				_event.m.Cultist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Cultist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_03.png[/img]You figure to let them do what they must, but a shadow draws over both your shoulders. The blackness spools before you until it\x0090s a great sheet blocking the world whole. In this infinite space there is a view of men dying, that of %cultist% and %oldgods%, and you see yourself amongst them. And more than that, you see a deed left undone, your work with and through Davkul unfinished. Just as you realize the omen, it snaps away and you find the two men ready to fight.\n\n Shouting, you split the godly and ungodly apart. %oldgods% leaves, but you spend a moment with %cultist%, leaning in and whispering.%SPEECH_ON%The light is only for a moment, brother, and its extinguishment is inevitable. Trust in Davkul, and await the darkness that is to come.%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他即将降临到我们。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.OldGods.getImagePath());
				this.Characters.push(_event.m.Cultist.getImagePath());
				_event.m.OldGods.worsenMood(1.0, "被剥夺了启发异教者的机会");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.OldGods.getMoodState()],
					text = _event.m.OldGods.getName() + this.Const.MoodStateEvent[_event.m.OldGods.getMoodState()]
				});
				_event.m.Cultist.worsenMood(1.0, "被剥夺了击溃古老神明的追随者的机会");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
					text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local cultist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				cultist_candidates.push(bro);
			}
		}

		if (cultist_candidates.len() == 0)
		{
			return;
		}

		local oldgods_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk" || bro.getBackground().getID() == "background.flagellant" || bro.getBackground().getID() == "background.pacified_flagellant" || bro.getBackground().getID() == "background.monk_turned_flagellant")
			{
				oldgods_candidates.push(bro);
			}
		}

		if (oldgods_candidates.len() == 0)
		{
			return;
		}

		this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		this.m.OldGods = oldgods_candidates[this.Math.rand(0, oldgods_candidates.len() - 1)];
		this.m.Score = (cultist_candidates.len() + oldgods_candidates.len()) * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist.getName()
		]);
		_vars.push([
			"oldgods",
			this.m.OldGods.getName()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
		this.m.OldGods = null;
	}

});
