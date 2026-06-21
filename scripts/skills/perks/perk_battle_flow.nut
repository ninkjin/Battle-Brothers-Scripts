// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_battle_flow.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.battle_flow";
    this.m.Name = this.Const.Strings.PerkName.BattleFlow;
    this.m.Description = this.Const.Strings.PerkDescription.BattleFlow;
    this.m.Icon = "ui/perks/perk_41.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onTargetKilled(this, _targetEntity, _skill)
{
    if (!this.m.IsSpent)
    {
        this.m.IsSpent = true;
        this.getContainer().getActor().setFatigue(this.Math.max(0, (this.getContainer().getActor().getFatigue() - ((this.getContainer().getActor().getBaseProperties().Stamina * this.getContainer().getActor().getBaseProperties().StaminaMult) * 0.15000000596046448))));
        this.getContainer().getActor().setDirty(true);
    }
    return;
}

function onTurnStart(this)
{
    this.m.IsSpent = false;
    return;
}
