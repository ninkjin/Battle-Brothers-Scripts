// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/ui/global/menu_stack.nut
// Functions: 8

function create(this)
{
    this.m.Stack = [];
    return;
}

function destroy(this)
{
    this.popAll(true);
    this.m.Stack = null;
    this.m.Enviroment = null;
    return;
}

function hasBacksteps(this)
{
    return;
}

function isAllowingCancel(this)
{
    return;
}

function pop(this, _ignoreValidator)
{
    if ((this.m.Stack == 0) && (this.m.Stack == 0))
    {
        return ((this.m.Stack == 0) && (this.m.Stack == 0));
        return _ignoreValidator;
    }
    if ((this.m.Stack["(this.m.Stack.len() - 1)"].backstepValidationCallback != null) && (this.m.Stack["(this.m.Stack.len() - 1)"].backstepValidationCallback != null))
    {
        return ((this.m.Stack["(this.m.Stack.len() - 1)"].backstepValidationCallback != null) && (this.m.Stack["(this.m.Stack.len() - 1)"].backstepValidationCallback != null));
        if (!this.m.Stack["(this.m.Stack.len() - 1)"].backstepValidationCallback())
        {
            return _ignoreValidator;
        }
    }
    this.m.Stack.remove((this.m.Stack.len() - 1));
    this.m.Stack["(this.m.Stack.len() - 1)"].backstepCallback();
    return _ignoreValidator;
}

function popAll(this, _ignoreValidator)
{
    if (this.pop(_ignoreValidator))
    {
    }
    return;
}

function push(this, _backstepCallback, _backstepValidationCallback, _allowCancel)
{
    if ((!this.m.Stack[(this.m.Stack - 1)].allowCancel) && (!this.m.Stack[(this.m.Stack - 1)].allowCancel))
    {
        return ((!this.m.Stack[(this.m.Stack - 1)].allowCancel) && (!this.m.Stack[(this.m.Stack - 1)].allowCancel));
        return _backstepCallback;
    }
    if (typeof(this) == "function")
    {
        if (this.m.Enviroment != null)
        {
        }
        {}.backstepCallback = _backstepCallback;
    }
    if (typeof(this) == "function")
    {
        if (this.m.Enviroment != null)
        {
        }
        {}.backstepValidationCallback = _backstepValidationCallback;
    }
    if ({}.backstepCallback != null)
    {
        this.m.Stack.push({});
        return _backstepCallback;
    }
    return _backstepCallback;
}

function setEnviroment(this, _value)
{
    this.m.Enviroment = _value;
    return;
}
