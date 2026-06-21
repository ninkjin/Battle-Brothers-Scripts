this.port_building <- this.inherit("scripts/entity/world/settlements/buildings/building", {
	m = {},
	function isHidden()
	{
		return !this.m.Settlement.isCoastal();
	}

	function create()
	{
		this.building.create();
		this.m.ID = "building.port";
		this.m.Name = "港口";
		this.m.UIImage = "ui/settlements/building_09";
		this.m.UIImageNight = "ui/settlements/building_09_night";
		this.m.Tooltip = "world-town-screen.main-dialog-module.Port";
		this.m.TooltipIcon = "ui/icons/buildings/harbor.png";
		this.m.Description = "为对外贸易船和当地渔民服务的港口";
		this.m.IsClosedAtNight = false;
		this.m.Sounds = [
			{
				File = "ambience/buildings/docks_rope_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_rope_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_bell_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_bell_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_bell_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_flapping_sail_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_flapping_sail_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_ship_creaking_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_ship_creaking_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_ship_creaking_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_ship_creaking_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_working_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_working_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_working_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_working_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_working_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_seagull_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_small_waves_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_small_waves_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_small_waves_02.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_small_waves_03.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_small_waves_04.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/terrain/coast_small_waves_05.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
		this.m.SoundsAtNight = [
			{
				File = "ambience/buildings/docks_rope_00.wav",
				Volume = 1.0,
				Pitch = 1.0
			},
			{
				File = "ambience/buildings/docks_rope_01.wav",
				Volume = 1.0,
				Pitch = 1.0
			}
		];
	}

	function onClicked( _townScreen )
	{
		if (this.World.Contracts.getActiveContract() != null && this.World.Contracts.getActiveContract().getType() == "contract.escort_caravan")
		{
			return;
		}

		_townScreen.getTravelDialogModule().setData(this.getUITravelRoster());
		_townScreen.showTravelDialog();
		this.pushUIMenuStack();
	}

	function onSettlementEntered()
	{
	}

	function getUITravelRoster()
	{
		local data = {
			Title = "港口",
			SubTitle = "可以让你订船前往大陆其他地方的港口",
			HeaderImage = null,
			Roster = []
		};
		local settlements = this.World.EntityManager.getSettlements();

		foreach( s in settlements )
		{
			if (!s.isCoastal())
			{
				continue;
			}

			if (s.getID() == this.m.Settlement.getID())
			{
				continue;
			}

			if (!s.isAlliedWithPlayer() || !this.m.Settlement.getOwner().isAlliedWith(s.getFaction()))
			{
				continue;
			}

			local dest = {
				ID = s.getID(),
				EntryID = data.Roster.len(),
				ListName = "驶向" + s.getName(),
				Name = s.getName(),
				Cost = this.getCostTo(s),
				ImagePath = s.getImagePath(),
				ListImagePath = s.getImagePath(),
				FactionImagePath = s.getOwner().getUIBannerSmall(),
				BackgroundText = s.getDescription() + "<br><br>" + this.getRandomDescription(s.getName())
			};
			data.Roster.push(dest);
		}

		return data;
	}

	function getRandomDescription( _destinationName )
	{
		local desc = "一艘名叫'%shipname%'的{快速船 | 结实的船 | 商船 | 龙头船 | 小船 | 商船 | 客船 | 当地渔船 | 吱吱作响的老船}{可让你的战团搭乘前往%destname% | 正巧开往%destname%并可以接受你战团的搭乘 | 即将启航，可以安全、快速地到达%destname% | 可以提供比陆行快的多的方式抵达%destname% | 只需一袋克朗就可以将你送到%destname%}。";
		local vars = [
			[
				"shipname",
				this.Const.Strings.ShipNames[this.Math.rand(0, this.Const.Strings.ShipNames.len() - 1)]
			],
			[
				"destname",
				_destinationName
			]
		];
		return this.buildTextFromTemplate(desc, vars);
	}

	function getCostTo( _to )
	{
		local myTile = this.getSettlement().getTile();
		local dist = _to.getTile().getDistanceTo(myTile);
		local cost = dist * this.World.getPlayerRoster().getSize() * 0.5;
		cost = this.Math.round(cost * 0.1);
		cost = cost * 10.0;
		return cost;
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

