this.named_item_set_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.named_item_set";
		this.m.Duration = 60.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "一家著名的战队因其装备而得到认可。 我们应该出发去索取一件享有声望的武器、盾牌、盔甲和头盔，以提高我们的声望。";
		this.m.UIText = "拥有一件著名的武器、盾牌、盔甲和头盔";
		this.m.TooltipText = "拥有至少一件著名的武器、盾牌、盔甲和头盔。 在酒馆里听从谣言，了解在哪里可以找到著名的物品，在大城市和城堡的专门商店购买，或者自己出去探索掠夺废墟和营地。 离文明越远，发现稀有物品的几率越高。";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]数周以来，你一直在听谣言，给年迈的老兵买啤酒，和那些甜言蜜语的老妪谈判，最终你找到了一件享有声望的武器、盾牌、盔甲和头盔的位置。 知道了在哪里可以找到这几件装备后，剩下的小事就是打败守卫它的各种恐怖之物和杀手。 现在，你战队的人很快就要穿上这些了，它们组成了一套可怖的景象。 %SPEECH_ON%在战场上武装起来的人会看到最凶猛的敌人蹒跚地离开，抖动着他那裤裆内的重物！%SPEECH_OFF%%randombrother% 自豪地欢呼着，得到了他战友们的欢笑和赞许。 一旦你宣布哪个男人去穿上这几件，你只希望他们的喜悦和兴奋不会变成嫉妒。";
		this.m.SuccessButtonText = "这对我们很有帮助。";
	}

	function getNamedItems()
	{
		local ret = {
			Weapon = false,
			Shield = false,
			Armor = false,
			Helmet = false,
			Items = 0
		};
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				++ret.Items;

				if (item.isItemType(this.Const.Items.ItemType.Weapon))
				{
					ret.Weapon = true;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Shield))
				{
					ret.Shield = true;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Armor))
				{
					ret.Armor = true;
				}
				else if (item.isItemType(this.Const.Items.ItemType.Helmet))
				{
					ret.Helmet = true;
				}
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				++ret.Items;

				if (item.isItemType(this.Const.Items.ItemType.Weapon))
				{
					ret.Weapon = true;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (item != null && item != "-1" && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				++ret.Items;

				if (item.isItemType(this.Const.Items.ItemType.Shield))
				{
					ret.Shield = true;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				++ret.Items;

				if (item.isItemType(this.Const.Items.ItemType.Helmet))
				{
					ret.Helmet = true;
				}
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				++ret.Items;

				if (item.isItemType(this.Const.Items.ItemType.Armor))
				{
					ret.Armor = true;
				}
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
				{
					++ret.Items;

					if (item.isItemType(this.Const.Items.ItemType.Weapon))
					{
						ret.Weapon = true;
					}
					else if (item.isItemType(this.Const.Items.ItemType.Shield))
					{
						ret.Shield = true;
					}
					else if (item.isItemType(this.Const.Items.ItemType.Armor))
					{
						ret.Armor = true;
					}
					else if (item.isItemType(this.Const.Items.ItemType.Helmet))
					{
						ret.Helmet = true;
					}
				}
			}
		}

		return ret;
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.getTime().Days <= 50)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 5)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		local named = this.getNamedItems();

		if (named.Items == 0)
		{
			return;
		}

		if (named.Weapon && named.Shield && named.Armor && named.Helmet)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local named = this.getNamedItems();

		if (named.Weapon && named.Shield && named.Armor && named.Helmet)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

