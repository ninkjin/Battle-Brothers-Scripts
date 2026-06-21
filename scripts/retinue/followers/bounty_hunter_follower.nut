this.bounty_hunter_follower <- this.inherit("scripts/retinue/follower", {
	m = {},
	function create()
	{
		this.follower.create();
		this.m.ID = "follower.bounty_hunter";
		this.m.Name = "赏金猎人";
		this.m.Description = "这个穿着花哨的赏金猎人口袋里装满了关于最危险人物的赏金合同。他知道如何找到他们的藏身处，并且会为每个完成的赏金合同支付丰厚的报酬。";
		this.m.Image = "ui/campfire/bounty_hunter_01";
		this.m.Cost = 4000;
		this.m.Effects = [
			"显著增加遭遇冠军的几率",
			"为每一个杀死的冠军支付300到750克朗"
		];
		this.m.Requirements = [
			{
				IsSatisfied = false,
				Text = ""
			}
		];
	}

	function isValid()
	{
		return this.Const.DLC.Wildmen;
	}

	function onUpdate()
	{
		this.World.Assets.m.ChampionChanceAdditional = 3;
	}

	function onEvaluate()
	{
		local namedItems = this.getNumberOfNamedItems();
		this.m.Requirements[0].Text = "拥有" + this.Math.min(3, namedItems) + "/3个著名或传奇物品";

		if (namedItems >= 3)
		{
			this.m.Requirements[0].IsSatisfied = true;
		}
	}

	function onChampionKilled( _champion )
	{
		if (this.Tactical.State.getStrategicProperties() == null || !this.Tactical.State.getStrategicProperties().IsArenaMode)
		{
			this.World.Assets.addMoney(this.Math.floor(_champion.getXPValue()));
		}
	}

	function getNumberOfNamedItems()
	{
		local n = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				n = ++n;
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				n = ++n;
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand);

			if (item != null && item != "-1" && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				n = ++n;
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Head);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)) && item.getID() != "armor.head.fangshire")
			{
				n = ++n;
			}

			item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
			{
				n = ++n;
			}

			for( local i = 0; i < bro.getItems().getUnlockedBagSlots(); i = ++i )
			{
				local item = bro.getItems().getItemAtBagSlot(i);

				if (item != null && (item.isItemType(this.Const.Items.ItemType.Named) || item.isItemType(this.Const.Items.ItemType.Legendary)))
				{
					n = ++n;
				}
			}
		}

		return n;
	}

});

