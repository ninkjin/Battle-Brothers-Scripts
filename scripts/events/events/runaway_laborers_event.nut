this.runaway_laborers_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.runaway_laborers";
		this.m.Title = "在路上…";
		this.m.Cooldown = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_59.png[/img]当你走在路上时，一群衣衫褴褛的人从你身边狂奔而过。 他们或离开小径，或跳下路堤，或是躲在灌木丛的屏障后。\n\n灌木丛还在摇晃，很快又有一群人出现了。 在对方的领头开口之前，你就已经知道发生什么了。 显然，一些工人联合起来，因为一些追踪他们的监工只是轻描淡写地称作“问题”的原因放弃了工程。 他们问你有没有见过那群消极怠工的家伙。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "他们在那！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我们在这附近什么人都没看见。",
					function getResult( _event )
					{
						this.World.Assets.addMoralReputation(1);

						if (this.World.getPlayerRoster().getSize() < this.World.Assets.getBrothersMax())
						{
							return this.Math.rand(1, 100) <= 70 ? "C" : "D";
						}
						else
						{
							return this.Math.rand(1, 100) <= 70 ? "E" : "D";
						}
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_59.png[/img]监工们点头，然后抽出棍棒，草叉，甚至还有几张网。 他们一哄而散，离开公路汇入灌木，像是一群袭击载重货车的强盗。 这是一场激烈而又一边倒的战斗。 工人们就像掉进灌木的鱼一样被暴揍殴打。 就算远远地站在山坡上，你都能听见木棍敲在人头骨上发出的响声。 你还看见有个人被一把长矛残忍地刺穿，好像有人借着冲突趁机解决了一下私人恩怨。 战斗结束后，领头的监工回到你这边，一堆造型更加难堪的囚犯跟在他身后。 他递给你一包硬币，拍拍你的肩膀，感谢你帮助他们维持“秩序”。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "轻松的克朗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				this.World.Assets.addMoney(50);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]50[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_59.png[/img]你的手指坚定地指向错误的方向，监工们离开了。 他们愤怒的喊声消失在远处。 他们走后，工人们慢慢地现身了。 他们似乎很惊讶，一群佣兵竟然没有出卖他们。 他们一个接一个对你们脱帽致敬，为你的仁慈祈福。 甚至有人称你们的行为是“正义”，一个在雇佣兵耳朵里是个很奇怪的词。\n\n当他们中的大多数人都离开时，有一个人茫然地留在后面。 他问他是否能加入你们的战队，如果，你懂的，你还有能留给他的位置的话。",
			Image = "",
			List = [],
			Characters = [],
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
					Text = "这里不适合你。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx(this.Const.CharacterLaborerBackgrounds);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_59.png[/img]所有的监工都朝着错误的方向出发了－除了其中一个。 他静静地站在路边，向路堤下看去。 有那么一瞬间，你寻思着要不要一刀抹了他的脖子，把他的话憋死在嗓子里。 那人很快转向他的战友们，喊叫着指向山坡下。 工人们察觉到自己被发现了，就从灌木丛里冲出来一哄而散。 他们的大部分人肯定都营养不良，因为他们的速度慢得就像一具试图爬楼梯的骷髅。\n\n接下来的战斗相当残暴而不公，监工们的抓捕措施相当具有惩罚性。 当一切尘埃落定后，他们开始离开，就像他们来的一样快，那些工人们现在被绳子五花大绑，头上还套着袋子。 领头的监工在离开前对你骂了句脏话。 你慢慢地从鞘里拔出利刃，问他还有什么要补充的。 他吐了口唾沫，摇头否认。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "那就滚出我的视线！",
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
			ID = "E",
			Text = "[img]gfx/ui/events/event_59.png[/img]你的手指坚定地指向错误的方向，监工们离开了。 他们愤怒的喊声消失在远处。 他们走后，工人们慢慢地现身了。 他们似乎很惊讶，一群佣兵竟然没有出卖他们。 他们一个接一个对你们脱帽致敬，为你的仁慈祈福。 甚至有人称你们的行为是“正义”，一个在雇佣兵耳朵里是个很奇怪的词。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "Farewell.",
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
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

