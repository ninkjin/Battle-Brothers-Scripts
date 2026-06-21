this.flagellant_vs_monk_event <- this.inherit("scripts/events/event", {
	m = {
		Monk = null,
		Flagellant = null
	},
	function create()
	{
		this.m.ID = "event.flagellant_vs_monk";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]营火闪耀着耀眼的光芒，照耀着那些身着鲜艳橙色衣服者的面庞，仿佛他们自己就是燃烧着的木头。\n\n 就是在这里，你发现 %monk% 和 %flagellant% 相互交谈。 他们的讨论的是，一个很简单的事。 僧侣恳求苦修者把鞭子放下。 虽然你没必要介入，但你不得不承认，用一种被美化的仪式摧残自己的身体并不是最好的生活方式。 但是随后苦修者用一些话来反驳，让你们两个人停了下来。 这是一个精心设计的短语，如果你认为它可以证明这家伙的个人习惯是正确的，你就会尽可能快地把这个概念从你的头脑中踢出去。 非常的让人不安，这家伙说的太轻描淡写了。 如此抚慰人心的声音竟能温暖地裹在伤痕累累的躯壳里。 什么造就了它？\n\n 这个僧侣结结巴巴地说了一会儿，然后把手放到了那个被鞭笞的人的肩膀上，按着他，让他们互相对视。 他轻声细语，这些话会让你耳朵发痒，但却不会大声地说出它们的真正含义。 你只能假设，他们的目的是，再次说服苦修者过上更好，更少暴力的生活。\n\n 但是，再一次的，苦修者开始回应，然后他们继续开始辩论。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这真带劲儿。咱们看看接下来会发生什么。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "好吧，你们闹够了。我们有很多实际的事要做。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Characters.push(_event.m.Flagellant.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]决定让他俩继续讨论，你走开了一段时间。 当你回来的时候，你发现苦修者坐在僧侣旁边。 两个人在一根圆木上来回地看了看，双手合十，祈祷着，低声说着神圣的话语，张开了嘴唇。 你没有必要去听他们在说什么，因为这本身就是一个令人欣慰的景象。 当你对如何侍奉神明不以为然的时候，你会不由自主地感到一丝欣慰，因为苦修者放下了折磨自己的工具。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "愿这人现在平静下来。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Characters.push(_event.m.Flagellant.getImagePath());
				local background = this.new("scripts/skills/backgrounds/pacified_flagellant_background");
				_event.m.Flagellant.getSkills().removeByID("background.flagellant");
				_event.m.Flagellant.getSkills().add(background);
				_event.m.Flagellant.m.Background = background;
				background.buildDescription();
				this.List = [
					{
						id = 13,
						icon = background.getIcon(),
						text = _event.m.Flagellant.getName() + "现在是一个被平息的苦修者"
					}
				];
				_event.m.Monk.getBaseProperties().Bravery += 2;
				_event.m.Monk.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Monk.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]决定让他俩继续讨论，你走开了一段时间。\n\n你回来的时候，僧侣光着身子，眼里含着泪水。 他的体型像个懦夫，但是面色坚毅，仿佛这就是他想要的。 他吸了一口气，直起身子，把手腕甩过肩膀。 苦修者的鞭子握在手里，你听到皮鞭打在僧侣背上的声音。 他把鞭子衰远，鞭刃和倒刺撕裂血肉的声音在你耳中回响。 苦修者自己什么也没说。 他在僧侣的旁边坐了下来。 他凝视着大地，但他的眼睛里几乎没有一丝生命的微光，尽管你肯定能看到他在殴打自己时，生命的血液从他的背部流出。\n\n你又一次离开，但脚下的草地却没有了那种嘎吱嘎吱的声音，空气中弥漫着一股金属的味道。 Little leather snickers follow you all the way back to your tent.",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一个自虐者会发现恐怖的真谛。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Monk.getImagePath());
				this.Characters.push(_event.m.Flagellant.getImagePath());
				local background = this.new("scripts/skills/backgrounds/monk_turned_flagellant_background");
				_event.m.Monk.getSkills().removeByID("background.monk");
				_event.m.Monk.getSkills().add(background);
				_event.m.Monk.m.Background = background;
				background.buildDescription();
				this.List = [
					{
						id = 13,
						icon = background.getIcon(),
						text = _event.m.Monk.getName() + "现在是僧侣转变成的苦修者"
					}
				];
				_event.m.Flagellant.getBaseProperties().Bravery += 2;
				_event.m.Flagellant.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Flagellant.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+2[/color] 决心"
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

		local flagellant_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.flagellant")
			{
				flagellant_candidates.push(bro);
			}
		}

		if (flagellant_candidates.len() == 0)
		{
			return;
		}

		local monk_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.monk")
			{
				monk_candidates.push(bro);
			}
		}

		if (monk_candidates.len() == 0)
		{
			return;
		}

		this.m.Flagellant = flagellant_candidates[this.Math.rand(0, flagellant_candidates.len() - 1)];
		this.m.Monk = monk_candidates[this.Math.rand(0, monk_candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"monk",
			this.m.Monk.getName()
		]);
		_vars.push([
			"flagellant",
			this.m.Flagellant.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Monk = null;
		this.m.Flagellant = null;
	}

});

