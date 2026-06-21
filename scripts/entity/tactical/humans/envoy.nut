// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/envoy.nut
// Functions: 5

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));
    if (this.Math.rand(1, 100) <= 33)
    {
        this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.Peasant;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.Councilman.XP;
    this.m.IsGuest = true;
    this.player.create();
    this.m.Faces = this.Const.Faces.SmartMale;
    this.m.Hairs = this.Const.Hair.CommonMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Tidy;
    this.m.AIAgent = this.new("scripts/ai/tactical/player_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function getPlaceInFormation(this)
{
    return 21;
}

function isReallyKilled(this, _fatalityType)
{
    return _fatalityType;
}

function onInit(this)
{
    this.player.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.Envoy);
    this.m.BaseProperties.TargetAttractionMult = 2.0;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.m.Talents.resize(this.Const.Attributes.COUNT, 0);
    this.m.Attributes.resize(this.Const.Attributes.COUNT, []);
    this.getSprite("socket").setBrush("bust_base_military");
    this.setAppearance();
    this.assignRandomEquipment();
    return;
}
