this.manhunters_ledger_item <- this.inherit("scripts/items/item", {
	m = {},
	function create()
	{
		this.item.create();
		this.m.ID = "misc.manhunters_ledger";
		this.m.Name = "战队账簿";
		this.m.Description = "一本详细介绍战团成员和合同条款的账簿。";
		this.m.Icon = "misc/inventory_ledger_item.png";
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

		local indebted = this.World.Statistics.getFlags().getAsInt("ManhunterIndebted");
		local nonIndebted = this.World.Statistics.getFlags().getAsInt("ManhunterNonIndebted");
		result.push({
			id = 65,
			type = "text",
			text = indebted + "战队负债者"
		});
		result.push({
			id = 65,
			type = "text",
			text = nonIndebted + "战队搜捕者"
		});
		result.push({
			id = 65,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color] 负债者经验获取"
		});
		result.push({
			id = 65,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "[color=" + this.Const.UI.Color.NegativeValue + "]-10%[/color] 搜捕者经验获取"
		});

		if (indebted <= nonIndebted)
		{
			result.push({
				id = 65,
				type = "hint",
				icon = "ui/tooltips/warning.png",
				text = "战队里的负债者太少了！ 如果这种情况继续下去，搜捕者会感到不满意！"
			});
		}

		return result;
	}

});

