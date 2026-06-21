// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/nomad_ranged_background.nut
// Functions: 3

function create(this)
{
    this.nomad_background.create();
    this.m.HiringCost = 300;
    return;
}

function onAddEquipment(this)
{
    if (this.Math.rand(0, 1) == 0)
    {
        this.getContainer().getActor().getItems().equip(this.new("scripts/items/weapons/oriental/nomad_sling"));
    }
    else
    {
        if (this.Math.rand(0, 1) == 1)
        {
            this.getContainer().getActor().getItems().equip(this.new("scripts/items/weapons/oriental/composite_bow"));
            this.getContainer().getActor().getItems().equip(this.new("scripts/items/ammo/quiver_of_arrows"));
        }
    }
    if (this.Math.rand(0, 3) == 0)
    {
        this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/nomad_robe"));
    }
    else
    {
        if (this.Math.rand(0, 3) == 1)
        {
            this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/thick_nomad_robe"));
        }
        else
        {
            if (this.Math.rand(0, 3) == 2)
            {
                this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/stitched_nomad_armor"));
            }
            else
            {
                if (this.Math.rand(0, 3) == 3)
                {
                    this.getContainer().getActor().getItems().equip(this.new("scripts/items/armor/oriental/leather_nomad_robe"));
                }
            }
        }
    }
    if (this.Math.rand(0, 3) == 0)
    {
        this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/nomad_head_wrap"));
    }
    else
    {
        if (this.Math.rand(0, 3) == 1)
        {
            this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/nomad_leather_cap"));
        }
        else
        {
            if (this.Math.rand(0, 3) == 2)
            {
                this.getContainer().getActor().getItems().equip(this.new("scripts/items/helmets/oriental/nomad_light_helmet"));
            }
        }
    }
    return;
}

function onChangeAttributes(this)
{
    return {Hitpoints = [], Bravery = [], Stamina = [], MeleeSkill = [], RangedSkill = [], MeleeDefense = [], RangedDefense = [], Initiative = []};
}
