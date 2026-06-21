// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/misc/anatomist/greater_flesh_golem_potion_item.nut
// Functions: 4

function create(this)
{
    this.anatomist_potion_item.create();
    this.m.ID = "misc.greater_flesh_golem_potion";
    this.m.Name = "Potion of Progress";
    this.m.Description = "This serum, extracted from the bone marrow of the so-called 'greater' flesh golems, can fashion even the most infirm into the pinnacle of physical health. Behold, the twisted vision of the Grand Diviner, untangled and made reality!";
    this.m.IconLarge = "Icon";
    this.m["consumables/potion_43.png"] = "Value";
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
    if ((r6 > 0) && (r6 > 0))
    {
        return ((r6 > 0) && (r6 > 0));
        if (!_actor.getSkills().hasSkill(this.new([].remove(this.Math.rand(0, ([].len() - 1))).getID())))
        {
            _actor.getSkills().add(this.new([].remove(this.Math.rand(0, ([].len() - 1)))));
        }
    }
    _actor.getSkills().add(this.new("scripts/skills/effects/greater_flesh_golem_potion_effect"));
    return this.anatomist_potion_item.onUse(_actor, _item);
    return _actor;
}

function playInventorySound(this, _eventType)
{
    this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
    return;
}
