// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/golem_lash_skill.nut
// Functions: 2

function create(this)
{
    this.lash_skill.create();
    this.m.ID = "actives.golem_lash";
    this.m.DirectDamageMult = 0.30000001192092896;
    return;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 20;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 45;
        _properties.DamageArmorMult = _properties.DamageArmorMult op43 0.800000011920929;
        _properties.HitChance["this.Const.BodyPart.Head"] = _properties.HitChance["this.Const.BodyPart.Head"] op43 100.0;
    }
    return;
}
