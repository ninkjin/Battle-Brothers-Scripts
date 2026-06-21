// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_slash_skill.nut
// Functions: 2

function create(this)
{
    this.slash.create();
    this.m.ID = "actives.golem_slash";
    this.m.DirectDamageMult = 0.20000000298023224;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 30;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 40;
        _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.75;
        _properties.MeleeSkill = _properties.MeleeSkill op43 10;
    }
    return;
}
