// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_overwhelm.nut
// Functions: 5

function create(this)
{
    this.m.ID = "perk.overwhelm";
    this.m.Name = this.Const.Strings.PerkName.Overwhelm;
    this.m.Description = this.Const.Strings.PerkDescription.Overwhelm;
    this.m.Icon = "ui/perks/perk_62.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onCombatFinished(this)
{
    this.skill.onCombatFinished();
    this.m.SkillCount = 0;
    this.m.LastTargetID = 0;
    return;
}

function onCombatStarted(this)
{
    this.m.SkillCount = 0;
    this.m.LastTargetID = 0;
    return;
}

function onTargetHit(this, _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
{
    if ((this.Tactical.TurnSequenceBar != r8) && (this.Tactical.TurnSequenceBar != r8))
    {
        return ((this.Tactical.TurnSequenceBar != r8) && (this.Tactical.TurnSequenceBar != r8));
    }
    if (_targetEntity.isAlliedWith(this.getContainer().getActor() || _targetEntity.isAlliedWith(this.getContainer().getActor())))
    {
        return (_targetEntity.isAlliedWith(this.getContainer().getActor()) || _targetEntity.isAlliedWith(this.getContainer().getActor()));
    }
    if ((!_targetEntity) && (!_targetEntity))
    {
        return ((!_targetEntity) && (!_targetEntity));
        if ((this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor()) && (this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor()))))
        {
            return ((this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor())) && (this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor())));
        }
        this.m.SkillCount = this.Const.SkillCounter;
        this.m.LastTargetID = _targetEntity.getID();
        _targetEntity.getSkills().add(this.new("scripts/skills/effects/overwhelmed_effect"));
    }
    return;
}

function onTargetMissed(this, _skill, _targetEntity)
{
    if ((this.Tactical.TurnSequenceBar != r5) && (this.Tactical.TurnSequenceBar != r5))
    {
        return ((this.Tactical.TurnSequenceBar != r5) && (this.Tactical.TurnSequenceBar != r5));
    }
    if (_targetEntity.isAlliedWith(this.getContainer().getActor() || _targetEntity.isAlliedWith(this.getContainer().getActor())))
    {
        return (_targetEntity.isAlliedWith(this.getContainer().getActor()) || _targetEntity.isAlliedWith(this.getContainer().getActor()));
    }
    if ((!_targetEntity) && (!_targetEntity))
    {
        return ((!_targetEntity) && (!_targetEntity));
        if ((this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor()) && (this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor()))))
        {
            return ((this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor())) && (this.m.LastTargetID == _targetEntity.isAlliedWith(this.getContainer().getActor())));
        }
        this.m.SkillCount = this.Const.SkillCounter;
        this.m.LastTargetID = _targetEntity.getID();
        this.m.SkillCount = this.Const.SkillCounter;
        _targetEntity.getSkills().add(this.new("scripts/skills/effects/overwhelmed_effect"));
    }
    return;
}
