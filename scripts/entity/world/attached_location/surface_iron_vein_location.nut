this.surface_iron_vein_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "露天铁矿";
		this.m.ID = "attached_location.surface_iron_vein";
		this.m.Description = "这处露天铁矿引来了一个小型采矿营地，开采着这种珍贵的金属。拥有这种资源能够增加最近定居点武器的种类与数量。";
		this.m.Sprite = "world_iron_mine_01";
		this.m.SpriteDestroyed = "world_iron_mine_01_ruins";
	}

	function getSounds( _all = true )
	{
		local r = [];

		if (this.World.getTime().IsDaytime)
		{
			r = [
				{
					File = "ambience/settlement/mines_00.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_01.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_00.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_01.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_02.wav",
					Volume = 1.25,
					Pitch = 1.0
				},
				{
					File = "ambience/settlement/mines_shoveling_03.wav",
					Volume = 1.25,
					Pitch = 1.0
				}
			];

			foreach( s in r )
			{
				s.Volume *= this.Const.Sound.Volume.Ambience / this.Const.Sound.Volume.AmbienceOutsideSettlement;
			}
		}

		return r;
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("miner_background");
		_list.push("retired_soldier_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "weapons/pickaxe"
			});
			_list.push({
				R = 15,
				P = 1.0,
				S = "weapons/reinforced_wooden_flail"
			});
			_list.push({
				R = 25,
				P = 1.0,
				S = "supplies/armor_parts_item"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
			_list.push({
				R = 55,
				P = 1.0,
				S = "weapons/falchion"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/morning_star"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/arming_sword"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/military_cleaver"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/winged_mace"
			});
			_list.push({
				R = 60,
				P = 1.0,
				S = "weapons/pike"
			});
			_list.push({
				R = 70,
				P = 1.0,
				S = "weapons/longaxe"
			});
		}
		else if (_id == "building.armorsmith")
		{
		}
	}

});

