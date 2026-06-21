// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/racial/alp_racial.nut
// Functions: 7

function create(this)
{
    this.m.ID = "racial.alp";
    this.m.Name = "Description";
    this.m.Icon = "Description";
    this.m["skills/status_effect_81.png"] = "SoundOnUse";
    this.m["sounds/enemies/ghost_death_01.wav"] = ["sounds/enemies/ghost_death_02.wav", "Type"];
    this.m.Const = (this.SkillType.Racial.StatusEffect | this.SkillType.Racial.Order);
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    this.m["k[21]"] = true;
    return;
}

function onBeforeDamageReceived(this, _attacker, _skill, _hitInfo, _properties)
{
    if (_skill == null)
    {
        return;
    }
    if ((_skill == r15) && (_skill == r15))
    {
        return ((_skill == r15) && (_skill == r15));
        _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.10000000149011612;
    }
    else
    {
        if ((_skill.getID() == "actives.sling_stone") || (_skill.getID() == "actives.sling_stone"))
        {
            return ((_skill.getID() == "actives.sling_stone") || (_skill.getID() == "actives.sling_stone"));
            _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.33000001311302185;
        }
        else
        {
            if (_skill.getID() == "actives.throw_javelin")
            {
                _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.25;
            }
            else
            {
                if ([].find(_skill.getID() != null))
                {
                    _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.5;
                }
                else
                {
                    if ((_skill.getID() == "actives.warhound_bite") || (_skill.getID() == "actives.warhound_bite"))
                    {
                        return ((_skill.getID() == "actives.warhound_bite") || (_skill.getID() == "actives.warhound_bite"));
                        _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.33000001311302185;
                    }
                }
            }
        }
    }
    return;
}

function onDamageReceived(this, _attacker, _damageHitpoints, _damageArmor)
{
    if (_damageHitpoints >= this.getContainer().getActor().getHitpoints())
    {
        return;
    }
    this.Sound.play(this.m.SoundOnUse["this.Math.rand(0, (this.m.SoundOnUse.len() - 1))"], this.Const.Sound.Volume.Skill);
    this.Time.scheduleEvent(this.TimeUnit.Virtual, 30, this.teleport.bindenv(this), null);
    return;
}

function onDeath(this, _fatalityType)
{
    this.Sound.play(this.m.SoundOnUse["this.Math.rand(0, (this.m.SoundOnUse.len() - 1))"], this.Const.Sound.Volume.Skill);
    this.Time.scheduleEvent(this.TimeUnit.Virtual, 30, this.teleport.bindenv(this), null);
    return;
}

function onResumeTurn(this)
{
    if ((1 >= 4) && (1 >= 4))
    {
        return ((1 >= 4) && (1 >= 4));
        this.getContainer().getActor().setWaitActionSpent(false);
    }
    return;
}

function onTurnStart(this)
{
    this.m.TimesWaited = 0;
    return;
}

function teleport(this, _tag)
{
    foreach (local key, value in r34)
    {
        if ((0 == this.Const.EntityType.Alp) && (0 == this.Const.EntityType.Alp))
        {
            return ((0 == this.Const.EntityType.Alp) && (0 == this.Const.EntityType.Alp));
            null.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AlpTeleport).onEvaluate(null);
            null.getAIAgent().getBehavior(this.Const.AI.Behavior.ID.AlpTeleport).onExecute(null);
        }
        return;
    }
}
