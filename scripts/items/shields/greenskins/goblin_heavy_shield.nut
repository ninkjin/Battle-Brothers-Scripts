this.goblin_heavy_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.goblin_heavy_shield";
		this.m.Name = "强化散兵盾";
		this.m.Description = "一面哥布林制作的强化木制盾牌。轻盈但同时太小，人类使用起来提供不了多少防护。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = this.Math.rand(1, 2);
		this.updateVariant();
		this.m.Value = 65;
		this.m.MeleeDefense = 10;
		this.m.RangedDefense = 10;
		this.m.StaminaModifier = -8;
		this.m.Condition = 16;
		this.m.ConditionMax = 16;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_goblin_02_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_goblin_02_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_goblin_02_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_goblin_shield_02_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_goblin_shield_02_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
	}

});

