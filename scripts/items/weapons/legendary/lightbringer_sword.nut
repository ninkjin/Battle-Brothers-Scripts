this.lightbringer_sword <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.lightbringer_sword";
		this.m.Name = "古神之耻";
		this.m.Description = "这把泛着紫黄微光的剑就如黄昏的晚霞。轻轻一碰，冰凉之中还带着灼热的触感。无论它是魔法淬炼还是精心打造的，随意间的挥舞都能感觉到其蕴含的无尽力量与强大电流。";
		this.m.Categories = "剑，单手";
		this.m.IconLarge = "weapons/melee/sword_legendary_01.png";
		this.m.Icon = "weapons/melee/sword_legendary_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_sword_legendary_01";
		this.m.Condition = 90.0;
		this.m.ConditionMax = 90.0;
		this.m.StaminaModifier = -8;
		this.m.Value = 20000;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 55;
		this.m.ArmorDamageMult = 0.9;
		this.m.DirectDamageMult = 0.2;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "对最多三个目标造成额外[color=" + this.Const.UI.Color.DamageValue + "]10[/color] - [color=" + this.Const.UI.Color.DamageValue + "]20[/color]无视护甲的伤害"
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/slash_lightning"));
		this.addSkill(this.new("scripts/skills/actives/riposte"));
	}

	function onAddedToStash( _stashID )
	{
		if (_stashID == "player")
		{
			this.updateAchievement("ReproachOfTheOldGods", 1, 1);
		}
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

});

