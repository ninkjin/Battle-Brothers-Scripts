// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_poacher.nut
// Functions: 4

function assignRandomEquipment(this)
{
    [].push([]);
    if (this.Const.DLC.Wildmen)
    {
        [].push([]);
    }
    foreach (local key, value in r11)
    {
        this.m.Items.equip(this.new(("scripts/items/" + null)));
        if (this.Math.rand(1, 100) <= 50)
        {
            this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
        }
        this.m.Items.addToBag(this.new("scripts/items/weapons/wooden_stick"));
        this.m.Items.equip(this.new("scripts/items/armor/leather_wraps"));
        if (this.Math.rand(1, 100) <= 50)
        {
            if (this.Math.rand(1, 2) == 1)
            {
                this.m.Items.equip(this.new("scripts/items/helmets/headscarf"));
            }
            else
            {
                if (this.Math.rand(1, 2) == 2)
                {
                    this.m.Items.equip(this.new("scripts/items/helmets/mouth_piece"));
                }
            }
        }
        return;
    }
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BanditPoacher;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditPoacher.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.UntidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Raider;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_ranged_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onAppearanceChanged(this, _appearance, _setDirty)
{
    this.actor.onAppearanceChanged(_appearance, false);
    this.setDirty(true);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditPoacher);
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_bandits");
    if (this.Math.rand(1, 100) <= 20)
    {
        this.getSprite("tattoo_head").Visible = true;
        this.getSprite("tattoo_head").setBrush("bust_head_darkeyes_01");
    }
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.getSprite("armor").Saturation = 0.8500000238418579;
    this.getSprite("helmet").Saturation = 0.8500000238418579;
    this.getSprite("helmet_damage").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").setBrightness(0.8500000238418579);
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
