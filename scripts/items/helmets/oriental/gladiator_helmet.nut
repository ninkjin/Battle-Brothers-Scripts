this.gladiator_helmet <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.gladiator_helmet";
		this.m.Name = "角斗士头盔";
		this.m.Description = "一顶令人印象深刻的金属头盔，制作来在南方城邦的竞技场中恐吓对手。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.ReplaceSprite = true;
		this.m.VariantString = "helmet_southern";
		local variants = [
			13,
			14,
			15
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 2200;
		this.m.Condition = 225;
		this.m.ConditionMax = 225;
		this.m.StaminaModifier = -13;
		this.m.Vision = -3;
	}

});

