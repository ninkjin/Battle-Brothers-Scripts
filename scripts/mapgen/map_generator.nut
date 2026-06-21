// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/mapgen/map_generator.nut
// Functions: 3

function create(this)
{
    this.registerTemplates();
    return;
}

function get(this, _templateName)
{
    if ("logError" in _templateName)
    {
        return _templateName;
    }
    this.logError((("ERROR: Template named "" + _templateName) + "" does not exist!"));
    this.assert(false);
    return _templateName;
}

function registerTemplates(this)
{
    foreach (local key, value in r19)
    {
        if (this.new(null) != null)
        {
            this.new(null).init();
            this.m.Templates["this.new(null).getName()"] <- this.new(null);
        }
        return;
    }
}
