this.wagon_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.wagon";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = " 一辆小货车来搬运我们的东西很好，但是还不够好。\n让我们存够15000克朗来买一辆真正的载重货车！";
		this.m.RewardTooltip = "你将解锁仓库中额外的27个空位。";
		this.m.UIText = "拥有至少15000克朗";
		this.m.TooltipText = "收集15000克朗或更多的数量，这样你就可以购买一辆载重货车来获得额外的库存空间。 你可以通过完成合同、掠夺营地和废墟或贸易来赚钱。";
		this.m.SuccessText = "[img]gfx/ui/events/event_158.png[/img]一位智者曾告诉你，一辆载重货车一旦到手就失去了价值。 当你为这辆载重货车交出10000克朗时，这条真理在你的脑海里生根发芽。 但是，当你走到箱型座位上，把你的靴子顶在踏板上时，你会有宾至如归的感觉。 你转身看一眼床。 在那里，造货车的工匠安装了一系列带有铁钉的侧翻门，适合用来悬挂奖杯、毛皮和其他物品。 如果需要的话，还有一个笼子可以关一只狗或一个讨厌的家伙。 一个木制工具箱，上面有一个沉重的门闩，里面有修理武器和盔甲的所有必要工具。 备用轮轴和车轮固定在底盘上。\n\n除此之外，你回头看看那匹驮马。 这役畜是一种矮胖的动物，腿部肌肉发达，举止冷漠。 好它漫不经心地吃着它脚下的草，直到你拉起它，让它向前的。 载重货车滚动、倾斜、下垂，没有任何迹象表明它是为了做任何你示意它做的事情。 然而它还是来了。\n\n %randombrother% 痛饮着酒走过。 当他问你骑得怎么样时，你偷了他的瓶子，把它打碎在载重货车边，大喊“生皮！”";
		this.m.SuccessButtonText = "Finally.";
	}

	function onUpdateScore()
	{
		if (this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 4)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.cart").isDone())
		{
			return;
		}

		this.m.Score = 2 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getMoney() >= 15000)
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		local item;
		local stash = this.World.Assets.getStash();
		this.World.Assets.addMoney(-10000);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/asset_money.png",
			text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]10,000[/color] 克朗"
		});
		this.World.Assets.getStash().resize(this.World.Assets.getStash().getCapacity() + 27);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/special.png",
			text = "你获得了27个额外的仓库空位"
		});
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

