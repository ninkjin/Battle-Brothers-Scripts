this.break_free_skill <- this.inherit("scripts/skills/skill", {
	m = {
		Decal = "",
		ChanceBonus = 0,
		SkillBonus = null
	},
	function setDecal( _d )
	{
		this.m.Decal = _d;
	}

	function setChanceBonus( _d )
	{
		this.m.ChanceBonus = _d;
	}

	function setSkillBonus( _d )
	{
		this.m.SkillBonus = _d;
	}

	function create()
	{
		this.m.ID = "actives.break_free";
		this.m.Name = "挣脱";
		this.m.Description = "利用你所能用到的一切，把你自己从束缚你的东西中解放出来。如果需要，可以砍、劈、割或啃！";
		this.m.Icon = "skills/active_15.png";
		this.m.IconDisabled = "skills/active_15_sw.png";
		this.m.Overlay = "active_15";
		this.m.SoundOnUse = [];
		this.m.Type = this.Const.SkillType.Active;
		this.m.Order = this.Const.SkillOrder.BeforeLast;
		this.m.IsSerialized = false;
		this.m.IsActive = true;
		this.m.IsTargeted = false;
		this.m.IsStacking = false;
		this.m.IsAttack = false;
		this.m.IsRemovedAfterBattle = true;
		this.m.ActionPointCost = 4;
		this.m.FatigueCost = 15;
		this.m.MinRange = 0;
		this.m.MaxRange = 0;
	}

	function getTooltip()
	{
		local chance = this.Math.min(100, this.getContainer().getActor().getCurrentProperties().getMeleeSkill() - 10 + this.m.ChanceBonus + (this.getContainer().getActor().getSkills().hasSkill("effects.goblin_shaman_potion") ? 100 : 0));
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			},
			{
				id = 3,
				type = "text",
				text = this.getCostString()
			},
			{
				id = 4,
				type = "text",
				icon = "ui/icons/melee_skill.png",
				text = "有[color=" + this.Const.UI.Color.PositiveValue + "]" + chance + "%[/color]基于近战技能的成功率。每次失败的尝试会增加之后尝试的成功率。"
			}
		];
	}

	function getChance()
	{
		return this.Math.min(100, this.getContainer().getActor().getCurrentProperties().getMeleeSkill() - 10 + this.m.ChanceBonus);
	}

	function isUsable()
	{
		return this.m.IsUsable && !this.isHidden();
	}

	function onVerifyTarget( _originTile, _targetTile )
	{
		return true;
	}

	function onUse( _user, _targetTile )
	{
		local skill = this.m.SkillBonus == null ? _user.getCurrentProperties().getMeleeSkill() : this.m.SkillBonus;
		local toHit = this.Math.min(100, skill - 10 + this.m.ChanceBonus + (_user.getSkills().hasSkill("effects.goblin_shaman_potion") ? 100 : 0));
		local rolled = this.Math.rand(1, 100);
		this.m.SkillBonus = null;
		this.Tactical.EventLog.log_newline();

		if (rolled <= toHit)
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + "挣脱束缚(几率：" + toHit + "，掷出：" + rolled + ")");

			if (this.m.SoundOnHit.len() != 0)
			{
				this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			_user.getSprite("status_rooted").Visible = false;
			_user.getSprite("status_rooted_back").Visible = false;

			if (this.m.Decal != "")
			{
				local ourTile = this.getContainer().getActor().getTile();
				local candidates = [];

				if (ourTile.Properties.has("IsItemSpawned") || ourTile.IsCorpseSpawned)
				{
					for( local i = 0; i < this.Const.Direction.COUNT; i = ++i )
					{
						if (!ourTile.hasNextTile(i))
						{
						}
						else
						{
							local tile = ourTile.getNextTile(i);

							if (tile.IsEmpty && !tile.Properties.has("IsItemSpawned") && !tile.IsCorpseSpawned && tile.Level <= ourTile.Level + 1)
							{
								candidates.push(tile);
							}
						}
					}
				}
				else
				{
					candidates.push(ourTile);
				}

				if (candidates.len() != 0)
				{
					local tileToSpawnAt = candidates[this.Math.rand(0, candidates.len() - 1)];
					tileToSpawnAt.spawnDetail(this.m.Decal);
					tileToSpawnAt.Properties.add("IsItemSpawned");
				}
			}

			_user.setDirty(true);
			this.getContainer().removeByID("effects.net");
			this.getContainer().removeByID("effects.rooted");
			this.getContainer().removeByID("effects.web");
			this.getContainer().removeByID("effects.kraken_ensnare");
			this.getContainer().removeByID("effects.serpent_ensnare");
			this.removeSelf();
			return true;
		}
		else
		{
			this.Tactical.EventLog.logEx(this.Const.UI.getColorizedEntityName(_user) + "无法挣脱(几率：" + toHit + "，掷出：" + rolled + ")");

			if (this.m.SoundOnMiss.len() != 0)
			{
				this.Sound.play(this.m.SoundOnMiss[this.Math.rand(0, this.m.SoundOnMiss.len() - 1)], this.Const.Sound.Volume.Skill, _targetTile.Pos);
			}

			this.m.ChanceBonus += 10;
			return false;
		}
	}

});

