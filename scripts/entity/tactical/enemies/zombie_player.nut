// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_player.nut
// Functions: 2

function create(this)
{
    this.zombie.create();
    this.m.Type = this.Const.EntityType.ZombieYeoman;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.ZombiePlayer.XP;
    this.m.ResurrectionValue = 3.0;
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_player";
    return;
}

function onInit(this)
{
    this.zombie.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.ZombiePlayer);
    this.m.BaseProperties.SurroundedBonus = 10;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.FatigueDealtPerHitMult = 2.0;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.InjuryType = 1;
    this.getSprite("injury").setBrush("zombify_01");
    return;
}
