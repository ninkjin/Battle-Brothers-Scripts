this.renown_tutorial_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.renown_tutorial";
		this.m.Title = "在途中…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_82.png[/img]当战团稍作休息时，你坐下来检查不久前一支箭穿透你体侧造成的伤口。它一直在慢慢愈合，如果你动作太快还是会疼，但情况正在好转。%bro1%靠近了你，抓住这个机会和他的团长谈话。%SPEECH_ON%在我看来，还没有人知道%companyname%。我们不想永远在树林里猎杀衣衫篓缕的强盗，但在贵族家族能注意到我们之前，我们首先需要打出自己是可靠佣兵的名声。我敢肯定，他们会想让战团去完成些报酬很好的任务。%SPEECH_OFF%他调整好武器带，继续道。%SPEECH_ON%只是我们要记住，大领主们在玩一场危险的游戏，我们不会想站到他们对立一面的。已经有足够多的故事讲述有人冒犯他们最终被切成四块拿去喂了猪，而且他们有能力压扁一整团佣兵。%SPEECH_OFF%他停了一会儿，又加了一个念头。%SPEECH_ON%乡镇的工会长和议员们记性也很好。我们现在需要他们来让战团得到雇佣，但如果有些有影响力的朋友，跟商人做生意也更容易有好价格。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我会记住的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local bro = this.World.getPlayerRoster().getAll()[0];
				this.Characters.push(bro.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Contracts.getContractsFinished() < 2)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.tutorial")
		{
			return;
		}

		this.m.Score = 5000;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro1",
			this.World.getPlayerRoster().getAll()[0].getName()
		]);
	}

	function onClear()
	{
	}

});

