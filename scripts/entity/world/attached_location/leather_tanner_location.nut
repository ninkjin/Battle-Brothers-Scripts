this.leather_tanner_location <- this.inherit("scripts/entity/world/attached_location", {
	m = {},
	function create()
	{
		this.attached_location.create();
		this.m.Name = "制革坊";
		this.m.ID = "attached_location.leather_tanner";
		this.m.Description = "这家制革坊用生皮制作耐用的皮革制品。这些皮革的供给能够增加最近定居点轻型盔甲的种类与数量。";
		this.m.Sprite = "world_leather_tanner_01";
		this.m.SpriteDestroyed = "world_leather_tanner_01_ruins";
	}

	function onUpdateDraftList( _list )
	{
		if (!this.isActive())
		{
			return;
		}

		_list.push("militia_background");
		_list.push("apprentice_background");
		_list.push("retired_soldier_background");
		_list.push("butcher_background");
	}

	function onUpdateShopList( _id, _list )
	{
		if (_id == "building.marketplace")
		{
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/leather_tunic"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/apron"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/full_leather_cap"
			});
			_list.push({
				R = 10,
				P = 1.0,
				S = "helmets/full_leather_cap"
			});
		}
		else if (_id == "building.specialized_trader")
		{
		}
		else if (_id == "building.weaponsmith")
		{
		}
		else if (_id == "building.armorsmith")
		{
			_list.push({
				R = 20,
				P = 1.0,
				S = "armor/padded_leather"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "armor/leather_lamellar"
			});
			_list.push({
				R = 35,
				P = 1.0,
				S = "armor/mail_hauberk"
			});
			_list.push({
				R = 50,
				P = 1.0,
				S = "armor/reinforced_mail_hauberk"
			});
			_list.push({
				R = 30,
				P = 1.0,
				S = "helmets/padded_nasal_helmet"
			});
			_list.push({
				R = 35,
				P = 1.0,
				S = "helmets/padded_kettle_hat"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "helmets/padded_flat_top_helmet"
			});
			_list.push({
				R = 45,
				P = 1.0,
				S = "helmets/closed_flat_top_helmet"
			});
			_list.push({
				R = 40,
				P = 1.0,
				S = "shields/kite_shield"
			});
		}
	}

});

