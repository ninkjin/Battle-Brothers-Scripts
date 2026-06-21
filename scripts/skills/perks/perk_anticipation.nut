// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_anticipation.nut
// Functions: 2

function create(this)
{
    this.m.ID = "perk.anticipation";
    this.m.Name = this.Const.Strings.PerkName.Anticipation;
    this.m.Description = this.Const.Strings.PerkDescription.Anticipation;
    this.m.Icon = "ui/perks/perk_10.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onBeingAttacked(this, _attacker, _skill, _properties)
{
    _properties.RangedDefense = _properties.RangedDefense op43 this.Math.max(10, this.Math.floor((_attacker.getTile().getDistanceTo(this.getContainer().getActor().getTile()) * (1 + (this.getContainer().getActor().getBaseProperties().getRangedDefense() * 0.10000000149011612)))));
    return;
}
