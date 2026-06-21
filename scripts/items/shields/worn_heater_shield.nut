this.worn_heater_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.worn_heater_shield";
		this.m.Name = "腐朽扇形盾";
		this.m.Description = "一面由皮革与帆布及苔藓覆盖的腐朽三角形木制盾牌。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = this.Math.rand(1, 5);
		this.updateVariant();
		this.m.Value = 150;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 15;
		this.m.StaminaModifier = -14;
		this.m.Condition = 24;
		this.m.ConditionMax = 24;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_zombie_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_zombie_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_zombie_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_zombie_heater_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_zombie_heater_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

