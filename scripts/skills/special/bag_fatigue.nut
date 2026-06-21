// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/special/bag_fatigue.nut
// Functions: 2

function create(this)
{
    this.m.ID = "special.bag_fatigue";
    this.m.Name = "Icon";
    this.m.Type = "Icon";
    this.m.Const = this.SkillType.Special.Order;
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsHidden = false;
    this.m.IsSerialized = true;
    this.m["k[15]"] = false;
    return;
}

function onUpdate(this, _properties)
{
    foreach (local key, value in r18)
    {
        if ((r8 != null) && (r8 != null))
        {
            return ((r8 != null) && (r8 != null));
            _properties.Stamina = _properties.Stamina op43 (null.getStaminaModifier() / 2);
        }
        return;
    }
}
