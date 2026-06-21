this.town_training_dialog_module <- this.inherit("scripts/ui/screens/ui_module", {
	m = {},
	function create()
	{
		this.m.ID = "TrainingDialogModule";
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

	function queryRosterInformation()
	{
		local settlement = this.World.State.getCurrentTown();
		local brothers = this.World.getPlayerRoster().getAll();
		local roster = [];

		foreach( b in brothers )
		{
			if (b.getLevel() >= 11)
			{
				continue;
			}

			if (b.getLevel() >= 7 && this.World.Assets.getOrigin().getID() == "scenario.manhunters" && b.getBackground().getID() == "background.slave")
			{
				continue;
			}

			if (b.getSkills().hasSkill("effects.trained"))
			{
				continue;
			}

			local background = b.getBackground();
			local e = {
				ID = b.getID(),
				Name = b.getName(),
				Level = b.getLevel(),
				ImagePath = b.getImagePath(),
				ImageOffsetX = b.getImageOffsetX(),
				ImageOffsetY = b.getImageOffsetY(),
				BackgroundImagePath = background.getIconColored(),
				BackgroundText = background.getDescription(),
				Training = [],
				Effects = []
			};
			e.Training.push({
				id = 0,
				icon = "skills/status_effect_75.png",
				name = "搏斗练习",
				tooltip = "world-town-screen.training-dialog-module.Train1",
				price = 80 + 50 * b.getLevel()
			});
			e.Training.push({
				id = 1,
				icon = "skills/status_effect_76.png",
				name = "老兵的课程",
				tooltip = "world-town-screen.training-dialog-module.Train2",
				price = 100 + 60 * b.getLevel()
			});
			e.Training.push({
				id = 2,
				icon = "skills/status_effect_77.png",
				name = "严格的训练",
				tooltip = "world-town-screen.training-dialog-module.Train3",
				price = 90 + 55 * b.getLevel()
			});
			roster.push(e);
		}

		return {
			Title = "训练厅",
			SubTitle = "让你的人接受战斗训练并向老兵学习经验",
			Roster = roster,
			Assets = this.m.Parent.queryAssetsInformation()
		};
	}

	function onTrain( _data )
	{
		local entityID = _data[0];
		local trainingID = _data[1];
		local settlement = this.World.State.getCurrentTown();
		local entity = this.Tactical.getEntityByID(entityID);

		if (entity.getSkills().hasSkill("effects.trained"))
		{
			return null;
		}

		local price = 0;
		local effect = this.new("scripts/skills/effects_world/new_trained_effect");

		switch(trainingID)
		{
		case 0:
			price = this.Math.round(80 + 50 * entity.getLevel());
			effect.m.Duration = 1;
			effect.m.XPGainMult = 1.5;
			effect.m.Icon = "skills/status_effect_75.png";
			break;

		case 1:
			price = this.Math.round(100 + 60 * entity.getLevel());
			effect.m.Duration = 3;
			effect.m.XPGainMult = 1.35;
			effect.m.Icon = "skills/status_effect_76.png";
			break;

		case 2:
			price = this.Math.round(90 + 55 * entity.getLevel());
			effect.m.Duration = 5;
			effect.m.XPGainMult = 1.2;
			effect.m.Icon = "skills/status_effect_77.png";
			break;
		}

		this.World.Assets.addMoney(-price);
		entity.getSkills().add(effect);
		local background = entity.getBackground();
		local e = {
			ID = entity.getID(),
			Name = entity.getName(),
			Level = entity.getLevel(),
			ImagePath = entity.getImagePath(),
			ImageOffsetX = entity.getImageOffsetX(),
			ImageOffsetY = entity.getImageOffsetY(),
			BackgroundImagePath = background.getIconColored(),
			BackgroundText = background.getDescription(),
			Training = [],
			Effects = []
		};
		e.Effects.push({
			id = effect.getID(),
			icon = effect.getIcon()
		});
		local r = {
			Entity = e,
			Assets = this.m.Parent.queryAssetsInformation()
		};
		return r;
	}

});

