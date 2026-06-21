this.sergeant_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.sergeant";
		this.m.Duration = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们作战情况不错，但还需要更好的组织来应对恶劣情况。我得命名一位军士在战场上集结你们。";
		this.m.RewardTooltip = "你将获得一个独特的能增加佩戴者额外的决心的配饰。";
		this.m.UIText = "有一人点出“集结部队”特技";
		this.m.TooltipText = "至少一人点出“集结部队”特技。 你还需要在仓库中留出足够的空间来存放一个新物品。";
		this.m.SuccessText = "[img]gfx/ui/events/event_64.png[/img]你起初对于让%sergeantbrother%担任这个重要任务有些犹豫，因为他和其他人一样沉迷于狂欢和喝酒。但是%sergeantbrother%对于他的职责表现出了可嘉的热情，虽然有时候会让人有些担忧。\n\n对于拂晓被他认为是胆小和软弱的人最喜欢的时辰，%sergeantbrother%很傲慢地认为每个人都应该起得更早。他让这些战士们进行训练和检查装备，但是还会给他们加上一些额外的工作，比如指挥他们架设和拆卸营地，磨练反扑技巧，进行强制性的行军训练，填充沉重的石头等等。还制定了详实的惩罚制度，任何谁落后了就必须受到惩罚。\n\n当%sergeantbrother%不在附近时，这一系列诸如“痛苦至极”，“冷酷无情”，“多情善感”等数十个粗口的词汇会在部队内传阅，虽然不会传到他的耳中。因为他们已经了解到%sergeantbrotherfull%从来不是真正的睡眠。";
		this.m.SuccessButtonText = "这将在今后的日子里对我们大有帮助。";
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 15)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.battle_standard").isDone())
		{
			return;
		}

		this.m.Score = 3 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return false;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("perk.rally_the_troops"))
			{
				return true;
			}
		}

		return false;
	}

	function onReward()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local highestBravery = 0;
		local bestSergeant;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("perk.rally_the_troops"))
			{
				if (bro.getCurrentProperties().getBravery() > highestBravery)
				{
					bestSergeant = bro;
					highestBravery = bro.getCurrentProperties().getBravery();
				}
			}
		}

		if (bestSergeant != null && bestSergeant.getTitle() == "")
		{
			bestSergeant.setTitle("军士");
			this.m.SuccessList.push({
				id = 90,
				icon = "ui/icons/special.png",
				text = bestSergeant.getNameOnly() + " 现在被称为 " + bestSergeant.getName()
			});
		}

		local item = this.new("scripts/items/accessory/sergeant_badge_item");
		this.World.Assets.getStash().add(item);
		this.m.SuccessList.push({
			id = 10,
			icon = "ui/items/" + item.getIcon(),
			text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
		});
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local highestBravery = 0;
		local bestSergeant;

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("perk.rally_the_troops") && bro.getCurrentProperties().getBravery() > highestBravery)
			{
				bestSergeant = bro;
				highestBravery = bro.getCurrentProperties().getBravery();
			}
		}

		_vars.push([
			"sergeantbrother",
			bestSergeant.getNameOnly()
		]);
		_vars.push([
			"sergeantbrotherfull",
			bestSergeant.getName()
		]);
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

