this.craftable_lindwurm_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.craftable_lindwurm";
		this.m.Name = "林德虫之盾";
		this.m.Description = "这面坚固的盾牌由闪闪发光的林德虫鳞片制成，提供了几乎坚不可摧的防护。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.Variant = 7;
		this.updateVariant();
		this.m.Value = 800;
		this.m.MeleeDefense = 17;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -14;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_named_0" + this.m.Variant;
		this.m.SpriteDamaged = "shield_named_0" + this.m.Variant + "_damaged";
		this.m.ShieldDecal = "shield_named_0" + this.m.Variant + "_destroyed";
		this.m.IconLarge = "shields/inventory_named_shield_0" + this.m.Variant + ".png";
		this.m.Icon = "shields/icon_named_shield_0" + this.m.Variant + ".png";
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

});

