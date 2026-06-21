// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/items/firearms_resistance_skill.nut
// Functions: 3

function create(this)
{
    this.m.ID = "items.firearms_resistance";
    this.m.Type = this.Const.SkillType.Item;
    this.m.Order = this.Const.SkillOrder.Item;
    this.m.IsActive = false;
    this.m.IsHidden = true;
    this.m.IsStacking = false;
    this.m.IsSerialized = false;
    this.m.IsRemovedAfterBattle = false;
    return;
}

function onBeforeDamageReceived(this, _attacker, _skill, _hitInfo, _properties)
{
    if (_skill == null)
    {
        return;
    }
    if ((_skill.getID() == "actives.fire_mortar") || (_skill.getID() == "actives.fire_mortar"))
    {
        return ((_skill.getID() == "actives.fire_mortar") || (_skill.getID() == "actives.fire_mortar"));
        _properties.DamageReceivedTotalMult = _properties.DamageReceivedTotalMult op42 0.6600000262260437;
    }
    return;
}

function onUpdate(this, _properties)
{
    _properties.DamageReceivedFireMult = _properties.DamageReceivedFireMult op42 0.6600000262260437;
    return;
}
