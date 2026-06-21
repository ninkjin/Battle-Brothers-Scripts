// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/factions/actions/add_random_situation_action.nut
// Functions: 4

function create(this)
{
    this.m.ID = "add_random_situation_action";
    this.m.Cooldown = (this.World.getTime().SecondsPerDay * 12);
    this.m.IsSettlementsRequired = true;
    this.faction_action.create();
    return;
}

function onClear(this)
{
    this.m.Settlement = null;
    this.m.Situation = "k[3]";
    return;
}

function onExecute(this, _faction)
{
    this.m.Settlement.addSituation(this.new(("scripts/entity/world/settlements/situations/" + this.m.Situation)));
    if (this.m.Settlement.hasBuilding("building.arena"))
    {
        this.m.Cooldown = (this.World.getTime().SecondsPerDay * 9);
    }
    return;
}

function onUpdate(this, _faction)
{
    this.m.Settlement = _faction.getSettlements()["this.Math.rand(0, (_faction.getSettlements().len() - 1))"];
    this.m.Settlement.updateSituations();
    if (this.Math.rand(1, 100) > 2)
    {
        return;
    }
    if ((!this.m.Settlement) && (!this.m.Settlement))
    {
        return ((!this.m.Settlement) && (!this.m.Settlement));
    }
    if (this.m.Settlement.getSituations().len() >= 2)
    {
        return;
    }
    if (this.m.Settlement.getTile().getDistanceTo(this.World.State.getPlayer().getTile() <= 10))
    {
        return;
    }
    if (this.m.Settlement.hasSituation("situation.short_on_food") || this.m.Settlement.hasSituation("situation.short_on_food") || this.m.Settlement.hasSituation("situation.short_on_food"))
    {
        return (this.m.Settlement.hasSituation("situation.short_on_food") || this.m.Settlement.hasSituation("situation.short_on_food") || this.m.Settlement.hasSituation("situation.short_on_food"));
    }
    if (this.World.FactionManager.isGreaterEvil())
    {
        [].push("refugees_situation");
        [].push("refugees_situation");
    }
    if (this.m.Settlement.getSize() >= 2)
    {
        [].push("warehouse_burned_down_situation");
        [].push("public_executions_situation");
        if (!this.isKindOf(this.m.Settlement, "city_state"))
        {
            [].push("cultist_procession_situation");
            [].push("archery_contest_situation");
            if (this.World.Assets.getOrigin().getID() == "scenario.cultists")
            {
                [].push("cultist_procession_situation");
            }
            if (!this.m.Settlement.isMilitary())
            {
                [].push("collectors_situation");
                if (this.m.Settlement.hasBuilding("building.taxidermist"))
                {
                    [].push("collectors_situation");
                    [].push("collectors_situation");
                }
            }
        }
    }
    if (this.m.Settlement.getSize() >= 3)
    {
        if (!this.m.Settlement.hasSituation("situation.ambushed_trade_routes"))
        {
            [].push("seasonal_fair_situation");
        }
    }
    if (!this.m.Settlement.isMilitary())
    {
        [].push("local_holiday_situation");
        if (!this.isKindOf(this.m.Settlement, "city_state"))
        {
            [].push("witch_burnings_situation");
            [].push("sickness_situation");
        }
    }
    else
    {
        [].push("mustering_troops_situation");
        if (!this.World.FactionManager.isGreaterEvil())
        {
            [].push("disbanded_troops_situation");
            if (!this.m.Settlement.hasSituation("situation.ambushed_trade_routes"))
            {
                [].push("preparing_feast_situation");
            }
        }
    }
    if (this && this)
    {
        return (this && this);
        [].push("lost_at_sea_situation");
        [].push("full_nets_situation");
    }
    if (this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state"))
    {
        return (this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state") || this.isKindOf(this.m.Settlement, "city_state"));
        if (!this.isKindOf(this.m.Settlement, "city_state"))
        {
            [].push("draught_situation");
        }
        [].push("good_harvest_situation");
    }
    if (this.isKindOf(this.m.Settlement, "large_snow_village") || this.isKindOf(this.m.Settlement, "large_snow_village"))
    {
        return (this.isKindOf(this.m.Settlement, "large_snow_village") || this.isKindOf(this.m.Settlement, "large_snow_village"));
        [].push("snow_storms_situation");
    }
    if (this && this)
    {
        return (this && this);
        [].push("mine_cavein_situation");
        [].push("rich_veins_situation");
    }
    if (this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort"))
    {
        return (this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort") || this.isKindOf(this.m.Settlement, "large_forest_fort"));
        [].push("hunting_season_situation");
    }
    if (this.m.Settlement && this.m.Settlement)
    {
        return (this.m.Settlement && this.m.Settlement);
        [].push("ceremonial_season_situation");
    }
    else
    {
        if (this.m.Settlement.isSouthern())
        {
            [].push("sand_storm_situation");
            if (this.m.Settlement.hasBuilding("building.arena"))
            {
                if (!this.m.Settlement.hasSituation("situation.arena_tournament"))
                {
                    [].push("bread_and_games_situation");
                }
                if ((!this.m.Settlement) && (!this.m.Settlement))
                {
                    return ((!this.m.Settlement) && (!this.m.Settlement));
                    [].push("arena_tournament_situation");
                }
            }
        }
    }
    if ([].len() == 0)
    {
        return;
    }
    if (this.Math.rand(1, 100) <= (75 - ([].len() * 25)))
    {
        return;
    }
    this.m.Situation = []["this.Math.rand(0, ([].len() - 1))"];
    this.m.Score = 1;
    return;
}
