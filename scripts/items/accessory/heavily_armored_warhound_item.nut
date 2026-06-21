this.heavily_armored_warhound_item <- this.inherit("scripts/items/accessory/warhound_item", {
	m = {},
	function create()
	{
		this.warhound_item.create();
		this.m.ID = "accessory.heavily_armored_warhound";
		this.m.Description = "忠诚而强壮的北方獒犬，为战争而饲养。可以在战斗中释放用以侦查，追踪或追捕逃跑的敌人。这一只穿着重型皮革外套以增加防护。";
		this.m.SlotType = this.Const.ItemSlot.Accessory;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.ArmorScript = "scripts/items/armor/special/wardog_heavy_armor";
		this.m.Value = 750;
	}

	function setEntity( _e )
	{
		this.m.Entity = _e;

		if (this.m.Entity != null)
		{
			this.m.Icon = "tools/hound_01_leash_70x70.png";
		}
		else
		{
			this.m.Icon = "tools/hound_0" + this.m.Variant + "_armor_02_70x70.png";
		}
	}

});

