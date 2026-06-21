// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_gifted.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.gifted";
    this.m.Name = this.Const.Strings.PerkName.Gifted;
    this.m.Description = this.Const.Strings.PerkDescription.Gifted;
    this.m.Icon = "ui/perks/perk_21.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onAdded(this)
{
    if (!this.m.IsApplied)
    {
        this.m.IsApplied = true;
        this.getContainer().getActor().m.LevelUps = this.getContainer().getActor().m.LevelUps op43 1;
        this.getContainer().getActor().fillAttributeLevelUpValues(1, true);
    }
    return;
}

function onDeserialize(this, _in)
{
    this.skill.onDeserialize(_in);
    this.m.IsApplied = true;
    return;
}
