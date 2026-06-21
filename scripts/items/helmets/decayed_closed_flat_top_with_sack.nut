this.decayed_closed_flat_top_with_sack <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.decayed_closed_flat_top_with_sack";
		this.m.Name = "罩住的腐朽覆面链甲平顶盔";
		this.m.Description = "一个破旧的拥有完整面罩的封闭式头盔，配有链甲头罩以保护颈部，整个被罩在一个腐朽的布袋子里。它显然已经被晾在户外有段时间了。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		local variants = [
			57
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 1250;
		this.m.Condition = 230;
		this.m.ConditionMax = 230;
		this.m.StaminaModifier = -19;
		this.m.Vision = -3;
	}

});

