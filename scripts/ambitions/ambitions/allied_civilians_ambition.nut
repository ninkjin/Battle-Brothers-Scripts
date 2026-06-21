this.allied_civilians_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.allied_civilians";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们需要盟友。与其中一个城镇建立友谊和信任的纽带将使战队获得更好的价格，更多的志愿者和更稳定的工作。";
		this.m.UIText = "与一个平民派系建立“友好”关系";
		this.m.RewardTooltip = "有良好的关系会使你得到更好的价格和更多的人雇用。";
		this.m.TooltipText = "通过履行派系定居点中的合同，将世界上某个村庄或城镇的平民派系的关系提升为“友好”。 违反合同或背叛他们会降低你们的关系。 增加与城邦的关系比增加与小村庄的关系需要更长的时间。 贵族家族不算平民派系。";
		this.m.SuccessText = "[img]gfx/ui/events/event_65.png[/img]%friendlytown% 是一个投资的好地方，你决定保护战队，从事任何适合你的工作。 在与当地人打交道时，你表现得像个绅士，并鼓励兄弟们在定居时注意自己的举止。 兄弟们刚开始时当然有一些抱怨。对于放弃与农夫的争吵，%brawler% 感到非常失望，特别是 %companyname% 花这么多时间在 %friendlytown%。\n\n但你让他们相信，在你的行业中，拥有一个友好的业务基础是很重要的，因为这意味着在市场上能获得更好的价格，更多的人愿意加入你这个混杂的团队。 不用一直躲避民兵也不那么累了。 你甚至能用善意征召士兵去做一些小任务。%SPEECH_ON%我找到了那个走失的小家伙，把他拖回了家。%SPEECH_OFF%%randombrother% 自夸道，在竞争中快速击败过 %randombrother2%。%SPEECH_ON%我宁愿去市场找个老处女，劈柴过冬，甚至帮她洗衣服，也不愿去救树上的猫。%SPEECH_OFF%";
		this.m.SuccessButtonText = "这样有利于我们。";
	}

	function onUpdateScore()
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && (f.getType() == this.Const.FactionType.Settlement || f.getType() == this.Const.FactionType.OrientalCityState) && f.getPlayerRelation() >= 70.0)
			{
				this.m.IsDone = true;
				return;
			}
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && (f.getType() == this.Const.FactionType.Settlement || f.getType() == this.Const.FactionType.OrientalCityState) && f.getPlayerRelation() >= 70.0)
			{
				return true;
			}
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		local allies = this.World.FactionManager.getAlliedFactions(this.Const.Faction.Player);

		foreach( a in allies )
		{
			local f = this.World.FactionManager.getFaction(a);

			if (f != null && (f.getType() == this.Const.FactionType.Settlement || f.getType() == this.Const.FactionType.OrientalCityState) && f.getPlayerRelation() >= 70.0)
			{
				_vars.push([
					"friendlytown",
					f.getName()
				]);
				break;
			}
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() > 1)
		{
			for( local i = 0; i < brothers.len(); i = ++i )
			{
				if (brothers[i].getSkills().hasSkill("trait.player"))
				{
					brothers.remove(i);
					break;
				}
			}
		}

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.brawler")
			{
				_vars.push([
					"brawler",
					bro.getName()
				]);
				return;
			}
		}

		foreach( bro in brothers )
		{
			if (bro.getBackground().isCombatBackground())
			{
				_vars.push([
					"brawler",
					bro.getName()
				]);
				return;
			}
		}

		_vars.push([
			"brawler",
			brothers[this.Math.rand(0, brothers.len() - 1)].getName()
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

