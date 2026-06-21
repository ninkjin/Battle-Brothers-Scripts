// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/vizier.nut
// Functions: 9

function assignRandomEquipment(this)
{
    if (this.Math.rand(1, 8) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/oriental/padded_mail_and_lamellar_hauberk"));
    }
    else
    {
        if (this.Math.rand(1, 8) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/oriental/mail_and_lamellar_plating"));
        }
        this.m.Items.equip(this.new("scripts/items/armor/oriental/vizier_gear"));
    }
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        this.getSprite("surcoat").setBrush(("bust_desert_noble_" + []["this.Math.rand(0, ([].len() - 1))"]));
    }
    if ((this.Math <= 80) && (this.Math <= 80))
    {
        return ((this.Math <= 80) && (this.Math <= 80));
        this.m.Items.equip(this.new("scripts/items/helmets/oriental/vizier_headgear"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Officer;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Officer.XP;
    this.m.Name = ((this.Const.Strings.SouthernNames["this.Math.rand(0, (this.Const.Strings.SouthernNames.len() - 1))"] + " ") + this.Const.Strings.SouthernNamesLast["this.Math.rand(0, (this.Const.Strings.SouthernNamesLast.len() - 1))"]);
    this.m.Title = this.Const.Strings.VizierTitles["this.Math.rand(0, (this.Const.Strings.VizierTitles.len() - 1))"];
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.Southern;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function getProperties(this)
{
    return this.m.Properties;
}

function getTitles(this)
{
    return this.m.Titles;
}

function onDeserialize(this, _in)
{
    this.human.onDeserialize(_in);
    this.m.Properties.resize(_in.readU8());
    if (0 < _in.readU8())
    {
        this.m.Properties["0"] = _in.readU32();
    }
    this.m.Titles.resize(_in.readU8());
    if (0 < _in.readU8())
    {
        this.m.Titles["0"] = _in.readString();
    }
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Noble);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.getSprite("socket").setBrush("bust_base_southern");
    return;
}

function onOtherActorDeath(this, _killer, _victim, _skill)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorDeath(_killer, _victim, _skill);
    return;
}

function onOtherActorFleeing(this, _actor)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorFleeing(_actor);
    return;
}

function onSerialize(this, _out)
{
    this.human.onSerialize(_out);
    _out.writeU8(this.m.Properties.len());
    foreach (local key, value in r6)
    {
        _out.writeU32(null);
        _out.writeU8(this.m.Titles.len());
        foreach (local key, value in _out.writeU32)
        {
            _out.writeString(null);
            return;
        }
    }
}
