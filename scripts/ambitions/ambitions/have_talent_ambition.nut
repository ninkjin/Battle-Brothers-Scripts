this.have_talent_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.have_talent";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们需要真正的人才来进一步加强我们的队伍。\n我们会招募我们能找到的最有才华的人，把他塑造成战神！";
		this.m.UIText = "拥有一个同时具有三个三星的天才角色";
		this.m.TooltipText = "在你的花名册中有一个拥有三个不同属性的三星天赋的角色。 走遍天下，寻找精英中的精英。 考虑雇佣非战斗追随者的“招募者”。";
		this.m.SuccessText = "[img]gfx/ui/events/event_82.png[/img]当矿工在山里发现一颗钻石时，它被匆忙送到了王宫。 当渔夫钓到一天中最肥的鱼时，一个贵族就会把它占为己有。 好士兵？以将军或教官的身份给了领主。 优秀的裁缝？最好的衣服需要最漂亮的手指，他要为贵族服务。 驯兽师除了摆鼻子和吠叫命令外，还显示了一点技巧？ 他能为出身高贵的军队训练战犬。 所以，这个世界抓住天才的速度就像老鹰扑向自身暴露的兔子一样快。\n\n 但现在你有了自己的目标：%star%。他是一个真正的天才，在身体、军事技能和勇气方面表现出非凡的才能。 即使是 %companyname%的其他人也能感觉到这个人的存在，就像一个人能感觉到命运和伟大一样。%star% 是雇佣兵中你想要的一切，如果战队完全配备了像他那样的一类人，那么，你不仅仅是追逐合同，你还可以征服整个世界！";
		this.m.SuccessButtonText = "当然，除非下次战斗中他被一支流箭射中。";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.getTime().Days <= 100)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 3)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax() - 1)
		{
			return;
		}

		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local n = 0;

			foreach( t in bro.getTalents() )
			{
				if (t == 3)
				{
					n = ++n;
				}
			}

			if (n >= 3)
			{
				return;
			}
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local roster = this.World.getPlayerRoster().getAll();

		foreach( bro in roster )
		{
			local n = 0;

			foreach( t in bro.getTalents() )
			{
				if (t == 3)
				{
					n = ++n;
				}
			}

			if (n >= 3)
			{
				return true;
			}
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		local roster = this.World.getPlayerRoster().getAll();
		local star;

		foreach( bro in roster )
		{
			local n = 0;

			foreach( t in bro.getTalents() )
			{
				if (t == 3)
				{
					n = ++n;
				}
			}

			if (n >= 3)
			{
				star = bro;
				break;
			}
		}

		_vars.push([
			"star",
			star.getName()
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

