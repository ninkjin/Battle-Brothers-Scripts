// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/flat_top_with_rusty_mail.nut
// Functions: 2

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.flat_top_with_rusty_mail";
    this.m.Name = "Flat Top with Rusty Mail";
    this.m.Description = "A worn flat full-metal helmet with a rusted mail coif covering the neck and face.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = true;
    this.m.HideBeard = true;
    this.m.Variant = []["this.Math.rand(0, ([].len() - 1))"];
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.Value = 1250;
    this.m.Condition = 245;
    this.m.ConditionMax = 245;
    this.m.StaminaModifier = -20;
    this.m.Vision = -2;
    return;
}

function onPaint(this, _color)
{
    if (_color == this.Const.Items.Paint.None)
    {
        this.m.Variant = 15;
    }
    else
    {
        if (_color == this.Const.Items.Paint.Black)
        {
            this.m.Variant = 135;
        }
        else
        {
            if (_color == this.Const.Items.Paint.WhiteBlue)
            {
                this.m.Variant = 132;
            }
            else
            {
                if (_color == this.Const.Items.Paint.WhiteGreenYellow)
                {
                    this.m.Variant = 133;
                }
                else
                {
                    if (_color == this.Const.Items.Paint.OrangeRed)
                    {
                        this.m.Variant = 134;
                    }
                    else
                    {
                        if (_color == this.Const.Items.Paint.Red)
                        {
                            this.m.Variant = 179;
                        }
                    }
                }
            }
        }
    }
    this.updateVariant();
    this.updateAppearance();
    return;
}
