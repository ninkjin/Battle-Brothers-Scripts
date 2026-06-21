// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/!mods_preload/mod_sr_alternative_standard.nut
// Functions: 9

function <anonymous>(this, _rosterID)
{
    if (this.World.getRoster(_rosterID) == null)
    {
        return _rosterID;
    }
    if (this.World.getRoster(_rosterID).getAll() != null)
    {
        foreach (local key, value in null)
        {
            [].push(this.convertEntityHireInformationToUIDataAltered(null));
            return _rosterID;
            return _rosterID;
        }
    }
}

function <anonymous>(this, entityId, elementId, elementOwner)
{
    if (outer[0](this, entityId, elementId, elementOwner) != null)
    {
        return entityId;
    }
    if (elementId == "sr-dismiss-tooltip")
    {
        return entityId;
    }
    return entityId;
}

function <anonymous>(this, o)
{
    o.general_queryUIElementTooltipData = function() /* closure #0 */;
    return;
}

function <anonymous>(this, _entityID)
{
    if (this.findEntityWithinRoster(_entityID) != null)
    {
        if (this.World.Assets.getMoney() < this.findEntityWithinRoster(_entityID).getTryoutCost())
        {
            return _entityID;
        }
        this.findEntityWithinRoster(_entityID).setTryoutDone(true);
        this.World.Assets.addMoney((-this));
        return _entityID;
    }
    return _entityID;
}

function <anonymous>(this, o)
{
    o.convertEntityHireInformationToUIDataAltered <- function() /* closure #0 */;
    o.convertHireRosterToUIDataAltered <- function() /* closure #1 */;
    o.queryHireInformation = function() /* closure #2 */;
    o.onTryoutRosterEntry = function() /* closure #3 */;
    o.onDismissRosterEntry <- function() /* closure #4 */;
    o.onHireRosterEntry = function() /* closure #5 */;
    return;
}

function <anonymous>(this)
{
    return {Roster = this.convertHireRosterToUIDataAltered(this.m.RosterID), Assets = this.m.Parent.queryAssetsInformation()};
}

function <anonymous>(this, _entityID)
{
    if (this.findEntityWithinRoster(_entityID) != null)
    {
        if (0 < this.findEntityWithinRoster(_entityID).getItems().getAllItems().len())
        {
        }
        if (this.World.Assets.getMoney() < this.Math.max((this.Math.ceil((this.findEntityWithinRoster(_entityID).getHiringCost() * this.World.Assets.m.HiringCostMult) - (this.findEntityWithinRoster(_entityID).getItems().getAllItems()["0"].getValue() * 0.20000000298023224)), 0)))
        {
            return _entityID;
        }
        this.World.getRoster(this.m.RosterID).remove(this.findEntityWithinRoster(_entityID));
        this.World.Assets.addMoney((-this));
        if (this.World.getRoster(this.m.RosterID).getSize() == 0)
        {
            this.m.Parent.getMainDialogModule().reload();
        }
        return _entityID;
    }
    return _entityID;
}

function <anonymous>(this, _entityID)
{
    if (this.findEntityWithinRoster(_entityID) != null)
    {
        if (((this.World.getPlayerRoster().getAll().len() + 1) <= this.World.Assets.getBrothersMax() && ((this.World.getPlayerRoster().getAll().len() + 1) <= this.World.Assets.getBrothersMax())))
        {
            return (((this.World.getPlayerRoster().getAll().len() + 1) <= this.World.Assets.getBrothersMax()) && ((this.World.getPlayerRoster().getAll().len() + 1) <= this.World.Assets.getBrothersMax()));
            if ((this.findEntityWithinRoster(_entityID).getBaseProperties().Initiative >= 100) && (this.findEntityWithinRoster(_entityID).getBaseProperties().Initiative >= 100))
            {
                return ((this.findEntityWithinRoster(_entityID).getBaseProperties().Initiative >= 100) && (this.findEntityWithinRoster(_entityID).getBaseProperties().Initiative >= 100));
            }
            else
            {
                if (this.findEntityWithinRoster(_entityID).getBaseProperties().Stamina >= 100)
                {
                    if (({}.Initiative["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Initiative["1"]) >= 100)
                    {
                    }
                }
                else
                {
                    if (this.findEntityWithinRoster(_entityID).getBaseProperties().Initiative >= 100)
                    {
                        if (({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) >= 100)
                        {
                        }
                    }
                    else
                    {
                        if ((({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) >= 100) && (({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) >= 100))
                        {
                            return ((({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) >= 100) && (({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) >= 100));
                            if ((({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) < 100) && (({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) < 100))
                            {
                                return ((({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) < 100) && (({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"]) < 100));
                            }
                            else
                            {
                                if ((({}.Initiative["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Initiative["1"]) < 100) && (({}.Initiative["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Initiative["1"]) < 100))
                                {
                                    return ((({}.Initiative["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Initiative["1"]) < 100) && (({}.Initiative["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Initiative["1"]) < 100));
                                }
                            }
                        }
                    }
                }
            }
            this.findEntityWithinRoster(_entityID).getBackground().m["
[img]gfx/ui/icons/health.png[/img]"] = (((((((((((((((((((((((((((((((((((((((((((((((((((((((((this.findEntityWithinRoster(_entityID).getBackground().getDescription() + "/") + this.findEntityWithinRoster(_entityID).getBaseProperties().Hitpoints) + "[img]gfx/ui/icons/talent_") + ({}.Hitpoints["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Hitpoints["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_skill.png[/img]") + "RawDescription") + ".png[/img]
[img]gfx/ui/icons/fatigue.png[/img]") + this.findEntityWithinRoster(_entityID).getBaseProperties().MeleeSkill) + "[img]gfx/ui/icons/talent_") + ({}.MeleeSkill["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().MeleeSkill["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/ranged_skill.png[/img]") + this.findEntityWithinRoster(_entityID).getBaseProperties().Stamina) + "[img]gfx/ui/icons/talent_") + ({}.Stamina["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Stamina["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_skill.png[/img]") + "RawDescription") + ".png[/img]
[img]gfx/ui/icons/bravery.png[/img]") + this.findEntityWithinRoster(_entityID).getBaseProperties().RangedSkill) + "[img]gfx/ui/icons/talent_") + ({}.RangedSkill["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().RangedSkill["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_defense.png[/img]") + this.findEntityWithinRoster(_entityID).getBaseProperties().Bravery) + "[img]gfx/ui/icons/talent_") + ({}.Bravery["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Bravery["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_skill.png[/img]") + "RawDescription") + ".png[/img]
[img]gfx/ui/icons/initiative.png[/img]") + this.findEntityWithinRoster(_entityID).getBaseProperties().MeleeDefense) + "[img]gfx/ui/icons/talent_") + ({}.MeleeDefense["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().MeleeDefense["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/ranged_defense.png[/img]") + this.findEntityWithinRoster(_entityID).getBaseProperties().Initiative) + "[img]gfx/ui/icons/talent_") + ({}.Initiative["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().Initiative["1"])) + ".png[/img]") + 0) + "&nbsp;&nbsp;&nbsp;[img]gfx/ui/icons/melee_skill.png[/img]") + "RawDescription") + ".png[/img]
") + this.findEntityWithinRoster(_entityID).getBaseProperties().RangedDefense) + "[img]gfx/ui/icons/talent_") + ({}.RangedDefense["1"] + this.findEntityWithinRoster(_entityID).getBackground().onChangeAttributes().RangedDefense["1"])) + ".png[/img]") + 0) + "buildDescription");
            this.findEntityWithinRoster(_entityID).getBackground()["k[41]"](true);
        }
    }
    return _entityID;
}

function <anonymous>(this, _entity)
{
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    if (1 == 1)
    {
    }
    foreach (local key, value in ({}.Hitpoints["1"] + _entity.getBackground().onChangeAttributes().Hitpoints["1"]))
    {
        if (null.SkillType() == this.Const.Trait.push)
        {
            [].id({});
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (1 == 1)
        {
            if (0 < 10)
            {
            }
        }
        if (_entity.getBaseProperties().Hitpoints >= 64)
        {
        }
        if (_entity.getBaseProperties().Hitpoints >= 56)
        {
        }
        if (_entity.getBaseProperties().Bravery >= 50)
        {
        }
        if (_entity.getBaseProperties().Bravery >= 40)
        {
        }
        if ((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) >= 140)
        {
        }
        if ((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) >= 130)
        {
        }
        if ((_entity.getBaseProperties().MeleeSkill + _entity.Skills.Attributes["this.Const.Attributes.MeleeSkill"]["0"]) >= 90)
        {
        }
        if ((_entity.getBaseProperties().MeleeSkill + _entity.Skills.Attributes["this.Const.Attributes.MeleeSkill"]["0"]) >= 85)
        {
        }
        if ((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 90)
        {
        }
        if ((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 85)
        {
        }
        if (((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) >= 130) && ((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) >= 130))
        {
            return (((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) >= 130) && ((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) >= 130));
        }
        else
        {
            if (((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) < 130) && ((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) < 130))
            {
                return (((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) < 130) && ((_entity.getBaseProperties().Stamina + _entity.Skills.Attributes["this.Const.Attributes.Fatigue"]["0"]) < 130));
            }
            else
            {
                if ((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 90)
                {
                }
                else
                {
                    if ((_entity.getBaseProperties().MeleeDefense + _entity.Skills.Attributes["this.Const.Attributes.MeleeDefense"]["0"]) >= 35)
                    {
                    }
                    else
                    {
                        if (((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 80) && ((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 80))
                        {
                            return (((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 80) && ((_entity.getBaseProperties().RangedSkill + _entity.Skills.Attributes["this.Const.Attributes.RangedSkill"]["0"]) >= 80));
                        }
                        else
                        {
                            if (((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80) && ((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80))
                            {
                                return (((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80) && ((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80));
                            }
                            if ((_entity.getBaseProperties().MeleeSkill + _entity.Skills.Attributes["this.Const.Attributes.MeleeSkill"]["0"]) >= 90)
                            {
                            }
                            if (((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80) && ((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80))
                            {
                                return (((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80) && ((_entity.getBaseProperties().Bravery + _entity.Skills.Attributes["this.Const.Attributes.Bravery"]["0"]) >= 80));
                            }
                        }
                    }
                }
            }
        }
        return _entity;
    }
}
