this.golden_goose_event <- this.inherit("scripts/events/event", {
	m = {
		Observer = null
	},
	function create()
	{
		this.m.ID = "event.location.golden_goose";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_125.png[/img]{船只搁浅在长满树木的地方，有些树木已经从船的裂缝中长出来。据您所知，几英里之内既没有海洋也没有河流。%observer%走过来，在看到这一情境时停了下来。%SPEECH_ON%老天爷，那是一艘船吗？%SPEECH_OFF%您叹了口气，让伙伴们留在这里，只带着一个非常敏锐的雇佣兵去看看。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们看看里面到底有什么秘密。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "它现在没有什么研究的价值了。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_125.png[/img]{你走进船舱的深处。里面除了一个中间插着一把斧头的树桩，一片空荡。%observer%看着它。%SPEECH_ON%这是一个斧头。%SPEECH_OFF%你点了点头，并且确认确实是一个斧头。但它的金属上有着一种金黄色的纹理。走近树桩，你看到一缕缕的余烬从树楔里飘散。%observer%拍了拍你的肩膀，指着黑暗的角落说。%SPEECH_ON%骷髅。死了的。%SPEECH_OFF%你勉强能看到苍白的骨骼。走近一看，发现身上穿的是皇室的衣袍。一只手拿着一只破碎的啤酒角，另一只手拿着一条发霉的面包。他的夹克被木屑撕成碎片。仔细一看，你发现一些木头深深扎进了他的脑袋里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "检查残留部分。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "让我们离开这里。",
					function getResult( _event )
					{
						if (this.World.State.getLastLocation() != null)
						{
							this.World.State.getLastLocation().setVisited(false);
						}

						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_125.png[/img]{既然骷髅及他的啤酒和面包没有任何变化，你只好不管它了。然而，斧头锋利的头引起了你的注意。%observer%走向树桩和闪闪发光的楔子。他试图把它取出来，但没有成功，于是他愤怒地后退并踢了一脚。树桩裂成两半，雇佣兵突然上下颠倒，斧头向天花板射出，你可以听到它咯咚一声落到了右舷。碎屑和烟雾悠悠飘荡。雇佣兵起身拍拍自己的衣服。%SPEECH_ON%这是怎么回事？%SPEECH_OFF%你安静地示意他，指向树桩原来的地方，一个小小的金鹅弯腰坐着。金属的光泽闪烁着。你曾听说过金色的鹅的故事，但从未想过它们会超越传说!}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是真的吗？",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_125.png[/img]{%observer% 踉跄着向前走。%SPEECH_ON%将军，您在干什么？%SPEECH_OFF%您挥了挥手，捡起了金色的鹅。双手捧着，感觉它有些暖和，也没有爆炸或融化你的脸。你能感觉到它的金属在你的手指上轻微地波动。甚至还在变大？珍宝安全地藏在你的肘下，你想知道为什么骷髅没有好好保管它。%observer% 走了过来，触摸了金色鹅的头，但很快就缩了回去。你问他是不是被烧了。雇佣兵撅起了嘴唇。%SPEECH_ON%真的，将军？这不明显吗？%SPEECH_OFF%他把手指放到嘴里。你告诉他不要对他的指挥官那么暴躁，否则你会将鹅扔向他，看看它是否会把他像骷髅那样迅速干掉。男人耸耸肩。%SPEECH_ON%哦，看看这个被闪亮玩意选中的男人，把刀放在翅膀下让它封你，或者上天有多少种玩法，你可以将其放在头上自称国王？%SPEECH_OFF%你看着鹅。一滴红色的血沿着它的长度流下来，变成了金色，并带着微小的声响掉在地上。你捡起来咬了一口。黄金在你的牙齿中发出令人满意的声音，然后将它扔给了 %observer%。这一次没有烫伤他，你意识到你可能已经发现了真正的黄金鹅故事！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这些故事是真的！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Observer.getImagePath());
				this.World.Assets.getStash().makeEmptySlots(1);
				local item;
				item = this.new("scripts/items/special/golden_goose_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getBackground().isNoble() && !bro.getSkills().hasSkill("trait.bright") && !bro.getSkills().hasSkill("trait.short_sighted") && !bro.getSkills().hasSkill("trait.night_blind"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Observer = candidates[this.Math.rand(0, candidates.len() - 1)];
		}
		else
		{
			this.m.Observer = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"observer",
			this.m.Observer != null ? this.m.Observer.getNameOnly() : ""
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Observer = null;
	}

});

