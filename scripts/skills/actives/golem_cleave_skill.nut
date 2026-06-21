// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_cleave_skill.nut
// Functions: 2

function create(this)
{
    this.cleave.create();
    this.m.ID = "actives.golem_cleave";
    this.m.DirectDamageMult = 0.25;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 20;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 35;
        _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.75;
    }
    return;
}
