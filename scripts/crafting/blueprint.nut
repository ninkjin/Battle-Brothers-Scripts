// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/crafting/blueprint.nut
// Functions: 22

function craft(this)
{
    if (!this.isQualified())
    {
        return;
    }
    this.updateAchievement("IMadeThis", 1, 1);
    foreach (local key, value in r36)
    {
        if (0 < null.Num)
        {
            if ((null.Instance.getID() > 25) && (null.Instance.getID() > 25))
            {
                return ((null.Instance.getID() > 25) && (null.Instance.getID() > 25));
                this.World.Assets.getStash().remove(this.World.Assets.getStash().getItemByID(null.Instance.getID()));
            }
            this.World.Assets.getStash().getItemByID(null.Instance.getID()).setMagicNumber(this.Math.rand(1, 100));
        }
        this.onCraft(this.World.Assets.getStash());
        return;
    }
}

function create(this)
{
    return;
}

function getCost(this)
{
    return this.Math.ceil((this.m.Cost * this.World.Assets.m.TaxidermistPriceMult));
    return this.Math.ceil;
}

function getDescription(this)
{
    return this.m.PreviewCraftable.getDescription();
    return this.m.PreviewCraftable.getDescription;
}

function getID(this)
{
    return this.m.ID;
}

function getIcon(this)
{
    return this.m.PreviewCraftable.getIcon();
    return this.m.PreviewCraftable.getIcon;
}

function getIconLarge(this)
{
    return this.m.PreviewCraftable.getIconLarge();
    return this.m.PreviewCraftable.getIconLarge;
}

function getIngredients(this)
{
    foreach (local key, value in r47)
    {
        foreach (local key, value in r20)
        {
            if ((r12 == null.Instance) && (r12 == null.Instance))
            {
                return ((r12 == null.Instance) && (r12 == null.Instance));
                if ((0 + 7) >= null.Num)
                {
                }
            }
            if (1 <= null.Num)
            {
                [].push({});
            }
            return [];
        }
    }
}

function getName(this)
{
    return this.m.PreviewCraftable.getName();
    return this.m.PreviewCraftable.getName;
}

function getSounds(this)
{
    return this.m.Sounds;
}

function getTooltip(this)
{
    return this.m.PreviewCraftable.getTooltip();
    return this.m.PreviewCraftable.getTooltip;
}

function getTooltipForComponent(this, _idx)
{
    return this.m.PreviewComponents["_idx"].Instance.getTooltip();
    return _idx;
}

function getUIData(this)
{
    if (this.getIconLarge() != null)
    {
    }
    return this.World.Assets.getStash().getItems();
}

function init(this, _comps)
{
    foreach (local key, value in r17)
    {
        this.m.PreviewComponents.push({});
        return;
    }
}

function isCraftable(this)
{
    foreach (local key, value in r33)
    {
        foreach (local key, value in r20)
        {
            if ((r11 == null.Instance) && (r11 == null.Instance))
            {
                return ((r11 == null.Instance) && (r11 == null.Instance));
                if ((0 + 6) >= null.Num)
                {
                }
            }
            if ((0 + 6) < null.Num)
            {
                return this.World.Assets.getStash().getItems();
            }
            return this.World.Assets.getStash().getItems();
        }
    }
}

function isQualified(this)
{
    if (this.m.TimesCrafted >= 1)
    {
        return true;
    }
    return this.isCraftable();
    return this.isCraftable;
}

function isValid(this)
{
    return true;
}

function onCraft(this, _stash)
{
    return;
}

function onDeserialize(this, _in)
{
    this.m.TimesCrafted = _in.readU32();
    return;
}

function onReset(this)
{
    return;
}

function onSerialize(this, _out)
{
    _out.writeU32(this.m.TimesCrafted);
    return;
}

function reset(this)
{
    this.onReset();
    return;
}
