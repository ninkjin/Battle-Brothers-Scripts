this.civilwar_savagery_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_savagery";
		this.m.Title = "在路上…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]{当你沿着一条路行进时，你遇到一个 %noblehouse% 的军官率领一群人在屠杀。 他们聚集了一个小村庄的村民，准备将他们全部杀掉。 其中一个村民向你呼喊，乞求你阻止他们。 军官瞥了你一眼。 他没有足够的人手来阻止你，你也没有足够的人手来阻止他，但是双方都有足够的人手来确保对方的行动会失败。%SPEECH_ON%少管闲事，雇佣兵。 这对你没有任何好处。 继续走你的。%SPEECH_OFF% | 当你遇到一群手持 %noblehouse% 旗帜的人时，%companyname% 的行军突然中断了。不幸的是，他们做的不仅仅是举着旗帜－他们把附近村庄的农民排成一排，准备把他们全部杀光。 贵族手下的军官盯着你看。%SPEECH_ON%我劝你少管闲事，雇佣兵。 我建议继续走你的。%SPEECH_OFF% | 你来到一间小屋。 几个 %noblehouse% 的手下在门外站岗。 你可以听到里面传出一个男人和一个女人的尖叫声。 军官走出来，看到了你。 他整理了一下自己的仪容仪表，甚至把头发梳到了后面，然后叫你走开。%SPEECH_ON%少管闲事，佣兵。 继续走你的。%SPEECH_OFF% | 你来到一座古老的神明圣殿。 几个 %noblehouse% 的手下正在用木板封门，而他们的军官则在火把周围挥手致意。 人们在庙宇里尖叫着求饶。 你挑挑眉毛，军官就发现了。%SPEECH_ON%嘿，佣兵。是你 走你的。少管闲事。%SPEECH_OFF% | 当你走下一条路的时候，你遇到了一个 %noblehouse% 的军官。他让几个女人站在树下的凳子上。 她们的脖子上挂着绳子，眼里流着泪水。 军官瞪着你。%SPEECH_ON%不要有任何英雄的想法，佣兵。 这不关你的事。%SPEECH_OFF% | 行进中，你突然听到孩子们的尖叫声。 他们的尖叫声引起了你的注意，你发现他们在路的一边，而在另一边，他们的父母跪在十几个行刑者的剑下。 一个 %noblehouse% 的军官站在附近，骄傲地举着他贵族家族的旗帜。 他凝视着你。%SPEECH_ON%噢，佣兵。你是来观看行刑的吗？ 我希望如此，你最好不要插手。 这与你无关。%SPEECH_OFF% | 当你需要小便的时候，你会爬上附近的一座小山，以获得一点隐私。 遗憾的是，这种情况不会发生。 对面的山坡上站着一些人，他们是 %noblehouse% 的人，听从他们的军官的命令，他们蹲伏在离你小便的地方不远的地方。 军队正在把妇女从附近山坡上的几间小屋里围起来。 村子里的人已经被杀死了，死在草地上，到处都是。 但是在你这个位置上看，那些尸体只不过是一些斑点。\n\n 军官抬头看着你。%SPEECH_ON%你好，佣兵。很棒的一天，不是吗？%SPEECH_OFF%他一定看到了你脸上令人不安的表情。%SPEECH_ON%嘿，听着。不要有任何英雄主义的想法，好吗？ 继续走你的。 我以前见过这种表情，如果你不把它收起来，我们大家都会有麻烦。%SPEECH_OFF% | 当你走在一条小路上时，你听到几只猎犬的吠叫声。 显然，一群来自 %noblehouse% 的人已经清理了一些茅舍，剩下的只有躲在狗窝里的可怜杂种狗。 外面站着几个拿着火把的士兵，随时准备点燃所有的狗窝。 一个军官站在附近，脸上露出可怕的笑容，虽然这个表情在看到你后很快就消失了。%SPEECH_ON%噢，你喜欢狗还是什么？ 别那样看着我。 你最好别管这件事，佣兵，不然我就把你当成这里的狗一样对待。%SPEECH_OFF% | 在战争时期，道路往往是最糟糕的地方，他们的附近总是充斥着死亡。 你发现几个 %noblehouse% 的士兵在小路旁闲逛，盯着一个他们绑在柴堆上的男人。 当你走过去的时候，士兵们的军官转过身来看你。%SPEECH_ON%嘿，如果你不喜欢你所看到的，那就不要管。 这是战争，你想要什么？ 现在离开这里，我们要生火了。%SPEECH_OFF% | 当你沿着一条偏离主干道的小路艰难跋涉，避开战争可能造成的大屠杀时，你发现几个 %noblehouse% 的士兵正在折磨一个人。 他们点燃了用皮革包裹的火把，让燃烧着的碎片落到他们可怜的囚犯身上。 他尖叫着要求宽恕，但是他们肯定没有宽恕他。 然而，看到你，他大声呼救，乞求帮助。 其中一个士兵转向你。%SPEECH_ON%就像你看到的？ 我父亲创造了这种酷刑。 让火热的皮革片滴在他们身上。 比简单的小火苗好多了。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "我们必须结束这种疯子的行为。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(4);

						if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "这里不是我们该管的地方。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_79.png[/img]{随着你一声令下，%companyname% 决定进行救援。 %noblehouse% 的人瞬间就被你的手下砍翻了。 获救的村民一边哭一边感激着你，几乎要亲吻你的脚。 你叫他们快跑，以免贵族军队的其他人出现。 | 你叫 %companyname% 的人们动作快一点。 %noblehouse% 的士兵试图保护自己，但是他们在生命的最后几分钟准备杀害无辜的人，而不是保护自己不受敌人伤害。 他们像稻草一样一个个倒下了。 获救的村民迅速逃走，他们喊着谢谢，却没有留下来干别的。 | 今天 %companyname% 绝不会支持这种暴行。 你命令雇佣兵杀死 %noblehouse% 的士兵，你手下动作非常快。 获救后，农民们表示感谢。 你告诉这些村民迅速离开这里，因为很明显，这片土地对任何人来说都不再安全。 | 你的良知战胜了你的理性。 你命令 %companyname% 的人迅速出击。 %noblehouse% 的士兵对真正的战斗毫无准备，他们就像被割草一样死去。 村民们在逃走之前对你的救援千恩万谢。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "今天，在这里做了一件大好事。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "杀了一些他们的人");
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(0.5, "帮助拯救了一些农民");

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
			ID = "C",
			Text = "[img]gfx/ui/events/event_79.png[/img]{你命令你的手下去拯救村民，但是 %noblehouse% 的士兵已经准备好了。 他们没有武器，人手也不足，但是他们有几匹快马。 毫无疑问，你在这里的行为会被贵族老爷知道的一清二楚。 但谁在乎呢，相比之下，获救的村民们是永远感激你的。 | 你命令 %companyname% 的人迅速干掉士兵。 有几个士兵很快就倒下了，但是军官设法骑上了一只快马。 这是一匹很快的马。 如果你自己有一匹马，你可能能抓住它，但你没有。 获救的农民非常感激，但这并不会让你和 %noblehouse% 的关系变好。 | 你没发现附近有几匹马在闲逛。 虽然一些雇佣兵很快就被杀死了，但是你的手下却无法追上军官，军官骑着快马跑了，这将会损害你在贵族那边的声誉。 并不是说你不在意他们的想法。 相比之下，那些村民们几乎要哭出来以表示感谢了。 你告诉他们快点离开这里。 谁知道这些天在这片土地上会出现什么样的危险。}",
			Banner = "",
			Characters = [],
			List = [],
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
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationOffense, "攻击了他们的一些人");
				this.World.Assets.addBusinessReputation(this.Const.World.Assets.ReputationOnContractSuccess);
				this.List.insert(0, {
					id = 10,
					icon = "ui/icons/special.png",
					text = "战队获得了声望"
				});
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(0.5, "帮助拯救了一些农民");

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
		if (!this.World.FactionManager.isCivilWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		local nobleHouses = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.NobleHouse);
		local candidates = [];

		foreach( h in nobleHouses )
		{
			if (h.isAlliedWithPlayer())
			{
				candidates.push(h);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.NobleHouse = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"noblehouse",
			this.m.NobleHouse.getName()
		]);
	}

	function onClear()
	{
		this.m.NobleHouse = null;
	}

});

