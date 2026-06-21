this.greenskins_pet_goblin_event <- this.inherit("scripts/events/event", {
	m = {
		HurtBro = null
	},
	function create()
	{
		this.m.ID = "event.crisis.greenskins_pet_goblin";
		this.m.Title = "在途中…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]当你穿过森林时，你来到一片空地上，那里有一间小茅屋。 墙上挂着捕熊器，屋檐上挂着松鼠皮，窗户的角落里挂满了湿漉漉的树叶。 一位老人坐在门廊上的椅子上摇来摇去。 他拿着一把弩瞄准你。%SPEECH_ON%这是我的财产。%SPEECH_OFF%有一条链子从他的椅子扶手一直延伸到地窖的门口。 它随着那个人的谈话轻微地移动了一下，那个人转过身，用那把弩顶着门。%SPEECH_ON%嘘,你！现在你，拿着剑的人，和你所有的朋友，走吧。 如果再走错一步，在我的地盘，我就把你的屁股拴起来。%SPEECH_OFF%%randombrother% 悄悄来到你身边。%SPEECH_ON%我们该怎么办，先生？%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "让我们走近点看看。",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "我们没时间做疯狂的事。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]你没有理由再冒犯这位老人，所以你让大家离他和他的小屋远点。 老人用怀疑的目光看着你前进的每一步。%SPEECH_ON%嗯哼，你们现在都有美好的一天了。%SPEECH_OFF%你点头回应。%SPEECH_ON%好的，你也一样。%SPEECH_OFF%链条又动了一下，发出了另一个声音。 谁知道这到底是怎么回事，但战队有它自己的任务。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "祝你过得愉快。 ",
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
			ID = "C",
			Text = "[img]gfx/ui/events/event_25.png[/img]你向前迈了一步。 老人从椅子上一跃而起，吐了一口唾沫。%SPEECH_ON%混蛋。%SPEECH_OFF%他举起那把弩，蹲着射了出去。 弩矢很沉重，射进了树林，树枝和灌木噼啪作响。%randombrother% 冲进门廊，把男人扑倒在地。%SPEECH_ON%把你那淫荡的手拿开，你，你个贱货！%SPEECH_OFF%当那个人又啐又踢的时候，你平静地走到门廊，打开他小屋的门。 链子沿着地板，绷紧了。 一个黑暗的身影出现在角落里，在它的镣铐所能允许的范围内，迅速爬上墙壁。 你拿起火把，在黑暗中挥舞。 你看到那个囚犯了吗。 老人在门廊里大喊。%SPEECH_ON%你别来烦我们！ 现在就走，你别管我们！%SPEECH_OFF%在那里，正在躲闪火把的，是个哥布林。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "你为什么在这里拴着一个哥布林？",
					function getResult( _event )
					{
						return "F";
					}

				},
				{
					Text = "最好现在杀了它。",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_25.png[/img]你向前迈了一步。 老人从椅子上一跃而起，吐了一口唾沫。%SPEECH_ON%混蛋，我警告过你们！ 我警告过你们要小心！%SPEECH_OFF%他举起那把弩，蹲着射了出去。 弩矢飞过你的肩膀，穿过 %hurtbro%的手臂。 佣兵往下看，一根弩矢的羽毛从伤口的一端摇摇欲坠，一根血淋淋的箭杆从另一端抖动着。 他坐了下来。%SPEECH_ON%我操。%SPEECH_OFF%%randombrother% 尖叫着向前冲。 当老人试图重新装填弹药时，雇佣兵把弩踢开，把射手掀翻在地。 你告诉佣兵留他一命。 当那个人又啐又踢的时候，你平静地走到门廊，打开他小屋的门。 当门开得很大时，链子沿着地板，绷紧了。 一个黑暗的身影出现在角落里，在它的镣铐所能允许的范围内，迅速爬上墙壁。 你拿起火把，在黑暗中挥舞。 你看到那个囚犯了吗。 老人在门廊里大喊。%SPEECH_ON%你别来烦我们！ 现在就走，你别管我们！%SPEECH_OFF%在那里，正在躲闪火把的，是个哥布林。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "你为什么在这里拴着一个哥布林？",
					function getResult( _event )
					{
						return "F";
					}

				},
				{
					Text = "最好现在杀了它。",
					function getResult( _event )
					{
						return "E";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.HurtBro.getImagePath());
				local injury = _event.m.HurtBro.addInjury(this.Const.Injury.PiercedArm);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.HurtBro.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_25.png[/img]你拿出剑，走进地窖。 那个老人大声呼唤你。 所有的威胁和傲慢都消失了。 他近乎疯狂地恳求你不要伤害那个哥布林。 但你就是这么做的，用一把利刃刺穿绿皮的胸膛。 它用它那黏糊糊令人作呕的手指抓住金属。 它的抓地力减弱了，正如他的眼睛失去了光芒。 你拔出利刃，把你裤子上的血擦干净。 悲伤仿佛以一种看不见的力量使他恢复了活力，老人大哭，挣扎着站了起来。 他抽出一把匕首跟在你后面，但是 %randombrother% 用自己的匕首阻止了他，把匕首插进了他的胸膛。 血从刀柄上喷涌而出，他的心脏在急促地跳动，生命的最后一刻。 老人双膝发软，倒了下去，紧紧抓住凶手的手臂。%SPEECH_ON%残忍的生物…残忍…%SPEECH_OFF%他在地板上断气。 你命令战队竭尽所能地搜查地窖。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "安息吧，隐士。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local item = this.new("scripts/items/weapons/light_crossbow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/weapons/dagger");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/supplies/roots_and_berries_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_25.png[/img]一直盯着哥布林，你问他为什么把一个绿皮绑在他的小屋里。 隐士对着地板哭泣。%SPEECH_ON%他是一个朋友！我惟一的朋友！%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "你一定是疯了，隐士。疯了！",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "谁会拴住一个朋友呢？",
					function getResult( _event )
					{
						return "H";
					}

				},
				{
					Text = "这个哥布林一旦获得自由，就会向他真正的朋友报信！",
					function getResult( _event )
					{
						return "I";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_25.png[/img]你从木屋里撤退，蹲在老人面前。 他挣扎着乞求着。%SPEECH_ON%求你，不要杀了他！%SPEECH_OFF%那人疯了，你也得跟他沟通。 他对着门廊的地板抽泣着，呼出的气把木屑吹向空中。 最后，他放松呼吸，平静下来。%SPEECH_ON%你们是对的。我脑子不太清醒。 几天前我在一个陷阱里找到了那个哥布林，把他抓了起来，治好了他。 在这些地方我没有同伴。 很孤独，你懂的。%SPEECH_OFF%你把那把弩装上子弹，然后把它交给老人。%SPEECH_ON%你能做到吗？%SPEECH_OFF%老人凝视着那把弩。 他眨了几下眼睛，点了点头。 你的佣兵们放开他。 他拿着弩走进小屋。 他的瞄准并不坚定，嘴里还嘟囔着道歉的话。 哥布林蜷成一团，用它那病态的手保护着自己。%SPEECH_ON%我对不起你。非常抱歉。%SPEECH_OFF%老人准备好弩的射击，将手指滑过扳机，然后将弩矢对准他的下巴开火。 他扣动扳机，弩矢砰的一声落在天花板上，稀稀落落的鲜血从羽毛上滴落下来。 你摇摇头，走进小屋，亲手杀死了哥布林。 完事后，你告诉队员们去搜查那间小屋，尽他们所能把东西拿走。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "Goddammit.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/light_crossbow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/supplies/roots_and_berries_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "H",
			Text = "[img]gfx/ui/events/event_25.png[/img]小心翼翼地，你回到老人身边。 你拿起铁链去激怒它，问那个人。%SPEECH_ON%一个被你束缚的朋友？ 如果他是你真正的朋友，你就不需要锁链了，不是吗？%SPEECH_OFF%隐士耸耸肩。%SPEECH_ON%你们是对的。让我去，我要向你证明他是一个真正的朋友。%SPEECH_OFF%你让那个人站起来，让他“证明”一下。 他拍拍衣服上的灰尘，走进地窖。 链条稍稍松了一点，哥布林在他蜷曲的地方退了一步。 隐士蹲在这个绿皮面前，伸出一只手。%SPEECH_ON%嘿，伙计。%SPEECH_OFF%当他试图解开绿皮的枷锁时，哥布林咆哮着向前冲去，用牙齿咬住了他的脸。 你冲进小木屋，把哥布林踢了回去。 它落在墙角上，血肉挂在它的嘴唇上。%randombrother% 用剑刺穿这个畜生的脸。 老人喊了一声，满脸是血。%SPEECH_ON%你是对的，我知道这是真的，但是我的心…太痛苦了。%SPEECH_OFF%仔细一看，你发现他的鼻子处有一个深红色的伤口。 隐士蜷缩着像一个球，他指了指小屋。%SPEECH_ON%在地板下面，尘土很多。 我已经不再需要它了。%SPEECH_OFF%你点了点头，告诉 %randombrother% 去给隐士包扎。 战队的其他人开始拆地板，看看下面的隐藏空间。 在得到他们需要的东西后，你告诉他们是时候离开了。 隐士回到他的摇椅上坐下。 他把双手仰起放在膝盖上，鲜血沿着手指流了下来，更多的血从一个肯定会溃烂的伤口流出来。 你能听到他每一次呼吸都被血呛到。%SPEECH_ON%我应该藏起来的。 那是我经常做的事。 为什么我没有藏起来？%SPEECH_OFF%",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "别紧张。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (this.World.Assets.getMedicine() >= 2)
				{
					this.World.Assets.addMedicine(-2);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_medicine.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-2[/color] 医疗用品"
					});
				}

				local r = this.Math.rand(1, 4);
				local item;

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/named/named_axe");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/named/named_spear");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/helmets/named/wolf_helmet");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/armor/named/black_leather_armor");
				}

				this.World.Assets.getStash().makeEmptySlots(1);
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "I",
			Text = "[img]gfx/ui/events/event_25.png[/img]你从地窖里出来，对着那个人大喊。%SPEECH_ON%你到底在搞什么鬼？ 如果链子松动了，它会跑到最近的绿皮营地，把他们的愤怒带到这片土地上！%SPEECH_OFF%老人朝铁链点了点头。%SPEECH_ON%我好的朋友很安全，陌生人，你不必担心。 你根本不知道他是谁，也不知道他的性格！%SPEECH_OFF%你一拳把那个人打倒在地，然后蹲下身子，让他好好地听你说话。%SPEECH_ON%那东西不是你的朋友。 他是一个祸害。%SPEECH_OFF%你向 %randombrother% 点头示意，他迅速进入地窖，很快用匕首杀死了哥布林。 老人叫道，血已经在他的牙齿间凝结成深红色的皮。%SPEECH_ON%但这是为什么？他对你做了什么？ 杀了像他这样的生物，你有什么荣誉可言？%SPEECH_OFF%你对那个疯子摇了摇头，然后命令战队的其他人散开去搜寻物品。 当他们结束时，你把老人留给他的小屋和死去的朋友。",
			Banner = "",
			Characters = [],
			List = [],
			Options = [
				{
					Text = "真是个疯子。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/weapons/light_crossbow");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/knife");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/supplies/roots_and_berries_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.FactionManager.isGreenskinInvasion())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d <= 5)
			{
				return;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (!bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.HurtBro = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hurtbro",
			this.m.HurtBro.getName()
		]);
	}

	function onClear()
	{
		this.m.HurtBro = null;
	}

});

