this.blunt_cleaver <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.blunt_cleaver";
		this.m.Name = "粗钝砍刀";
		this.m.Description = "这把砍刀又重又不锋利，但仍然能够造成可怕的伤口。";
		this.m.Categories = "砍刀，单手";
		this.m.IconLarge = "weapons/melee/wildmen_04.png";
		this.m.Icon = "weapons/melee/wildmen_04_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_wildmen_04";
		this.m.Value = 600;
		this.m.Condition = 66.0;
		this.m.ConditionMax = 66.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 40;
		this.m.ArmorDamageMult = 0.8;
		this.m.DirectDamageMult = 0.25;
		this.m.DirectDamageAdd = 0.1;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		local skill = this.new("scripts/skills/actives/cleave");
		skill.m.Icon = "skills/active_182.png";
		skill.m.IconDisabled = "skills/active_182_sw.png";
		skill.m.Overlay = "active_182";
		this.addSkill(skill);
		this.addSkill(this.new("scripts/skills/actives/decapitate"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

