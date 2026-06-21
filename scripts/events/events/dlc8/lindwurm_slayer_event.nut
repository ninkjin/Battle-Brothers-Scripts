this.lindwurm_slayer_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null,
		Town = null
	},
	function create()
	{
		this.m.ID = "event.crisis.lindwurm_slayer";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_35.png[/img]{你正在%townname%的舒适小酒馆里喝酒。不出意料，这样的舒适没能持续多久，一个人佩戴着喧哗的铠甲闯进了这个地方。你不慎看向他，对上了他的目光。他随即向你走来。你叹了口气，将另一只手放在剑柄上，等待着可能发生的事情。那人跺着脚走到你的桌子前，挺直了身子。\n%SPEECH_ON%让我介绍一下自己，以防传说和神话还没把我归到所在。我是%dragonslayer%。在这个世界上，我的使命是猎杀并消灭龙。%SPEECH_OFF%你喝了一口酒，放下杯子，告诉那个人龙并不存在。他咧嘴笑了。\n%SPEECH_ON%那是因为我父亲已经杀死了所有的龙。事实上，我是一名猎杀林德瓦姆的杀手，而我听说你是%companyname%的队长，该队伍有着一定的声望，几乎和我一样有名。不如我们合并技能和才华，怎么样？我愿意以%price%个克朗的价格加入你们。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "好的，我将支付你%price%克朗的费用。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "不了，谢谢，我们没事。",
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
				_event.m.Dude.setStartValuesEx([
					"lindwurm_slayer_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "{%name%是一位据说很有名的怪物猎人，特长是杀死林德虫。他说自己是屠龙者迪克的儿子，他父亲杀死了最后一只还活着的龙。}";
				_event.m.Dude.getBackground().buildDescription(true);

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
				}

				_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
				_event.m.Dude.getItems().equip(this.new("scripts/items/shields/buckler_shield"));
				_event.m.Dude.getItems().equip(this.new("scripts/items/helmets/heavy_mail_coif"));
				_event.m.Dude.getItems().equip(this.new("scripts/items/armor/named/lindwurm_armor"));
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_35.png[/img]{你和誓言守卫者们漫步在%townname%街头，突然出现了一位身披闪闪发光的，配得上誓言守卫者头衔的盔甲的男子。他径直走向你，尽管守卫者们警惕地半拔出了武器，但那人毫不畏惧，伸出手。%SPEECH_ON%欢迎！我是%dragonslayer%，来自这片土地上最著名的龙屠者之子。%SPEECH_OFF%你的手下放下武器，所有人纷纷环视四周。你和那人握手，问他到底想干什么。他退后一步像是要给自己定位，然后展示了一下自己的业绩：除了打败各色怪物和各个尺码的女人外，他特别喜欢屠杀龙，还喜欢更胖的女人，因为她们让他想起了......你打断了他，告诉他龙已经不存在了。他点点头。%SPEECH_ON%没错！因为我的父亲杀死了最后一只龙，所以龙不复存在。老实说，我是一名飞龙猎人，并且做得相当不错。我寻找你们誓言守卫者，是因为你们的声名和名气，当然也希望能成为你们其中的一员。%SPEECH_OFF%这位号称杀死大蛇的名人主动提出免费加入%companyname%。}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "好的，加入我们。",
					function getResult( _event )
					{
						return "D";
					}

				},
				{
					Text = "不了，谢谢，我们没事。",
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
				_event.m.Dude.setStartValuesEx([
					"lindwurm_slayer_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "{%name%是一位据说很有名的怪物猎人，特长是杀死林德虫。他说自己是屠龙者迪克的儿子，他父亲杀死了最后一只还活着的龙。}";
				_event.m.Dude.getBackground().buildDescription(true);

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
				}

				_event.m.Dude.getItems().equip(this.new("scripts/items/weapons/fighting_spear"));
				_event.m.Dude.getItems().equip(this.new("scripts/items/shields/buckler_shield"));
				_event.m.Dude.getItems().equip(this.new("scripts/items/helmets/heavy_mail_coif"));
				_event.m.Dude.getItems().equip(this.new("scripts/items/armor/named/lindwurm_armor"));
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_35.png[/img]{你从口袋里掏出钱袋放在桌子上。那个人拿起来，数着里面的硬币。他点点头，拉紧了钱袋的带子。%SPEECH_ON%非常好。你获得了我，%companyname%的队长的服务，以我父亲的名誉为证，你不会后悔的。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "欢迎加入战团！",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				this.World.Assets.addMoney(-5000);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]5000[/color] 克朗"
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_35.png[/img]{这个人要么证明他对自己所说的成就是有价值的，要么他将成为死肉。如果他愿意免费加入战团，那么看看他的表现有何妨呢？你伸出手，男子握住了你的手，他的盔甲装备哗啦哗啦作响，他的手臂上下跳动。%SPEECH_ON%你的队长们不会失望的，这一点我可以向你保证。%SPEECH_OFF%}",
			Banner = "",
			Characters = [],
			Options = [
				{
					Text = "欢迎来到战团，[队长]%dragonslayer%[/队长]。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getBusinessReputation() < 2000)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		if (this.World.Assets.getMoney() < 6000 && this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;
		local town;
		local playerTile = this.World.State.getPlayer().getTile();

		foreach( t in towns )
		{
			if (t.isSouthern() || t.isMilitary())
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

		this.m.Town = town;
		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"dragonslayer",
			this.m.Dude.getNameOnly()
		]);
		_vars.push([
			"price",
			"5000"
		]);
		_vars.push([
			"townname",
			this.m.Town.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.paladins")
		{
			return "B";
		}

		return "A";
	}

	function onClear()
	{
		this.m.Dude = null;
		this.m.Town = null;
	}

});

