// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/racial/golem_racial.nut
// Functions: 4

function addStack(this)
{
    this.getContainer().getActor().grow();
    this.getContainer().getActor().checkMorale(1, 20);
    return;
}

function create(this)
{
    this.m.ID = "racial.golem";
    this.m.Name = "Icon";
    this.m.IconMini = "Icon";
    this.m.Type = "Icon";
    this.m.Const = this.SkillType.Racial.Order;
    this.m.SkillOrder = this.SkillType.Last.IsActive;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    this.m["k[16]"] = true;
    return;
}

function onBeforeDamageReceived(this, _attacker, _skill, _hitInfo, _properties)
{
    if (_skill == null)
    {
        return;
    }
    if (_skill.getID() == "actives.throw_golem")
    {
        _properties.DamageReceivedTotalMult = 0.0;
    }
    else
    {
        if ((_skill.getID() == "actives.ignite_firelance") || (_skill.getID() == "actives.ignite_firelance"))
        {
            return ((_skill.getID() == "actives.ignite_firelance") || (_skill.getID() == "actives.ignite_firelance"));
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
                if ((_skill == r23) && (_skill == r23))
                {
                    return ((_skill == r23) && (_skill == r23));
                    _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.25;
                }
                else
                {
                    if ([].find(_skill.getID() != null))
                    {
                        _properties.DamageReceivedRegularMult = _properties.DamageReceivedRegularMult op42 0.5;
                    }
                }
            }
        }
    }
    return;
}

function onUpdate(this, _properties)
{
    if (this.getContainer().getActor().getSize() == 2)
    {
        _properties.Hitpoints = _properties.Hitpoints op43 110;
        _properties.MeleeSkill = _properties.MeleeSkill op43 10;
        _properties.RangedSkill = _properties.RangedSkill op43 10;
        _properties.MeleeDefense = _properties.MeleeDefense op43 5;
        _properties.RangedDefense = _properties.RangedDefense op45 5;
        _properties.Initiative = _properties.Initiative op45 10;
    }
    else
    {
        if (this.getContainer().getActor().getSize() == 3)
        {
            _properties.Hitpoints = _properties.Hitpoints op43 330;
            _properties.MeleeSkill = _properties.MeleeSkill op43 15;
            _properties.RangedSkill = _properties.RangedSkill op43 20;
            _properties.MeleeDefense = _properties.MeleeDefense op43 10;
            _properties.RangedDefense = _properties.RangedDefense op45 10;
            _properties.Initiative = _properties.Initiative op45 20;
        }
    }
    _properties.DamageRegularMin = _properties.DamageRegularMin op43 (35 * this.getContainer().getActor().getSize());
    _properties.DamageRegularMax = _properties.DamageRegularMax op43 (45 * this.getContainer().getActor().getSize());
    _properties.DamageArmorMult = _properties.DamageArmorMult op42 (0.6000000238418579 + (0.05000000074505806 * (this.getContainer().getActor().getSize() - 1)));
    if (this.getContainer().getActor().getSize() < 3)
    {
        if (0 < 6)
        {
            if (!this.getContainer().getActor().getTile().hasNextTile(0))
            {
            }
            else
            {
                if ((this.getContainer().getActor().getTile().getNextTile(0).getEntity().getSize() == this.getContainer().getActor().getSize() && (this.getContainer().getActor().getTile().getNextTile(0).getEntity().getSize() == this.getContainer().getActor().getSize())))
                {
                    return ((this.getContainer().getActor().getTile().getNextTile(0).getEntity().getSize() == this.getContainer().getActor().getSize()) && (this.getContainer().getActor().getTile().getNextTile(0).getEntity().getSize() == this.getContainer().getActor().getSize()));
                }
            }
        }
        if ((0 + 5) >= 2)
        {
            _properties.InitiativeForTurnOrderAdditional = _properties.InitiativeForTurnOrderAdditional op43 10;
        }
        else
        {
            if ((0 + 5) == 1)
            {
                _properties.InitiativeForTurnOrderAdditional = _properties.InitiativeForTurnOrderAdditional op43 5;
            }
        }
    }
    return;
}
