this.research_notes_legendary_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.research_notes_legendary";
		this.m.Name = "世间传奇之书";
		this.m.Description = "这是一本用精致的皮革装订的薄日志，里面记载着你们对那些出现在传说和神话中的生物的粗浅科学研究。";
		this.m.Icon = "misc/inventory_anatomists_book_04.png";
		this.m.SlotType = this.Const.ItemSlot.None;
		this.m.ItemType = this.Const.Items.ItemType.Misc;
		this.m.Value = 0;
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
			id = 11,
			type = "text",
			icon = "ui/icons/papers.png",
			text = "记录着战团对传奇生物的研究成果，前提你找得到"
		});
		local buffAcquisitions = [
			{
				flag = "isKrakenPotionDiscovered",
				creatureName = "克拉肯",
				potionName = "沼地霸主药剂"
			},
			{
				flag = "isRachegeistPotionDiscovered",
				creatureName = "复仇之魂",
				potionName = "复仇刀锋药剂"
			},
			{
				flag = "isIjirokPotionDiscovered",
				creatureName = "伊吉洛克",
				potionName = "疯嚣之神药剂"
			},
			{
				flag = "isLorekeeperPotionDiscovered",
				creatureName = "博学者",
				potionName = "内部命匣药剂"
			}
		];

		foreach( buff in buffAcquisitions )
		{
			if (this.World.Statistics.getFlags().get(buff.flag))
			{
				result.push({
					id = 15,
					type = "text",
					icon = "ui/icons/special.png",
					text = "" + buff.creatureName + ": " + buff.potionName
				});
			}
		}

		return result;
	}

});

