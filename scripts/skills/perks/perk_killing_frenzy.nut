// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_killing_frenzy.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.killing_frenzy";
    this.m.Name = this.Const.Strings.PerkName.KillingFrenzy;
    this.m.Description = this.Const.Strings.PerkDescription.KillingFrenzy;
    this.m.Icon = "ui/perks/perk_36.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onTargetKilled(this, _targetEntity, _skill)
{
    if (!_targetEntity.isAlliedWith(this.getContainer().getActor()))
    {
        if (this.getContainer().getActor().getSkills().getSkillByID("effects.killing_frenzy") != null)
        {
            this.getContainer().getActor().getSkills().getSkillByID("effects.killing_frenzy").reset();
        }
        this.getContainer().add(this.new("scripts/skills/effects/killing_frenzy_effect"));
    }
    return;
}

function onUpdate(this, _properties)
{
    _properties.TargetAttractionMult = _properties.TargetAttractionMult op42 1.2000000476837158;
    return;
}
