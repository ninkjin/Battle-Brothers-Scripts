this.weapon_mastery_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.weapon_mastery";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "想象一下，如果你的技能与你的勇敢相当，我们会留下怎样的恐怖痕迹。\n我们要训练五个人掌握他们的武器，以便他们可以充当先锋！";
		this.m.UIText = "每个人都有一个武器精通特技";
		this.m.TooltipText = "让你的5个人每人拥有一个武器精通特技，不管是哪一种武器。";
		this.m.SuccessText = "[img]gfx/ui/events/event_50.png[/img]引入一种新的方法来训练兄弟们掌握武器对每个人的士气都有好处。 那些进行训练的人提高了他们的能力和生存机会，赢得了同伴的钦佩，而其他人则坐在木头上吃羊肉，看着有趣的东西。\n\n受训者在每一个空闲时间都用各种各样的武器进行练习，直到坚硬的手臂变得像橡树树枝一样，锐利的眼睛变得像一只大猫一样敏锐和无情。%SPEECH_ON%不仅 %weaponbrother% 对我们的敌人是一个可怖的威胁，而且他敏捷的步法让你想到跳舞的女孩。%SPEECH_OFF%%notweaponbrother% 评论说，结果被人用训练剑狠狠地教育了，是 %weaponbrother%。";
		this.m.SuccessButtonText = "他们现在是专业人士了。";
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.Math.min(5, this.getBrosWithMastery()) + "/5)";
	}

	function getBrosWithMastery()
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local count = 0;

		foreach( bro in brothers )
		{
			local p = bro.getCurrentProperties();

			if (p.IsSpecializedInBows)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInCrossbows)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInThrowing)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInSwords)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInCleavers)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInMaces)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInHammers)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInAxes)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInFlails)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInSpears)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInPolearms)
			{
				count = ++count;
			}
			else if (p.IsSpecializedInDaggers)
			{
				count = ++count;
			}
		}

		return count;
	}

	function onUpdateScore()
	{
		if (this.World.getTime().Days <= 15)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		local count = this.getBrosWithMastery();

		if (count >= 3)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		local count = this.getBrosWithMastery();

		if (count >= 5)
		{
			return true;
		}

		return false;
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local not_candidates = [];

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
			local p = bro.getCurrentProperties();

			if (p.IsSpecializedInBows)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInCrossbows)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInThrowing)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInSwords)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInCleavers)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInMaces)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInHammers)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInAxes)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInFlails)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInSpears)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInPolearms)
			{
				candidates.push(bro);
			}
			else if (p.IsSpecializedInDaggers)
			{
				candidates.push(bro);
			}
			else
			{
				not_candidates.push(bro);
			}
		}

		if (not_candidates.len() == 0)
		{
			not_candidates = brothers;
		}

		_vars.push([
			"weaponbrother",
			candidates[this.Math.rand(0, candidates.len() - 1)].getName()
		]);
		_vars.push([
			"notweaponbrother",
			not_candidates[this.Math.rand(0, not_candidates.len() - 1)].getName()
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

