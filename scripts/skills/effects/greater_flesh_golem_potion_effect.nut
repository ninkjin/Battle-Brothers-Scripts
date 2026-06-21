// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/effects/greater_flesh_golem_potion_effect.nut
// Functions: 4

function create(this)
{
    this.m.ID = "effects.greater_flesh_golem_potion";
    this.m.Name = "Mutated Glands";
    this.m.Icon = "skills/status_effect_156.png";
    this.m.IconMini = "Overlay";
    this.m.status_effect_156 = "Type";
    this.m.Const = this.SkillType.StatusEffect.Order;
    this.m.SkillOrder = this.SkillType.Perk.IsActive;
    this.m.IsRemovedAfterBattle = false;
    this.m.IsStacking = false;
    this.m["k[20]"] = false;
    return;
}

function getDescription(this)
{
    return "This character's body has been irreversibly mutated, its chemical balance thrown into chaos by overproducing glands. By some miracle, it seems to have stabilized in a beneficial manner.";
}

function onDeath(this, _fatalityType)
{
    if (_fatalityType != this.Const.FatalityType.Unconscious)
    {
        this.World.Statistics.getFlags().set("isGreaterFleshGolemPotionAcquired", false);
    }
    return;
}

function onDismiss(this)
{
    this.World.Statistics.getFlags().set("isGreaterFleshGolemPotionAcquired", false);
    return;
}
