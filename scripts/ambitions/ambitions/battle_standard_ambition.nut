this.battle_standard_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.battle_standard";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们需要一柄战旗，这样我们才能被远方的人认出来！\n做一个很费钱，所以我们要为此收集2000克朗。";
		this.m.RewardTooltip = "你将获得一个独特的物品，授予佩戴者附近的任何人额外的决心。";
		this.m.UIText = "拥有至少2000克朗";
		this.m.TooltipText = "收集2000或更多的克朗，这样就能为战队打造一面旗帜。 你可以通过完成合同、掠夺营地和废墟或贸易来赚钱。 你还需要在仓库中留出足够的空间来存放一个新物品。";
		this.m.SuccessText = "[img]gfx/ui/events/event_65.png[/img]没有人喜欢一个吝啬鬼，尤其是一群流浪的、嗜血的乌合之众，他们的动机主要是对硬币的热爱。 不是每个人，或者更确切地说，没有人，在你建议削减开支以节省战队标准时感到兴奋。\n\n然而，一旦 %companyname%的旗帜终于被支付并第一次被举起来自豪地吹拂一股清新的晨风，没有人会说这是不值得的。 男人们为他们的新旗帜感到骄傲，甚至在营火旁为他们的新旗帜起名，尽管没有一个人真正坚持。\n\n现在大家都清楚地看到，这不是一个暴徒的团伙，这是一个真正的雇佣兵战队。 谁有幸扛着这个旗帜？";
		this.m.SuccessButtonText = "兄弟们，那就是我们的旗帜！";
	}

	function onUpdateScore()
	{
		if (this.World.Ambitions.getDone() < 1)
		{
			return;
		}

		this.m.Score = 10;
	}

	function onCheckSuccess()
	{
		if (this.World.Assets.getMoney() >= 2000 && this.World.Assets.getStash().hasEmptySlot())
		{
			return true;
		}

		return false;
	}

	function onReward()
	{
		local item;
		local stash = this.World.Assets.getStash();
		this.World.Assets.addMoney(-1000);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/icons/asset_money.png",
			text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]1,000[/color] 克朗"
		});
		item = this.new("scripts/items/tools/player_banner");
		item.setVariant(this.World.Assets.getBannerID());
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
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

