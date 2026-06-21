this.player_corpse_stub <- {
	m = {
		CombatStats = null,
		LifetimeStats = null,
		OriginalID = 0,
		Name = "",
		Title = "",
		DaysWithCompany = 0,
		Level = 0,
		DailyCost = 0
	},
	function getName()
	{
		if (this.m.Title.len() != 0)
		{
			return this.m.Name + " " + this.m.Title;
		}
		else
		{
			return this.m.Name;
		}
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getTitle()
	{
		return this.m.Title;
	}

	function setName( _n )
	{
		this.m.Name = _n;
	}

	function setTitle( _t )
	{
		this.m.Title = _t;
	}

	function getCombatStats()
	{
		return this.m.CombatStats;
	}

	function setCombatStats( _s )
	{
		this.m.CombatStats = clone _s;
	}

	function setLifetimeStats( _s )
	{
		this.m.LifetimeStats = clone _s;
	}

	function isLeveled()
	{
		return false;
	}

	function getDaysWounded()
	{
		return 0;
	}

	function getOriginalID()
	{
		return this.m.OriginalID;
	}

	function setOriginalID( _id )
	{
		this.m.OriginalID = _id;
	}

	function isAlive()
	{
		return false;
	}

	function getImagePath()
	{
		return "tacticalentity(" + this.Math.rand() + "," + this.getID() + ")";
	}

	function getImageOffsetX()
	{
		return 0;
	}

	function getImageOffsetY()
	{
		return 0;
	}

	function getRosterTooltip()
	{
		local tooltip = [
			{
				id = 1,
				type = "title",
				text = this.getName()
			}
		];
		local time = this.m.DaysWithCompany;
		local text;

		if (time == -1)
		{
			text = "从一开始就在战团里。";
		}
		else if (time > 1)
		{
			text = "跟随战团" + time + "天。";
		}
		else
		{
			text = "刚加入战团。";
		}

		if (this.m.LifetimeStats.Battles != 0)
		{
			text = text + ("参加了" + this.m.LifetimeStats.Battles + "战斗并且达成" + this.m.LifetimeStats.Kills + "次击杀。");
		}

		if (this.m.LifetimeStats.MostPowerfulVanquished != "")
		{
			text = text + ("他曾击败过的最强对手是" + this.m.LifetimeStats.MostPowerfulVanquished + "。");
		}

		tooltip.push({
			id = 2,
			type = "description",
			text = text
		});
		tooltip.push({
			id = 5,
			type = "text",
			icon = "ui/icons/xp_received.png",
			text = "等级" + this.m.Level
		});

		if (this.m.DailyCost != 0)
		{
			tooltip.push({
				id = 3,
				type = "text",
				icon = "ui/icons/asset_daily_money.png",
				text = "支付[img]gfx/ui/tooltips/money.png[/img]" + this.m.DailyCost + "每日"
			});
		}

		return tooltip;
	}

	function create()
	{
	}

	function onInit()
	{
		this.setAlwaysApplySpriteOffset(true);
	}

};

