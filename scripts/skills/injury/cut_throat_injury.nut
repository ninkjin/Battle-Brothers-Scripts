this.cut_throat_injury <- this.inherit("scripts/skills/injury/injury", {
	m = {
		LastRoundApplied = 0
	},
	function create()
	{
		this.injury.create();
		this.m.ID = "injury.cut_throat";
		this.m.Name = "颈静脉割伤";
		this.m.Description = "脖子上的静脉被割开并大量出血，如果不进行治疗最终会导致死亡。如果幸存下来，之后一段时间也会因失血而体质严重下降，并会留下一道可怕的疤痕。";
		this.m.KilledString = "流血至死";
		this.m.Type = this.m.Type | this.Const.SkillType.TemporaryInjury;
		this.m.DropIcon = "injury_icon_30";
		this.m.Icon = "ui/injury/injury_icon_30.png";
		this.m.IconMini = "injury_icon_30_mini";
		this.m.HealingTimeMin = 1;
		this.m.HealingTimeMax = 4;
		this.m.IsShownOnArm = true;
		this.m.IsAlwaysInEffect = true;
	}

	function getTooltip()
	{
		local ret = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];

		if (!this.m.IsShownOutOfCombat)
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "这个角色将持续每回合失去[color=" + this.Const.UI.Color.NegativeValue + "]6[/color]生命值"
			});
		}
		else
		{
			ret.push({
				id = 7,
				type = "text",
				icon = "ui/icons/health.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-50%[/color]生命值"
			});
		}

		this.addTooltipHint(ret);
		return ret;
	}

	function applyDamage()
	{
		if (!this.m.IsShownOutOfCombat && this.m.LastRoundApplied != this.Time.getRound())
		{
			this.m.LastRoundApplied = this.Time.getRound();
			this.spawnIcon("status_effect_01", this.getContainer().getActor().getTile());
			local hitInfo = clone this.Const.Tactical.HitInfo;
			hitInfo.DamageRegular = 6;
			hitInfo.DamageDirect = 1.0;
			hitInfo.BodyPart = this.Const.BodyPart.Body;
			hitInfo.BodyDamageMult = 1.0;
			hitInfo.FatalityChanceMult = 0.0;
			this.getContainer().getActor().onDamageReceived(this.getContainer().getActor(), this, hitInfo);
		}
	}

	function onTurnEnd()
	{
		this.applyDamage();
	}

	function onWaitTurn()
	{
		this.applyDamage();
	}

	function onUpdate( _properties )
	{
		this.injury.onUpdate(_properties);

		if (this.m.IsShownOutOfCombat)
		{
			_properties.HitpointsMult *= 0.5;
		}
	}

});

