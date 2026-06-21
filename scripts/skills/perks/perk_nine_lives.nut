// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_nine_lives.nut
// Functions: 7

function create(this)
{
    this.m.ID = "perk.nine_lives";
    this.m.Name = this.Const.Strings.PerkName.NineLives;
    this.m.Description = this.Const.Strings.PerkDescription.NineLives;
    this.m.Icon = "ui/perks/perk_07.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function getLastFrameUsed(this)
{
    return this.m.LastFrameUsed;
}

function isSpent(this)
{
    return this.m.IsSpent;
}

function onCombatFinished(this)
{
    this.m.IsSpent = false;
    this.m.LastFrameUsed = 0;
    this.skill.onCombatFinished();
    return;
}

function onCombatStarted(this)
{
    this.m.IsSpent = false;
    this.m.LastFrameUsed = 0;
    return;
}

function onUpdate(this, _properties)
{
    if ((this.m.LastFrameUsed == this.Time) && (this.m.LastFrameUsed == this.Time))
    {
        return ((this.m.LastFrameUsed == this.Time) && (this.m.LastFrameUsed == this.Time));
        this.getContainer().removeByType(this.Const.SkillType.DamageOverTime);
    }
    return;
}

function setSpent(this, _f)
{
    if ((!this.m.IsSpent) && (!this.m.IsSpent))
    {
        return ((!this.m.IsSpent) && (!this.m.IsSpent));
        this.getContainer().add(this.new("scripts/skills/effects/nine_lives_effect"));
    }
    this.m.IsSpent = _f;
    this.m.LastFrameUsed = this.Time.getFrame();
    return;
}
