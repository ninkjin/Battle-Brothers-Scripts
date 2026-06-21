this.undead_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.crisis.undead_intro";
		this.m.Title = "露营时…";
		this.m.Cooldown = 1.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_84.png[/img]你低下头准备打个盹。\n\n 你翻个身，丝质的被单溜了出去。 有鸟飞过镶有象牙的窗棂。 仿佛有一种浸在前所未有的优雅芳香里的声音侵入你的耳朵。%SPEECH_ON%你醒啦。%SPEECH_OFF%一个女人翻过身，沿着你胸前纤纤玉指轻轻向下游离，复又逆行而上攫取你的下巴。 轻盈而又美丽，阳光映照在她光洁的脸上，绿宝石般的眼眸熠熠生辉。 她向你索吻。 你狂乱地滚下床，四下张望。 她攥着床单跪在床上，非常疑惑。%SPEECH_ON%怎么了？你要去哪我的帝王？%SPEECH_OFF%抬起头，你看到一个天花板，那么宽广你甚至看不清可称为艺术品的精致花边。 你打开一扇门，走到阳台上。 难以置信的高耸群楼，红，白和金色的旗帜，一直延伸到目之所及凝成黑色形状的奇点。 穹顶，喷泉，巨大的拱门，以及高高耸立的雕像，如此雄伟好像它们就像统领士兵一样指挥着建筑群。 每个屋顶上都有一个花园，比你在永恒的春天里看到的任何自然形成的花园都要更大，更壮观。 这时两个男人从你身边冒出来，放出提着的笼子里的鸽子。 鸟儿们拼命四散飞出去，在你脚下发出尖啸。 周围的人群雀跃着挥舞起旗帜。%SPEECH_ON%他们爱戴他们的帝王。%SPEECH_OFF%那个女人出现在门口。%SPEECH_ON%去迎接他们吧。%SPEECH_OFF%你低头一看，只见一群士兵正沿着大路行进，每个人都和队友的步调一致，靴子踏着地面发出整齐的步伐声。 囿于镀金的头盔里的是坚定的神色，长长的长柄武器向上泛起着阳光般的色泽，仿佛他们要用财富本身来击败敌人。%SPEECH_ON%他们整装待发。 准备迎击远大的未来，并征服它。%SPEECH_OFF%女人待你身边。 温和地笑着，挽着你的胳膊。 无论这个新现实是什么，你都准备好接受它了。 你把她的脸颊握在手心里，正准备拥她入怀，但从下面传来清晰响亮的惨叫却地盖过了一切。 你往下看了一眼，曾经列着整齐划一队形已经不复存在。 远处，一座大山正在爆发，喷出大量的红色火焰和满天的巨大的灼热灰烬，炼狱很快涌进城市。 建筑物分崩离析，花园被火焰吞噬，人们…人们尖叫着。 逃跑，但是没人能逃脱炼狱。 士兵们尖叫着脱离了阵型。 随着一股灼热、汹涌的热浪，很快你就看到居民们融化在这股热浪之中，士兵们变成了金属像，原本保护他们的盔甲也被烧焦，而没有盔甲保护的人群直接燃烧起来。 女人在你身边尖叫起来。%SPEECH_ON%噢，太恐怖了！太恐怖了！ 你看到了吗？ 但没关系，明白吗？ 完全没关系。 看着我，看着我！%SPEECH_OFF%那个女人伸出手抱住你。 她那曾经柔美的面容已经成了焦黑的薄片，头顶业燃烧枯涸，牙龈和牙齿都在破碎离析。如此，她仍然咧开嘴笑着。%SPEECH_ON%我们会复兴的，帝王！ 我们…终将…重拾…荣光！%SPEECH_OFF%她的颅骨崩溃了，身体也崩塌成一堆燃烧着的骨头。\n\n 你一个激灵醒来，发现 %randombrother% 在摇你。%SPEECH_ON%先生，醒醒，我们在这碰到一群难民说死者从地里复活起来，见一个杀一个！%SPEECH_OFF%女人的脸在你眼前一闪而过。 带着可怕的伤疤，但这没阻止她的笑容。%SPEECH_ON%帝国复生了。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战争就要来了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.Statistics.hasNews("crisis_undead_start"))
		{
			this.m.Score = 6000;
		}
	}

	function onPrepare()
	{
		this.World.Statistics.popNews("crisis_undead_start");
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

