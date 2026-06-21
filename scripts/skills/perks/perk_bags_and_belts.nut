// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/perks/perk_bags_and_belts.nut
// Functions: 3

function create(this)
{
    this.m.ID = "perk.bags_and_belts";
    this.m.Name = this.Const.Strings.PerkName.BagsAndBelts;
    this.m.Description = this.Const.Strings.PerkDescription.BagsAndBelts;
    this.m.Icon = "ui/perks/perk_20.png";
    this.m.Type = this.Const.SkillType.Perk;
    this.m.Order = this.Const.SkillOrder.Perk;
    this.m.IsActive = false;
    this.m.IsStacking = false;
    this.m.IsHidden = false;
    return;
}

function onRemoved(this)
{
    if (this.getContainer().getActor().getItems().getItemAtBagSlot(2) != null)
    {
        this.getContainer().getActor().getItems().removeFromBag(this.getContainer().getActor().getItems().getItemAtBagSlot(2));
        this.World.Assets.getStash().add(this.getContainer().getActor().getItems().getItemAtBagSlot(2));
    }
    if (this.getContainer().getActor().getItems().getItemAtBagSlot(3) != null)
    {
        this.getContainer().getActor().getItems().removeFromBag(this.getContainer().getActor().getItems().getItemAtBagSlot(3));
        this.World.Assets.getStash().add(this.getContainer().getActor().getItems().getItemAtBagSlot(3));
    }
    this.getContainer().getActor().getItems().setUnlockedBagSlots(2);
    return;
}

function onUpdate(this, _properties)
{
    this.getContainer().getActor().getItems().setUnlockedBagSlots(4);
    return;
}
