// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/events/events/miasma_flail_company_nightmare_event.nut
// Functions: 7

function create(this)
{
    this.m.ID = "event.miasma_flail_company_nightmare";
    this.m.Title = "Along the way...";
    this.m.Cooldown = (9999.0 * this.World.getTime().SecondsPerDay);
    {}["Motherfarker."] <- [];
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
    return;
}

function onPrepare(this)
{
    return;
}

function onPrepareVariables(this, _vars)
{
    return;
}

function onUpdateScore(this)
{
    foreach (local key, value in r21)
    {
        if ((this.Const.ItemSlot.Mainhand == r9) && (this.Const.ItemSlot.Mainhand == r9))
        {
            return ((this.Const.ItemSlot.Mainhand == r9) && (this.Const.ItemSlot.Mainhand == r9));
        }
        if (!true)
        {
            foreach (local key, value in r15)
            {
                if (((this.Const.ItemSlot.Mainhand == r9) == r9) && ((this.Const.ItemSlot.Mainhand == r9) == r9))
                {
                    return (((this.Const.ItemSlot.Mainhand == r9) == r9) && ((this.Const.ItemSlot.Mainhand == r9) == r9));
                }
                if (!true)
                {
                    return;
                }
                this.m.Score = 6;
                return;
            }
        }
    }
}

function start(this, _event)
{
    foreach (local key, value in r39)
    {
        null.worsenMood(0.75, "Had a disturbing nightmare involving the Grand Diviner");
        if (null.getMoodState() < this.Const.MoodState.Neutral)
        {
            this.List.push({});
        }
        return;
    }
}
