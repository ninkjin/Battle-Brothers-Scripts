this.throwing_spear <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.throwing_spear";
		this.m.Name = "投矛";
		this.m.Description = "用于短距离投掷的投矛，比一般的矛要轻但又比标枪重。矛尖受到冲击时会弯曲，有可能使得盾牌无法使用。也可以用来对付无盾牌的对手，效果显著。";
		this.m.Categories = "投掷武器，单手";
		this.m.IconLarge = "weapons/ranged/throwing_spear_01.png";
		this.m.Icon = "weapons/ranged/throwing_spear_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.RangedWeapon | this.Const.Items.ItemType.Tool;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_throwing_spear_01";
		this.m.Value = 80;
		this.m.RangeMin = 2;
		this.m.RangeMax = 4;
		this.m.RangeIdeal = 4;
		this.m.StaminaModifier = -6;
		this.m.ShieldDamage = 26;
		this.m.RegularDamage = 45;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.1;
		this.m.DirectDamageMult = 0.45;
		this.m.IsDroppedAsLoot = true;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "使用时摧毁"
		});
		return result;
	}

	function isDroppedAsLoot()
	{
		return this.weapon.isDroppedAsLoot() && (this.m.LastEquippedByFaction == this.Const.Faction.Player || this.getCurrentSlotType() != this.Const.ItemSlot.Bag);
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/throw_spear_skill"));
	}

});

