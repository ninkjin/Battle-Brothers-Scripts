// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: data\scripts\root_state.nut
// Functions: 1

function onInit(this)
{
    this.getroottable().Root <- this;
    this.getroottable().LoadingScreen <- this.new("scripts/ui/screens/loading/loading_screen");
    this.getroottable().TooltipScreen <- this.new("scripts/ui/screens/tooltip/tooltip_screen");
    this.getroottable().UIDataHelper <- this.new("scripts/ui/global/data_helper");
    this.getroottable().Cursor <- this.new("scripts/ui/global/cursor");
    this.getroottable().MapGen <- this.new("scripts/mapgen/map_generator");
    this.getroottable().DialogScreen <- this.new("scripts/ui/screens/dialog_screen");
    this.mods_callHook("root_state.onInit", this);
    this.add("MainMenuState", "scripts/states/main_menu_state");
    return;
}
