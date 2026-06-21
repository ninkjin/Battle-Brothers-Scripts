// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_shield_bash.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.shield_bash";
    this.m.Name = this.Const.Strings.PerkName.ShieldBash;
    this.m.Description = this.Const.Strings.PerkDescription.ShieldBash;
    this.m.Icon = "ui/perks/perk_22.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onTriggeredMovement(this, _skill, _targetEntity, _hitInfo)
{
    if ((r5 == _skill) && (r5 == _skill))
    {
        return ((r5 == _skill) && (r5 == _skill));
        _hitInfo.DamageRegular = _hitInfo.DamageRegular op43 ((this.Math.rand(10, 25) * this.getContainer().getActor().getCurrentProperties().DamageTotalMult) * this.getContainer().getActor().getCurrentProperties().DamageRegularMult);
        _hitInfo.DamageFatigue = _hitInfo.DamageFatigue op43 10;
        _hitInfo.DamageArmor = _hitInfo.DamageArmor op43 this.Math.floor(((this.Math.rand(10, 25) * this.getContainer().getActor().getCurrentProperties().DamageTotalMult) * 0.5));
    }
    return;
}
