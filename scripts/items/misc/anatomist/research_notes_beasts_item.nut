this.research_notes_beasts_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.research_notes_beasts";
		this.m.Name = "野兽种类大全";
		this.m.Description = "一本关于世界上所存在的各种野兽的专著。书中关于那些最有趣而且确实存在的生物的段落附近所有的空白都被加密的笔记填满了。";
		this.m.Icon = "misc/inventory_anatomists_book_03.png";
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
			text = "记录着战团对奇禽异兽的研究成果"
		});
		local buffAcquisitions = [
			{
				flag = "isDirewolfPotionDiscovered",
				creatureName = "恐狼",
				potionName = "刀锋之舞药剂"
			},
			{
				flag = "isNachzehrerPotionDiscovered",
				creatureName = "食尸鬼",
				potionName = "血肉编织药剂"
			}
		];

		if (this.Const.DLC.Lindwurm)
		{
			buffAcquisitions.extend([
				{
					flag = "isLindwurmPotionDiscovered",
					creatureName = "林德虫",
					potionName = "阴燃之血药剂"
				}
			]);
		}

		if (this.Const.DLC.Unhold)
		{
			buffAcquisitions.extend([
				{
					flag = "isAlpPotionDiscovered",
					creatureName = "梦魔",
					potionName = "午夜君王药剂"
				},
				{
					flag = "isHexePotionDiscovered",
					creatureName = "女巫",
					potionName = "歹毒心肠药剂"
				},
				{
					flag = "isSchratPotionDiscovered",
					creatureName = "树人",
					potionName = "神树根须药剂"
				},
				{
					flag = "isUnholdPotionDiscovered",
					creatureName = "巨魔",
					potionName = "愚者宝藏药剂"
				},
				{
					flag = "isWebknechtPotionDiscovered",
					creatureName = "织网蛛",
					potionName = "毒素血液药剂"
				}
			]);
		}

		if (this.Const.DLC.Desert)
		{
			buffAcquisitions.extend([
				{
					flag = "isHyenaPotionDiscovered",
					creatureName = "鬣狗",
					potionName = "鲜血闸门药剂"
				},
				{
					flag = "isSerpentPotionDiscovered",
					creatureName = "大蛇",
					potionName = "迅捷尖牙药剂"
				},
				{
					flag = "isIfritPotionDiscovered",
					creatureName = "伊弗利特",
					potionName = "护体石肤药剂"
				}
			]);
		}

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
					text = "" + buff.creatureName + ": " + "???"
				});
			}
		}

		return result;
	}

});

