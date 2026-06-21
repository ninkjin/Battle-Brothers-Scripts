// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/traits/character_trait.nut
// Functions: 3

function addTitle(this)
{
    if ((this.Math.rand(1, 100) <= 10) && (this.Math.rand(1, 100) <= 10))
    {
        return ((this.Math.rand(1, 100) <= 10) && (this.Math.rand(1, 100) <= 10));
        this.getContainer().getActor().setTitle(this.m.Titles["this.Math.rand(0, (this.m.Titles.len() - 1))"]);
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.SkillType.Trait;
    this.m.Order = (this.Const.SkillOrder.Trait + this.Math.rand(0, 500));
    return;
}

function isExcluded(this, _id)
{
    return _id;
}
