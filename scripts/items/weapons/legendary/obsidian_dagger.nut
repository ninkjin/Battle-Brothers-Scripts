this.obsidian_dagger <- this.inherit("scripts/items/weapons/weapon", {
	m = {},
	function create()
	{
		this.weapon.create();
		this.m.ID = "weapon.obsidian_dagger";
		this.m.Name = "黑曜石匕首";
		this.m.Description = "一个隐居女巫用你的血炼制的石刀。镜子里的倒影似乎会自己移动，但这显然只是眼睛的把戏。然而非常奇怪的是，如果血滴落在黑曜石上，它似乎永远不会干涸。";
		this.m.Categories = "匕首，单手";
		this.m.IconLarge = "weapons/melee/obsidian_dagger_01.png";
		this.m.Icon = "weapons/melee/obsidian_dagger_70x70.png";
		this.m.SlotType = this.Const.ItemSlot.Mainhand;
		this.m.ItemType = this.Const.Items.ItemType.Weapon | this.Const.Items.ItemType.MeleeWeapon | this.Const.Items.ItemType.OneHanded | this.Const.Items.ItemType.Legendary;
		this.m.IsDoubleGrippable = true;
		this.m.AddGenericSkill = true;
		this.m.ShowQuiver = false;
		this.m.ShowArmamentIcon = true;
		this.m.ArmamentIcon = "icon_obsidian_dagger";
		this.m.Condition = 1.0;
		this.m.ConditionMax = 1.0;
		this.m.Value = 5000;
		this.m.RegularDamage = 25;
		this.m.RegularDamageMax = 45;
		this.m.ArmorDamageMult = 0.7;
		this.m.DirectDamageMult = 0.2;
	}

	function getTooltip()
	{
		local result = this.weapon.getTooltip();
		result.push({
			id = 6,
			type = "text",
			icon = "ui/icons/special.png",
			text = "杀死的任何人类单位都将复活为丧尸为你而战"
		});
		return result;
	}

	function onEquip()
	{
		this.weapon.onEquip();
		this.addSkill(this.new("scripts/skills/actives/stab"));
		this.addSkill(this.new("scripts/skills/actives/puncture"));
	}

	function onDamageDealt( _target, _skill, _hitInfo )
	{
		this.weapon.onDamageDealt(_target, _skill, _hitInfo);

		if (!this.isKindOf(_target, "player") && !this.isKindOf(_target, "human"))
		{
			return;
		}

		if (_target.getHitpoints() > 0)
		{
			return;
		}

		if (_hitInfo.Tile.IsCorpseSpawned && _hitInfo.Tile.Properties.get("Corpse").IsResurrectable)
		{
			local corpse = _hitInfo.Tile.Properties.get("Corpse");
			corpse.Faction = this.Const.Faction.PlayerAnimals;
			corpse.Hitpoints = 1.0;
			corpse.Items = _target.getItems();
			corpse.IsConsumable = false;
			corpse.IsResurrectable = false;
			this.Time.scheduleEvent(this.TimeUnit.Rounds, this.Math.rand(1, 1), this.Tactical.Entities.resurrect, corpse);
		}
	}

});

