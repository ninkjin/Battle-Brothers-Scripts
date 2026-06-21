this.poison_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.poison";
		this.m.Name = "哥布林毒药";
		this.m.Description = "一瓶哥布林使用的蜘蛛毒素。可以涂在你的武器和箭头上面。";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/poison_01.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 100;
	}

	function getTooltip()
	{
		local result = this.accessory.getTooltip();
		result.push({
			id = 4,
			type = "text",
			icon = "ui/icons/special.png",
			text = "使用时摧毁"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onEquip()
	{
		this.accessory.onEquip();
		local skill = this.new("scripts/skills/actives/coat_with_poison_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

