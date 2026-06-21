// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/tactical/scenario_template.nut
// Functions: 5

function createStash(this)
{
    this.getroottable().Stash <- this.new("scripts/items/stash_container");
    return;
}

function generate(this)
{
    this.logDebug("ScenarioTemplate::generate()");
    return;
}

function getMusic(this)
{
    return this.m.Music;
}

function getPlayerName(this, _index)
{
    if ((_index >= this.m.PlayerNames) && (_index >= this.m.PlayerNames))
    {
        return ((_index >= this.m.PlayerNames) && (_index >= this.m.PlayerNames));
        return _index;
    }
    return _index;
}

function getRandomPlayerName(this)
{
    return this.Const.Strings.CharacterNames["this.Math.rand(0, (this.Const.Strings.CharacterNames.len() - 1))"];
}
