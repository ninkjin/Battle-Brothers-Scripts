// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/serpent_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Serpent;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.KnockBack"] = 4.0;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageMelee"] = 0.019999999552965164;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.AttackDefault"] = 10.0;
    this.m.Properties.TargetPriorityHitchanceMult = 0.25;
    this.m.Properties.TargetPriorityHitpointsMult = 0.5;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.25;
    this.m.Properties.TargetPriorityFleeingMult = 0.75;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityCounterSkillsMult = 0.75;
    this.m.Properties.OverallDefensivenessMult = 0.0;
    this.m.Properties.OverallFormationMult = 1.0;
    this.m.Properties.EngageAgainstSpearwallMult = 1.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.3300000429153442;
    this.m.Properties.EngageFlankingMult = 1.0;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 0.10000000149011612;
    this.m.Properties.EngageLockDownTargetMult = 2.0;
    this.m.Properties.PreferCarefulEngage = true;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_flee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_retreat"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_melee"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_break_free"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_attack_default"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_defend_knock_back"));
    return;
}

function onUpdate(this)
{
    foreach (local key, value in r98)
    {
        if (null.getID() == this.getActor().getID())
        {
        }
        if ((!null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions()) && (!null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions())) && (!null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions()))))
        {
            return ((!null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions())) && (!null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions())) && (!null.getTile().hasZoneOfOccupationOtherThan(null.getAlliedFactions())));
            if (null.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.Idle).queryTargetsInMeleeRange(2, 3).len() == 0)
            {
            }
            foreach (local key, value in r28)
            {
                if ((!null.getCurrentProperties().IsImmuneToKnockBackAndGrab) && (!null.getCurrentProperties().IsImmuneToKnockBackAndGrab))
                {
                    return ((!null.getCurrentProperties().IsImmuneToKnockBackAndGrab) && (!null.getCurrentProperties().IsImmuneToKnockBackAndGrab));
                }
                if (true)
                {
                }
                if (true)
                {
                    this.m.Properties.PreferWait = true;
                }
                this.m.Properties.PreferWait = false;
                if (!this.getStrategy().getStats().IsEngaged)
                {
                    this.m.Properties.EngageRangeMin = 1;
                    this.m.Properties.EngageRangeMax = 3;
                    this.m.Properties.EngageRangeIdeal = 3;
                }
                this.m.Properties.EngageRangeMin = 1;
                this.m.Properties.EngageRangeMax = 1;
                this.m.Properties.EngageRangeIdeal = 1;
                return;
            }
        }
    }
}
