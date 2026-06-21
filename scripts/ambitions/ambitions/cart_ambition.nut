this.cart_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.cart";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们几乎带不了那么多的装备和战利品了。\n让我们存个7500克朗买辆货车来减轻负担吧！";
		this.m.RewardTooltip = "你将解锁仓库中额外的27个空位。";
		this.m.UIText = "拥有至少7500克朗";
		this.m.TooltipText = "收集7500或更多的克朗，这样就能买一辆货车来增加额外的仓库空间。 你可以通过完成合同、掠夺营地和废墟或贸易来赚钱。";
		this.m.SuccessText = "[img]gfx/ui/events/event_158.png[/img]收集足够的克朗来支付车夫的工作成本相当于你一只胳膊和一条腿，在某些情况下，相当真实。 现在，作为一辆新载重货车的骄傲主人，你可以携带更多的装备和战利品，无论是银器和金王冠，或者是一个被撕破了一半，满是虱子的暴徒。\n\n在使用新车轮行驶第一英里后，你会注意到 %randombrother% 似乎不见了。 环顾四周，你最终发现他藏在载重货车上的一些粮食包后面，安静地呼噜着。 头上浇点冷水，屁股上穿上靴子，懒汉很快就会站起来，像其他人一样走路。 不过，你最好确保那些人知道他们的位置。%SPEECH_ON%我不要这些！ %companyname% 中的任何人都会发现自己坐在这辆载重货车上的唯一方法就是把自己的头夹在腋下！ 当我们在这些地方旅行时，要时刻保持警惕，随时准备好你的武器！%SPEECH_OFF%人们发牢骚，继续往前走。";
		this.m.SuccessButtonText = "行动起来！";
	}

	function onUpdateScore()
	{
		if (this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		this.m.Score = 3 + this.Math.rand(0, 5);

		if (this.World.getTime().Days >= 25)
		{
			this.m.Score += 1;
		}

		if (this.World.getTime().Days >= 35)
		{
			this.m.Score += 1;
		}

		if (this.World.getTime().Days >= 45)
		{
			this.m.Score += 1;
		}
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getMoney() >= 7500)
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		local item;
		local stash = this.World.Assets.getStash();
		this.World.Assets.addMoney(-5000);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/asset_money.png",
			text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]5,000[/color] 克朗"
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

