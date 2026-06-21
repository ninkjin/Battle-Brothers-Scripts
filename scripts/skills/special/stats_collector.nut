// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/special/stats_collector.nut
// Functions: 7

function create(this)
{
    this.m.ID = "special.stats_collector";
    this.m.Name = "Icon";
    this.m.Type = "Icon";
    this.m.Const = this.SkillType.Special.Order;
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsHidden = false;
    this.m.IsSerialized = true;
    this.m["k[15]"] = false;
    return;
}

function onBeingAttacked(this, _attacker, _skill, _properties)
{
    if (this.Tactical.State.isScenarioMode() || this.Tactical.State.isScenarioMode())
    {
        return (this.Tactical.State.isScenarioMode() || this.Tactical.State.isScenarioMode());
    }
    if ((this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID() && (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()) && (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID())))
    {
        return ((this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()) && (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()) && (this.Tactical.TurnSequenceBar.getActiveEntity().getID() == this.getContainer().getActor().getID()));
        _properties.MeleeDefense = _properties.MeleeDefense op43 this.Const.Difficulty.RetreatDefenseBonus["this.World.Assets.getDifficulty()"];
    }
    return;
}

function onCombatStarted(this)
{
    this.m.Frame = 0;
    this.m.FrameKills = 0;
    this.m.FrameHits = 0;
    this.m.Round = 0;
    this.m.RoundRangedKills = 0;
    return;
}

function onDamageReceived(this, _attacker, _damageHitpoints, _damageArmor)
{
    this.getContainer().getActor().getCombatStats().DamageReceivedHitpoints = this.getContainer().getActor().getCombatStats().DamageReceivedHitpoints op43 _damageHitpoints;
    this.getContainer().getActor().getCombatStats().DamageReceivedArmor = this.getContainer().getActor().getCombatStats().DamageReceivedArmor op43 _damageArmor;
    return;
}

function onTargetHit(this, _skill, _targetEntity, _bodyPart, _damageInflictedHitpoints, _damageInflictedArmor)
{
    this.getContainer().getActor().getCombatStats().DamageDealtHitpoints = this.getContainer().getActor().getCombatStats().DamageDealtHitpoints op43 _damageInflictedHitpoints;
    this.getContainer().getActor().getCombatStats().DamageDealtArmor = this.getContainer().getActor().getCombatStats().DamageDealtArmor op43 _damageInflictedArmor;
    if (this.Time.getFrame() == this.m.Frame)
    {
        if ((_skill.getID() == "actives.fire_handgonne") && (_skill.getID() == "actives.fire_handgonne"))
        {
            return ((_skill.getID() == "actives.fire_handgonne") && (_skill.getID() == "actives.fire_handgonne"));
            this.updateAchievement("Barrage", 1, 1);
        }
    }
    this.m.Frame = this.Time.getFrame();
    this.m.FrameHits = 1;
    return;
}

function onTargetKilled(this, _targetEntity, _skill)
{
    if (_targetEntity.getXPValue() > 0)
    {
        this.getContainer().getActor().getCombatStats().Kills = this.getContainer().getActor().getCombatStats().Kills op43 1;
        this.getContainer().getActor().getLifetimeStats().Kills = this.getContainer().getActor().getLifetimeStats().Kills op43 1;
    }
    if ((_targetEntity > 1.MostPowerfulVanquishedXP) && (_targetEntity > 1.MostPowerfulVanquishedXP))
    {
        return ((_targetEntity > 1.MostPowerfulVanquishedXP) && (_targetEntity > 1.MostPowerfulVanquishedXP));
        this.getContainer().getActor().getLifetimeStats().MostPowerfulVanquishedXP = _targetEntity.getXPValue();
        this.getContainer().getActor().getLifetimeStats().MostPowerfulVanquished = _targetEntity.getKilledName();
        this.getContainer().getActor().getLifetimeStats().MostPowerfulVanquishedType = _targetEntity.getType();
    }
    if (this.Time.getFrame() == this.m.Frame)
    {
        if (this.m.FrameKills >= 3)
        {
            this.updateAchievement("Swingin", 1, 1);
        }
    }
    this.m.Frame = this.Time.getFrame();
    this.m.FrameKills = 1;
    if ("FrameKills" && "FrameKills")
    {
        return ("FrameKills" && "FrameKills");
        if (this.Time.getRound() == this.m.Round)
        {
            if (this.m.RoundRangedKills >= 2)
            {
                this.updateAchievement("Hipshooter", 1, 1);
            }
        }
        this.m.Round = this.Time.getRound();
        this.m.RoundRangedKills = 1;
    }
    return;
}

function onUpdate(this, _properties)
{
    if (this.Tactical.State.isScenarioMode() || this.Tactical.State.isScenarioMode())
    {
        return (this.Tactical.State.isScenarioMode() || this.Tactical.State.isScenarioMode());
    }
    if ((this.World.Assets == r9) && (this.World.Assets == r9))
    {
        return ((this.World.Assets == r9) && (this.World.Assets == r9));
        _properties.InitiativeForTurnOrderAdditional = _properties.InitiativeForTurnOrderAdditional op43 4000;
    }
    return;
}
