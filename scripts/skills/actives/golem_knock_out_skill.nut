// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_knock_out_skill.nut
// Functions: 2

function create(this)
{
    this.knock_out.create();
    this.m.ID = "actives.golem_knock_out";
    this.m.DirectDamageMult = 0.5;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.FatigueDealtPerHitMult = _properties.FatigueDealtPerHitMult op43 2.0;
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 20;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 35;
        _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.75;
    }
    return;
}
