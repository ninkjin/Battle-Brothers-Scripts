this.manhunters_origin_capture_prisoner_event <- this.inherit("scripts/events/event", {
	m = {
		LastCombatID = 0,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.manhunters_origin_capture_prisoner";
		this.m.Title = "战斗之后…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "Nobles",
			Text = "[img]gfx/ui/events/event_53.png[/img]{幸存者艰难的爬离你。他在咕哝这什么。 你听不清，但语言还是很明显的：他知道你是谁，你是什么。 | 战斗结束了，你在战场找到一个幸存者。 他有点伤但是还有用。 | %SPEECH_ON%奴隶混账，拿出本事吧。%SPEECH_OFF%尽管是最后一个人，这个北方人依然能战斗。 他将来可能会做得很好，在 %companyname%。 | 你找到最后一个人，受伤了，但还活着。 他是个北方人而且挂着锁链会很好看。 或许在南方卖到个好价钱，又或者在前线当炮灰？ | 北方士兵被斩到最后一人，一个苍白的人看起来在失败中沉浸多久。%SPEECH_ON%南方杂种，你们这些“镀金者”狗娘养的。 来啊，给我个武器，我会给你展示北方人怎么战死！%SPEECH_OFF%不得不说你喜欢他的精力。 比起在坟墓里，或许作为一个负债者加入战队更合适？}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "将他作为镀金者的负债者这样他可以赢得他的救赎。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "战败被俘");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要他。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "以前是一个忠于贵族的士兵，他的战队被你们的人屠杀了，而 %name% 成为了负债者。 没花多少时间他就精神崩溃了，强迫他为你而战。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Civilians",
			Text = "[img]gfx/ui/events/event_53.png[/img]{幸存者艰难的爬离你。他在咕哝这什么。 你听不清，但语言还是很明显的：他知道你是谁，你是什么。 | 战斗结束了，你在战场找到一个幸存者。 他有点伤但是还有用。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "将他作为镀金者的负债者这样他可以赢得他的救赎。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "战败被俘");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要他。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "%name% 在和你的人的战斗中勉强幸存下来后成为了负债者。 他的精神崩溃了，他被迫为你而战，这样做他就可以偿还镀金者的债务了。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Bandits",
			Text = "[img]gfx/ui/events/event_53.png[/img]{幸存者艰难的爬离你。他在咕哝这什么。 你听不清，但语言还是很明显的：他知道你是谁，你是什么。 | 战斗结束了，你在战场找到一个幸存者。 他有点伤但是还有用。 | 孤独的土匪幸存者呼喊着旧神，你手中拿着锁链，心想合不合他的脖子。 | %SPEECH_ON%这是当土匪的惩罚吗？%SPEECH_OFF%北方人看着你掂量手中的锁链问道。 你还不太确定你会怎么处理他，但还是回答了。%SPEECH_ON%这不是惩罚，这只是生意。%SPEECH_OFF% | 土匪试着躲起来，但是作为最后的幸存者他就像片鲜红的战场上的白兔子。 他呼喊着旧神不会容忍你这样的人。你耸耸肩。%SPEECH_ON%旧神们现在不在这，不是吗？%SPEECH_OFF%然后你拿出了锁链绕在他的脖子上。%SPEECH_ON%不过我在想，你会愿意为了和你的其中一个神换位置付出多少，哼？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "将他作为镀金者的负债者这样他可以赢得他的救赎。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "战败被俘");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要他。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "%name% 在和你的人的战斗中勉强幸存下来后成为了负债者。 他的精神崩溃了，他被迫为你而战，这样做他就可以偿还镀金者的债务了。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Nomads",
			Text = "[img]gfx/ui/events/event_172.png[/img]{幸存者艰难的爬离你。他在咕哝这什么。 你听不清，但语言还是很明显的：他知道你是谁，你是什么。 | 战斗结束了，你在战场找到一个幸存者。 他有点伤但是还有用。 | 你向游牧民伸出锁链，在远处用它的闭锁抓住了他的头。%SPEECH_ON%有时候在沙漠里，一个人可能经过了一些他不该打扰的人。 有时候他能走开。%SPEECH_OFF%你紧紧的抓住锁链。%SPEECH_ON%有时候他只是走着。%SPEECH_OFF% | 沙漠滑动着，一个受伤的游民试着逃跑。 你轻松的把靴子踩在他身上并按住他，你的另只手用奴隶锁链圈住他的脖子。 | 游牧民恳求原谅。%SPEECH_ON%通过远离你的阴暗，镀金者的光辉将我们都照亮！%SPEECH_OFF%你举起锁链并告诉他不是所有阴暗都是我们生来的一部分。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "将他作为镀金者的负债者这样他可以赢得他的救赎。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "战败被俘");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要他。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_southern_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "%name% 在和你的人的战斗中勉强幸存下来后成为了负债者。 他的精神崩溃了，他被迫为你而战，这样做他就可以偿还镀金者的债务了。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "CityState",
			Text = "[img]gfx/ui/events/event_172.png[/img]{幸存者艰难的爬离你。他在咕哝这什么。 你听不清，但语言还是很明显的：他知道你是谁，你是什么。 | 战斗结束了，你在战场找到一个幸存者。 他有点伤但是还有用。 | %SPEECH_ON%镀金者不会允许这种事的。%SPEECH_OFF%他是南方士兵的最后一人，一个受伤的可怜虫，乞求仁慈。 你举起了锁链。%SPEECH_ON%只因为这些东西戴到你身上不意味着你的道路被阴影遮蔽了，旅行者伙计。 只意味着我的稍微更亮了一点。%SPEECH_OFF% | %SPEECH_ON%啊，求你了不要！%SPEECH_OFF%你的靴子踩着最后的南方士兵，然后抓起他加入负债者。 他乞求仁慈或者自由，或者说保持自由的死去。 你摇了摇头。%SPEECH_ON%金子可没法活也没法死，旅行者，它只能被衡量重量。重。或是轻。 我的决策与你无关。 你在乞求你与我相遇时就失去的东西。%SPEECH_OFF% | 最后的南方士兵在你脚下。 他在向镀金者祈祷给他的道路带来光明。 不幸的是，这里只有你说了算，而你在锁链中有个位置给他，如果你想让他“加入” %companyname%。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "将他作为镀金者的负债者这样他可以赢得他的救赎。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "战败被俘");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要他。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_southern_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "%name% 在和你的人的战斗中勉强幸存下来后成为了负债者。 他的精神崩溃了，他被迫为你而战，这样做他就可以偿还镀金者的债务了。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Barbarians",
			Text = "[img]gfx/ui/events/event_145.png[/img]{幸存者艰难的爬离你。他在咕哝这什么。 你听不清，但语言还是很明显的：他知道你是谁，你是什么。 | 战斗结束了，你在战场找到一个幸存者。 他有点伤但是还有用。 | 啊，最后的幸存者。 他挺大个儿的，这个野蛮人，而且可以为你效劳。 当然，戴着锁链。 | %companyname% 很少过手这些北方野蛮人。 当最后一个幸存者留在战场上时，你思索把他作为负债者会不会对你有利。 | 最后一个野蛮人站立着。 他用一种你从没有时间去学习的语言向你说话。 嘟囔着，低吼着，一些其他语言会当做威胁的东西，但是这里你知道他在试图说什么比较重要的事情。 但是，你的回应只有锁链，还有这个野人可能会是个非常棒的负债者在 %companyname%。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "将他作为镀金者的负债者这样他可以赢得他的救赎。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude.m.MoodChanges = [];
						_event.m.Dude.worsenMood(2.0, "战败被俘");
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "我们不需要他。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_barbarian_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "%name% 在和你的人的战斗中勉强幸存下来后成为了负债者。 他的精神崩溃了，他被迫为你而战，这样做他就可以偿还镀金者的债务了。";
				_event.m.Dude.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function isValid()
	{
		if (!this.Const.DLC.Desert)
		{
			return false;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.manhunters")
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("LastCombatID") <= this.m.LastCombatID)
		{
			return;
		}

		if (this.Time.getVirtualTimeF() - this.World.Events.getLastBattleTime() > 5.0 || this.World.Statistics.getFlags().getAsInt("LastCombatResult") != 1)
		{
			return false;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return false;
		}

		local f = this.World.FactionManager.getFaction(this.World.Statistics.getFlags().getAsInt("LastCombatFaction"));

		if (f == null)
		{
			return false;
		}

		if (f.getType() != this.Const.FactionType.NobleHouse && f.getType() != this.Const.FactionType.Settlement && f.getType() != this.Const.FactionType.Bandits && f.getType() != this.Const.FactionType.Barbarians && f.getType() != this.Const.FactionType.OrientalCityState && f.getType() != this.Const.FactionType.OrientalBandits)
		{
			return false;
		}

		this.m.LastCombatID = this.World.Statistics.getFlags().get("LastCombatID");
		return true;
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		local f = this.World.FactionManager.getFaction(this.World.Statistics.getFlags().getAsInt("LastCombatFaction"));

		if (f.getType() == this.Const.FactionType.NobleHouse)
		{
			return "Nobles";
		}
		else if (f.getType() == this.Const.FactionType.Settlement)
		{
			return "Civilians";
		}
		else if (f.getType() == this.Const.FactionType.Bandits)
		{
			return "Bandits";
		}
		else if (f.getType() == this.Const.FactionType.Barbarians)
		{
			return "Barbarians";
		}
		else if (f.getType() == this.Const.FactionType.OrientalCityState)
		{
			return "CityState";
		}
		else if (f.getType() == this.Const.FactionType.OrientalBandits)
		{
			return "Nomads";
		}
		else
		{
			return "Civilians";
		}
	}

	function onClear()
	{
		this.m.Dude = null;
	}

	function onSerialize( _out )
	{
		this.event.onSerialize(_out);
		_out.writeU32(this.m.LastCombatID);
	}

	function onDeserialize( _in )
	{
		this.event.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 54)
		{
			this.m.LastCombatID = _in.readU32();
		}
	}

});

