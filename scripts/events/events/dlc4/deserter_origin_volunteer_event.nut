this.deserter_origin_volunteer_event <- this.inherit("scripts/events/event", {
	m = {
		Dude1 = null,
		Dude2 = null,
		Victim = null
	},
	function create()
	{
		this.m.ID = "event.deserter_origin_volunteer";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_88.png[/img]{两个看起来衣衫不整、疲倦的的人从路旁的一些树丛里冒了出来。 他们举起了他们的手，好像他们是过来投降的。%SPEECH_ON%你们是 %companyname%？我们已经听说了，你们是逃兵们组成的战团。 我这不是一种侮辱。 我们也是逃兵，但是我们无路可走了。 我们去的每一处都是赏金猎人和行刑者。 让我们为你而战吧。 战斗从来就吓不倒我们。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们可以用上像你们这样的战士。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "B" : "C";
					}

				},
				{
					Text = "我们不需要你。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude1 = null;
						_event.m.Dude2 = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude1 = roster.create("scripts/entity/tactical/player");
				_event.m.Dude1.setStartValuesEx([
					"deserter_background"
				]);
				_event.m.Dude1.getBackground().m.RawDescription = "一段时间以来，为了躲避赏金猎人和行刑者，%name% 在路上撞到了你的战队，并立即自愿加入。";
				_event.m.Dude1.getBackground().buildDescription(true);
				_event.m.Dude2 = roster.create("scripts/entity/tactical/player");
				_event.m.Dude2.setStartValuesEx([
					"deserter_background"
				]);
				_event.m.Dude2.getBackground().m.RawDescription = "%name% 和一个军团一起背叛了该团" + _event.m.Dude1.getNameOnly() + "在他志愿加入你的战团之前。";
				_event.m.Dude2.getBackground().buildDescription(true);
				this.Characters.push(_event.m.Dude1.getImagePath());
				this.Characters.push(_event.m.Dude2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_88.png[/img]{如果把他们用绳子挂起来并且吊死他们，因他们所做的那些事，那一定会及其的讽刺，但是你不打算让战队保持在那种氛围中。 你欢迎他们加入团队，并让他们接近物资。%victim% 盯着他们看了好一会儿，然后他报告说那些人说的是实话，他们将会为你战斗。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入 %companyname%！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude1);
						this.World.getPlayerRoster().add(_event.m.Dude2);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude1.onHired();
						_event.m.Dude2.onHired();
						_event.m.Dude1 = null;
						_event.m.Dude2 = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude1.getImagePath());
				this.Characters.push(_event.m.Dude2.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]{如果把他们用绳子挂起来并且吊死他们，因他们所做的那些事，那一定会及其的讽刺，但是你不打算让战队保持在那种氛围中。 你欢迎他们加入团队，并让他们接近物资，让 %victim% 盯着他们。 但你并没有保留一段用来怀疑的时间，并在这期间看住你的佣兵。 当你去看的时候，他被发现打昏在地上，物资都被洗劫了。 那两个人不知道去了哪里！}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这帮该死的鼠辈！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.getTemporaryRoster().clear();
				_event.m.Dude1 = null;
				_event.m.Dude2 = null;
				local injury = _event.m.Victim.addInjury(this.Const.Injury.Concussion);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Victim.getName() + " 遭受 " + injury.getNameOnly()
				});
				local r = this.Math.rand(1, 4);

				if (r == 1)
				{
					local food = this.World.Assets.getFoodItems();
					food = food[this.Math.rand(0, food.len() - 1)];
					this.World.Assets.getStash().remove(food);
					this.List.push({
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你失去了 " + food.getName()
					});
				}
				else if (r == 2)
				{
					local amount = this.Math.rand(20, 50);
					this.World.Assets.addAmmo(-amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_ammo.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 弹药"
					});
				}
				else if (r == 3)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addArmorParts(-amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_supplies.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 工具和补给"
					});
				}
				else if (r == 4)
				{
					local amount = this.Math.rand(5, 10);
					this.World.Assets.addMedicine(-amount);
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_medicine.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 医疗用品"
					});
				}

				this.Characters.push(_event.m.Victim.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.deserters")
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() + 1 >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();
		this.m.Victim = roster[this.Math.rand(0, roster.len() - 1)];
		this.m.Score = 20;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"victim",
			this.m.Victim.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude1 = null;
		this.m.Dude2 = null;
		this.m.Victim = null;
	}

});

