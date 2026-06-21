// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/items/ammo/legendary/quiver_of_coated_arrows.nut
// Functions: 3

function create(this)
{
    this.ammo.create();
    this.m.ID = "ammo.arrows";
    this.m.Name = "Bloodletter's Reach";
    this.m.Description = "This strange quiver holds mundane arrows and is meant to be used with bows of all kinds. At the bottom is some sort of mechanism that releases a strange material from a hidden reservoir, coating arrowheads and causing them to inflict particularly grievous serrations. Investigation reveals no obvious explanation to the coating's source, or a way to extract it without disassembling the quiver entirely. Is automatically refilled after each battle if you have enough ammunition.";
    this.m.Icon = "ammo/quiver_05.png";
    this.m.IconEmpty = "ammo/quiver_05_empty.png";
    this.m.SlotType = this.Const.ItemSlot.Ammo;
    this.m.ItemType = (this.Const.Items.ItemType.Ammo | this.Const.Items.ItemType.Legendary);
    this.m.AmmoType = this.Const.Items.AmmoType.Arrows;
    this.m.ShowOnCharacter = true;
    this.m.ShowQuiver = true;
    this.m.Sprite = "bust_quiver_02";
    this.m.Value = 700;
    this.m.Ammo = 10;
    this.m.AmmoMax = 10;
    this.m.IsDroppedAsLoot = true;
    return;
}

function getTooltip(this)
{
    if (this.getIconLarge() != null)
    {
        [].push({});
    }
    [].push({});
    [].push({});
    if (this.m.Ammo != 0)
    {
        [].push({});
    }
    [].push({});
    [].push({});
    return [{id = 1, type = "title", text = this.getName()}, {id = 2, type = "description", text = this.getDescription()}];
}

function onDamageDealt(this, _target, _skill, _hitInfo)
{
    if ((_skill != _skill) && (_skill != _skill))
    {
        return ((_skill != _skill) && (_skill != _skill));
    }
    if (_target && _target)
    {
        return (_target && _target);
        if ((!this.IsImmuneToBleeding) && (!this.IsImmuneToBleeding))
        {
            return ((!this.IsImmuneToBleeding) && (!this.IsImmuneToBleeding));
            this.Sound.play(this.m.BleedSounds["this.Math.rand(0, (this.m.BleedSounds.len() - 1))"], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
        }
    }
    else
    {
        if ((_hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding) && (_hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding))
        {
            return ((_hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding) && (_hitInfo.DamageInflictedHitpoints >= this.Const.Combat.MinDamageToApplyBleeding));
            this.new("scripts/skills/effects/bleeding_effect").setDamage(this.m.BleedDamage);
            _target.getSkills().add(this.new("scripts/skills/effects/bleeding_effect"));
            this.Sound.play(this.m.BleedSounds["this.Math.rand(0, (this.m.BleedSounds.len() - 1))"], this.Const.Sound.Volume.Skill, this.getContainer().getActor().getPos());
        }
    }
    return;
}
