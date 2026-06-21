// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/tactical/enemies/grand_diviner.nut
// Functions: 6

function assignRandomEquipment(this)
{
    this.m.Items.equip(this.new("scripts/items/weapons/legendary/miasma_flail_enemy"));
    this.m.Items.equip(this.new("scripts/items/armor/golems/grand_diviner_robes_enemy"));
    this.m.Items.equip(this.new("scripts/items/helmets/golems/grand_diviner_headdress_enemy"));
    return;
}

function create(this)
{
    this.m.Type = this.Const.EntityType.GrandDiviner;
    this.m.BloodType = this.Const.BloodType.Red;
    this.m.XP = this.Const.Tactical.Actor.GrandDiviner.XP;
    this.human.create();
    this.m.Faces = this.Const.Faces.Necromancer;
    this.m.Hairs = this.Const.Hair.Necromancer;
    this.m.HairColors = this.Const.HairColors.Zombie;
    this.m.Beards = null;
    this.m.ConfidentMoraleBrush = "icon_confident_undead";
    this.m.Sound["this.Const.Sound.ActorEvent.Resurrect"] = ["sounds/enemies/diviner_resurrect_01.wav", "sounds/enemies/diviner_resurrect_02.wav"];
    this.m.SoundVolume["this.Const.Sound.ActorEvent.Resurrect"] = 2.0;
    this.m.SoundPitch = 0.8999999761581421;
    this.m.AIAgent = this.new("scripts/ai/tactical/agents/grand_diviner_agent");
    this.m.AIAgent.setActor(this);
    return;
}

function onDeath(this, _killer, _skill, _tile, _fatalityType)
{
    foreach (local key, value in r26)
    {
        foreach (local key, value in r21)
        {
            if ((this.getFaction() == this.Const.EntityType.FaultFinder) && (this.getFaction() == this.Const.EntityType.FaultFinder))
            {
                return ((this.getFaction() == this.Const.EntityType.FaultFinder) && (this.getFaction() == this.Const.EntityType.FaultFinder));
                [].push(null);
            }
            if ([].len() == 0)
            {
                this.human.onDeath(_killer, _skill, _tile, _fatalityType);
                return;
            }
            this.Tactical.Entities.setBusy(true);
            foreach (local key, value in r16)
            {
                if (null.getTile().getDistanceTo(_tile) < []["0"].getTile().getDistanceTo(_tile))
                {
                }
                null.kill(null, null);
                this.Time.scheduleEvent(this.TimeUnit.Real, 300, this.onPossess.bindenv(this), {});
                this.Tactical.State.spawnMiasmaOnTile(_tile);
                this.human.onDeath(_killer, _skill, null, this.Const.FatalityType.Unconscious);
                return;
            }
        }
    }
}

function onInit(this)
{
    this.human.onInit();
    this.m.BaseProperties.setValues(this.Const.Tactical.Actor.GrandDiviner);
    this.m.BaseProperties.IsAffectedByNight = false;
    this.m.BaseProperties.Vision = 8;
    this.m.ActionPoints = this.m.BaseProperties.ActionPoints;
    this.m.Hitpoints = this.m.BaseProperties.Hitpoints;
    this.m.CurrentProperties = clone this;
    this.setAppearance();
    this.getSprite("socket").setBrush("bust_base_undead");
    this.getSprite("head").Color = this.createColor("#ffffff");
    this.getSprite("head").Saturation = 1.0;
    this.getSprite("body").Saturation = 0.6000000238418579;
    this.m.BaseProperties.IsSpecializedInFlails = true;
    this.m.Skills.add(this.new("scripts/skills/perks/perk_adrenalin"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_hold_out"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_pathfinder"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_anticipation"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_reach_advantage"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_nimble"));
    this.m.Skills.add(this.new("scripts/skills/perks/perk_fearsome"));
    this.m.Skills.add(this.new("scripts/skills/racial/grand_diviner_racial"));
    this.m.Skills.add(this.new("scripts/skills/actives/footwork"));
    this.m.Skills.add(this.new("scripts/skills/actives/corpse_explosion_skill"));
    return;
}

function onPossess(this, _data)
{
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/grand_diviner", _data.SpawnTile.Coords).assignRandomEquipment();
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/grand_diviner", _data.SpawnTile.Coords).setFaction(_data.Faction);
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/grand_diviner", _data.SpawnTile.Coords).setMoraleState(this.Const.MoraleState.Confident);
    this.Tactical.spawnEntity("scripts/entity/tactical/enemies/grand_diviner", _data.SpawnTile.Coords).riseFromGround();
    this.Tactical.Entities.setBusy(false);
    return;
}

function sortByNearest(this, _a, _b)
{
    if (_a.getTile().getDistanceTo(this["_tile"]) < _b.getTile().getDistanceTo(this["_tile"]))
    {
        return _a;
    }
    else
    {
        if (_a.getTile().getDistanceTo(this["_tile"]) > _b.getTile().getDistanceTo(this["_tile"]))
        {
            return _a;
        }
    }
    return _a;
}
