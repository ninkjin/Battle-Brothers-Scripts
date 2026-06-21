this.town_taxidermist_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {},
	function create()
	{
		this.m.ID = "TaxidermistDialogModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function clear()
	{
	}

	function onLeaveButtonPressed()
	{
		this.m.Parent.onModuleClosed();
	}

	function queryBlueprints()
	{
		return {
			Title = "剥制屋",
			SubTitle = "剥制师可以从你带给他的各种野兽战利品中创造有用的物品",
			Blueprints = this.World.Crafting.getQualifiedBlueprintsForUI(),
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function onCraft( _blueprintID )
	{
		local blueprint = this.World.Crafting.getBlueprint(_blueprintID);
		blueprint.craft();
		this.World.Assets.addMoney(-blueprint.getCost());

		if (blueprint.getSounds().len() != 0)
		{
			this.Sound.play(blueprint.getSounds()[this.Math.rand(0, blueprint.getSounds().len() - 1)], 1.0);
		}

		this.World.Statistics.getFlags().increment("ItemsCrafted");
		this.World.Ambitions.updateUI();

		if (blueprint.isCraftable())
		{
			return {
				Blueprints = null,
				Assets = this.m.Parent.queryAssetsInformation()
			};
		}
		else
		{
			return this.queryBlueprints();
		}
	}

});

