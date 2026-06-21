this.player_banner <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.player_banner";
		this.m.Name = "战旗";
		this.m.Description = "一面带入战斗的战团旗帜。高举战旗能激励周围友军的决心，并且还能让敌人知道是谁击溃了他们。";
		this.m.Categories = "长柄武器，双手";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.BlockedSlotType = this.Const.ItemSlot.Offhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.TwoHanded | this.Const.Items.ItemType.Defensive;
		this.m.IsDroppedAsLoot = true;
		this.m.IsIndestructible = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = false;
		this.m.ArmamentIcon = "";
		this.m.Value = 1500;
		this.m.ShieldDamage = 0;
		this.m.Condition = 64;
		this.m.ConditionMax = 64;
		this.m.StaminaModifier = -15;
		this.m.RangeMin = 1;
		this.m.RangeMax = 2;
		this.m.RangeIdeal = 2;
		this.m.RegularDamage = 50;
		this.m.RegularDamageMax = 70;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.Variant = 5;
		this.updateVariant();
	}

	function updateVariant()
	{
		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;
		this.m.IconLarge = "weapons/banner/banner_" + variant + ".png";
		this.m.Icon = "weapons/banner/banner_" + variant + "_70x70.png";
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 10,
			type = "text",
			icon = "ui/icons/special.png",
			text = "距离4格及以内的盟友得到持举旗帜角色决心的[color=" + this.Const.UI.Color.PositiveValue + "]10%[/color]作为加成，但最高不能超过掌旗者的决心。"
		});
		return result;
	}

	function getBuyPrice()
	{
		return 1000000;
	}

	function onEquip()
	{
		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return;
		}

		local variant = this.m.Variant < 10 ? "0" + this.m.Variant : this.m.Variant;

		if (actor.hasSprite("background"))
		{
			actor.getSprite("background").setBrush("player_banner_" + variant);
		}

		if (actor.hasSprite("shaft"))
		{
			actor.getSprite("shaft").setBrush("player_banner_" + variant + "_shaft");
		}

		actor.setDirty(true);
		this.weapon.onEquip();
		local impale = this.new("scripts/skills/actives/impale");
		impale.m.Icon = "skills/active_54.png";
		impale.m.IconDisabled = "skills/active_54_sw.png";
		impale.m.Overlay = "active_54";
		this.addSkill(impale);
	}

	function onUnequip()
	{
		local actor = this.getContainer().getActor();

		if (actor == null)
		{
			return;
		}

		if (actor.hasSprite("background"))
		{
			actor.getSprite("background").resetBrush();
		}

		if (actor.hasSprite("shaft"))
		{
			actor.getSprite("shaft").resetBrush();
		}

		actor.setDirty(true);
		this.weapon.onUnequip();
	}

	function onMovementFinished()
	{
		local actor = this.getContainer().getActor();
		local allies = this.Tactical.Entities.getInstancesOfFaction(actor.getFaction());

		foreach( ally in allies )
		{
			if (ally.getID() != actor.getID())
			{
				ally.getSkills().update();
			}
		}
	}

});

