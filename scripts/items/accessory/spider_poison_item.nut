this.spider_poison_item <- this.inherit("scripts/items/accessory/accessory", {
	m = {},
	function create()
	{
		this.accessory.create();
		this.m.ID = "accessory.spider_poison";
		this.m.Name = "毒油";
		this.m.Description = "一瓶掺入了浓缩织网蛛毒素的油，可以涂在你的武器和箭头上面。";
		this.m.SlotType = this.Const.ItemSlot.Bag;
		this.m.IsAllowedInBag = true;
		this.m.IsDroppedAsLoot = true;
		this.m.ShowOnCharacter = false;
		this.m.IconLarge = "";
		this.m.Icon = "consumables/potion_04.png";
		this.m.StaminaModifier = -2;
		this.m.Value = 150;
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
		local skill = this.new("scripts/skills/actives/coat_with_spider_poison_skill");
		skill.setItem(this);
		this.addSkill(skill);
	}

	function onPutIntoBag()
	{
		this.onEquip();
	}

});

