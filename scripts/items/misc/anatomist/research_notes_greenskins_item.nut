this.research_notes_greenskins_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.research_notes_greenskins";
		this.m.Name = "绿皮研究笔记";
		this.m.Description = "一系列整理好的目击者报告、实验日志和研究笔记，里面详细介绍了各种绿皮的躯体构造以及对样本的解剖记录。";
		this.m.Icon = "misc/inventory_anatomists_book_01.png";
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
			text = "记录着战团对兽人与哥布林的研究成果"
		});
		local buffAcquisitions = [
			{
				flag = "isGoblinGruntPotionDiscovered",
				creatureName = "哥布林",
				potionName = "神行如飞药剂"
			},
			{
				flag = "isGoblinOverseerPotionDiscovered",
				creatureName = "哥布林督军",
				potionName = "死神之眼药剂"
			},
			{
				flag = "isGoblinShamanPotionDiscovered",
				creatureName = "哥布林萨满",
				potionName = "十指抹油药剂"
			},
			{
				flag = "isOrcYoungPotionDiscovered",
				creatureName = "兽人青年",
				potionName = "动力学家药剂"
			},
			{
				flag = "isOrcBerserkerPotionDiscovered",
				creatureName = "兽人狂战士",
				potionName = "血腥玫瑰药剂"
			},
			{
				flag = "isOrcWarriorPotionDiscovered",
				creatureName = "兽人战士",
				potionName = "愣头铁额药剂"
			},
			{
				flag = "isOrcWarlordPotionDiscovered",
				creatureName = "兽人军阀",
				potionName = "力量之符药剂"
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
			else
			{
				result.push({
					id = 15,
					type = "text",
					icon = "ui/icons/special.png",
					text = "" + buff.creatureName + ": ???"
				});
			}
		}

		return result;
	}

});

