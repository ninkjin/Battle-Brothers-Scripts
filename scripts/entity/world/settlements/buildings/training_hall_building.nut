this.training_hall_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {},
	function create()
	{
		this.building.create();
		this.m.ID = "building.training_hall";
		this.m.Name = "训练厅";
		this.m.Description = "让你的人接受战斗训练并向老兵学习经验";
		this.m.UIImage = "ui/settlements/building_07";
		this.m.UIImageNight = "ui/settlements/building_07_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.VeteransHall";
		this.m.TooltipIcon = "ui/icons/buildings/vet_hall.png";
		this.m.Sounds = [];
		this.m.SoundsAtNight = [];
	}

	function onClicked( _townScreen )
	{
		_townScreen.showTrainingDialog();
		this.pushUIMenuStack();
	}

	function onSettlementEntered()
	{
	}

	function onSerialize( _out )
	{
		this.building.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.building.onDeserialize(_in);
	}

});

