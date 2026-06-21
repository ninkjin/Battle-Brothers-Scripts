// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/fault_finder.nut
// Functions: 4

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/knife"));
    }
    if (this.Math.rand(1, 3) == 2)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
    }
    if (this.Math.rand(1, 3) == 3)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
    }
    this.m.Items.equip(this.new("scripts/items/armor/golems/fault_finder_robes"));
    if (this.Math.rand(1, 6) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/golems/fault_finder_book_head"));
    }
    if (this.Math.rand(1, 6) <= 3)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/golems/fault_finder_facewrap"));
    }
    this.m.Items.equip(this.new("scripts/items/helmets/golems/fault_finder_eye_mask"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.FaultFinder;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.FaultFinder.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.Necromancer;
    this.m.Hairs = this.Const.Hair.Necromancer;
    this.m.HairColors = this.Const.HairColors.Zombie;
    this.m.Beards = null;
    this.m.ConfidentMoraleBrush = "icon_confident_undead";
    this.m.SoundPitch = 0.8999999761581421;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/fault_finder_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.FaultFinder);
    this.m.BaseProperties.TargetAttractionMult = 3.0;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.Vision = 8;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_undead");
    this.getSprite("head").Color = this.createColor("#ffffff");
    this.getSprite("head").Saturation = 1.0;
    this.getSprite("body").Saturation = 0.6000000238418579;
    this.m.Skills.add(this.new("scripts/skills/actives/flesh_pull_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/corpse_explosion_skill"));
    return;
}
