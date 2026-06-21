this.have_armor_upgrades_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.have_armor_upgrades";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "世俗的盔甲不适合作为真正的雇佣兵装备。\n我们应该用战利品来装饰我们的装备！";
		this.m.UIText = "拥有至少6件带附件的盔甲";
		this.m.TooltipText = "在你的所有中拥有至少6件带附件的盔甲。 购买它们，掠夺它们，或者有一个剥制师为你制作他们，然后将它们与你的人的盔甲结合。";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]当你接掌战队时，那只是一群苟且求生的乌合之众，一群临时拼凑起来的佣兵，除了顽固和对常识的绝对蔑视外，一无所有。 现在你看着这些人像一个超凡脱俗的野兽一样四处走动，他们的盔甲上装饰着丑陋的头皮、毛皮和骨头，这种不合时宜的征服者式的娱乐方式，使其他人知道 %companyname% 不能按照大陆上已知的任何标准来分类，无论是怪物还是人类。";
		this.m.SuccessButtonText = "这对我们很有帮助。";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().Days <= 20)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		local upgrades = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Armor) && item.getUpgrade() != null)
			{
				upgrades = ++upgrades;
			}
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null && item.isItemType(this.Const.Items.ItemType.Armor) && item.getUpgrade() != null)
			{
				upgrades = ++upgrades;
			}
		}

		if (upgrades > 6)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local upgrades = 0;
		local items = this.World.Assets.getStash().getItems();

		foreach( item in items )
		{
			if (item != null && item.isItemType(this.Const.Items.ItemType.Armor) && item.getUpgrade() != null)
			{
				upgrades = ++upgrades;
			}
		}

		if (upgrades >= 6)
		{
			return true;
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Body);

			if (item != null && item.isItemType(this.Const.Items.ItemType.Armor) && item.getUpgrade() != null)
			{
				upgrades = ++upgrades;
			}
		}

		return upgrades >= 6;
	}

	function onPrepareVariables( _vars )
	{
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

