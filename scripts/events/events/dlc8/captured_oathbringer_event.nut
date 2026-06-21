this.captured_oathbringer_event <- this.inherit("scripts/events/event", {
	m = {
		Torturer = null
	},
	function create()
	{
		this.m.ID = "event.captured_oathbringer";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{一个男人冲进你的帐篷，大声说有人偷偷溜进了营地。你问他是不是盗贼。男人摇了摇头。%SPEECH_ON%不是，比盗贼更糟，他是一名誓约者。%SPEECH_OFF%混账东西！你跳起身，冲出去，这个入侵者已经被捆绑起来，并被誓约守卫们殴打。你将他们隔开，站在他面前。%SPEECH_ON%誓约者，Anselm的下巴在哪里？%SPEECH_OFF%这个人朝你的靴子吐了口口水，并告诉你他永远不会告诉你，而且誓约守卫可以去地狱，他认为Anselm本人如果能的话也会亲自将他们带到地狱。他亵渎年轻的Anselm名字的言论引起了你和你的士兵们的轻蔑。%randombrother%低下头。%SPEECH_ON%队长，只要一声令下，我们就可以让该死的誓约者认清自己的错误。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "杀了他。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "折磨他。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 80 ? "C" : "D";
					}

				},
				{
					Text = "放他走。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{你拔出剑，刺入这个男人的心脏。%SPEECH_ON%安瑟姆不会等你到下一次生命中，异端。%SPEECH_OFF%这个男人的身体缓缓倒下，眼睛稍稍睁大，然后定格在半眯状态下看向地面。你拔出剑，%companyname%欢呼雀跃。%SPEECH_ON%死给所有的誓约者！%SPEECH_OFF%誓约者拔出剑，高举着，燃起了狂热的情绪。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "伸张了正义。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local potential_loot = [
					"armor/adorned_mail_shirt",
					"helmets/heavy_mail_coif",
					"helmets/heavy_mail_coif"
				];
				local item = this.new("scripts/items/" + potential_loot[this.Math.rand(0, potential_loot.len() - 1)]);
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 30) * 0.01));
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin" || !bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(0.75, "你击败一个誓约破坏者，我感到很高兴。");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().isOffendedByViolence())
					{
						bro.worsenMood(0.5, "不喜欢你冷血杀死了一个俘虏");

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
		this.m.Screens.push({
			ID = "C",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{你点了点头。%SPEECH_ON%折磨他，直到他的舌头告诉我们年轻的安瑟姆在哪里。我不在乎你用什么方式，只要快点。%SPEECH_OFF%转身后，囚犯尖叫着说安瑟姆不会同意的事情。然后他开始毫无分别地尖叫，最终喊出一些毫无意义的话语。你退回帐篷，脚边还在跳动着那节奏感染的呻吟。最终，%randombrother% 出现了。他带着你知道库存中没有的一些武器和盔甲。%SPEECH_ON%他领我们到一个藏有这些东西的地方，但安瑟姆的下巴仍然失踪了，我怕是 忠诚誓言军团 把它带到他们的营地了，但他不会说具体位置。我们，在我们割掉他的舌头之后，有些沟通上的困难。%SPEECH_OFF%叹了口气，你问囚犯现在在哪里。那人清了清嗓子。%SPEECH_ON%哦，他脸色发白，倒了下去。他...死了，长官。%SPEECH_OFF%至少我们为年轻的安瑟姆做了正确的事情。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们还会找到下颚骨的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local potential_loot = [
					"armor/adorned_warriors_armor",
					"helmets/adorned_closed_flat_top_with_mail",
					"helmets/adorned_closed_flat_top_with_mail"
				];
				local item = this.new("scripts/items/" + potential_loot[this.Math.rand(0, potential_loot.len() - 1)]);
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 30) * 0.01));
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
				potential_loot = [
					"weapons/arming_sword",
					"weapons/fighting_axe",
					"weapons/military_cleaver",
					"shields/heater_shield"
				];
				local item = this.new("scripts/items/" + potential_loot[this.Math.rand(0, potential_loot.len() - 1)]);
				item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 30) * 0.01));
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin" || !bro.getBackground().isOffendedByViolence() && this.Math.rand(1, 100) <= 75)
					{
						bro.improveMood(1.25, "折磨了一个背离誓言者公司的异端人。");

						if (bro.getMoodState() > this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
					else if (bro.getBackground().isOffendedByViolence())
					{
						bro.worsenMood(0.75, "对您下令拷问俘虏感到震惊。");

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
		this.m.Screens.push({
			ID = "D",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{你命令士兵折磨这个男人以获取信息。每个誓言者都知道的一件事就是年轻的安瑟姆下巴骨在哪里，这是每个誓言者都希望找到的。男人被拖走时惨叫声不断，你撤退到帐篷里淹没烦恼，像尖叫和哭声这样的事情真的会让你的心情受挫。片刻之后，%torturer%进入帐篷，衬衫沾血。他想说些什么，然后倒在地上。另一名誓言者进来说囚犯逃跑了，在逃跑前他连刺酷刑者一刀。你命令士兵帮助%torturer%在流血过多之前止住伤口。%SPEECH_ON%那些该死的誓言者没有荣誉！我们将找到并杀死他，按Young Anselm的说法，也按我们所有人的说法！%SPEECH_OFF%你咬紧牙关、满是戏剧化的气息。事实上，这个混蛋逃了，捕捉那些像老鼠一样的誓言者不容易。你只希望%torturer%能活下来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的誓言者( Oathbringer) 贱民。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Torturer.addHeavyInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Torturer.getName() + "遭受重伤"
				});
				local injury = _event.m.Torturer.addInjury([
					{
						ID = "injury.cut_throat",
						Threshold = 0.0,
						Script = "injury/cut_throat_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Torturer.getName() + " 遭受 " + injury.getNameOnly()
				});
				_event.m.Torturer.worsenMood(0.5, "放走一名被俘的誓言者(Oathbringer)。");
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "{[img]gfx/ui/events/event_05.png[/img]{这个人没有任何值钱的东西。你告诉士兵们把他放走。他们抗议说，一个誓言者只有一个选择，服从誓言者并走向真正的终极之路，否则就是死。还有一个人可以把年轻的安瑟姆的下颚骨还回来，但是如何对待一个这样做的誓言者的规则还没有制定出来。但是，就这个人而言，他并没有真正的用处，而你并不想流血。就在你重申要把他放走时，%randombrother%切断了这个人的喉咙，其他人也欢呼雀跃。%SPEECH_ON%你说要放他走，对吧，队长？对吧？%SPEECH_OFF%你意识到誓言者正在替你掩盖，否认誓言者必须死可能会让你陷入棘手的情况。于是你点了点头。%SPEECH_ON%是的，当然，这只小老鼠必须要死，就像所有没有走上终极之路的誓言者一样！他们都会死！%SPEECH_OFF%男人们再次欢呼，尽管你有一种几个人会记得你让誓言者走的荒谬建议。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我应该更加小心我说什么。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin" || this.Math.rand(1, 100) <= 75)
					{
						bro.worsenMood(0.75, "你差点让被俘的「誓言者」逃跑了。");

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
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		if (this.World.getTime().Days < 35)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local torturer_candidates = [];
		local haveSkull = false;

		foreach( bro in brothers )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && item.getID() == "accessory.oathtaker_skull_02")
			{
				haveSkull = true;
			}

			if (bro.getBackground().getID() == "background.paladin")
			{
				torturer_candidates.push(bro);
			}
		}

		if (!haveSkull)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && item.getID() == "accessory.oathtaker_skull_02")
				{
					haveSkull = true;
					break;
				}
			}
		}

		if (haveSkull)
		{
			return;
		}

		if (torturer_candidates.len() == 0)
		{
			torturer_candidates.push(brothers[this.Math.rand(0, this.brother.len() - 1)]);
		}

		this.m.Torturer = torturer_candidates[this.Math.rand(0, torturer_candidates.len() - 1)];
		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"torturer",
			this.m.Torturer.getName()
		]);
	}

	function onClear()
	{
		this.m.Torturer = null;
	}

});

