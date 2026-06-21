// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/misc/anatomist/lesser_flesh_golem_potion_item.nut
// Functions: 4

function create(this)
{
    this.anatomist_potion_item.create();
    this.m.ID = "misc.lesser_flesh_golem_potion";
    this.m.Name = "Potion of Change";
    this.m.Description = "This vile tasting concoction, distilled from the remains of a flesh golem, promises to cure joint pain, grow muscle mass, and even sharpen vision! Results not guaranteed.";
    this.m.IconLarge = "Icon";
    this.m["consumables/potion_42.png"] = "Value";
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
    _actor.getSkills().add(this.new("scripts/skills/effects/lesser_flesh_golem_potion_effect"));
    return this.anatomist_potion_item.onUse(_actor, _item);
    return _actor;
}

function playInventorySound(this, _eventType)
{
    this.Sound.play("sounds/bottle_01.wav", this.Const.Sound.Volume.Inventory);
    return;
}
