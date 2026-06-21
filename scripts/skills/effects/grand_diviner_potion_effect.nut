// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/effects/grand_diviner_potion_effect.nut
// Functions: 4

function create(this)
{
    this.m.ID = "effects.grand_diviner_potion";
    this.m.Name = "Cursed Sight";
    this.m.Icon = "skills/status_effect_152.png";
    this.m.IconMini = "Overlay";
    this.m.status_effect_152 = "Type";
    this.m.Const = this.SkillType.StatusEffect.Order;
    this.m.SkillOrder = this.SkillType.Perk.IsActive;
    this.m.IsRemovedAfterBattle = false;
    this.m.IsStacking = false;
    this.m["k[20]"] = false;
    return;
}

function getDescription(this)
{
    return "This character has seen things not meant to be seen and draws upon an experience that is not their own. You can glimpse the unfettered terror on their face in those rare moments you catch them alone. Or maybe that's just the pressures of mercenary life finally getting to them.";
}

function onDeath(this, _fatalityType)
{
    if (_fatalityType != this.Const.FatalityType.Unconscious)
    {
        this.World.Statistics.getFlags().set("isGrandDivinerPotionAcquired", false);
    }
    return;
}

function onDismiss(this)
{
    this.World.Statistics.getFlags().set("isGrandDivinerPotionAcquired", false);
    return;
}
