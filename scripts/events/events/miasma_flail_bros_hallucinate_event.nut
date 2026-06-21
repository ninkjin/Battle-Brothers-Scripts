// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/events/events/miasma_flail_bros_hallucinate_event.nut
// Functions: 7

function create(this)
{
    this.m.ID = "event.miasma_flail_bros_hallucinate";
    this.m.Title = "Along the way...";
    this.m.Cooldown = (9999.0 * this.World.getTime().SecondsPerDay);
    {}["Just what did they see?"] <- [];
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
    this.m.Bro1 = null;
    this.m.Bro2 = null;
    return;
}

function onPrepare(this)
{
    return;
}

function onPrepareVariables(this, _vars)
{
    _vars.push([]);
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
                if ([].len() < 2)
                {
                    return;
                }
                this.m.Bro1 = []["this.Math.rand(0, ([].len() - 1))"];
                [].remove(this.Math.rand(0, ([].len() - 1)));
                this.m.Bro2 = []["this.Math.rand(0, ([].len() - 1))"];
                this.m.Score = 6;
                return;
            }
        }
    }
}

function start(this, _event)
{
    this.Characters.push(_event.m.Bro1.getImagePath());
    this.Characters.push(_event.m.Bro2.getImagePath());
    _event.m.Bro1.addLightInjury();
    _event.m.Bro2.addLightInjury();
    _event.m.Bro1.worsenMood(1.0, "Was ensorcelled by the Grand Diviner's Flail");
    _event.m.Bro2.worsenMood(1.0, "Was ensorcelled by the Grand Diviner's Flail");
    this.List.push({});
    this.List.push({});
    if (_event.m.Bro1.getMoodState() < this.Const.MoodState.Neutral)
    {
        this.List.push({});
    }
    if (_event.m.Bro2.getMoodState() < this.Const.MoodState.Neutral)
    {
        this.List.push({});
    }
    return;
}
