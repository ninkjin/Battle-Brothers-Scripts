// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_decapitate_skill.nut
// Functions: 2

function create(this)
{
    this.decapitate.create();
    this.m.ID = "actives.golem_decapitate";
    this.m.DirectDamageMult = 0.25;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_targetEntity == null)
    {
        return;
    }
    if (_skill == this)
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 20;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 35;
        _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.75;
        _properties.DamageRegularMult = _properties.DamageRegularMult op43 (1.0 - (_targetEntity.getHitpoints() / (_targetEntity.getHitpointsMax() * 1.0)));
    }
    return;
}
