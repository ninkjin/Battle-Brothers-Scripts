this.defeat_goblin_location_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		Defeated = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_goblin_location";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "只有最勇敢的人才敢对抗大规模的哥布林。 我们要把他们的一些臭气熏天的营地夷为平地，让消息传出去！";
		this.m.RewardTooltip = "你将获得一件独特的配饰，使佩戴者免疫定身。";
		this.m.UIText = "摧毁哥布林营地";
		this.m.TooltipText = "摧毁四个哥布林营地来证明战队的实力，无论是作为合同的一部分，还是通过自己发现。 你还需要在仓库中留出足够的空间来存放一个新物品。";
		this.m.SuccessText = "[img]gfx/ui/events/event_83.png[/img]人类零零散散分布在战场上，经过一场恶战后，人们气踹嘘嘘。 由于你勘查了地面，所以 %randombrother% 和 %randombrother2% 会在地面上搜寻贵重物品。%SPEECH_ON%我们前进，他们后退。 我们退后，他们就会骚扰我们。 射出一串箭，他们就躲藏起来了。 用有毒的刀锋将盾墙刺穿，对手在冲锋时像虫子一样散开。 他们扔的那些该死的东西穿过我即将到来的夜晚梦幻。%SPEECH_OFF%%randombrother2% 用他的武器戳穿一个死去的哥布林，确信他已经死了，跪下来仔细查看他的东西。%SPEECH_ON%但是战斗越激烈，胜利就更让人舒坦。%SPEECH_OFF%他站起来，迎接 %randombrother%的目光。%SPEECH_ON%战斗越激烈，我感觉越带劲。来吧。%SPEECH_OFF%他们慢慢地继续和其他人会合，在这里驻扎下来，在战队让他们离开去一个城市时，他们会在那里找价值一两个克朗的物件。";
		this.m.SuccessButtonText = "胜利！";
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.m.Defeated + "/4)";
	}

	function onLocationDestroyed( _location )
	{
		if (this.World.FactionManager.getFaction(_location.getFaction()).getType() == this.Const.FactionType.Goblins)
		{
			++this.m.Defeated;
			this.World.Ambitions.updateUI();
		}
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days < 20)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		this.m.Score = 2 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return false;
		}

		if (this.m.Defeated >= 4)
		{
			return true;
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"recently_destroyed",
			this.World.Statistics.getFlags().get("LastLocationDestroyedName")
		]);
	}

	function onReward()
	{
		local item;
		local stash = this.World.Assets.getStash();
		item = this.new("scripts/items/accessory/goblin_trophy_item");
		stash.add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}

	function onClear()
	{
		this.m.Defeated = 0;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU8(this.m.Defeated);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.Defeated = _in.readU8();
	}

});

