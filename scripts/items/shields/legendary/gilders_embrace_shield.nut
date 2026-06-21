this.gilders_embrace_shield <- this.inherit("scripts/items/shields/shield", {
	m = {},
	function create()
	{
		this.shield.create();
		this.m.ID = "shield.gilders_embrace";
		this.m.Name = "金铎之拥";
		this.m.Description = "一面华丽的金属盾牌，有明亮的镀金光泽，会用太阳本身的力量反射哪怕是最微弱的光线。";
		this.m.AddGenericSkill = true;
		this.m.ShowOnCharacter = true;
		this.m.SoundOnHit = this.Const.Sound.ShieldHitMetal;
		this.updateVariant();
		this.m.Value = 20000;
		this.m.MeleeDefense = 25;
		this.m.RangedDefense = 25;
		this.m.StaminaModifier = -16;
		this.m.Condition = 786;
		this.m.ConditionMax = 786;
	}

	function updateVariant()
	{
		this.m.Sprite = "shield_legendary_01";
		this.m.SpriteDamaged = "shield_legendary_01_damaged";
		this.m.ShieldDecal = "shield_legendary_01_destroyed";
		this.m.IconLarge = "shields/inventory_legendary_shield_01.png";
		this.m.Icon = "shields/icon_legendary_shield_01.png";
	}

	function getTooltip()
	{
		local result = [
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

		if (this.getIconLarge() != null)
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIconLarge(),
				isLarge = true
			});
		}
		else
		{
			result.push({
				id = 3,
				type = "image",
				image = this.getIcon()
			});
		}

		result.push({
			id = 66,
			type = "text",
			text = this.getValueString()
		});
		result.push({
			id = 4,
			type = "progressbar",
			icon = "ui/icons/asset_supplies.png",
			value = this.m.Condition,
			valueMax = this.m.ConditionMax,
			text = "" + this.m.Condition + " / " + this.m.ConditionMax + "",
			style = "armor-head-slim"
		});
		result.push({
			id = 5,
			type = "text",
			icon = "ui/icons/melee_defense.png",
			text = "近战防御[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.MeleeDefense + "[/color]"
		});
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/ranged_defense.png",
			text = "远程防御[color=" + this.Const.UI.Color.PositiveValue + "]+" + this.m.RangedDefense + "[/color]"
		});
		result.push({
			id = 7,
			type = "text",
			icon = "ui/icons/fatigue.png",
			text = "最大疲劳[color=" + this.Const.UI.Color.NegativeValue + "]" + this.m.StaminaModifier + "[/color]"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "坚不可摧"
		});
		result.push({
			id = 8,
			type = "text",
			icon = "ui/icons/special.png",
			text = "每个击打此盾牌的人都会受到‘茫然’效果"
		});
		return result;
	}

	function onEquip()
	{
		this.shield.onEquip();
		this.addSkill(this.new("scripts/skills/actives/shieldwall"));
		this.addSkill(this.new("scripts/skills/actives/knock_back"));
	}

	function onShieldHit( _attacker, _skill )
	{
		if (_attacker != null && _attacker.isAlive() && !_attacker.isDying() && !_attacker.getCurrentProperties().IsImmuneToDaze)
		{
			_attacker.getSkills().add(this.new("scripts/skills/effects/dazed_effect"));

			if (_attacker.getTile().IsVisibleForPlayer)
			{
				this.Tactical.EventLog.log(this.Const.UI.getColorizedEntityName(_attacker) + "被金铎之拥茫然了");
			}
		}
	}

	function applyShieldDamage( _damage, _playHitSound = true )
	{
		if (this.m.SoundOnHit.len() != 0)
		{
			this.Sound.play(this.m.SoundOnHit[this.Math.rand(0, this.m.SoundOnHit.len() - 1)], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
		}
	}

});

