// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/helmets/kettle_hat_with_rusty_mail.nut
// Functions: 3

function create(this)
{
    this.helmet.create();
    this.m.ID = "armor.head.kettle_hat_with_rusty_mail";
    this.m.Name = "Kettle Hat with Rusty Mail";
    this.m.Description = "A worn helmet with a broad rim and a rusted mail coif covering the neck and face.";
    this.m.ShowOnCharacter = true;
    this.m.IsDroppedAsLoot = true;
    this.m.HideHair = true;
    this.m.HideBeard = true;
    this.m.Variant = []["this.Math.rand(0, ([].len() - 1))"];
    this.updateVariant();
    this.m.ImpactSound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.InventorySound = this.Const.Sound.ArmorHalfplateImpact;
    this.m.Value = 1050;
    this.m.Condition = 230;
    this.m.ConditionMax = 230;
    this.m.StaminaModifier = -19;
    this.m.Vision = -2;
    return;
}

function onPaint(this, _color)
{
    if (_color == this.Const.Items.Paint.None)
    {
        this.m.Variant = 11;
    }
    else
    {
        if (_color == this.Const.Items.Paint.Black)
        {
            this.m.Variant = 119;
        }
        else
        {
            if (_color == this.Const.Items.Paint.WhiteBlue)
            {
                this.m.Variant = 116;
            }
            else
            {
                if (_color == this.Const.Items.Paint.WhiteGreenYellow)
                {
                    this.m.Variant = 117;
                }
                else
                {
                    if (_color == this.Const.Items.Paint.OrangeRed)
                    {
                        this.m.Variant = 118;
                    }
                    else
                    {
                        if (_color == this.Const.Items.Paint.Red)
                        {
                            this.m.Variant = 175;
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

function setPlainVariant(this)
{
    this.setVariant(11);
    return;
}
