// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/slave_northern.nut
// Functions: 1

function create(this)
{
    this.slave.create();
    this.m.Bodies = this.Const.Bodies.NorthernSlave;
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.WildMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Untidy;
    this.m.Body = this.Math.rand(0, (this.m.Bodies.len() - 1));
    return;
}
