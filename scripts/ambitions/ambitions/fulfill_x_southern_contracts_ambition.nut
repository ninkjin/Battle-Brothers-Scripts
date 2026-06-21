this.fulfill_x_southern_contracts_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		ContractsToFulfill = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.fulfill_x_southern_contracts";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "南方的城邦拥有很多的克朗。\n我们会在炽热的沙漠阳光下发财！";
		this.m.UIText = "履行城邦的合同";
		this.m.TooltipText = "向南旅行，访问南方的城邦并在那里找到工作。 接受并完成上层统治者的合同。";
		this.m.SuccessText = "[img]gfx/ui/events/event_150.png[/img]尽管南方人追求知识，举止得体，但他们不会误解你是一个雇佣兵。 在北方他们叫你佣兵，在这里他们叫你逐币者。 你对这两种归因都不太在意，只认识到一个残酷的现实，尽管他们鄙视你，但他们还是会寻找出你的工作，奖励你的能力，并为未来出现的危机记住你的账单。\n\n 这就是北方和南方的基石：强大的克朗。 语言，宗教，民族，都见鬼去吧。 一点金子不需要翻译，不需要调解，也不需要仲裁。 你对克朗的追求表明你对南方人是可靠的，你的名声也像他们的口袋一样深。";
		this.m.SuccessButtonText = "金子就是金子。";
	}

	function getUIText()
	{
		local d = 5 - (this.m.ContractsToFulfill - this.World.Statistics.getFlags().getAsInt("CityStateContractsDone"));
		return this.m.UIText + " (" + this.Math.min(5, d) + "/5)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("CityStateContractsDone") > 15)
		{
			return;
		}

		this.m.ContractsToFulfill = this.World.Statistics.getFlags().getAsInt("CityStateContractsDone") + 5;
		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("CityStateContractsDone") >= this.m.ContractsToFulfill)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU16(this.m.ContractsToFulfill);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.ContractsToFulfill = _in.readU16();
	}

});

