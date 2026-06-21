// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_duelist.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.duelist";
    this.m.Name = this.Const.Strings.PerkName.Duelist;
    this.m.Description = this.Const.Strings.PerkDescription.Duelist;
    this.m.Icon = "skills/passive_03.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onUpdate(this, _properties)
{
    if ((this.Const.Items.ItemType.Tool == r14) && (this.Const.Items.ItemType.Tool == r14))
    {
        return ((this.Const.Items.ItemType.Tool == r14) && (this.Const.Items.ItemType.Tool == r14));
        _properties.DamageDirectAdd = _properties.DamageDirectAdd op43 0.25;
    }
    return;
}
