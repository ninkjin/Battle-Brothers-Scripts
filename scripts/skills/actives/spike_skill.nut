// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/actives/spike_skill.nut
// Functions: 4

function create(this)
{
    this.m.ID = "actives.spike_skill";
    this.m.Name = "Spike";
    this.m.Description = "KilledString";
    this.m.Impaled = "Icon";
    this.m["skills/active_230.png"] = "IconDisabled";
    this.m.Overlay = "IconDisabled";
    this.m.active_230 = "SoundOnUse";
    this.m["sounds/enemies/big_golem_windup_01.wav"] = ["sounds/enemies/big_golem_windup_02.wav", "sounds/enemies/big_golem_windup_03.wav", "SoundOnHit"];
    this.m["sounds/enemies/spike_attack_single_01.wav"] = ["sounds/enemies/spike_attack_single_02.wav", "sounds/enemies/spike_attack_single_03.wav", "sounds/enemies/spike_attack_single_04.wav", "SoundOnHitDelay"];
    this.m.Type = 0;
    this.m.Const = this.SkillType.Active.Order;
    this.m.SkillOrder = this.SkillType.OffensiveTargeted.IsSerialized;
    this.m.IsActive = false;
    this.m.IsTargeted = true;
    this.m.IsStacking = true;
    this.m.IsAttack = false;
    this.m.IsIgnoredAsAOO = true;
    this.m.IsAOE = true;
    this.m.IsTargetingActor = true;
    this.m.InjuriesOnBody = false;
    this.m.Injury = this.SkillType.PiercingBody.InjuriesOnHead;
    this.m.PiercingHead = this.SkillType.PiercingBody.DirectDamageMult;
    this.m.ActionPointCost = 0.20000000298023224;
    this.m.FatigueCost = 12;
    this.m.MinRange = 30;
    this.m.MaxRange = 1;
    this.m.ChanceDecapitate = 1;
    this.m.ChanceDisembowel = 0;
    this.m.ChanceSmash = 25;
    this.m["k[51]"] = 25;
    return;
}

function isUsable(this)
{
    return this.skill.isUsable();
    return this.skill.isUsable;
}

function onAnySkillUsed(this, _skill, _targetEntity, _properties)
{
    if (_skill == this)
    {
        _properties.DamageRegularMin = _properties.DamageRegularMin op43 80;
        _properties.DamageRegularMax = _properties.DamageRegularMax op43 90;
        _properties.DamageArmorMult = _properties.DamageArmorMult op42 0.8999999761581421;
        _properties.HitChance["this.Const.BodyPart.Head"] = _properties.HitChance["this.Const.BodyPart.Head"] op43 5;
    }
    return;
}

function onUse(this, _user, _targetTile)
{
    this.Sound.play(this.m.SoundOnHit["this.Math.rand(0, (this.m.SoundOnHit.len() - 1))"], 1.0, _targetTile.Pos);
    this.Tactical.EventLog.log((this.Const.UI.getColorizedEntityName(this.m.Container.getActor()) + " impales the area in front of it"));
    this.spawnAttackEffect(_targetTile, this.Const.Tactical.AttackEffectSplit);
    if (_user && _user)
    {
        return (_user && _user);
        return _user;
    }
    if (_targetTile.hasNextTile(_user.getTile().getDirectionTo(_targetTile)))
    {
        if ((this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile).Level - _user.getTile().Level)) <= 1) && (this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1)))
        {
            return ((this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1) && (this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1));
            if (this.attackEntity(_user, _targetTile.getEntity()))
            {
                if (this && this)
                {
                    return (this && this);
                    return _user;
                }
                if (_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).hasNextTile(_user.getTile().getDirectionTo(_targetTile)))
                {
                    if ((this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile).getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1) && (this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1)))
                    {
                        return ((this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1) && (this.Math.abs((_targetTile.getNextTile(_user.getTile().getDirectionTo(_targetTile)).getNextTile(_user.getTile().getDirectionTo(_targetTile)).Level - _user.getTile().Level)) <= 1));
                        if (this.attackEntity(_user, _targetTile.getEntity()))
                        {
                            if (this && this)
                            {
                                return (this && this);
                                return _user;
                            }
                            return _user;
                        }
                    }
                }
            }
        }
    }
}
