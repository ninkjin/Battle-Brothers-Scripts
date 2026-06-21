// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/racial/flesh_golem_racial.nut
// Functions: 2

function create(this)
{
    this.m.ID = "racial.flesh_golem";
    this.m.Name = "Flesh Golem Racial";
    this.m.Description = "Icon";
    this.m.Type = "Icon";
    this.m.Const = ((this.SkillType.Racial.Perk | this.SkillType.Racial.StatusEffect) | this.SkillType.Racial.Order);
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    this.m["k[19]"] = true;
    return;
}

function onUpdate(this, _properties)
{
    _properties.ThresholdToReceiveInjuryMult = _properties.ThresholdToReceiveInjuryMult op42 0.699999988079071;
    _properties.MovementAPCostAdditional = _properties.MovementAPCostAdditional op43 2;
    return;
}
