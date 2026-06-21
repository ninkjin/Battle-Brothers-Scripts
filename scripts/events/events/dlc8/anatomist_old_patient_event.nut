this.anatomist_old_patient_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_old_patient";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_77.png[/img]{%townname%的居民大多把你和解剖学家视为迷途的魔鬼。但突然，一个男人从门廊上走下来，跨过马路走向解剖学家%anatomist%，他们直立着身体，迈着得意洋洋的步伐，脸上带着灿烂的微笑。他握住解剖学家的手并开始热情洋溢地寒暄。%SPEECH_ON%我X，我就觉得你总有一天会回来的！你不认识我了吗？多年以前我们还都年轻。当时我在背上背着一个大麻袋，而你把它割了下来，从那一天起我的整个生活都变得更好了！赞一下，等我一下别动，我马上回来！%SPEECH_OFF%男人很快回到了家。你看着%anatomist%，他说他认得这个男人：他的脊柱上长了一个巨大的肿瘤，而解剖学家曾经用镊子、切割刀和很多布条成功地将其切除。他遗憾地说，自己没有保留这个肉质的物体供以研究，但在那时他是一种不同的医生。男人拿着一把武器回来，伸出手来给你。%SPEECH_ON%我以前很健康，去打过战争，也很不错，但你知道吗，生活在不断地改变。我看到你和这个佣兵在一起，所以我想你的情况也发生了变化。请，拿走它吧。%SPEECH_OFF%当解剖学家犹豫时，你自己拿起了武器，一面错失了这个天掉下来的馅饼。你感谢男人，他再次握住%anatomist%的手，然后告别。当他离开时，解剖学家凝视着他。%SPEECH_ON%既然我完全想起了他，我们可以对他进行实验。他背部的那个肉块可能会再次出现，我可以...只是...打开他看看...%SPEECH_OFF%你阻止解剖学家对当地人进行任何解剖的幻想，重新上路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你可以在别处找到大量的黑暗大典来研究。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local weapons = [
					"weapons/arming_sword",
					"weapons/winged_mace",
					"weapons/warhammer",
					"weapons/fighting_spear",
					"weapons/fighting_axe",
					"weapons/military_cleaver"
				];
				local weapon = this.new("scripts/items/" + weapons[this.Math.rand(0, weapons.len() - 1)]);
				this.World.Assets.getStash().add(weapon);
				this.List.push({
					id = 10,
					icon = "ui/items/" + weapon.getIcon(),
					text = "你获得了" + weapon.getName()
				});

				if (this.Math.rand(1, 100) <= 75)
				{
					_event.m.Anatomist.improveMood(0.75, "看到了过去工作成功的活生生的证明。");
				}
				else
				{
					_event.m.Anatomist.improveMood(0.5, "一位老病人感谢他的医疗帮助。");
				}

				if (_event.m.Anatomist.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				town = t;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 5;
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
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Town = null;
	}

});

