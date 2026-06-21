this.world_active_contract_panel_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {},
	function create()
	{
		this.m.ID = "ActiveContractPanelModule";
		this.ui_module.create();
	}

	function destroy()
	{
		this.ui_module.destroy();
	}

	function show( _withSlideAnimation = false )
	{
		if (!this.isVisible() && !this.isAnimating())
		{
			this.m.JSHandle.asyncCall("show", _withSlideAnimation);
		}
	}

	function hide( _withSlideAnimation = false )
	{
		if (this.isVisible() && !this.isAnimating())
		{
			this.m.JSHandle.asyncCall("hide", _withSlideAnimation);
		}
	}

	function updateContract( _contract = null )
	{
		this.m.JSHandle.asyncCall("loadFromData", this.convertToUI(_contract));
	}

	function clearContract()
	{
		this.m.JSHandle.asyncCall("hide", false);
	}

	function onShowContractDetails()
	{
		this.World.State.showDialogPopup("取消合同", "取消一份有效的合同将对你作为一把可靠的雇佣之剑的声誉以及与你当前雇主的关系产生不利影响，尤其是如果你收到了预付款。\n\n你确定要取消吗？", this.onContractCancelled.bindenv(this), null);
	}

	function onContractCancelled()
	{
		this.World.Contracts.removeContract(this.World.Contracts.getActiveContract());
	}

	function convertToUI( _contract )
	{
		local ret = {
			Title = _contract.getTitle(),
			Lists = _contract.getUIBulletpoints()
		};
		return ret;
	}

});

