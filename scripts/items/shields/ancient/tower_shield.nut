this.tower_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.tower_shield";
		this.m.Name = "古代塔盾";
		this.m.Description = "一面又高又重的塔盾，提供良好防护的同时却非常笨重。它看上去又古老又破旧。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = this.Math.rand(1, 5);
		this.updateVariant();
		this.m.Value = 200;
		this.m.MeleeDefense = 20;
		this.m.RangedDefense = 20;
		this.m.StaminaModifier = -20;
		this.m.Condition = 24;
		this.m.ConditionMax = 24;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_tower_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_tower_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_tower_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_shield_tower_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_shield_tower_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

