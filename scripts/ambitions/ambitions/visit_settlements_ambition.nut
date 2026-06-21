this.visit_settlements_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.visit_settlements";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我知道你们现在闲得发慌，而且我们还得宣传咱们的战队。让我们到处拜访每一处定居点！";
		this.m.UIText = "拜访每一座城镇与城堡";
		this.m.TooltipText = "拜访每一座村落，城镇，城堡来了解他们的商品与服务设施，并且推广战队。";
		this.m.SuccessText = "[img]gfx/ui/events/event_16.png[/img]你很快发现斯卡德尔（注：古代北欧诗人）所唱的旅行热情并不像他们说的那样普遍。你决定让战团开拓视野，但是这项决定却引起了不满，人们开始抱怨强行行军和辗转夜路。不过并不是所有人都参与抱怨。%SPEECH_ON%如果一天的行军或一夜的雨水让你筋疲力尽，你如何面对兽人的攻击？%SPEECH_OFF%%sergeantbrother%问道，只得到了一个尖刻的回答。%SPEECH_ON%保持干燥和警觉。%SPEECH_OFF%你催促他们前进，并在每个村庄和城镇鼓舞士气，他们将这个请求牢记在心，并参与打斗，昏倒在镇广场上，威胁商人，骚扰村庄的女孩。无论这些穷苦的商人和农民怎么看待你的战团，至少他们不会很快忘记你！探索了地图的边缘后，%companyname%的名字更广为人知，你对这片土地的了解也更深入了。";
		this.m.SuccessButtonText = "记住咱们的名字，“%companyname%”！";
	}

	function getTooltipText()
	{
		if (this.World.Ambitions.getActiveAmbition() == null)
		{
			return this.m.TooltipText;
		}
		else if (!this.onCheckSuccess())
		{
			local ret = this.m.TooltipText + "\n\n还有一些定居点要拜访。\n";
			local c = 0;
			local settlements = this.World.EntityManager.getSettlements();

			foreach( s in settlements )
			{
				if (!s.isVisited())
				{
					c = ++c;

					if (c <= 10)
					{
						ret = ret + ("\n- " + s.getName());
					}
					else
					{
						ret = ret + "\n... 以及更多!";
						break;
					}
				}
			}

			return ret;
		}
		else
		{
			local ret = this.m.TooltipText + "\n\n你已经完成了你打算做的事。\n";
			return ret;
		}
	}

	function onUpdateScore()
	{
		if (this.World.Ambitions.getDone() == 0 && (this.World.Assets.getOrigin().getID() != "scenario.deserters" || this.World.Assets.getOrigin().getID() != "scenario.raiders"))
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 2)
		{
			return;
		}

		local settlements = this.World.EntityManager.getSettlements();
		local notVisited = 0;

		foreach( s in settlements )
		{
			if (!s.isVisited())
			{
				notVisited = ++notVisited;
			}
		}

		if (notVisited < 4)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local settlements = this.World.EntityManager.getSettlements();
		local notVisited = 0;

		foreach( s in settlements )
		{
			if (!s.isVisited())
			{
				notVisited = ++notVisited;
			}
		}

		if (notVisited == 0)
		{
			return true;
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local bestBravery = 0;
		local bravest;

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
			if (bro.getCurrentProperties().getBravery() > bestBravery)
			{
				bestBravery = bro.getCurrentProperties().getBravery();
				bravest = bro;
			}
		}

		_vars.push([
			"sergeantbrother",
			bravest.getName()
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

