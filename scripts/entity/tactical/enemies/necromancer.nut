// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/necromancer.nut
// Functions: 5

function assignRandomEquipment(this)
{
    if (this.Math.rand(0, 4) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/weapons/dagger"));
    }
    else
    {
        if (this.Math.rand(0, 4) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/weapons/knife"));
        }
        else
        {
            if (this.Math.rand(0, 4) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/weapons/butchers_cleaver"));
            }
            else
            {
                if (this.Math.rand(0, 4) == 4)
                {
                    this.m.Items.equip(this.new("scripts/items/weapons/scramasax"));
                }
            }
        }
    }
    if (this.Math.rand(1, 2) <= 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/ragged_dark_surcoat"));
    }
    else
    {
        if (this.Math.rand(1, 2) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/thick_dark_tunic"));
        }
    }
    if (this.Math.rand(1, 3) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/witchhunter_hat"));
    }
    else
    {
        if (this.Math.rand(1, 3) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/helmets/dark_cowl"));
        }
        else
        {
            if (this.Math.rand(1, 3) == 3)
            {
                this.new("scripts/items/helmets/hood").setVariant(63);
                this.m.Items.equip(this.new("scripts/items/helmets/hood"));
            }
        }
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Necromancer;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Necromancer.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.Necromancer;
    this.m.Hairs = this.Const.Hair.Necromancer;
    this.m.HairColors = this.Const.HairColors.Zombie;
    this.m.Beards = this.Const.Beards.Raider;
    this.m.ConfidentMoraleBrush = "icon_confident_undead";
    this.m.SoundPitch = 0.8999999761581421;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/necromancer_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function makeMiniboss(this)
{
    if (!this.actor.makeMiniboss())
    {
        return false;
    }
    this.getSprite("miniboss").setBrush("bust_miniboss");
    if (this.Const.DLC.Desert)
    {
        [].extend([]);
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    this.m.ActionPoints = ["weapons/named/named_dagger", "weapons/named/named_qatal_dagger"];
    this.m.BaseProperties.ActionPoints = 9;
    this.m.Skills.update();
    return [];
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    if (_killer.isPlayerControlled() && _killer.isPlayerControlled())
    {
        return (_killer.isPlayerControlled() && _killer.isPlayerControlled());
        this.updateAchievement("ManInBlack", 1, 1);
    }
    this.human.onDeath(_killer, _skill, _tile, _fatalityType);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Necromancer);
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
    this.m.Skills.add(this.new("scripts/skills/actives/raise_undead"));
    this.m.Skills.add(this.new("scripts/skills/actives/possess_undead_skill"));
    return;
}
