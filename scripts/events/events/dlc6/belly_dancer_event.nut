this.belly_dancer_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.belly_dancer";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_163.png[/img]{一个肚皮舞者在 %townname%的中心广场吸引着人群。有节奏的运动本身能让一个乞丐献出一克朗，但是以一整个广场为舞台，这足够引来人群和成堆的金子。舞者身穿薄丝绸，遮盖了半身，饰有透明的深绿色面纱。她无疑是自己领域的专家。她转动着，臀部充满魅惑，手肘弯曲，手抓着小铜钹鼓。她的脚尖踮起着在一个点上旋转，如此稳定好似有一个隐形的神使她在眼花缭乱的运动中保持原地。\n\n突然有人向空中扔了一个苹果，舞者立刻转身，用一把小匕首刺了进去，并且打在了目标中心，果实掉落在地上。然后又有一个苹果被扔了进来，这次舞者拿出了一把大刀，砍断了茎，并抓住剩下的部分咬了一口。人群轻轻拍掌为她喝彩。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色，这是一克朗。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "是时候离开了。",
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
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你取出一克朗并掷向舞者。 她的眼睛捕捉到了它的微光，但这没有影响到她的舞蹈。 她放下她的武器神气的靠过来，钹碰撞着，她的膝盖微微弯曲，她的脚以一种神秘的方式让她掠过地面。 她近了。脸窄而小，下颌宽。 她的额角深邃。她笑了。 这是个男人。她是一个男人。 他在你面前拍响钹，然后摆过身去，他的屁股轻微的抚摸过你的腹股，并舞动着返回中央。 他用脚尖踮起了你的硬币，旋转着，硬币落入了一个陶罐。群众欢呼了起来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "或许他可以为我们所用？",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "是时候离开了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-1);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]1[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_163.png[/img]{在那个充满男人味的肚皮舞者拿走你的克朗后你等待着表演结束。 在他捡起他的东西时你靠近了他。 他看到了你露出一个假笑。%SPEECH_ON%啊，一个崇拜者。很抱歉，今晚只有一场演出，亲爱的陌生人。%SPEECH_OFF%你摇了摇头并问他是否知道怎么战斗。他点头。%SPEECH_ON%我当然知道。 镀金者的辉光闪耀在我们所有人身上，但也不是每时每刻的。 有时候我们必须自己找到走出黑暗的道路。 从你的着装来看你是个逐币者，把刀刃放在该去也有时候不该去的地方。%SPEECH_OFF%你点头并问他有没有兴趣加入。 弯下脚并像框架倒下般缩向地面。 他数着他的克朗。%SPEECH_ON%我不清楚你是否有眼神来看透我自己这样人的游荡本性。 或许你看到了我自己到刚才为止都没有主要的职业疲劳。 话虽如此，要让我为了钱去杀戮你还得加把劲。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你运用刀刃的天赋是我前所未见的。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 75 ? "E" : "D";
					}

				},
				{
					Text = "我现在就付500克朗，只要你愿意加入我们。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"belly_dancer_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "你在" + _event.m.Town.getName() + "遇到了%name%，他以绿色丝绸遮面，用有节奏的舞蹈和奇准的水果切割吸引了大批观众。后面这一项技能对于任何雇佣兵团都及其有用，因此你毫不犹豫地招募了他。";
				_event.m.Dude.getBackground().buildDescription(true);
				local trait = this.new("scripts/skills/traits/dexterous_trait");
				_event.m.Dude.getSkills().add(trait);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你试图通过称赞他是你见过的最好的刀锋之一来缓和他的情绪。 舞者将他的头转向沙土，他的手指在每一个硬币下滑动着将他们弹到他的陶罐中。 他的左手伸过地面，在这个动作吸引住你的眼神时，他的右手从沙土下取出了一把刀。 他将它抵在你的裤裆上。%SPEECH_ON%好我相信我的刀如同你那里的毒刺一样致命的。 现在，我知道你只是在试图让我软下来，像猎手抚摸狮子一样捕食我的自尊，而我得说：它起效了。 我会为你战斗，逐币者的首领，我会很好的战斗的。%SPEECH_OFF%点头，你问他能不能把刀放下。 他把它旋转在手中快速的收到了刀鞘中。 他站起身，脱下衣服直到全裸。%SPEECH_ON%我将把这种生活彻底抛在脑后，并将自己全身心的投入逐币者的生活中。%SPEECH_OFF%你与男人握手。 一个路过的人瞥过来挠着他的头说。%SPEECH_ON%等一下，你下面有条蛇！ 我以为你是个舞女，啊这…%SPEECH_OFF%他用衣服蹭了蹭额头并压低声音说道。%SPEECH_ON%这不是更好了吗。%SPEECH_OFF%舞者看着你笑了出来。%SPEECH_ON%我们的行业都有各种各样的危险，逐币者，现在我很期待看看你的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入战团！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你告诉舞者他是你见过的最好的刀锋之一。他笑了。%SPEECH_ON%你努力的很好，逐币者，试图把我拖到你的生活方式上。 但是你知道的，说或做，你无法将我从这种生活中剥离。 是的，刀很适合我，但为了群众起舞，不溅血的获得赞美。 你就在沙地上扮演角斗士挣你的硬币吧，逐币者，而我会在这里赚我的。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我总得问的。",
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
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_163.png[/img]{你向舞者提出了这五百克朗。 他继续捡着硬币－一次一个－并将它们放到他的陶罐子里。 静悄悄的，只有硬币碰撞和掉入一个近乎空的陶罐中的声音。 他上下观望。 他将又一个克朗放入并站了起来。 他脱下他的衣服并伸出手。%SPEECH_ON%镀金者一定照耀这我们两人，看你能赚取这么一笔财富，无疑他把你的钱袋领向这里是为了交给我。%SPEECH_OFF%你点头并和他握手。 一个路过的人瞥过来挠着他的头说。%SPEECH_ON%等一下，你下面有条蛇！ 我以为你是个舞女，啊这…%SPEECH_OFF%他擦了擦额头并压低了声音。%SPEECH_ON%这不是更好了吗。%SPEECH_OFF%叹着气，舞者想看看你的库存。%SPEECH_ON%我这样的身体，什么装备都能穿上的，不论内层外层，都可以。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入战团！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.World.Assets.addMoney(-500);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.PositiveEventValue + "]500[/color] 克朗"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (this.World.Assets.getMoney() < 750)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local currentTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() && t.getTile().getDistanceTo(currentTile) <= 4 && t.isAlliedWithPlayer())
			{
				this.m.Town = t;
				break;
			}
		}

		if (this.m.Town == null)
		{
			return;
		}

		this.m.Score = 15;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"townname",
			this.m.Town.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Town = null;
		this.m.Dude = null;
	}

});

