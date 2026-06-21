this.closed_flat_top_with_mail <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.closed_flat_top_with_mail";
		this.m.Name = "覆面链甲平顶盔";
		this.m.Description = "一个拥有完整面罩的封闭式头盔，配有链甲头罩以保护颈部。有着良好的防护但难以呼吸并限制视野。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		local variants = [
			18,
			18,
			18,
			18,
			18,
			18,
			18,
			144,
			145,
			146,
			147,
			182
		];
		this.m.Variant = variants[this.Math.rand(0, variants.len() - 1)];
		this.updateVariant();
		this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
		this.m.Value = 3000;
		this.m.Condition = 280;
		this.m.ConditionMax = 280;
		this.m.StaminaModifier = -19;
		this.m.Vision = -3;
	}

	function setPlainVariant()
	{
		this.setVariant(18);
	}

	function onPaint( _color )
	{
		switch(_color)
		{
		case this.Const.Items.Paint.None:
			this.m.Variant = 18;
			break;

		case this.Const.Items.Paint.Black:
			this.m.Variant = 147;
			break;

		case this.Const.Items.Paint.WhiteBlue:
			this.m.Variant = 144;
			break;

		case this.Const.Items.Paint.WhiteGreenYellow:
			this.m.Variant = 145;
			break;

		case this.Const.Items.Paint.OrangeRed:
			this.m.Variant = 146;
			break;

		case this.Const.Items.Paint.Red:
			this.m.Variant = 182;
			break;
		}

		this.updateVariant();
		this.updateAppearance();
	}

});

