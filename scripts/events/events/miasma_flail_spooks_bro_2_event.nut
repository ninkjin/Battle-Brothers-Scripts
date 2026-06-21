// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/events/events/miasma_flail_spooks_bro_2_event.nut
// Functions: 7

function create(this)
{
    this.m.ID = "event.miasma_flail_spooks_bro_2";
    this.m.Title = "Along the way...";
    this.m.Cooldown = (9999.0 * this.World.getTime().SecondsPerDay);
    {}["It's only a weapon, you fools."] <- [];
    {}["k[21]"] <- function() /* closure #1 */;
    this.m.Screens.push({});
    return;
}

function getResult(this, _event)
{
    return _event;
}

function onClear(this)
{
    this.m.Dude = null;
    return;
}

function onPrepare(this)
{
    return;
}

function onPrepareVariables(this, _vars)
{
    _vars.push([]);
    return;
}

function onUpdateScore(this)
{
    foreach (local key, value in r34)
    {
        if (null.getSkills().hasSkill("trait.player"))
        {
        }
        [].push(null);
        if ((this.Const.ItemSlot.Mainhand == r13) && (this.Const.ItemSlot.Mainhand == r13))
        {
            return ((this.Const.ItemSlot.Mainhand == r13) && (this.Const.ItemSlot.Mainhand == r13));
        }
        if (!true)
        {
            foreach (local key, value in r15)
            {
                if (((this.Const.ItemSlot.Mainhand == r13) == r13) && ((this.Const.ItemSlot.Mainhand == r13) == r13))
                {
                    return (((this.Const.ItemSlot.Mainhand == r13) == r13) && ((this.Const.ItemSlot.Mainhand == r13) == r13));
                }
                if (!true)
                {
                    return;
                }
                if ([].len() == 0)
                {
                    return;
                }
                this.m.Dude = []["this.Math.rand(0, ([].len() - 1))"];
                this.m.Score = 6;
                return;
            }
        }
    }
}

function start(this, _event)
{
    this.Characters.push(_event.m.Dude.getImagePath());
    _event.m.Dude.worsenMood(1.0, "Was ensorcelled by the Grand Diviner's Flail");
    if (_event.m.Dude.getMoodState() < this.Const.MoodState.Neutral)
    {
        this.List.push({});
    }
    _event.m.Dude.addLightInjury();
    this.List.push({});
    return;
}
