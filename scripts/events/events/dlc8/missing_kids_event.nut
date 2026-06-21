this.missing_kids_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Cultist = null,
		Hedge = null,
		Killer = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.missing_kids";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_31.png[/img]{当你在%townname%的街上漫步时，一群瘦弱的守卫突然像一群老鼠一样从小巷子里冒了出来，它们数量众多且危险。当你低下头时，解剖学家%anatomist%却忍不住瞪着他们，引起了他们的注意。守卫们与他们对视后走了过来，如预料的那样，他们开始透露他们的要求。%SPEECH_ON%嘿，旅行家，城里流传着有人在杀孩子的消息。现在我们有理由相信是你们身边这个奇怪的家伙在干这件可怕的事情。%SPEECH_OFF%解剖学家试图为自己辩护，但你知道理性在这里并没有用。你问守卫们需要多少赔偿，他们说道。%SPEECH_ON%如何支付%blackmail%克朗，我们就不再追究这件可怕的事情了。否则，我们就要打得你们俩遍体鳞伤。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好的，我们会“支付罚款”的。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们不支付任何费用。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Hedge != null)
				{
					this.Options.push({
						Text = "当你需要那个野骑士%hedgeknight%的时候，他在哪里？",
						function getResult( _event )
						{
							return "Hedge";
						}

					});
				}

				if (_event.m.Cultist != null)
				{
					this.Options.push({
						Text = "你有什么话要说，邪教徒%cultist%？",
						function getResult( _event )
						{
							return "Cultist";
						}

					});
				}

				if (this.Const.DLC.Unhold && _event.m.Killer != null)
				{
					this.Options.push({
						Text = "%killer%那个杀手总是躲过守卫，他会做什么？",
						function getResult( _event )
						{
							return "Killer";
						}

					});
				}

				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_31.png[/img]{你支付了金币，他们拿着金币大笑着离开了。%anatomist%解释道他从未杀死过任何儿童，除非其中有科学价值。你闭上了眼睛，并问他如果有科学价值，他会杀死孩子吗？解剖学家嘲笑了一声。%SPEECH_ON%我会将他们摧毁，先生。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你当然会这么想。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(-750);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]750[/color] 克朗"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_31.png[/img]{你告诉他们你得先数一下你有多少钱。你低头看了看你的口袋，说道：%SPEECH_ON%我想我有五个克朗。%SPEECH_OFF%站在一旁的一个瘦弱的卫兵问道：“五个什么？” 你一拳打在了他的脸上以回答他的问题。在那个男人摔倒之前，其余的卫兵已经向你和他冲了过来，踢踹和猛打。他们搜了你的口袋，但你身上没有一枚克朗。最终，他们停了下来，退到一边，一群农民慢慢地聚集在这场骚乱周围。其中一名卫兵拍了拍另一名卫兵，表示是时候走了。卫兵队长盯着你看。%SPEECH_ON%该死，兄弟，你真的能挨打。希望这场打得值得。走吧，我们离开这里。%SPEECH_OFF%你慢慢地站起身，然后帮助%anatomist%站起来。他擦了擦脸上的血。你明白怎么应对这种场面，但是你觉得这可能是对解剖学家的第一次。血从他的鼻子口中不断流出，他不停地擦拭。你告诉他把头往后靠，然后带他回到马车旁。解剖学家用尖细的声音说道：%SPEECH_ON%它还在流血。我知道这就是它的设计，但亲身经历看到和感受到它...... 很有趣。非常有趣。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这很快就会变得老套，相信我。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local injury = _event.m.Anatomist.addInjury([
					{
						ID = "injury.broken_nose",
						Threshold = 0.0,
						Script = "injury/broken_nose_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Anatomist.getName() + " 遭受 " + injury.getNameOnly()
				});
			}

		});
		this.m.Screens.push({
			ID = "Hedge",
			Text = "[img]gfx/ui/events/event_96.png[/img]{野骑士%hedgeknight%突然从拐角处出现。卫兵们向后退了一步。他一手拿着苹果，另一只手放在他的武器柄上，就像刽子手手握刑具一样。他逐个审视着每个卫兵，并发现他们都有缺陷。他又咬了一口苹果，然后转向你。%SPEECH_ON%队长，这里有什么问题吗？%SPEECH_OFF%一名卫兵迅速走上前，焦虑地微笑着。%SPEECH_ON%啊，没有问题。我们只是在某个问题上进行我们的职责所在而已。%SPEECH_OFF%野骑士扔掉了苹果核并做了个长长的伸展，他们的盔甲发出摩擦和金属碰撞的声音。他点了点头。%SPEECH_ON%进展如何？%SPEECH_OFF%卫兵们宣布他们已经完成了工作。野骑士笑了，说如果一个人的时间浪费在错误上，那他应该得到补偿。紧张地咽了口口水，其中一名卫兵交出了一袋硬币。他向你道歉浪费你的时间。这群瘦弱的卫兵弓腰退到了远处。%hedgeknight%叹息道。他说他在等你的指令。你问他做什么指令，他拿出另一个苹果，紧紧地捏碎它，然后把其中一块塞进嘴里。%SPEECH_ON%你觉得呢？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Ahh...",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(150);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]150[/color] 克朗"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Hedge.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Cultist",
			Text = "[img]gfx/ui/events/event_03.png[/img]{当你还没来得及回答，一只小袋子飞过两边，着地后流出一堆鸡骨头。紧接着传来一阵脚步声，转头一看，是%cultist%教徒走了过来，弯下腰去拿了一根骨头。他转向卫兵，说没有孩子失踪，他们的报告都是谎言。一个操着蹩脚语言的卫兵翻起白眼.%SPEECH_ON%你他妈是谁？%SPEECH_OFF%Cultist走向卫兵，骨头在他的靴子下嘎吱作响。他靠近卫兵的耳朵，开始小声说话。当教徒说完后，卫兵朝后退缩。%SPEECH_ON%我是在考验他的耐性吗？%SPEECH_OFF%Cultist点点头，说道.%SPEECH_ON%而终结那场注定要永存的事将会对你造成如此可怕的后果，你会相信生于世上不过是一场巨大的错误，事实上它本就是如此。%SPEECH_OFF%卫兵们互相瞥了一眼，其中一个献上他的皇冠，仿佛这是忏悔一样。你欣然接受了皇冠，奇怪的是它们是温暖的。%cultist%转身点点头，低声说着超出你理解的存在的决心。你看着那些骨头，但不记得队伍有任何养鸡，你的进入路上也没有鸡舍。%SPEECH_ON%看上去像-%SPEECH_OFF%解剖学家的声音有点大，你马上阻止了他，匆匆离开这条街道，以免这场奇怪的骚动再引起其他麻烦。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "咱们赶紧离开这里吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local initiativeBoost = this.Math.rand(1, 3);
				_event.m.Cultist.getBaseProperties().Initiative += initiativeBoost;
				_event.m.Cultist.getSkills().update();
				this.List.push({
					id = 16,
					icon = "ui/icons/initiative.png",
					text = _event.m.Cultist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiativeBoost + "[/color] 主动性"
				});
				this.World.Assets.addMoney(75);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]75[/color] 克朗"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Cultist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Killer",
			Text = "[img]gfx/ui/events/event_20.png[/img]{当你张嘴要回答时，突然一名女子尖叫。两派人马看向声音传来的方向，只见一个半裸男子在绳索末端扭动着，脖子扭曲到了最不可能存活的角度。然而，不是坠落致死：他的身体已经被撕成了碎片，用各种拷问设备刻蚀着。一个身影站在阳台上，望着下面的场景。从斗篷深处透出一双狂野的眼睛和下面邪恶的微笑，这完全没有任何犯罪心虚的迹象。警卫们大喊着追赶过去，这个人嘲笑着从阳台上消失了。你听着警卫和凶手之间的奔跑声，愈发远离了%townname%。很快，你能听到的仅仅是偶尔的血滴从尸体上滴落和被吸引过来舔它的小巷里的狗的轻声啜饮声。%anatomist%仔细地端详着它。他开口说话，但是正在逃跑的%killer%凶手突然出现了。%SPEECH_ON%队长，你好。我觉得你会喜欢这些东西。%SPEECH_OFF%他递给你一些可以附在盔甲上的配件，金属上沾满了鲜血。不需要什么高智商就能知道这是从哪里来的，但它仍然值得保存。你告诉他把它擦干净，放到库存中。那人点了点头，他长长地吸了一口气，然后露出了一抹满意的笑容。%SPEECH_ON%你不喜欢大城市的生活吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少还有人过得很开心。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local attachmentList = [
					"mail_patch_upgrade",
					"double_mail_upgrade"
				];
				local item = this.new("scripts/items/armor_upgrades/" + attachmentList[this.Math.rand(0, attachmentList.len() - 1)]);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.World.Assets.getStash().add(item);
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Killer.getImagePath());
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

		if (this.World.Assets.getMoney() < 900)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.getSize() < 2)
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];
		local cultist_candidates = [];
		local hedge_candidates = [];
		local killer_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && !bro.getSkills().hasSkill("injury.broken_nose"))
			{
				anatomist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				cultist_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.hedge_knight")
			{
				hedge_candidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.killer_on_the_run")
			{
				this.killerCandidates.push(bro);
			}
		}

		if (cultist_candidates.len() > 0)
		{
			this.m.Cultist = cultist_candidates[this.Math.rand(0, cultist_candidates.len() - 1)];
		}

		if (hedge_candidates.len() > 0)
		{
			this.m.Hedge = hedge_candidates[this.Math.rand(0, hedge_candidates.len() - 1)];
		}

		if (killer_candidates.len() > 0)
		{
			this.m.Killer = killer_candidates[this.Math.rand(0, killer_candidates.len() - 1)];
		}

		if (anatomist_candidates.len() == 0)
		{
			return;
		}

		this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		this.m.Town = town;
		this.m.Score = 8 + anatomist_candidates.len();
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
			"blackmail",
			750
		]);
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
		_vars.push([
			"hedgeknight",
			this.m.Hedge != null ? this.m.Hedge.getNameOnly() : ""
		]);
		_vars.push([
			"killer",
			this.m.Killer != null ? this.m.Killer.getNameOnly() : ""
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Cultist = null;
		this.m.Hedge = null;
		this.m.Killer = null;
		this.m.Town = null;
	}

});

