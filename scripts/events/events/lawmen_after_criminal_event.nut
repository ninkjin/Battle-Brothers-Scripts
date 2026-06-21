this.lawmen_after_criminal_event <- this.inherit("scripts/events/event", {
	m = {
		Criminal = null,
		OtherBro = null,
		NobleHouse = null
	},
	function create()
	{
		this.m.ID = "event.lawmen_after_criminal";
		this.m.Title = "在路上…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_90.png[/img]有骑手登上了附近的小山，他们的轮廓看上去是黑色的像礁石一样矗立在山峰上。 因为没有办法看清他们是谁，你叫了几个兄弟埋伏起来。 你需要凭借伏击来保护自己否则你根本没有机会对抗这些骑手。 当被选中的雇佣兵在灌木丛中隐藏好，这些骑手也开始下山。 马蹄的轰隆声越来越大，但你却依然坚定地站着，希望用你勇敢的表现激励自己的兄弟。\n\n你看到佩戴着带有 %noblehousename% 纹章徽章的封臣。在他生后另外一个骑手正在拉着运货车还有几个带着镣铐的人在帮助着运货。 当着一行人到达你面前，他们的领头者站在马蹬上俯视着你们并且指着你说道。%SPEECH_ON%雇佣兵！在领主大人的权柄之下我们有权力去要求－这个犯罪者！－在你们身边的 %criminal% 交还给我。我知道我说的人就在你们之间。 他必须为自己的罪行付出代价。 立刻把他交出来然后你就会得到奖赏。%SPEECH_OFF%你转头吐了口唾沫。 你在问问题之前先向他点头致意。%SPEECH_ON%那么是哪位大人给的你权力呢？ 在这片土地上有很多大人但不是所有的大人都会付给我报酬。%SPEECH_OFF%这群执法者的队长重新坐在马鞍上。 他的双手交叉放在他的鞍子上，带着肃穆的权威坐在那上面。 看上去他对你的话并没有感到有趣语气也开始变得不快。%SPEECH_ON%私自窝藏逃犯的惩罚是死刑。 你们还有最后一次机会把他交给我否则你们将会面对于相当适合战争鬣狗的结局。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "如果我们为此事而斗争，战队就会遭殃。 这个人是你的。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们是不会放弃他的。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				if (this.World.Assets.getMoney() >= 1500)
				{
					this.Options.push({
						Text = "你确定这是一件不能用钱解决的事吗？",
						function getResult( _event )
						{
							return "F";
						}

					});
				}

				if (this.World.Assets.getBusinessReputation() > 3000)
				{
					this.Options.push({
						Text = "你知道你在威胁谁吗？大名鼎鼎的%companyname%！",
						function getResult( _event )
						{
							return "G";
						}

					});
				}
				else
				{
					this.Options.push({
						Text = "你有你要找的人的画像吗？ 让我看看。",
						function getResult( _event )
						{
							return this.Math.rand(1, 100) <= 50 ? "D" : "E";
						}

					});
				}

				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_53.png[/img]你根本没有战胜面前这群人的可能。 尽管这很痛苦，但你还是交出了 %criminal%。 当执法者把他锁起来的时候他对你狂吠咒骂，当他们把他和其他被绑的人一起扔进去的时候他疯狂的咒骂着你的名字。 这群执法者的队长驱赶着马来到你身边俯视着你。 他嘲笑着你并且向地上丢了一包硬币。 他的身体距离你很近并且在盔甲上面有一个很明显的缺口。 你可以把匕首准确地，刺进肋骨之间，然后将他的心脏戳穿。 这个过程会相当迅速。但做完这一切你也不会活太久，并且你所有的兄弟都会被杀死。\n\n所以你做出了正确的选择，你弯下腰捡起了那袋硬币，轻轻地把尊严和骄傲放在了泥地上，说了声谢谢。 执法的队伍很快就从来时的路返回。",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "我不能因为你而把整个团队置于危险中。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/asset_brothers.png",
					text = _event.m.Criminal.getName() + "离开了战队"
				});
				_event.m.Criminal.getItems().transferToStash(this.World.Assets.getStash());
				_event.m.Criminal.getSkills().onDeath(this.Const.FatalityType.None);
				this.World.getPlayerRoster().remove(_event.m.Criminal);
				this.World.Assets.addMoney(100);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + 100 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_10.png[/img]当执法官盯着你，等待回答时，你吹了一声尖锐的口哨。 队伍中有一半人从灌木丛中冒出来，从伏击处大叫着朝那支队伍发起冲锋。 拉车的战马受到惊吓将背上的骑手摔在地上，一群跟在后面的罪犯睁大眼睛不敢置信的看着面前的一幕。 一名执法者连忙逃跑，丢下他的部队。\n\n%randombrother% 把一个人从马鞍上拽了下来而另外一个兄弟用长矛刺入马的胸膛，将人和马都撂翻在地上。 当他的马惊恐万状地直立起来时队长从马上摔了下来。 虽然摔得很重，但他还是设法站了起来，结果被跃起的马蹄成功的踢中了头。 这是一个快速，凿实的死亡，队长的脸朝下埋在他的头盔里。\n\n其余的人都来站在他尸体旁用复仇的眼神看着你。",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "冲锋！",
					function getResult( _event )
					{
						_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "你杀了他们的一些人");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.NobleTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.TemporaryEnemies = [
							_event.m.NobleHouse.getID()
						];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Noble, this.Math.rand(80, 100) * _event.getReputationToDifficultyLightMult(), _event.m.NobleHouse.getID());
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_78.png[/img]这个队长用手指了其中一个士兵封臣。 他递给你一卷通缉令队长把它展开递给你。 这个人看起来的确和 %criminal% 很像，但是自从他和你上路成为雇佣兵之后脸上已经多了好几道疤通过现在的通缉令根本认不出他。 但是他们不会就这样买账的。 所以你决定撒谎。%SPEECH_ON%你们要找的人已经死了。 就像你说的，他是一名罪犯，我们看见他的时候他在偷我们的食物。在我们发现他时 %other_bro% 用剑刺穿了他的喉咙。%SPEECH_OFF%这个兄弟看着你，然后看了看这群执法者。他点头。%SPEECH_ON%的确是我做的。他就像一头猪一样吃我的面包我实在忍受不了就结果了他！ 我把幸免于难的面包保存起来给自己吃，谢天谢地。%SPEECH_OFF%执法者们互相窃笑。 他们的队长回头望着他们，他的目光使他们安静下来。 他回头看看你。 你现在明白为什么他们为什么闭上了嘴：他的眼睛是严厉的，死板的，凶狠的，深不见底的。 男人就这样盯着你看了将近半分钟然后点了点头拉了拉缰绳。%SPEECH_ON%很好，雇佣兵。谢谢你让我们了解了这个。%SPEECH_OFF%执法者们打点行装从他们来时的方向回去。 整个队伍都松了一口气你命令藏在灌木丛里的人出来。 前面还有很长的路要走希望不会再有这样的问题了。",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "Phew.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
				_event.m.Criminal.improveMood(2.0, "受到战队的保护");

				if (_event.m.Criminal.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Criminal.getMoodState()],
						text = _event.m.Criminal.getName() + this.Const.MoodStateEvent[_event.m.Criminal.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_78.png[/img]队长递给你一个画有 %criminal% 脸的通缉令。 的确，两者有相似之处。 但是这个男人呆在团队里面很长时间了脸上已经有了两道伤疤。 或许他们不会认出来？ 你让罪犯上前一步，虽然很紧张，但他还是照你说的做了。 你看着那位队长。%SPEECH_ON%这就是你要找的人吗？ 他们的确长得很像但是看看这些伤疤。 画里的人可没有这些。 然后再看看他的头发！ 画里面头发是直的，这个男人的头发显然是卷的。%SPEECH_OFF%你停了下来因为从这些听众的表情判断这根本就行不通。 这个队长拔出了剑。%SPEECH_ON%你认为我是好愚弄的人吗？把他们都杀了。%SPEECH_OFF%好吧，只能这样了。 在执法者还在冲锋的时候你尽可能地大声吹着口哨。 团里一半的人从灌木丛中涌出，像女巫一样又喊又叫。 突然的惊吓使马把身子直立起来，将骑手们扔进泥土里车夫甚至直接跑掉了，还带着两个非常困惑的罪犯。\n\n%randombrother% 带着长矛冲过混乱的战场。 他把长矛深深地刺进了那个队长的战马身体里，把人和马都撂倒在地上。 剩下的那些执法者聚集在他们的队长周围。 这名男子似乎在咆哮，他擦去脸上的血吐出了一颗牙齿。 露出残忍的笑容然后命令手下冲锋。",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "上啊！",
					function getResult( _event )
					{
						_event.m.NobleHouse.addPlayerRelation(this.Const.World.Assets.RelationAttacked, "你杀了他们的一些人");
						local properties = this.World.State.getLocalCombatProperties(this.World.State.getPlayer().getPos());
						properties.CombatID = "Event";
						properties.Music = this.Const.Music.NobleTracks;
						properties.IsAutoAssigningBases = false;
						properties.Entities = [];
						properties.TemporaryEnemies = [
							_event.m.NobleHouse.getID()
						];
						this.Const.World.Common.addUnitsToCombat(properties.Entities, this.Const.World.Spawn.Noble, this.Math.rand(80, 100) * _event.getReputationToDifficultyLightMult(), _event.m.NobleHouse.getID());
						this.World.State.startScriptedCombat(properties, false, false, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_04.png[/img]当你拿出一大袋克朗的时候那名队长冷酷的表情就消失不见了。 当你举起包时，他的手下交换着眼色。%SPEECH_ON%我们双方都没有必要在这上面浪费太多时间。 我这里有 %bribe% 克朗。 拿走它们然后离开。 或者留下来，自掘坟墓。你的选择呢，执法者。%SPEECH_OFF%似乎是感觉到同伴们的目光，队长仔细考虑了一下这个问题。 他审视了一下你的人，然后又回头看了看自己的。 他终于点头了一定时最终的结果不能让他满意。 他下了马牵着马走到你跟前好让你们两个能面对面地交易。 你微笑着把克朗递过去。%SPEECH_ON%交易愉快。%SPEECH_OFF%队长接过袋子把它系在马鞍边，将自己的剑放在挽具旁边好让手下看到。 他点了点头，但却没有对你回报以微笑。%SPEECH_ON%再过两个星期我女儿就要结婚了。 我想去那儿。%SPEECH_OFF%你点头，向这个毫无幽默感队长道别。%SPEECH_ON%愿她的丈夫仁慈，她的孩子们慈爱。%SPEECH_OFF%队长牵了牵马上的缰绳将它回到士兵们身边。 他们出发了，他们的马蹄声不断地踏向远方直到空气中只剩下风吹过的草的沙沙声。",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "这是已经是我所能做的了…",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
				this.World.Assets.addMoney(-1000);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + 1000 + "[/color] 克朗"
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_12.png[/img]你径直向这个队长走去，最后停在了你的人和他之间。 你把拳头放在屁股上，向那位执法者队长大喊，问他们是否知道 %companyname% 大名。你可以看到一些骑手在马鞍上移动着不安的身体，他们看着你的旗帜并且用手撑住马鞍保持平衡。 他们很快平静下来低声细语从他们的队伍中传出来。\n\n有一个人大喊着，问你是否真的剪掉了那些被你杀死的人的鼻子。 这当然不是真的，但是你却没理由去反驳他们述说的真实。 另一个人问 %randombrother% 是否在你的队伍中，并且他是否有一条耳朵项链而早餐是否吃人骨。 你抑制住了想笑的冲动，只是点头回应。 很自然地，谣言击垮了你的对手他们开始大叫着不想参与这场战斗。\n\n他们的队长告诉他们你们就是狗屎没有什么好怕的只要一冲锋就可以解决你们，但没有人听从他的命令。 最终，那名队长被迫折回，向他现在正在撤退的部队追去。\n\n被认为是食人族的兄弟挠了挠头走了过来。%SPEECH_ON%早餐吃人骨头？%SPEECH_OFF%一阵爆笑撕裂了整个战队很快就有一声非常应景的“不要吃我！”",
			Image = "",
			List = [],
			Characters = [],
			Banner = [],
			Options = [
				{
					Text = "不要试图挑战 %companyname%！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = _event.m.NobleHouse.getUIBannerSmall();
				this.Characters.push(_event.m.Criminal.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 10)
		{
			return;
		}

		if (this.World.getTime().Days < 30 && this.World.Assets.getOrigin().getID() == "scenario.raiders")
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.FactionManager.isGreaterEvil())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.18)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		if (brothers.len() < 2)
		{
			return;
		}

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.killer_on_the_run" || bro.getBackground().getID() == "background.thief" || bro.getBackground().getID() == "background.graverobber" || bro.getBackground().getID() == "background.raider" || bro.getBackground().getID() == "background.nomad")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.NobleHouse = this.getNearestNobleHouse(this.World.State.getPlayer().getTile());

		if (this.m.NobleHouse == null)
		{
			return;
		}

		this.m.Criminal = candidates[this.Math.rand(0, candidates.len() - 1)];

		do
		{
			this.m.OtherBro = brothers[this.Math.rand(0, brothers.len() - 1)];
		}
		while (this.m.OtherBro == null || this.m.OtherBro.getID() == this.m.Criminal.getID());

		this.m.Score = candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"criminal",
			this.m.Criminal.getName()
		]);
		_vars.push([
			"other_bro",
			this.m.OtherBro.getName()
		]);
		_vars.push([
			"noblehousename",
			this.m.NobleHouse.getName()
		]);
		_vars.push([
			"bribe",
			"1000"
		]);
	}

	function onClear()
	{
		this.m.Criminal = null;
		this.m.OtherBro = null;
		this.m.NobleHouse = null;
	}

});

