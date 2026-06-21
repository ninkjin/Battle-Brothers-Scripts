this.coffin_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.coffin_shield";
		this.m.Name = "古代棺形盾";
		this.m.Description = "一面用青铜强化的八角形木制盾牌。由于年代久远其木材已经变脆。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = this.Math.rand(1, 4);
		this.updateVariant();
		this.m.Value = 100;
		this.m.MeleeDefense = 15;
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = -12;
		this.m.Condition = 20;
		this.m.ConditionMax = 20;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_coffin_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_coffin_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_coffin_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_shield_coffin_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_shield_coffin_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

