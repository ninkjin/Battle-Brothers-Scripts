this.militia_guest <- this.inherit("scripts/entity/tactical/player", {
	m = {},
	function isReallyKilled( _fatalityType )
	{
		return true;
	}

	function create()
	{
		this.m.Type = this.Const.EntityType.Militia;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Militia.XP;
		this.m.IsGuest = true;
		this.player.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.AllMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
		this.m.AIAgent.setActor(this);
	}

	function onInit()
	{
		this.player.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Militia);
		b.TargetAttractionMult = 1.0;
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
		this.m.Attributes.resize(this.Const.Attributes.COUNT, [
			0
		]);
		this.m.Name = this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
		this.m.Title = "民兵";
		this.setAppearance();
		this.getSprite("socket").setBrush("bust_base_militia");
		this.getSprite("accessory_special").setBrush("bust_militia_band_01");
	}

	function assignRandomEquipment()
	{
		local r = this.Math.rand(0, 10);

		if (r <= 1)
		{
			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/knife"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/billhook"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/pitchfork"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
		}
		else
		{
			if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/bludgeon"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/militia_spear"));
			}
			else if (r == 6)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
			}
			else if (r == 7)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/shortsword"));
			}
			else if (r == 8)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/wooden_flail"));
			}
			else if (r == 9)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
			}
			else if (r == 10)
			{
				this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
			}

			if (this.Math.rand(1, 100) <= 25)
			{
				this.m.Items.equip(this.new("scripts/items/shields/buckler_shield"));
			}
		}

		r = this.Math.rand(1, 6);

		if (r == 1)
		{
			this.m.Items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 3)
		{
			this.m.Items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}
		else if (r == 4)
		{
			this.m.Items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 5)
		{
			this.m.Items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}
		else if (r == 6)
		{
			this.m.Items.equip(this.new("scripts/items/armor/thick_tunic"));
		}
		else if (r == 7)
		{
			this.m.Items.equip(this.new("scripts/items/armor/apron"));
		}

		if (this.Math.rand(1, 100) <= 50)
		{
			local r = this.Math.rand(1, 5);

			if (r == 1)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/hood"));
			}
			else if (r == 2)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/aketon_cap"));
			}
			else if (r == 3)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/open_leather_cap"));
			}
			else if (r == 4)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/full_leather_cap"));
			}
			else if (r == 5)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
			}
		}
	}

});

