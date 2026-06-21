this.graverobber_heist_event <- this.inherit("scripts/events/event", {
	m = {
		Graverobber = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.graverobber_heist";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%graverobber% 那个阴暗的盗墓贼，把手藏在背后的阴影里走进你的帐篷。 你不想看他再故弄玄虚，于是直接问他想干啥。%SPEECH_ON%先生…我听说… 我听说本地一位男爵－一个有钱的男爵！－最近下葬了，就埋在离这儿不远的地方。%SPEECH_OFF%你换了个舒服的坐姿，耸耸肩。他接着说。%SPEECH_ON%I... 我不敢叫上别人，他们看我的眼神叫我不舒服。 But you... you're different. 无论如何是你把我雇来的。%SPEECH_OFF%你向前凑了凑，身上的铠甲压得屁股下面的椅子发出一声扭曲的短促哀嚎。%SPEECH_ON%让我想想：你想叫我跟你去挖了那个男爵的坟。%SPEECH_OFF%那人咧嘴一笑，一副可怜的样子，让你想起那次你骂狗偷饼干。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "呃，过几天再说吧。",
					function getResult( _event )
					{
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
					Text = "不行，你也不准去。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "我这就去拿铲子！",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]你说服自己不要参加这场挖掘计划，接着做手上的活计。 时间悄悄走过，飞蛾绕着烛火飞舞，透明的火焰不时灼烧着这小东西的翅膀。 终于，%graverobber% 回来了，怀里抱着一个箱子走进帐篷。 他满身都是泥。%SPEECH_ON%我弄到了，先生！%SPEECH_OFF%盗墓贼神经兮兮地回头看了一眼，又开口了，这次他的声音低了一点。%SPEECH_ON%我弄到了…我把东西全弄来了。 这样，我会分你一点。 我是说，虽然你没有帮我躲过巡逻队，没有帮我挖土，也没帮我把尸体拽出来，帮我抬出箱子，帮我把棺材放回去，帮我填土，帮我再一次躲过巡逻队，再把这箱子一路拖回营地…不过你好歹让我去了！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你说得对。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				local money = this.Math.rand(50, 150);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]你说服自己不要参加这场挖掘计划，接着做手上的活计。 时间悄悄走过，飞蛾绕着烛火飞舞，透明的火焰不时灼烧着这小东西的翅膀。 终于，%graverobber% 回来了，他从帐篷门口露出半个脑袋。 你放下羽毛笔，叫他进来。 他小心翼翼地挪进去，看得出来他完全不想进来。 就着昏暗的烛光，你看见这个家伙的身上就像开了间染坊：青一块紫一块，有的地方还见了红。他不好意思地笑笑。%SPEECH_ON%先生，他们，呃，他们抓住我了。%SPEECH_OFF%你点头。%SPEECH_ON%是的，我看得见。%SPEECH_OFF%那人猛地举起一只手，不知从哪甩出一块污泥，飞进黑暗里发出一声闷响。%SPEECH_ON%不过下次！%SPEECH_OFF%你赶紧伸手叫他闭嘴。%SPEECH_ON%要不这样，你先去包扎一下，然后咱们再来聊聊你这个下次，嗯？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "还有，出去的时候别弄脏了我的帐篷。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());

				if (this.Math.rand(1, 100) <= 50)
				{
					local injury2 = _event.m.Graverobber.addInjury(this.Const.Injury.Brawl);
					this.List.push({
						id = 10,
						icon = injury2.getIcon(),
						text = _event.m.Graverobber.getName() + " 遭受 " + injury2.getNameOnly()
					});
				}
				else
				{
					_event.m.Graverobber.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.Graverobber.getName() + "遭受轻伤"
					});
				}

				_event.m.Graverobber.worsenMood(0.5, "被打了一顿，在 " + _event.m.Town.getName());
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]%townname% 不是你打算在这地方搞坏你的名声－虽然雇佣兵原本就没啥好名声。 你告诉 %graverobber% 你不会帮他，而且他自己也不许去。 他失落极了，看着就像一个年轻的猎人被愤怒的父亲抢走了猎弓。%SPEECH_ON%那…那好吧… 只是几个钱而已…%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "回去干活。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				_event.m.Graverobber.worsenMood(1.0, "禁止盗墓");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_33.png[/img]你和 %graverobber% 矮着身子从灌木丛中爬过，即使是在这伸手不见五指的黑夜里，只要不是瞎子也能一眼认出你俩没怀着什么好心思。 你们若无其事地溜进墓地，装作无意间撞进去的样子，好像这样别人就不会怀疑一会要被挖开的坟墓是你们这两个外地佬干的似的。\n\n 坟地旁边是一排排灰石和看不清面目的大理石像做成的栅栏，黑色的大铁门在夜风中吱吱作响。 到处是齐腰高的杂草，很明显，此地土壤肥沃无比。 野花和人们带来的花束散落得到处都是，亦有杂交品种。\n\n盗墓贼环视一周，狠狠地抿了抿嘴唇。 他把铲子的头踩进泥土里，一只手叉着腰。%SPEECH_ON%该死。%SPEECH_OFF%听出他语气不对劲，你问他咋了。 他张口说道。%SPEECH_ON%我想不起来他埋在哪了，是这个还是那个，也有可能是那边那个。%SPEECH_OFF%随着他的示意，你看向三座坟墓：其中一个是一块低矮的石头墓碑，风吹日晒已经变得十分光滑；其二是一圈哥特式的围栏，坟墓就被围在中间；第三个则是一座地下陵墓，大门紧闭。 盗墓贼看向你。%SPEECH_ON%咱们不能在这儿多待，你说挖哪个？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "从墓碑那挖。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							return "F";
						}
						else
						{
							return "I";
						}
					}

				},
				{
					Text = "咱们打开那些栅栏。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							return "G";
						}
						else
						{
							return "I";
						}
					}

				},
				{
					Text = "去地下陵墓。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 66)
						{
							return "H";
						}
						else
						{
							return "I";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_33.png[/img]你和 %graverobber% 矮着身子从灌木丛中爬过，即使是在这伸手不见五指的黑夜里，只要不是瞎子也能一眼认出你俩没怀着什么好心思。 你们若无其事地溜进墓地，装作无意间撞进去的样子，好像这样别人就不会怀疑一会要被挖开的坟墓是你们这两个外地佬干的似的。\n\n 坟地旁边是一排排灰石和看不清面目的大理石像做成的栅栏，黑色的大铁门在夜风中吱吱作响。 到处是齐腰高的杂草，很明显，此地土壤肥沃无比。 野花和人们带来的花束散落得到处都是，亦有杂交品种。\n\n盗墓贼环视一周，狠狠地抿了抿嘴唇。 他把铲子的头踩进泥土里，一只手叉着腰。%SPEECH_ON%该死。%SPEECH_OFF%听出他语气不对劲，你问他咋了。 他张口说道。%SPEECH_ON%我想不起来他埋在哪了，是这个还是那个，也有可能是那边那个。%SPEECH_OFF%随着他的示意，你看向三座坟墓：其中一个是一块低矮的石头墓碑，风吹日晒已经变得十分光滑；其二是一圈哥特式的围栏，坟墓就被围在中间；第三个则是一座地下陵墓，大门紧闭。 盗墓贼看向你。%SPEECH_ON%咱们不能在这儿多待，你说挖哪个？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "都是徒劳的，不做。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				_event.m.Graverobber.worsenMood(0.5, "跟你一起盗墓没成功");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_33.png[/img]你拿起铲子猛地一敲，栅栏门应声而破。 金属撞击的声音顿时回荡在墓碑之间，就连树枝都颤动着，好像在叫你小声点。 你猛地打开栅栏门，铰链吱吱作响，好像两只被惊醒的幽灵。 你钻进围栏中间，扶着铁栏杆向外瞧。 叫 %graverobber% 赶紧干活，你帮他把风。 经过几分钟小心翼翼的挖掘，你们完成了这次盗墓。 土里埋着的是一个硕大的棺材，一眼就看出凭你们两人的力气完全不可能把它抬出来。\n\n 就像砸开铁门一样，你弄坏了棺材盖上的栓，把盖子掀开。 一个刚死不久的人盯着你，用两只石头做的假眼睛。 你吓了一跳，但很快就反应过来，伸手在他的行李里摸索。 看来，%graverobber% 说的没错，这人身边有一大袋陪葬的金子、杯子和金子做的杯子。 你把它们全拿走了，关上棺材板，溜出墓园。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "宝藏！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				local money = this.Math.rand(200, 500);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
				_event.m.Graverobber.improveMood(1.0, "盗墓时发现宝藏");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_33.png[/img]你走进陵墓，疑神疑鬼的，就好像背后的门随时会自己关上，把你们永远关在里面。 棺椁被放置在一大块大理石地面上，四角摆着明亮的烛台。 空气中一丝风也没有，但你却隐约听见忽明忽灭的风声环绕着这间斗室。 摇摇头把恐惧驱散，你和 %graverobber% 推开棺材板，小心地不让它摔到地上，那样发出的巨响恐怕会惊醒大半个镇子。\n\n 在棺材里你看见一具穿着骑士装备的尸体：头盔，胸甲，身上盖着一面盾牌。 一把宝剑从喉咙到胯下，双手握在剑柄之上。 你看了 %graverobber% 一眼，后者耸肩。%SPEECH_ON%我猜这家伙生前是个骑士。%SPEECH_OFF%你点头。盗墓贼从头到脚瞥了一下这位骑士。%SPEECH_ON%我猜…骑士大人用不上他生前的装备了…%SPEECH_OFF%你不准备空手而归，于是同意了他的看法。 在 %graverobber% 扒下他的装备时，死掉的骑士奋力挣扎。 经过几分钟的苦战，你帮着摘下了那顶头盔。 一大束金发一下子露出来。%graverobber% 向后退了一步。%SPEECH_ON%是个女人！%SPEECH_OFF%突然，墓穴外传来说话声。 你抱起地上的东西，告诉盗墓贼赶紧跑。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "宝藏！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				local item;
				local r = this.Math.rand(1, 3);

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/arming_sword");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/helmets/decayed_full_helm");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/armor/decayed_coat_of_plates");
				}

				item.setCondition(item.getCondition() / 2);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				_event.m.Graverobber.improveMood(1.0, "盗墓时发现宝藏");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_33.png[/img]你刚拿起铲子，突然有人朝你大吼。%SPEECH_ON%你们到底在干什么？%SPEECH_OFF%你回头一看，有个人提着灯走过来。 他把提灯举起来，铁链左摇右摆嘎吱作响。%SPEECH_ON%我猜你们是一帮盗墓贼。%SPEECH_OFF%%graverobber% 从腰带上拽出一把小刀。 巡逻者则从腰带上拽出一个硕大的铜铃，一面反射着烛火，一面反射着月光。%SPEECH_ON%你可以跟我来，但在我敲响这钟之前。 或者你会听到的我敲响警钟。%SPEECH_OFF%你拽住 %graverobber% 的领子叫他快跑。 没必要自找麻烦。 在你俩撒腿狂奔之际，看守朝你大吼。%SPEECH_ON%我记住你的长相了！ 就像被踢的狗知道是靴子干的，我会记得你的脸！%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Embarrassing.",
					function getResult( _event )
					{
						this.World.FactionManager.getFaction(_event.m.Town.getFactions()[0]).addPlayerRelation(this.Const.World.Assets.RelationOffense, "你和你的人企图盗窃当地的坟墓");
						this.World.Assets.addMoralReputation(-1);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				_event.m.Graverobber.worsenMood(0.5, "在盗窃坟墓时被抓");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Graverobber.getMoodState()],
					text = _event.m.Graverobber.getName() + this.Const.MoodStateEvent[_event.m.Graverobber.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_graverobber = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.graverobber")
			{
				candidates_graverobber.push(bro);
			}
		}

		if (candidates_graverobber.len() == 0)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getSize() >= 2 && t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
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

		this.m.Town = town;
		this.m.Graverobber = candidates_graverobber[this.Math.rand(0, candidates_graverobber.len() - 1)];
		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"graverobber",
			this.m.Graverobber.getName()
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Graverobber = null;
		this.m.Town = null;
	}

});

