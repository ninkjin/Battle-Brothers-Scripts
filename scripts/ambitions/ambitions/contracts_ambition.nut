this.contracts_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		ContractsToComplete = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.contracts";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们需要把自己打造成可以依靠的雇佣兵。\n让我们一次又一次地接受考验，毫无疑问地证明这一点！";
		this.m.UIText = "完成更多合同";
		this.m.TooltipText = "再完成8份任何形式的合同，以证明自己毫无疑问是可靠的。";
		this.m.SuccessText = "[img]gfx/ui/events/event_62.png[/img]刚开始的时候，全世界都看到了你的本来面目：带着武器的野心。 每个人都有一个梦想，大约一半的人身上都有武器。 你不是唯一的，不是杰出的，甚至不是特别危险的，如果你让你过去的自己看起来很好。 但你成功了。 门在你面前关上了。 讨价还价的尝试让你失去了好买卖。 随地吐痰。吐了那么多口水。 这是一个寒冷的世界，你敢于温暖自己。你成功了。\n\n 你手头上的合同，地平线上的合同，他们都模糊在一起。 一种胜利的文化已经开始席卷 %companyname%，你有充分的理由为自己的指挥权感到自豪。";
		this.m.SuccessButtonText = "我们正在为自己扬名。";
	}

	function getUIText()
	{
		local d = 8 - (this.m.ContractsToComplete - this.World.Contracts.getContractsFinished());
		return this.m.UIText + " (" + this.Math.min(8, d) + "/8)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 1)
		{
			return;
		}

		if (this.World.Contracts.getContractsFinished() >= 15)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.ContractsToComplete = this.World.Contracts.getContractsFinished() + 8;
		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Contracts.getContractsFinished() >= this.m.ContractsToComplete)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU16(this.m.ContractsToComplete);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.ContractsToComplete = _in.readU16();
	}

});

