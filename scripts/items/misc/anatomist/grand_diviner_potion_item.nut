// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/misc/anatomist/grand_diviner_potion_item.nut
// Functions: 4

function create(this)
{
    this.anatomist_potion_item.create();
    this.m.ID = "misc.grand_diviner_potion";
    this.m.Name = "Elixir of Enlightenment";
    this.m.Description = "They say the difference between poison and medicine is in the dosage, and perhaps nowhere is this more true than the unusual substance found in the Grand Diviner's censer and, more curiously, bloodstream. Whoever drinks this elixir, brewed from that substance, will surely gain his same otherwordly vision!";
    this.m.IconLarge = "Icon";
    this.m["consumables/potion_39.png"] = "Value";
    this.m["k[13]"] = 0;
    return;
}

function getTooltip(this)
{
    [].push({});
    if (this.getIconLarge() != null)
    {
        [].push({});
    }
    [].push({});
    [].push({});
    [].push({});
    [].push({});
    return [{id = 1, type = "title", text = this.getName()}, {id = 2, type = "description", text = this.getDescription()}];
}

function onUse(this, _actor, _item)
{
    _actor.addXP(this.Const.LevelXP["10"], false);
    _actor.updateLevel();
    _actor.getSkills().add(this.new("scripts/skills/effects/grand_diviner_potion_effect"));
    return this.anatomist_potion_item.onUse(_actor, _item);
    return _actor;
}

function playInventorySound(this, _eventType)
{
    this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
    return;
}
