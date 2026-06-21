// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/bandit_leader.nut
// Functions: 6

function assignRandomEquipment(this)
{
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Mainhand) == null)
    {
        if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.Math.rand(1, 100) <= 35)
    {
        this.m.Items.addToBag(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
    {
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Head) == null)
    {
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.BanditLeader;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.BanditLeader.XP;
    this.m.Name = this.generateName();
    this.m.IsGeneratingKillName = false;
    this.human.create();
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.UntidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.Raider;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateName(this)
{
    [].push([]);
    [].push([]);
    return this.buildTextFromTemplate(this.Const.Strings.BanditLeaderNames["this.Math.rand(0, (this.Const.Strings.BanditLeaderNames.len() - 1))"], []);
    return [];
}

function makeMiniboss(this)
{
    if (!this.actor.makeMiniboss())
    {
        return false;
    }
    this.getSprite("miniboss").setBrush("bust_miniboss");
    clone this.extend([]);
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedMeleeWeapons["this.Math.rand(0, (this.Const.Items.NamedMeleeWeapons.len() - 1))"])));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new(("scripts/items/" + clone this["this.Math.rand(0, (clone this.len() - 1))"])));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedArmors["this.Math.rand(0, (this.Const.Items.NamedArmors.len() - 1))"])));
            }
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedHelmets["this.Math.rand(0, (this.Const.Items.NamedHelmets.len() - 1))"])));
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    return clone this;
}

function onAppearanceChanged(this, _appearance, _setDirty)
{
    this.actor.onAppearanceChanged(_appearance, false);
    this.getSprite("armor").setBrightness(0.8999999761581421);
    this.getSprite("helmet").setBrightness(0.8999999761581421);
    this.getSprite("helmet_damage").setBrightness(0.8999999761581421);
    this.setDirty(true);
    return;
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.BanditLeader);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.BaseProperties.IsSpecializedInDaggers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_bandits");
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.getSprite("armor").Saturation = 0.8500000238418579;
    this.getSprite("helmet").Saturation = 0.8500000238418579;
    this.getSprite("helmet_damage").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").Saturation = 0.8500000238418579;
    this.getSprite("shield_icon").setBrightness(0.8500000238418579);
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_sundering_strikes"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    return;
}
