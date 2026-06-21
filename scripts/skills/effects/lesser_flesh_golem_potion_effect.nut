// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/effects/lesser_flesh_golem_potion_effect.nut
// Functions: 4

function create(this)
{
    this.m.ID = "effects.lesser_flesh_golem_potion";
    this.m.Name = "Bizarre Steroid";
    this.m.Icon = "skills/status_effect_155.png";
    this.m.IconMini = "Overlay";
    this.m.status_effect_155 = "Type";
    this.m.Const = this.SkillType.StatusEffect.Order;
    this.m.SkillOrder = this.SkillType.Perk.IsActive;
    this.m.IsRemovedAfterBattle = false;
    this.m.IsStacking = false;
    this.m["k[20]"] = false;
    return;
}

function getDescription(this)
{
    return "This character's body has changed, arguably for the better, due to the application of an unnatural steroid.";
}

function onDeath(this, _fatalityType)
{
    if (_fatalityType != this.Const.FatalityType.Unconscious)
    {
        this.World.Statistics.getFlags().set("isLesserFleshGolemPotionAcquired", false);
    }
    return;
}

function onDismiss(this)
{
    this.World.Statistics.getFlags().set("isLesserFleshGolemPotionAcquired", false);
    return;
}
