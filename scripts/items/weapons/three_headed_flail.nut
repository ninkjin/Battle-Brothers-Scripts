this.three_headed_flail <- this.inherit("scripts/items/weapons/weapon", {
	m = {
		LastSkillUse = 0
	},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.three_headed_flail";
		this.m.Name = "三头链枷";
		this.m.Description = "分分别用锁链连接在握把上的三个独立的锤头。每个头可以分别击中目标或击空，能绕过盾牌进行打击。";
		this.m.Categories = "链枷，单手";
		this.m.IconLarge = "weapons/melee/flail_three_headed_01.png";
		this.m.Icon = "weapons/melee/flail_three_headed_01_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded;
		this.m.ItemProperty = this.Const.Items.Property.IgnoresShieldwall;
		this.m.IsDoubleGrippable = true;
		this.m.IsAgainstShields = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_flail_three_headed_01";
		this.m.Value = 1500;
		this.m.ShieldDamage = 0;
		this.m.Condition = 60.0;
		this.m.ConditionMax = 60.0;
		this.m.StaminaModifier = -10;
		this.m.RegularDamage = 30;
		this.m.RegularDamageMax = 75;
		this.m.ArmorDamageMult = 1.0;
		this.m.DirectDamageMult = 0.3;
		this.m.ChanceToHitHead = 10;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/cascade_skill"));
		this.addSkill(this.new("scripts/skills/actives/hail_skill"));
	}

	function onUpdateProperties( _properties )
	{
		this.weapon.onUpdateProperties(_properties);
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		local actor = this.getContainer().getActor();

		if (actor == null || actor.isNull() || this.m.LastSkillUse == this.Const.SkillCounter)
		{
			return;
		}

		if (actor.isPlayerControlled() && _skill.getDirectDamage() < 1.0 && !_skill.isRanged() && this.m.ConditionMax > 1)
		{
			this.m.LastSkillUse = this.Const.SkillCounter;

			if (_target.getArmorMax(_hitInfo.BodyPart) >= 50 && _hitInfo.DamageInflictedArmor >= 5 || this.m.ConditionMax == 2)
			{
				this.lowerCondition();
			}
		}
	}

});

