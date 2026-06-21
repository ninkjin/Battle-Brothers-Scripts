this.bandit_raider_wolf <- this.inherit("scripts/entity/tactical/enemies/bandit_raider", {
	m = {},
	function create()
	{
		this.bandit_raider.create();
		this.m.Name = "伪装的强盗";
	}

	function onInit()
	{
		this.bandit_raider.onInit();
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(0, 8);

		if (r <= 1)
		{
			r = this.Math.rand(0, 3);

			if (r == 0)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
			else if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pike"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/warbrand"));
			}
		}
		else
		{
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hand_axe"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/morning_star"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/falchion"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/flail"));
			}

			if (this.Math.rand(1, 100) <= 75)
			{
				if (this.Math.rand(1, 100) <= 75)
				{
					this.m.Items.equip(this.new("scripts/items/shields/wooden_shield"));
				}
				else
				{
					this.m.Items.equip(this.new("scripts/items/shields/kite_shield"));
				}
			}
		}

		if (this.Math.rand(1, 100) <= 33)
		{
			r = this.Math.rand(1, 2);

			if (r == 1)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/throwing_axe"));
			}
			else if (r == 2)
			{
				this.m.Items.addToBag(this.new("scripts/items/weapons/javelin"));
			}
		}

		if (this.Const.DLC.Unhold)
		{
			local armor;
			r = this.Math.rand(2, 7);

			if (r == 2)
			{
				armor = this.new("scripts/items/armor/ragged_surcoat");
			}
			else if (r == 3)
			{
				armor = this.new("scripts/items/armor/padded_leather");
			}
			else if (r == 4)
			{
				armor = this.new("scripts/items/armor/worn_mail_shirt");
			}
			else if (r == 5)
			{
				armor = this.new("scripts/items/armor/patched_mail_shirt");
			}
			else if (r == 6)
			{
				armor = this.new("scripts/items/armor/leather_lamellar");
			}
			else if (r == 7)
			{
				armor = this.new("scripts/items/armor/basic_mail_shirt");
			}

			this.m.Items.equip(armor);
			local upgrade = this.new("scripts/items/armor_upgrades/direwolf_pelt_upgrade");
			armor.setUpgrade(upgrade);
		}
		else
		{
			r = this.Math.rand(1, 3);

			if (r <= 2)
			{
				this.m.Items.equip(this.new("scripts/items/armor/werewolf_hide_armor"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/armor/werewolf_mail_armor"));
			}
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/dented_nasal_helmet"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/nasal_helmet_with_rusty_mail"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/rusty_mail_coif"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
		}
	}

});

