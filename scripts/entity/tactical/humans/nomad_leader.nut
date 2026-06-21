// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/humans/nomad_leader.nut
// Functions: 7

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
    if ((this.Math <= 66) && (this.Math <= 66))
    {
        return ((this.Math <= 66) && (this.Math <= 66));
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if ((this.Math <= 35) && (this.Math <= 35))
    {
        return ((this.Math <= 35) && (this.Math <= 35));
        if (this.Const.DLC.Unhold)
        {
            [].extend([]);
        }
        this.m.Items.equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    if (this.m.Items.getItemAtSlot(this.Const.ItemSlot.Body) == null)
    {
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
    this.m.Type = this.Const.EntityType.NomadLeader;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.NomadLeader.XP;
    this.m.Name = this.generateName();
    this.m.IsGeneratingKillName = false;
    this.human.create();
    this.m.Bodies = this.Const.Bodies.SouthernMale;
    this.m.Faces = this.Const.Faces.SouthernMale;
    this.m.Hairs = this.Const.Hair.SouthernMale;
    this.m.HairColors = this.Const.HairColors.Southern;
    this.m.Beards = this.Const.Beards.SouthernUntidy;
    this.m.BeardChance = 90;
    this.m.Ethnicity = 1;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/bandit_melee_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function generateName(this)
{
    return ((this.Const.Strings.SouthernNames["this.Math.rand(0, (this.Const.Strings.SouthernNames.len() - 1))"] + " ") + this.Const.Strings.NomadChampionTitles["this.Math.rand(0, (this.Const.Strings.NomadChampionTitles.len() - 1))"]);
}

function makeMiniboss(this)
{
    if (!this.actor.makeMiniboss())
    {
        return false;
    }
    this.getSprite("miniboss").setBrush("bust_miniboss");
    if (this.Math.rand(1, 4) == 1)
    {
        this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernMeleeWeapons["this.Math.rand(0, (this.Const.Items.NamedSouthernMeleeWeapons.len() - 1))"])));
    }
    else
    {
        if (this.Math.rand(1, 4) == 2)
        {
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernShields["this.Math.rand(0, (this.Const.Items.NamedSouthernShields.len() - 1))"])));
        }
        else
        {
            if (this.Math.rand(1, 4) == 3)
            {
                this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernArmors["this.Math.rand(0, (this.Const.Items.NamedSouthernArmors.len() - 1))"])));
            }
            this.m.Items.equip(this.new(("scripts/items/" + this.Const.Items.NamedSouthernHelmets["this.Math.rand(0, (this.Const.Items.NamedSouthernHelmets.len() - 1))"])));
        }
    }
    this.m.Skills.add(this.new("scripts/skills/perks/perk_underdog"));
    return this.Math.rand(1, 4);
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.NomadLeader);
    this.m.BaseProperties.IsSpecializedInSwords = true;
    this.m.BaseProperties.IsSpecializedInAxes = true;
    this.m.BaseProperties.IsSpecializedInMaces = true;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.BaseProperties.IsSpecializedInPolearms = true;
    this.m.BaseProperties.IsSpecializedInThrowing = true;
    this.m.BaseProperties.IsSpecializedInHammers = true;
    this.m.BaseProperties.IsSpecializedInSpears = true;
    this.m.BaseProperties.IsSpecializedInCleavers = true;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_nomads");
    this.getSprite("dirt").Visible = true;
    this.getSprite("dirt").Alpha = this.Math.rand(150, 255);
    this.m.Skills.add(this.new("scripts/skills/perks/perk_captain"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_shield_expert"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_brawny"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_coup_de_grace"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_quick_hands"));
    this.m.Skills.add(this.new("scripts/skills/effects/dodge_effect"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nine_lives"));
    this.m.Skills.add(this.new("scripts/skills/actives/throw_dirt_skill"));
    this.m.Skills.add(this.new("scripts/skills/actives/rotation"));
    this.m.Skills.add(this.new("scripts/skills/actives/recover_skill"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    if ((this.World.Days >= this.Const.World.Scaling.Nomads.LeaderNimbleDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.LeaderNimbleDay))
    {
        return ((this.World.Days >= this.Const.World.Scaling.Nomads.LeaderNimbleDay) && (this.World.Days >= this.Const.World.Scaling.Nomads.LeaderNimbleDay));
        this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    }
    return;
}

function onOtherActorDeath(this, _killer, _victim, _skill)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorDeath(_killer, _victim, _skill);
    return;
}

function onOtherActorFleeing(this, _actor)
{
    if (this.Const.EntityType.Slave && this.Const.EntityType.Slave)
    {
        return (this.Const.EntityType.Slave && this.Const.EntityType.Slave);
    }
    this.actor.onOtherActorFleeing(_actor);
    return;
}
