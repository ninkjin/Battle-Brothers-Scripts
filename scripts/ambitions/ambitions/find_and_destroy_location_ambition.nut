this.find_and_destroy_location_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.find_and_destroy_location";
		this.m.Duration = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "让我们踏上荒野，探索未知，并抢掠它。\n无论是巫师的坟墓，哥布林营地，或者我们能找到的任何东西。";
		this.m.UIText = "发现一个废墟或敌对营地，并摧毁它";
		this.m.TooltipText = "通过自己探索这片土地，发现一处废墟、营地或其他敌对地点，摧毁它，并夺取战利品。";
		this.m.SuccessText = "[img]gfx/ui/events/event_65.png[/img]在当时，这听起来是个好主意，但在没有地图或任何目的地的荒野中行走，结果证明是一种相当费劲的寻找财富的方式，甚至是一场战斗。 不过，你的脚痛队伍最终还是找到了一个有价值的目标，所有人都不得不同意这一冒险毕竟是值得的。%farmer% 正以几乎满意得容光焕发的神情审视余烬下的 %recently_destroyed%。%SPEECH_ON%他们一点儿也不知道我们要来。 就像镰刀前的麦子，兄弟们！%SPEECH_OFF%%notfarmer%挑了挑眉毛。%SPEECH_ON%为自己说的吧。我不是农夫。%SPEECH_OFF%";
		this.m.SuccessButtonText = "又一个挑战被征服了。";
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastLocationDestroyedFaction") != 0 && this.World.Statistics.getFlags().get("LastLocationDestroyedForContract") == false)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastLocationDestroyedFaction") != 0 && this.World.Statistics.getFlags().get("LastLocationDestroyedForContract") == false)
		{
			return true;
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local farmers = [];
		local workers = [];
		local not_farmers = [];

		if (brothers.len() > 2)
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
			if (bro.getBackground().getID() == "background.farmhand")
			{
				farmers.push(bro);
			}
			else if (bro.getBackground().getID() == "background.shepherd" || bro.getBackground().getID() == "background.miller" || bro.getBackground().getID() == "background.daytaler")
			{
				workers.push(bro);
			}
			else
			{
				not_farmers.push(bro);
			}
		}

		local farmer;

		if (farmers.len() != 0)
		{
			farmer = farmers[this.Math.rand(0, farmers.len() - 1)];
		}
		else if (workers.len() != 0)
		{
			farmer = workers[this.Math.rand(0, workers.len() - 1)];
		}
		else
		{
			farmer = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		local not_farmer;

		if (not_farmers.len() != 0)
		{
			not_farmer = not_farmers[this.Math.rand(0, not_farmers.len() - 1)];
		}
		else
		{
			not_farmer = brothers[this.Math.rand(0, brothers.len() - 1)];
		}

		_vars.push([
			"farmer",
			farmer.getName()
		]);
		_vars.push([
			"notfarmer",
			not_farmer.getName()
		]);
		_vars.push([
			"recently_destroyed",
			this.World.Statistics.getFlags().get("LastLocationDestroyedName")
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

