this.civilwar_deserter_event <- this.inherit("scripts/events/event", {
	m = {
		NobleHouse = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.civilwar_deserter";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_02.png[/img]{你在路上遇到两个 %noblehouse%的士兵，他们正在架设什么，那个东西似乎是他们自己的。 那人的头被套在绞索里，但一看见你，他就大声喊叫。%SPEECH_ON%他们想让我杀孩子！ 这就是我不服从命令的下场？%SPEECH_OFF%%randombrother% 带着也许我们能做点什么的表情看着你。 | 你发现两个 %noblehouse%的人把一个蒙着眼睛的人绑起来。 出于好奇，你问他犯了什么罪。 其中一个行刑者笑了。%SPEECH_ON%他被命令烧毁一个小村庄，但他拒绝了。 你不能拒绝贵族，不然就得被处死。%SPEECH_OFF%被蒙住眼睛的人吐了口唾沫。%SPEECH_ON%你们见鬼去吧。 至少我会一直保持我的尊严与荣誉。%SPEECH_OFF% | 在小路的一边，你看到一个男人把一根绳子吊在一根树枝上。 第二个人把一个被蒙住眼睛的囚犯往前推，把绞索套在他的脖子上。 行刑者看到你，举起手来。%SPEECH_ON%退后，佣兵们。 这个人将在 %noblehouse% 的命令下被处死。如果你干涉，你也会被以同样的方式对待。%SPEECH_OFF%囚犯大叫起来。%SPEECH_ON%他们想让我谋杀妇女和儿童。 这是我无视这些命令所付出的代价，但至少我会带着完整的荣誉离开这个可怕的世界。%SPEECH_OFF% | 小路通向一个戴着镣铐的男人，他坐在草地上，两个男人愤怒地在树枝上系着绳子。 他们试了几次，然后点了点头，放了一个桶在下面，大概是让囚犯站在上面。 囚犯看到你后喊道。%SPEECH_ON%佣兵们，救救我！我所做的一切就是拒绝把一座神殿夷为平地！%SPEECH_OFF%一个行刑者踢了他一脚。%SPEECH_ON%那神殿是叛军的住所，叛军杀死了我们的军官，你这个傻瓜！ 你比任何人都更应该被这样处死。 如果 %noblehouse% 想要赢得这场战争，我们就不能有你们这样的老鼠在我们中间。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "放了那个人！",
					function getResult( _event )
					{
						local roster = this.World.getTemporaryRoster();
						_event.m.Dude = roster.create("scripts/entity/tactical/player");
						_event.m.Dude.setStartValuesEx([
							"deserter_background"
						]);
						_event.m.Dude.setTitle("尊者(the Honorable)");
						_event.m.Dude.getBackground().m.RawDescription = "曾经是一支贵族军队的士兵，%name% 的人几乎因为拒绝命令而被绞死，直到被营救到你的 %companyname%。";
						_event.m.Dude.getBackground().buildDescription(true);

						if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
						{
							_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
						}

						if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
						{
							_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
						}

						if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
						{
							_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
						}

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
					Text = "这不关我们的事。",
					function getResult( _event )
					{
						return "D";
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
			Text = "[img]gfx/ui/events/event_02.png[/img]{你命令行刑者放了他。 他们笑着拔出了剑，但这是他们做的最后一件事，因为 %companyname% 在一瞬间释放出了怒火，短短几秒就把两名士兵砍翻了。 囚犯感谢你，作为他获救的回报，他愿意在战场上为你效劳。 | 你不能容忍这样的处决，于是你命令 %companyname% 的人去干预。 他们迅速拔出武器，扑向士兵，不一会儿就把他们杀死了。 被释放的囚犯在你面前跪下了。%SPEECH_ON%求求你，让我加入你们的队伍吧，这是我唯一能做到的了！%SPEECH_OFF% | 你命令 %companyname% 去营救那个囚犯。 那个囚犯的命运瞬间逆转了，认为自己是行刑者的人突然被砍死。 这样的命运轮回带来一阵狂野的尖叫。 如果那些人没有逃跑的话，你的手下会做的更加干脆利落，但是，一个求生欲望强的人是很难杀的。 与此同时，囚犯倒在你的脚下，向你效忠。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "欢迎加入 %companyname%！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "回你自己家去吧，士兵。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationUnitKilled);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_02.png[/img]{你命令去营救那个囚犯。 其中一个对方士兵立刻自信的拔出了剑，随后就因为这错误的自信被砍翻了。 另一个士兵，看起来头脑清醒，已经跑掉了。 毫无疑问，他会告诉 %noblehouse% 你们在这的所作所为。 获救的囚犯来见你，单膝跪地向你鞠躬。%SPEECH_ON%谢谢你，佣兵。今天我的命就交给你了。%SPEECH_OFF% | 在你看来，这两个行刑者不太可能放弃他们的贵族阵营而加入你。 但是，如果你放了那个囚犯，他很可能会站在你这边与你一同作战。 所以你下令营救他。 其中一个敌方士兵拔出他的剑，宣誓效忠 %noblehouse%。这是他这辈子做的最后一件事了。 另一个士兵逃走了。 也许你本可以招募他，但考虑到他的搭档被迅速杀害，他不太可能回来。 他很可能会把你在这里的行为告诉他的上级。\n\n 你去找被释放的囚犯。 他连忙鞠了一躬，提出要加入 %companyname%。 | 你命令士兵放了那个人。 一个人大笑起来，只是收紧套在他脖子上的绞索，然后开始吊起他。%randombrother% 跳到前面，将行刑者击倒在地。 当第二个士兵逃跑时，他摔了一跤，没追上。 毫无疑问，那个逃兵会告诉他的指挥官你在这里做了什么。\n\n 获释后，被释放的囚犯亲自来向你鞠躬，表示将对你效忠来作为报答。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "欢迎加入 %companyname%！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "回你自己家去吧，士兵。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "杀了他们的一个人");
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_02.png[/img]{虽然你不能因为一个人无视他的命令而责怪他，但是这个决定是他的，不是你的，就像他的惩罚是他的，不是你的。 你命令 %companyname% 继续前进。 | 你没有理由把 %companyname% 牵扯进那些争吵不休的贵族的政治活动中。 囚犯点头，表示理解。 在他们把他直接吊起来之前，他把头抬得很高。 | 行刑者们看了你一眼，也许感觉到你可能会介入，彻底毁掉他们的一天。 相反，你告诉囚犯，是他的选择让他来到这里。 他郑重地点头。行刑者们争先恐后地绞死他，以免这个穿过他们道路的危险陌生人突然改变心意。}",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "他的战斗不是我们的战斗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.deserter")
					{
						bro.worsenMood(0.75, "你没有帮助一个逃跑的军官");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
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

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local bestDistance = 9000;
		local bestTown;

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= bestDistance)
			{
				bestDistance = d;
				bestTown = t;
				break;
			}
		}

		if (bestTown == null)
		{
			return;
		}

		this.m.NobleHouse = bestTown.getOwner();
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
		this.m.Dude = null;
	}

});

