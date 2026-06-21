this.metal_round_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.metal_round_shield";
		this.m.Name = "西帕尔盾";
		this.m.Description = "一面南方风格的全金属圆盾。沉重但很耐用。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.SoundOnHit = this.Const.Sound.ShieldHitMetal;
		this.m.Variant = this.Math.rand(1, 3);
		this.updateVariant();
		this.m.Value = 250;
		this.m.MeleeDefense = 18;
		this.m.RangedDefense = 18;
		this.m.StaminaModifier = -18;
		this.m.Condition = 60;
		this.m.ConditionMax = 60;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_metal_round_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_metal_round_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_metal_round_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_metal_round_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_metal_round_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

