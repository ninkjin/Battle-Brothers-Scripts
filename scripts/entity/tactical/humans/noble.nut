// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/noble.nut
// Functions: 8

function assignRandomEquipment(this)
{
    this.m.Surcoat = this.World.FactionManager.getFaction(this.getFaction()).getBanner();
    if (this.m.Surcoat < 10)
    {
    }
    if (this.Math.rand(1, 7) == 1)
    {
        this.m.Items.equip(this.new("scripts/items/armor/noble_tunic"));
    }
    else
    {
        if (this.Math.rand(1, 7) == 2)
        {
            this.m.Items.equip(this.new("scripts/items/armor/coat_of_plates"));
            if (this.Math.rand(1, 100) <= 75)
            {
                this.getSprite("surcoat").setBrush(("surcoat_" + this.m.Surcoat));
            }
            if (this.Math.rand(1, 100) <= 25)
            {
                this.new("scripts/items/helmets/greatsword_faction_helm").setVariant(this.World.FactionManager.getFaction(this.getFaction()).getBanner());
                this.m.Items.equip(this.new("scripts/items/helmets/greatsword_faction_helm"));
            }
            if (this.Math.rand(1, 100) <= 33)
            {
                this.getSprite("surcoat").setBrush(("bust_body_noble_" + []["this.Math.rand(0, ([].len() - 1))"]));
            }
        }
        else
        {
            if (this.Math.rand(1, 7) == 3)
            {
                this.m.Items.equip(this.new("scripts/items/armor/coat_of_scales"));
                if (this.Math.rand(1, 100) <= 75)
                {
                    this.getSprite("surcoat").setBrush(("surcoat_" + this.m.Surcoat));
                }
                if (this.Math.rand(1, 100) <= 25)
                {
                    this.new("scripts/items/helmets/greatsword_faction_helm").setVariant(this.World.FactionManager.getFaction(this.getFaction()).getBanner());
                    this.m.Items.equip(this.new("scripts/items/helmets/greatsword_faction_helm"));
                }
                if (this.Math.rand(1, 100) <= 33)
                {
                    this.getSprite("surcoat").setBrush(("bust_body_noble_" + []["this.Math.rand(0, ([].len() - 1))"]));
                }
            }
            this.m.Items.equip(this.new("scripts/items/armor/noble_gear"));
        }
    }
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        this.getSprite("surcoat").setBrush(("bust_body_noble_" + []["this.Math.rand(0, ([].len() - 1))"]));
    }
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        this.m.Items.equip(this.new("scripts/items/helmets/noble_headgear"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Knight;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Noble.XP;
    this.m.Name = this.generateName();
    this.human.create();
    this.m.Faces = this.Const.Faces.SmartMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = null;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateName(this)
{
    return ((this.Const.Strings.NobleTitles["this.Math.rand(0, (this.Const.Strings.NobleTitles.len() - 1))"] + " ") + this.Const.Strings.CharacterNames["this.Math.rand(0, (this.Const.Strings.CharacterNames.len() - 1))"]);
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
    this.getSprite("socket").setBrush("bust_base_military");
    this.m.Skills.add(this.new("scripts/skills/perks/perk_steel_brow"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
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
