// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/objects/golem_spectator.nut
// Functions: 4

function getDescription(this)
{
    return "A golem of flesh, watching you in stony silence";
}

function getName(this)
{
    return "Flesh Golem Observer";
}

function onInit(this)
{
    this.addSprite("body").setBrush("bust_flesh_golem_body_01");
    this.addSprite("body").varyColor(0.05000000074505806, 0.05000000074505806, 0.05000000074505806);
    this.addSprite("body").varySaturation(0.10000000149011612);
    this.addSprite("armor").setBrush("bust_flesh_golem_armor_01");
    this.addSprite("head").setBrush([]["this.Math.rand(0, ([].len() - 1))"]);
    this.addSprite("head").Color = this.addSprite("body").Color;
    this.addSprite("head").Saturation = this.addSprite("body").Saturation;
    if (this.Math.rand(1, 100) <= 80)
    {
        this.addSprite("helmet").setBrush([]["this.Math.rand(0, ([].len() - 1))"]);
    }
    return;
}

function setFlipped(this, _flip)
{
    this.getSprite("body").setHorizontalFlipping(_flip);
    this.getSprite("head").setHorizontalFlipping(_flip);
    this.getSprite("armor").setHorizontalFlipping(_flip);
    this.getSprite("helmet").setHorizontalFlipping(_flip);
    return;
}
