this.thief_caught_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.thief_caught";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]在一次短暂的休息时，你的人设法抓到了一个尝试偷取你们补给的人。 他衣衫褴褛，比起人瘦得更像个骷髅。 你要怎么处理他？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "给这个可怜的家伙一些食物和水。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "给他一顿痛打。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "用剑刺穿他。",
					function getResult( _event )
					{
						return "F";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_33.png[/img]在夜幕的掩护下，一些小偷设法偷走了你的一些补给。 他也许会在下次扎营的时候把它们还给你…",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死的盗贼！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					local food = this.World.Assets.getFoodItems();
					food = food[this.Math.rand(0, food.len() - 1)];
					this.World.Assets.getStash().remove(food);
					this.List = [
						{
							id = 10,
							icon = "ui/items/" + food.getIcon(),
							text = "你失去了 " + food.getName()
						}
					];
				}
				else if (r == 2)
				{
					local amount = this.Math.rand(20, 50);
					this.World.Assets.addAmmo(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_ammo.png",
							text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 弹药"
						}
					];
				}
				else if (r == 3)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addArmorParts(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_supplies.png",
							text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 工具和补给"
						}
					];
				}
				else if (r == 4)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addMedicine(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_medicine.png",
							text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 医疗用品"
						}
					];
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_33.png[/img]%randombrother% 用一根木棍给了这个贼一顿名副其实的痛打。 棍子不怀好意地重重落下，你可以听到武器猛击的声音穿过了他那几乎中空的骨架。 他瘫倒，又转身用尽全力尝试脱逃，但是佣兵执着于完成惩罚。 当一切都被完成之后，你把那个挨了打的人留在了那里，他的整个身体都蜷缩在土里。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让这成为一次给你的教训！",
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
			ID = "D",
			Text = "[img]gfx/ui/events/event_33.png[/img]出于对这个虚弱的人的怜悯，你决定给他一些食物和水。 他几乎是把食物从你的手中抢走，然后把他的整张饥饿的脸埋在里面。 小偷每咬一下都感谢你一句。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不是每个人都会这么宽容的…",
					function getResult( _event )
					{
						if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax() || this.Math.rand(1, 100) <= 25)
						{
							return 0;
						}
						else
						{
							return "E";
						}
					}

				}
			],
			function start( _event )
			{
				local food = this.World.Assets.getFoodItems();
				food = food[this.Math.rand(0, food.len() - 1)];
				food.setAmount(this.Math.maxf(0.0, food.getAmount() - 5.0));
				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你失去了一些" + food.getName()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_33.png[/img] 你告诉你的手下回去继续行军。 小偷擦了擦他的嘴然后站了起来，摇晃着，用他那瘦弱的腿走了几步跟上了你。 他问他可不可以加入战队。 他会把他的生命献给你，如果他必须的话，这样他就什么都不用偷了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，好的，你当然可以加入我们。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "我们需要的是战士，不是没吃饱的盗贼。",
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
				_event.m.Dude.setStartValuesEx(this.Const.CharacterThiefBackgrounds);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_33.png[/img]当小偷恐惧地后退的同时，你拔出了剑。 刃和脊上反射着他那整张乞求着怜悯的脸。 你举起了武器。 那人尖叫着说他愿意为你工作，他愿意免费工作，任何事都行，只要能留他一命。 你犹豫着，你的剑还在空中挥舞。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "带着些尊严死去吧。",
					function getResult( _event )
					{
						return "G";
					}

				},
				{
					Text = "可以。如果你为我工作的话我就饶了你。",
					function getResult( _event )
					{
						return "H";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_33.png[/img]%SPEECH_ON%对于偷窃的惩罚就是死刑。%SPEECH_OFF%你重重地将剑挥下，用迅捷的刺入他胸口的一击结束了他剩余的话语。 他身体僵直，无言地用他那瘦弱的手捂住正在杀死他的那个伤口，然后倒下，没过一会就死了。 你把武器从他的身体里拔了出来，然后在你的肘关节上擦了擦。 死人的头转向一边，血在他的身下汇成了一滩。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这样更好一点。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoralReputation(-1);
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.refugee" || bro.getBackground().getID() == "background.beggar")
					{
						if (bro.getSkills().hasSkill("trait.bloodthirsty"))
						{
							continue;
						}

						bro.worsenMood(1.0, "感觉像是被你杀死的小偷");

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
			ID = "H",
			Text = "[img]gfx/ui/events/event_05.png[/img]你放下了你的武器，那人爬向了你保住了你的双腿。 他亲吻着你的脚直到你走开。\n\n为了确保一切顺利，你给了他一张长长的关于命令和如何在战队里工作的清单。 你也给了他一份合同，他用一个歪歪扭扭的“x”来签。 有几个兄弟花了这天接下来的时间来教他如何打结，并把他介绍给战队里的其他人。 到了晚上时，他看起来已经开始适应了。 第二天早上，你醒来却看见一大堆补给不见了，新来的那个也看不见了。 看来，虽然你饶恕了那个小偷，他也依然偷了你的东西然后逃跑了。 让这成为给你的一个教训。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那个混蛋！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					local food = this.World.Assets.getFoodItems();
					food = food[this.Math.rand(0, food.len() - 1)];
					this.World.Assets.getStash().remove(food);
					this.List = [
						{
							id = 10,
							icon = "ui/items/" + food.getIcon(),
							text = "你失去了 " + food.getName()
						}
					];
				}
				else if (r == 2)
				{
					local amount = this.Math.rand(20, 50);
					this.World.Assets.addAmmo(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_ammo.png",
							text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 弹药"
						}
					];
				}
				else if (r == 3)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addArmorParts(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_supplies.png",
							text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 工具和补给"
						}
					];
				}
				else if (r == 4)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addMedicine(-amount);
					this.List = [
						{
							id = 10,
							icon = "ui/icons/asset_medicine.png",
							text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 医疗用品"
						}
					];
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getFood() < 25 || this.World.Assets.getMedicine() < 10 || this.World.Assets.getArmorParts() < 10 || this.World.Assets.getAmmo() <= 50)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(playerTile) <= 10)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		this.m.Score = this.isSomethingToSee() && this.World.getTime().Days >= 7 ? 50 : 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		if (!this.isSomethingToSee() && this.Math.rand(1, 100) <= 75)
		{
			return "A";
		}
		else
		{
			return "B";
		}
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

