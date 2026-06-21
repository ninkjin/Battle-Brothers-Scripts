// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/agents/hexe_agent.nut
// Functions: 3

function create(this)
{
    this.agent.create();
    this.m.ID = this.Const.AI.Agent.ID.Hexe;
    this.m.Properties.BehaviorMult["this.Const.AI.Behavior.ID.EngageRanged"] = 0.5;
    this.m.Properties.IsRangedUnit = true;
    this.m.Properties.TargetPriorityHitchanceMult = 0.0;
    this.m.Properties.TargetPriorityHitpointsMult = 0.4000000059604645;
    this.m.Properties.TargetPriorityRandomMult = 0.0;
    this.m.Properties.TargetPriorityDamageMult = 0.0;
    this.m.Properties.TargetPriorityFleeingMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityHittingAlliesMult = 0.10000000149011612;
    this.m.Properties.TargetPriorityFinishOpponentMult = 2.75;
    this.m.Properties.TargetPriorityCounterSkillsMult = 1.0;
    this.m.Properties.TargetPriorityArmorMult = 1.0;
    this.m.Properties.TargetPriorityMoraleMult = 0.0;
    this.m.Properties.TargetPriorityBraveryMult = 0.6000000238418579;
    this.m.Properties.OverallDefensivenessMult = 1.0;
    this.m.Properties.OverallFormationMult = 0.5;
    this.m.Properties.EngageWhenAlreadyEngagedMult = 0.0;
    this.m.Properties.EngageTargetMultipleOpponentsMult = 1.0;
    this.m.Properties.EngageOnGoodTerrainBonusMult = 1.0;
    this.m.Properties.EngageOnBadTerrainPenaltyMult = 1.0;
    this.m.Properties.EngageAgainstSpearwallMult = 0.25;
    this.m.Properties.EngageAgainstSpearwallWithShieldwallMult = 0.25;
    this.m.Properties.EngageTargetArmedWithRangedWeaponMult = 1.0;
    this.m.Properties.EngageTargetAlreadyBeingEngagedMult = 1.0;
    this.m.Properties.EngageLockDownTargetMult = 1.0;
    this.m.Properties.EngageRangeMin = 1;
    this.m.Properties.EngageRangeMax = 8;
    this.m.Properties.EngageRangeIdeal = 8;
    this.m.Properties.PreferCarefulEngage = true;
    return;
}

function onAddBehaviors(this)
{
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_engage_ranged"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_charm"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_hex"));
    this.addBehavior(this.new("scripts/ai/tactical/behaviors/ai_use_potion"));
    return;
}

function onRoundStarted(this)
{
    this.agent.onRoundStarted();
    if (this.Time.getRound() == 1)
    {
        foreach (local key, value in r39)
        {
            if ((!null.getSkills().hasSkill("effects.charmed") && (!null.getSkills().hasSkill("effects.charmed")) && (!null.getSkills().hasSkill("effects.charmed"))))
            {
                return ((!null.getSkills().hasSkill("effects.charmed")) && (!null.getSkills().hasSkill("effects.charmed")) && (!null.getSkills().hasSkill("effects.charmed")));
                null.getSkills().add(this.new("scripts/skills/effects/fake_charmed_effect"));
            }
            return;
        }
    }
}
