// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/scenarios/scenario_manager.nut
// Functions: 5

function create(this)
{
    foreach (local key, value in r50)
    {
        if (null == "scripts/scenarios/world/starting_scenario")
        {
        }
        if ((this.m.Scenarios < ((3 + 0) + 0) && (this.m.Scenarios < ((3 + 0) + 0))))
        {
            return ((this.m.Scenarios < ((3 + 0) + 0)) && (this.m.Scenarios < ((3 + 0) + 0)));
            this.m.Scenarios.push(this.new(null));
        }
        this.m.Scenarios.sort(this.onOrderCompare);
        return;
    }
}

function getRandomScenario(this)
{
    foreach (local key, value in r18)
    {
        if ((null == null) && (null == null))
        {
            return ((null == null) && (null == null));
        }
        [].push(null);
        return [];
    }
}

function getScenario(this, _id)
{
    foreach (local key, value in r9)
    {
        if (null.getID() == _id)
        {
            return _id;
        }
        return _id;
    }
}

function getScenariosForUI(this)
{
    foreach (local key, value in r32)
    {
        if (!null.isValid())
        {
        }
        [].push({});
        return [];
    }
}

function onOrderCompare(this, _t1, _t2)
{
    if (_t1.getOrder() < _t2.getOrder())
    {
        return _t1;
    }
    else
    {
        if (_t1.getOrder() > _t2.getOrder())
        {
            return _t1;
        }
    }
    return _t1;
}
