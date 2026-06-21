this.potion_of_oblivion_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.potion_of_oblivion";
		this.m.Name = "遗忘药水";
		this.m.Description = "最好不要问这种由最稀有、最奇异的原料混合而成的混合物味道如何！据说，任何喝了这东西的人都能重新体验他的生活，改变他在人生道路上所做过的决定。";
		this.m.Icon = "consumables/potion_08.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Usable;
		this.m.IsDroppedAsLoot = true;
		this.m.IsAllowedInBag = false;
		this.m.IsUsable = true;
		this.m.Value = 2500;
	}

	function getTooltip()
	{
		local result = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 65,
			type = "text",
			text = "右键单击或拖动到当前选定的角色上进行饮用。 此物品会在使用过程中消耗掉。"
		});
		return result;
	}

	function playInventorySound( _eventType )
	{
		this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
	}

	function onUse( _actor, _item = null )
	{
		this.Sound.play("sounds/combat/drink_03.wav", this.Const.Sound.Volume.Inventory);
		local perks = _actor.m.PerkPointsSpent;
		local hasStudent = false;

		if (_actor.getLevel() >= 11 && _actor.getSkills().hasSkill("perk.student"))
		{
			perks = perks - 1;
			hasStudent = true;
		}

		_actor.m.PerkPoints += perks;
		_actor.m.PerkPointsSpent = hasStudent ? 1 : 0;
		_actor.getSkills().removeByType(this.Const.SkillType.Perk);

		if (hasStudent)
		{
			_actor.getSkills().add(this.new("scripts/skills/perks/perk_student"));
		}

		this.Const.Tactical.Common.checkDrugEffect(_actor);
		this.updateAchievement("MemoryLoss", 1, 1);
		return true;
	}

});

