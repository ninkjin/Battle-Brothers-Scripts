// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_thrust_skill.nut
// Functions: 2

function create(this)
{
    this.thrust.create();
    this.m.ID = "actives.golem_thrust";
    this.m.DirectDamageMult = 0.20000000298023224;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 25;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 30;
        _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.8999999761581421;
        _properties.MeleeSkill = _properties.MeleeSkill op43 20;
    }
    return;
}
