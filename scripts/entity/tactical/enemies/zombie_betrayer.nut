// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_betrayer.nut
// Functions: 2

function create(this)
{
    this.zombie_knight.create();
    this.m.Type = this.Const.EntityType.ZombieBetrayer;
    this.m.BloodType = this.Const.BloodType.Dark;
    this.m.MoraleState = this.Const.MoraleState.Ignore;
    this.m.XP = this.Const.Tactical.Actor.ZombieBetrayer.XP;
    this.m.Name = this.Const.Strings.EntityName["this.m.Type"];
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_betrayer";
    return;
}

function onInit(this)
{
    this.zombie_knight.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.ZombieBetrayer);
    this.m.BaseProperties.SurroundedBonus = 10;
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.IsAffectedByInjuries = false;
    this.m.BaseProperties.IsImmuneToBleeding = true;
    this.m.BaseProperties.IsImmuneToPoison = true;
    this.m.BaseProperties.DamageTotalMult = 1.25;
    this.m.BaseProperties.DamageReceivedArmorMult = 0.75;
    this.m.BaseProperties.FatigueDealtPerHitMult = 2.0;
    this.m.Skills.update();
    return;
}
