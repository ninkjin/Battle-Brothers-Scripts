// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/unhold_armored.nut
// Functions: 5

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/armor/barbarians/unhold_armor_light"));
    this.m.Items.equip(this.new("scripts/items/helmets/barbarians/unhold_helmet_light"));
    return;
}

function create(this)
{
    this.unhold.create();
    this.m.Type = this.Const.EntityType.BarbarianUnhold;
    return;
}

function onInit(this)
{
    this.unhold.onInit();
    this.getSprite("socket").setBrush("bust_base_wildmen_01");
    return;
}

function onTurnStart(this)
{
    this.actor.onTurnStart();
    if ((!this.Tactical.State.isAutoRetreat() && (!this.Tactical.State.isAutoRetreat()) && (!this.Tactical.State.isAutoRetreat())))
    {
        return ((!this.Tactical.State.isAutoRetreat()) && (!this.Tactical.State.isAutoRetreat()) && (!this.Tactical.State.isAutoRetreat()));
        this.m.Skills.getSkillByID("racial.unhold").spawnIcon("status_effect_107", this.getTile());
        if (this.Math.rand(1, 100) <= 50)
        {
            this.playSound(this.Const.Sound.ActorEvent.Other1, 0.75, (this.Math.rand(90, 100) * 0.009999999776482582));
        }
        if (this.Math.rand(1, 100) <= 33)
        {
            this.updateAchievement("FriendOrFoe", 1, 1);
            this.m.HasTurned = true;
            if (this.Tactical.State.isScenarioMode())
            {
            }
            this.setFaction(this.World.FactionManager.getFactionOfType(this.Const.FactionType.Beasts).getID());
            this.getSprite("socket").setBrush("bust_base_beasts");
        }
    }
    this.m.HasBeenWhipped = false;
    return;
}

function setWhipped(this, _w)
{
    this.m.HasBeenWhipped = _w;
    return;
}
