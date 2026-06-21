// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_marksman_low.nut
// Functions: 3

function assignRandomEquipment(this)
{
    [].push([]);
    [].push([]);
    [].push([]);
    foreach (local key, value in r11)
    {
        this.m.Items.equip(this.new(("scripts/items/" + null)));
        this.m.Items.addToBag(this.new("scripts/items/weapons/knife"));
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
    this.bandit_marksman.create();
    this.m.IsLow = true;
    return;
}

function onInit(this)
{
    this.bandit_marksman.onInit();
    this.m.BaseProperties.Initiative = this.m.BaseProperties.Initiative op45 10;
    this.m.BaseProperties.RangedSkill = this.m.BaseProperties.RangedSkill op45 10;
    this.m.Skills.update();
    return;
}
