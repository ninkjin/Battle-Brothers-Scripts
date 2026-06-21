this.something_in_barn_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		BeastSlayer = null,
		Farmer = null
	},
	function create()
	{
		this.m.ID = "event.something_in_barn";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_115.png[/img]{有个人来到战团那里，说他的谷仓里被一只邪恶的幼狼所困。%anatomist% 解剖学家听到后滑了过来，他问他是否确定这只幼狼是邪恶的。陌生人点了点头。%SPEECH_ON%想必这是半只恶魔狼的后代吧，可恶的家伙躲在谷仓里，只有一个入口，这件事很棘手。%SPEECH_OFF%他请求你去杀死这只幼狼，因为狼一旦逃脱就难以收拾。%anatomist% 对于这项任务非常好奇，因为关于幼狼的知识还十分有限。他自告奋勇要和你一起去看看这个婴儿一样的生物。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们去看看吧。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 55 ? "B" : "C";
					}

				},
				{
					Text = "不是我们的事。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
				if (this.Const.DLC.Unhold && _event.m.BeastSlayer != null)
				{
					this.Options.push({
						Text = "[队长]兽王猎人%beastslayer%应该能处理这个。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				if (_event.m.Farmer != null)
				{
					this.Options.push({
						Text = "我们的常驻农民[%farmer%]似乎有主意了。",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_27.png[/img]{你接受了陌生人的请求，前往谷仓。这是一个相当普通的谷仓，他解释说只有一种进入方式。他靠在门上听着，然后点头。%SPEECH_ON%噢，没错，它还在里面。%SPEECH_OFF%门打开了，你和%anatomist%进去了，经过一堆粪便和把头塞进角落里，受惊的动物朝你们半倚半立。你看到谷仓的远端有一个邋遢的生物在一堆干草里翻找着什么。%anatomist%惊慌失措地抓起一把长叉向前冲去。你抵挡住他，抓住长杆一骑而起。你对他大喊了一声，然后指向下方。这只野兽根本不是一只恶狼，只是一只普通的狗，而这个杂种目光空洞，眼里含泪凝视着你。陌生人站在你身后揉着脖子。%SPEECH_ON%哎，噢，是我没看清楚。我本以为这是只野狼怪。%SPEECH_OFF%经过一些食物和训练，毫无疑问，这只杂种狗可以成为%companyname%有用的生物。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "只是要将它远离解剖学家%anatomist%。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/wardog_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_06.png[/img]{你来到一间默默无闻的谷仓门前，门上带着链条。男子靠在门框上，静静聆听了片刻，点头解开链条。他打开门，站在你身后，从安全的位置向里面凝视。%SPEECH_ON%就在那堆干草里。%SPEECH_OFF%你看到了那个生物的轮廓，拔出了剑，小心翼翼地靠近。然而，%anatomist%看到这只犬就惊慌失措，发出了难听的尖叫。他拿起了一把干草叉，一遍又一遍地刺向草堆，生物发出了尖叫，最终被扎死。你蹲下来，拨开血淋淋的草，发现那不是只狼，甚至不是一只小狗狗，它只是一只普通的狗而已，且已经死了。\n\n就在这时，你听到了身后的一声声音。这不是那个接你的人，而是另一个人。他喊你杀了他的狗。%anatomist%将草叉丢下，解释这全是一个误会。既然解剖学家已经决定自己仲裁这件事，你急忙离开现场，只听到狗主人和%anatomist%试图争论这是个意外，微弱的哭声。你想去找那个陷害你的混蛋，但你感觉他已经消失的无影无踪。你能做的就是数清一些库存，无视死狗主人的哀鸣和%anatomist%的可怜的反驳。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Oof.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(0.75, "意外杀死了某人的狗。");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
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
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_131.png[/img]{如果确实是一只野兽，最好还是让真正的野兽猎人%beastslayer%一起去。你们三个走向谷仓。在静默片刻后，数到三，你和野兽猎人一起踢开谷仓门。解剖学家迟到了，甚至没有意识到这是计划，踢得很慢，走路也极不协调，磨磨蹭蹭地慢了半拍，在谷仓地板上扭曲着脚，拔出双腿极不舒适。他试图重整旗鼓，重新站起，但似乎他的鼠蹊肌拉伤了。你和%beastslayer%一起大笑。你帮助解剖学家起身时，野兽猎人停止了思考，一阵动静，一阵风，谷仓的墙咣当一声响。你转过头，看到野兽猎人抓住了一只苍白、鬼魅的生物，武器插在它的头骨上，他的手臂将其颈部钳住。%SPEECH_ON%没错，是一只小狗崽，但绝对不是恶狼。%SPEECH_OFF%他说道，把小的nachzehrer扔到了地上。他看着对面。%SPEECH_ON%看似有点像解剖学家。%SPEECH_OFF%%anatomist%尽管不像其他人那样粗糙，但他对研究的欣赏仍令人尊敬。他笨拙地站起来，弯曲的步态向前行进。他说野兽可能仍有科学价值。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/misc/ghoul_teeth_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.BeastSlayer.improveMood(1.0, "利用他的怪物猎杀技能");

				if (_event.m.BeastSlayer.getMoodState() > this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.BeastSlayer.getMoodState()],
						text = _event.m.BeastSlayer.getName() + this.Const.MoodStateEvent[_event.m.BeastSlayer.getMoodState()]
					});
				}

				_event.m.Anatomist.worsenMood(0.5, "尝试击败怪物，但却让自己很尴尬。");
				_event.m.Anatomist.addXP(200, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.BeastSlayer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_131.png[/img]{%farmer% 农民走上前来。他告诉那个人。%SPEECH_ON%那个谷仓原本不是你的，对吧？%SPEECH_OFF%那人摇着头。%farmer% 点点头。%SPEECH_ON%我就知道，因为像那样的谷仓不只有一个入口。它建有一个泥土出口，你得知道在哪里寻找。给我一秒钟，我就从它的后面把它赶出来，你们准备迎击它的前方。%SPEECH_OFF%按计划，你们在前方等待。没多久，你们听到里面传来野兽的叫声，它蹒跚着向门口走来。它一踏出门外，你就用剑刺穿了它的头骨，它翻倒在地上，你意识到它是一只小纳赫族人。%anatomist% 拍手大笑，因为他有值得研究的东西。%farmer% 正拿着一把长长的双手武器从谷仓的侧面走过来。%SPEECH_ON%看来有人在打后面的谷仓时忘了它。我想我们可以把它当做报酬留下来，不是吗？%SPEECH_OFF%你点点头，而请求你协助的那个人对此事没有反对。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local twoHanders = [
					"weapons/woodcutters_axe",
					"weapons/hooked_blade",
					"weapons/warbrand"
				];

				if (this.Const.DLC.Unhold)
				{
					twoHanders.extend([
						"weapons/two_handed_wooden_hammer",
						"weapons/two_handed_wooden_flail",
						"weapons/spetum",
						"weapons/goedendag"
					]);
				}

				local item = this.new("scripts/items/" + twoHanders[this.Math.rand(0, twoHanders.len() - 1)]);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Anatomist.improveMood(1.0, "得研究一个有趣的样本。");
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Farmer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_115.png[/img]{尽管 %anatomist% 想要帮助，你还是告诉农民，如果谷仓里真的有一只恶狼，他应该自己解决。这种麻烦不是你的问题，如果需要处理，那么有人最好付出报酬。该死，也许这只小狼长大变强，就能为战团提供足够的合同机会，以威慑农民而加入 %companyname%。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们在经营生意。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.worsenMood(1.0, "被剥夺了研究机会");

				if (_event.m.Anatomist.getMoodState() < this.Const.MoodState.Neutral)
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
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary() || t.getSize() >= 2)
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 4 && t.isAlliedWithPlayer())
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local beastSlayerCandidates = [];
		local farmerCandidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.beast_slayer")
			{
				beastSlayerCandidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.farmhand")
			{
				farmerCandidates.push(bro);
			}
		}

		if (beastSlayerCandidates.len() > 0)
		{
			this.m.BeastSlayer = beastSlayerCandidates[this.Math.rand(0, beastSlayerCandidates.len() - 1)];
		}

		if (farmerCandidates.len() > 0)
		{
			this.m.Farmer = farmerCandidates[this.Math.rand(0, farmerCandidates.len() - 1)];
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 10;
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
			"beastslayer",
			this.m.BeastSlayer != null ? this.m.BeastSlayer.getNameOnly() : ""
		]);
		_vars.push([
			"farmer",
			this.m.Farmer != null ? this.m.Farmer.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.BeastSlayer = null;
		this.m.Farmer = null;
	}

});

