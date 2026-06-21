this.mood_check <- this.inherit("scripts/skills/skill", {
	m = {},
	function create()
	{
		this.m.ID = "special.mood_check";
		this.m.Name = "心情检定";
		this.m.Icon = "skills/status_effect_02.png";
		this.m.IconMini = "";
		this.m.Type = this.Const.SkillType.Special | this.Const.SkillType.Trait;
		this.m.Order = this.Const.SkillOrder.Trait + 600;
		this.m.IsActive = false;
		this.m.IsHidden = false;
		this.m.IsSerialized = false;
		this.m.IsStacking = true;
	}

	function getTooltip()
	{
		local ret;

		switch(this.getContainer().getActor().getMoodState())
		{
		case this.Const.MoodState.Neutral:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "这个角色满足于目前的进展。可以变得更好，也可以变得更糟。\n\n心情总是随着时间趋近这个状态。"
				}
			];
			break;

		case this.Const.MoodState.Concerned:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "对于一个过着艰难的雇佣兵生活的人而言并不少见，这个角色并不是很满意并且希望事情有所改善。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "只能有[color=" + this.Const.UI.Color.NegativeValue + "]稳定[/color]或更糟士气"
				}
			];
			break;

		case this.Const.MoodState.Disgruntled:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "最近的事件让这个角色对目前的进展感到失望和不满。这心情可能会消散，但如果有其它事件雪上加霜则可能变得更糟。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "只能有[color=" + this.Const.UI.Color.NegativeValue + "]动摇[/color]或更糟士气"
				}
			];
			break;

		case this.Const.MoodState.Angry:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "最近的事件让这个角色对周围的人愤怒和报复心。如果事情没有很快改善，这个角色可能决定逃离战团！"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "只能有[color=" + this.Const.UI.Color.NegativeValue + "]溃散[/color]或更糟士气"
				}
			];
			break;

		case this.Const.MoodState.InGoodSpirit:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "最近的事件使这个角色精神不错。这心情可能会被骨感的现实消散，但至少目前一切都很顺心。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "有[color=" + this.Const.UI.Color.PositiveValue + "]25%[/color]几率以自信的士气开始战斗"
				}
			];
			break;

		case this.Const.MoodState.Eager:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "最近的事件让这个角色渴望为战队战斗，对目前的进展感到高兴并激励他周围的人。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "有[color=" + this.Const.UI.Color.PositiveValue + "]50%[/color]几率以自信的士气开始战斗"
				}
			];
			break;

		case this.Const.MoodState.Euphoric:
			ret = [
				{
					id = 1,
					type = "title",
					text = this.getName()
				},
				{
					id = 2,
					type = "description",
					text = "最近的事件使这个角色处于一种兴奋的状态，他乐于投入时间为战队服务，并确信能战胜任何敌人。说真的，已经开始有点烦人了。"
				},
				{
					id = 11,
					type = "text",
					icon = "ui/icons/special.png",
					text = "有[color=" + this.Const.UI.Color.PositiveValue + "]75%[/color]几率以自信的士气开始战斗"
				}
			];
			break;
		}

		local changes = this.getContainer().getActor().getMoodChanges();

		foreach( change in changes )
		{
			if (change.Positive)
			{
				ret.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/positive.png",
					text = "" + change.Text + ""
				});
			}
			else
			{
				ret.push({
					id = 11,
					type = "hint",
					icon = "ui/tooltips/negative.png",
					text = "" + change.Text + ""
				});
			}
		}

		return ret;
	}

	function onCombatStarted()
	{
		local actor = this.getContainer().getActor();
		local mood = actor.getMoodState();
		local morale = actor.getMoraleState();
		local isDastard = this.getContainer().hasSkill("trait.dastard");

		switch(mood)
		{
		case this.Const.MoodState.Concerned:
			actor.setMaxMoraleState(this.Const.MoraleState.Steady);
			actor.setMoraleState(this.Const.MoraleState.Steady);
			break;

		case this.Const.MoodState.Disgruntled:
			actor.setMaxMoraleState(this.Const.MoraleState.Wavering);
			actor.setMoraleState(this.Const.MoraleState.Wavering);
			break;

		case this.Const.MoodState.Angry:
			actor.setMaxMoraleState(this.Const.MoraleState.Breaking);
			actor.setMoraleState(this.Const.MoraleState.Breaking);
			break;

		case this.Const.MoodState.Neutral:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);
			break;

		case this.Const.MoodState.InGoodSpirit:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);

			if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 25 && !isDastard)
			{
				actor.setMoraleState(this.Const.MoraleState.Confident);
			}

			break;

		case this.Const.MoodState.Eager:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);

			if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 50 && !isDastard)
			{
				actor.setMoraleState(this.Const.MoraleState.Confident);
			}

			break;

		case this.Const.MoodState.Euphoric:
			actor.setMaxMoraleState(this.Const.MoraleState.Confident);

			if (morale < this.Const.MoraleState.Confident && this.Math.rand(1, 100) <= 75 && !isDastard)
			{
				actor.setMoraleState(this.Const.MoraleState.Confident);
			}

			break;
		}
	}

	function onUpdate( _properties )
	{
		local mood = this.getContainer().getActor().getMoodState();
		local p = this.Math.round(this.getContainer().getActor().getMood() / (this.Const.MoodState.len() - 0.05) * 100.0);
		this.m.Name = this.Const.MoodStateName[mood] + " (" + p + "%)";

		switch(mood)
		{
		case this.Const.MoodState.Neutral:
			this.m.Icon = "skills/status_effect_64.png";
			break;

		case this.Const.MoodState.Concerned:
			this.m.Icon = "skills/status_effect_46.png";
			break;

		case this.Const.MoodState.Disgruntled:
			this.m.Icon = "skills/status_effect_45.png";
			break;

		case this.Const.MoodState.Angry:
			this.m.Icon = "skills/status_effect_44.png";
			break;

		case this.Const.MoodState.InGoodSpirit:
			this.m.Icon = "skills/status_effect_47.png";
			break;

		case this.Const.MoodState.Eager:
			this.m.Icon = "skills/status_effect_48.png";
			break;

		case this.Const.MoodState.Euphoric:
			this.m.Icon = "skills/status_effect_49.png";
			break;
		}
	}

});

