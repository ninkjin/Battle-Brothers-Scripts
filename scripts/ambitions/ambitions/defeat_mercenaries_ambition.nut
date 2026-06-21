this.defeat_mercenaries_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		Defeated = 0,
		OtherMercs = ""
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_mercenaries";
		this.m.Duration = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "证明我们是最强战队的最佳方法就是在战斗中击败另一支雇佣兵团！";
		this.m.UIText = "击败另一支雇佣兵战队";
		this.m.TooltipText = "击败另一支在路上游荡的雇佣兵战队。 如果你没有敌对的另一支雇佣兵战队，你可以随时按CTRL加左键单击来攻击任何人－前提是你当前没被雇佣。";
		this.m.SuccessText = "[img]gfx/ui/events/event_87.png[/img]%randombrother% 擦去额头上的汗水和血迹。%SPEECH_ON%这些骗子！ 我以为只有我知道那个把戏！%SPEECH_OFF%雇佣兵是一群杂七杂八的群体，天生难以估计，装备千奇百怪，技能和经验参差不齐，战术诡计多端。 由于对于成员没有统一标准，他们可能只是一群寻求冒险的老商人。 但话说回来，你可能会被一群老兵惊叹到。 更糟糕的是，他们没有遵守交战规则。 %defeatedcompany% 尽了最大努力，尽管他们知道许多与兄弟们相同的聪明策略，但他们还是敌不过 %companyname%。\n\n你的胜利肯定会让各地的雇主知道哪一个战队队的锋刃最锋利。";
		this.m.SuccessButtonText = "吞噬与被吞噬。";
	}

	function onPartyDestroyed( _party )
	{
		if (_party.getFlags().has("IsMercenaries"))
		{
			++this.m.Defeated;
			this.m.OtherMercs = _party.getName();
		}

		this.World.Ambitions.updateUI();
	}

	function onUpdateScore()
	{
		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.m.Defeated >= 1)
		{
			return true;
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"defeatedcompany",
			this.m.OtherMercs
		]);
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU8(this.m.Defeated);
		_out.writeString(this.m.OtherMercs);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.Defeated = _in.readU8();
		this.m.OtherMercs = _in.readString();
	}

});

