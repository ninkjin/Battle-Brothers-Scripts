// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/racial/grand_diviner_racial.nut
// Functions: 2

function create(this)
{
    this.m.ID = "racial.grand_diviner";
    this.m.Name = "Diviner's Fury";
    this.m.Description = "Icon";
    this.m["skills/status_effect_161.png"] = "IconMini";
    this.m.status_effect_161_mini = "Type";
    this.m.Const = ((this.SkillType.Racial.Perk | this.SkillType.Racial.StatusEffect) | this.SkillType.Racial.Order);
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    this.m["k[22]"] = false;
    return;
}

function onUpdate(this, _properties)
{
    foreach (local key, value in r19)
    {
        _properties.SkillCostAdjustments.push({});
        return;
    }
}
