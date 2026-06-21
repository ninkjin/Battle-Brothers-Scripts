// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ai/tactical/behaviors/ai_pickup_weapon.nut
// Functions: 3

function create(this)
{
    this.m.ID = this.Const.AI.Behavior.ID.PickupWeapon;
    this.m.Order = this.Const.AI.Behavior.Order.PickupWeapon;
    this.behavior.create();
    return;
}

function onEvaluate(this, _entity)
{
    if (_entity.getActionPoints() < this.Const.Tactical.Settings.SwitchItemAPCost)
    {
        return _entity;
    }
    if (_entity.getMoraleState() == this.Const.MoraleState.Fleeing)
    {
        return _entity;
    }
    if (_entity.isArmed())
    {
        return _entity;
    }
    if (_entity.getTile().Items.len() == 0)
    {
        return _entity;
    }
    foreach (local key, value in r23)
    {
        if ((this.Const.Items.ItemType.MeleeWeapon == null) && (this.Const.Items.ItemType.MeleeWeapon == null))
        {
            return ((this.Const.Items.ItemType.MeleeWeapon == null) && (this.Const.Items.ItemType.MeleeWeapon == null));
            [].push(null);
        }
        if ([].len() == 0)
        {
            return _entity;
        }
        return _entity;
    }
}

function onExecute(this, _entity)
{
    if (this.Const.AI.VerboseMode)
    {
        this.logInfo((("* " + _entity.getName()) + ": Picking up melee weapon!"));
    }
    _entity.pickupMeleeWeaponAndShield(_entity.getTile());
    _entity.getItems().payForAction([]);
    return _entity;
}
