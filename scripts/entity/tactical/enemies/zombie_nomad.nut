// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/zombie_nomad.nut
// Functions: 2

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if ((this.Math <= 50) && (this.Math <= 50))
    {
        return ((this.Math <= 50) && (this.Math <= 50));
        if (this.Math.rand(1, 100) <= 66)
        {
            this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setCondition((this.Math.round(((this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).getConditionMax() / 2) - 1)) / 1.0));
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.Math.rand(1, 100) <= 66)
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setArmor((this.Math.round(((this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).getArmorMax() / 2) - 1)) / 1.0));
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.Math.rand(1, 100) <= 66)
    {
        this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).setArmor((this.Math.round(((this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])).getArmorMax() / 2) - 1)) / 1.0));
    }
    this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    return;
}

function create(this)
{
    this.zombie_yeoman.create();
    this.m.ResurrectWithScript = "scripts/entity/tactical/enemies/zombie_nomad";
    return;
}
