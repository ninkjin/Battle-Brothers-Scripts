this.mask_of_davkul <- this.inherit("scripts/items/helmets/helmet", {
	m = {},
	function create()
	{
		this.helmet.create();
		this.m.ID = "armor.head.mask_of_davkul";
		this.m.Name = "达库尔的凝视";
		this.m.Description = "达库尔的凝视是古老并黑暗的力量赐予人类的礼物，通过最不可言说的仪式将人类的皮肤和骨骼融合而来的一顶头盔。它是人与域外造物合而为一的未来的凤毛麟角。它永远不会损毁，取而代之的是会当即重新长出它那带疤的外皮。";
		this.m.ShowOnCharacter = true;
		this.m.IsDroppedAsLoot = true;
		this.m.HideHair = true;
		this.m.HideBeard = true;
		this.m.HideCharacterHead = true;
		this.m.HideCorpseHead = true;
		this.m.IsIndestructible = true;
		this.m.Variant = 85;
		this.updateVariant();
		this.m.ImpactSound = [
			"sounds/combat/cleave_hit_hitpoints_01.wav",
			"sounds/combat/cleave_hit_hitpoints_02.wav",
			"sounds/combat/cleave_hit_hitpoints_03.wav"
		];
		this.m.Value = 20000;
		this.m.Condition = 270.0;
		this.m.ConditionMax = 270.0;
		this.m.StaminaModifier = -10;
		this.m.ItemType = this.m.ItemType | this.Const.Items.ItemType.Legendary;
	}

	function getTooltip()
	{
		local result = this.helmet.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "每回合回复自身[color=" + this.Const.UI.Color.PositiveValue + "]90[/color]点耐久。"
		});
		return result;
	}

	function onTurnStart()
	{
		this.m.Condition = this.Math.minf(this.m.ConditionMax, this.m.Condition + 90.0);
		this.updateAppearance();
	}

	function onCombatFinished()
	{
		this.m.Condition = this.m.ConditionMax;
		this.updateAppearance();
	}

});

