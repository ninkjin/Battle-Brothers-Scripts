this.waterwheel_enter_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.waterwheel_enter";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_109.png[/img]{水车轮悬摇着转动，水桶进出水中。水车旁边是一个石墙屋子，烟囱里冒着黑烟。房外墙上悬挂着兽皮和捕兽机，门廊上摆着一张橡木椅。窗户模糊不清，但你可以听到木制声音的磨坊在内部苍凉地嘎吱作响。你拔出剑，走上门廊，打开门。\n\n房间里只有一间，一个男人在欢迎你。他站在磨坊旁边，用手抚摸着谷粒。他是一位年迈的男子，但却身形矮小，好像时间对他的姿态和能力毫无影响。壁炉上方挂着一把剑柄，它的光泽显然十分丰富，老人用温暖的微笑注视着你的凝视。%SPEECH_ON%只有有资格的人才可以获得%weapon%的剑柄。你这个陌生人没有资格。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这个老人没有阻止我。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "什么使我更有价值？",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				if (this.World.State.getLastLocation() != null)
				{
					this.World.State.getLastLocation().setVisited(false);
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_109.png[/img]{你向前迈出一步，威胁那个人要他让路，否则你就要动手。他挥了挥手，你的脚离开了地面。一阵风猛烈地将你撞向墙壁，以至于你听到银器发出的声响，灰尘从天花板上飘落下来。这位老人看着你，就像你踏进他门口那一刻一样平静。%SPEECH_ON%只有值得的人才能通过。你明白了吗？%SPEECH_OFF%在这里除了点头赞同别无选择。老人的手伸向了他的腰部，你瘫倒在地上。你拿起剑，确保他理解你只是要将其收起来。你问什么才是值得的。老人再次露出微笑。%SPEECH_ON%只有我唯一的儿子是值得的。他离开了，去战斗伟大的野兽。替他报仇，那么你就可以称得上是值得的人了。%SPEECH_OFF%你被赶出了屋子，门在你的身后砰地一声关上。看起来你有一个任务，尽管你甚至不知道指南针北方的方向在哪里。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们必须自己解决这个问题。",
					function getResult( _event )
					{
						this.World.Flags.set("IsWaterWheelVisited", true);
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
			Text = "[img]gfx/ui/events/event_109.png[/img]{老人凝视着磨坊。他的手抬起来，一群谷物围绕他的指尖旋转，就像甘蔗芽上的蜜蜂一样。%SPEECH_ON%我的独生子出发去杀那只巨兽。他的侍从把剑柄还给了我，但剑已经失去踪影。复仇我的儿子，陌生人，到时你才配得上这个剑柄。%SPEECH_OFF%你问那兽在哪里，老人又把手插进了磨坊。%SPEECH_ON%我多么希望知道啊。我相信你会找到的，雇佣兵。%SPEECH_OFF%你的脚突然慢慢朝后溜，穿过门廊，踩到草地上。门砰地关上，再也打不开了。看来你不知不觉地接了个任务，或者也可以把它当成平时的事情。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们必须自己解决这个问题。",
					function getResult( _event )
					{
						this.World.Flags.set("IsWaterWheelVisited", true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "A2",
			Text = "[img]gfx/ui/events/event_109.png[/img]{当你进入时，这位老人已经在等你了。他转身相当迅速，好像被打断了思路。%SPEECH_ON%所以你已经回来了！你成功了吗？你为我的孩子复仇了吗？卖剑之徒，你值得我信任吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这会使我更有价值？",
					function getResult( _event )
					{
						return "C2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B2",
			Text = "[img]gfx/ui/events/event_109.png[/img]{水车架在铰链上摇摆，水桶起伏摆水。水车一侧连接着一个石墙住所，一根黑烟直冒的烟囱上面。墙外挂着皮毛和捕兽器，门廊上放着一把橡木椅。窗户模糊不清，只能听到木头发出的嘎吱声。抽出剑，走到门廊前打开了门。\n\n只有一间屋子，门口迎接你的是一个老人。他站在水磨旁边，手指间碾着麦粒。他年事已高，个头不高，好像时间对其不起作用。壁炉上方吊着一把剑柄，其光泽毫无疑问非常富饶，老人用温暖的微笑看着你的目光。%SPEECH_ON%只有那些值得的人才能拥有%weapon%的剑柄。只有那些为我的儿子报仇，并将他的剑带给我，才是有价值的人。为此，你需要找到那个野兽。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这会使我更有价值？",
					function getResult( _event )
					{
						return "C2";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C2",
			Text = "[img]gfx/ui/events/event_109.png[/img]{%weapon%的刀刃颤动并嗡嗡作响。你双手将其向前伸出，钢铁微微颤动在你的手指上。长老再次微笑，转动他的手掌，剑柄挂起并漂浮到你的手上。然后它转向一侧，与钢铁融合，一闪而过变为一体。这是你见过的最令人难以置信的剑之一，满满的星月标记沿着剑背闪耀。当你抬起头，你会看到长者的胸口逐渐消失。%SPEECH_ON%我的儿子得到了复仇。他的灵魂可以安息，现在我的心也可以安息了。%SPEECH_OFF%你看着这把精美的剑升到空中并旋转，钢铁朝下。橱柜爆开，皮革带飞舞着，缠绕到剑鞘上瞬间合上。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我要把它带走。",
					function getResult( _event )
					{
						return "D2";
					}

				}
			],
			function start( _event )
			{
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.legendary_sword_blade")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了一个 " + item.getName()
						});
						break;
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D2",
			Text = "[img]gfx/ui/events/event_109.png[/img]{然后，%weapon% 掉落并且你试图去抓住它，但是一个幽灵般的手将其夺走。你抬头看见长者拔出剑，露出剑身上的火和冰，就像他在钢铁的光谱中谋划新的白昼和阴郁的夜晚。他笑得噎住了。%SPEECH_ON%‘为我的儿子报仇！’‘做得配得上！’愚人玩的闹剧。卖身之徒，你追逐的那个鲜嫩的胡萝卜确实给了你好运，因此我会让你快速死亡。%SPEECH_OFF%护肩、护腕和胸甲从磨坊井中升出，谷物从它们的表面流下，显露出夸张的形状，金属扭曲，漂浮到长者身边，猛烈地击打他的身体，仿佛它们想要装甲锤子。这套钢铁盔甲随着它的佩戴者发出笑声而聚合在一起。手揪住你的肩膀把你拖出屋子，你被%companyname%保护着。长者幽灵转头。%SPEECH_ON%一群傻瓜吗？走，你们全都离开这里，才能获得拯救。我只要求你把队长留给我，因为我已经决定杀了他。%SPEECH_OFF%%randombrother%拔出武器，其他的队员紧随其后。长者拿起暮色剑回敬。虽然这剑非常真实，但长者的身体像月光下的薄纱幕布一样不断地波动。他叹息并从嘴唇中喷出蓝色气息。他转过剑刃，使其面对着你。%SPEECH_ON%那么就这样吧。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "战斗！",
					function getResult( _event )
					{
						this.World.State.getLastLocation().setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Zombies).getID());
						this.World.Events.showCombatDialog(true, true, true);
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"weapon",
			"古神之耻"
		]);
	}

	function onDetermineStartScreen()
	{
		local hasBlade = false;
		local hasBeenHereBefore = this.World.Flags.get("IsWaterWheelVisited");
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.getID() == "misc.legendary_sword_blade")
			{
				hasBlade = true;
				break;
			}
		}

		if (hasBlade)
		{
			if (hasBeenHereBefore)
			{
				return "A2";
			}
			else
			{
				return "C2";
			}
		}
		else
		{
			return "A";
		}
	}

	function onClear()
	{
	}

});

