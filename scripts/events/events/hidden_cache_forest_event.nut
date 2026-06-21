this.hidden_cache_forest_event <- this.inherit("scripts/events/event", {
	m = {
		Graverobber = null,
		Otherbrother = null
	},
	function create()
	{
		this.m.ID = "event.hidden_cache_forest";
		this.m.Title = "在途中…";
		this.m.Cooldown = 200.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]森林并非人类的好朋友，因此，很多声名狼藉的人喜欢在森林里藏东西。 今天你就偶然发现了一个：%otherbrother% 的脚趾踢中了它的表面，从而发现了一个储藏处。 你们挖出了一个板条箱，用力地把它敲开，发现里面藏了各种各样的武器和盔甲，还有不少黄金。 你拍了拍发现那些东西的佣兵的肩膀并感谢他的“努力工作”。 他晃了晃他的靴子。%SPEECH_ON%是的，先生，我有一个猎犬鼻子一般的脚趾头。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "确实是的。",
					function getResult( _event )
					{
						if (_event.m.Graverobber != null)
						{
							return "B";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Otherbrother.getImagePath());
				local money = this.Math.rand(30, 150);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
				local r = this.Math.rand(1, 8);
				local item;

				if (r == 1)
				{
					item = this.new("scripts/items/weapons/bludgeon");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/weapons/falchion");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/weapons/knife");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/weapons/dagger");
				}
				else if (r == 5)
				{
					item = this.new("scripts/items/weapons/shortsword");
				}
				else if (r == 6)
				{
					item = this.new("scripts/items/weapons/woodcutters_axe");
				}
				else if (r == 7)
				{
					item = this.new("scripts/items/weapons/scramasax");
				}
				else if (r == 8)
				{
					item = this.new("scripts/items/weapons/hand_axe");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				r = this.Math.rand(1, 5);

				if (r == 1)
				{
					item = this.new("scripts/items/armor/gambeson");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/armor/leather_tunic");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/armor/thick_tunic");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/armor/wizard_robe");
				}
				else if (r == 5)
				{
					item = this.new("scripts/items/armor/worn_mail_shirt");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]在你准备离开的时候，盗墓贼 %graverobber% 叫住了你。%SPEECH_ON%等一下。%SPEECH_OFF%他跳进了那个曾经埋着藏匿物的坑里。 他开始在那里的地上四处走动。 哒。哒。哒。咔嚓。 他的手指用力敲着，随即露出了一个微笑。%SPEECH_ON%是的，跟我想的一样。%SPEECH_OFF%他向下又挖了挖，找到了另一个箱子并打开了它。 你为你所看见的东西而惊讶。盗墓贼点了点头。%SPEECH_ON%如果有人想藏一些好东西，他不仅仅将它藏在地下，他还会把它和一些没那么珍贵的东西藏在一起。 这样就算你找到了他们藏的财宝，也很有可能找不到真正珍贵的东西。 很聪明，但是它糊弄不了我。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Graverobber.getImagePath());
				local r = this.Math.rand(1, 4);
				local item;

				if (r == 1)
				{
					item = this.new("scripts/items/loot/gemstones_item");
				}
				else if (r == 2)
				{
					item = this.new("scripts/items/loot/silver_bowl_item");
				}
				else if (r == 3)
				{
					item = this.new("scripts/items/loot/silverware_item");
				}
				else if (r == 4)
				{
					item = this.new("scripts/items/loot/golden_chalice_item");
				}

				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d < 15)
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

		if (brothers.len() < 2)
		{
			return;
		}

		local graverobber_candidates = [];
		local other_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.graverobber")
			{
				graverobber_candidates.push(bro);
			}
			else
			{
				other_candidates.push(bro);
			}
		}

		if (other_candidates.len() == 0)
		{
			return;
		}

		if (graverobber_candidates.len() != 0)
		{
			this.m.Graverobber = graverobber_candidates[this.Math.rand(0, graverobber_candidates.len() - 1)];
		}

		this.m.Otherbrother = other_candidates[this.Math.rand(0, other_candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"otherbrother",
			this.m.Otherbrother.getName()
		]);
		_vars.push([
			"graverobber",
			this.m.Graverobber != null ? this.m.Graverobber.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Graverobber = null;
		this.m.Otherbrother = null;
	}

});

