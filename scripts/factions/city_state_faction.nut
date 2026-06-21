this.city_state_faction <- this.inherit("scripts/factions/faction", {
	m = {
		Title = ""
	},
	function getName()
	{
		return this.m.Title + " " + this.m.Name;
	}

	function getNameOnly()
	{
		return this.m.Name;
	}

	function getColor()
	{
		return this.Const.BannerColor[this.m.Banner];
	}

	function getBannerSmall()
	{
		return "banner_noble_" + (this.m.Banner < 10 ? "0" + this.m.Banner : this.m.Banner);
	}

	function setTitle( _t )
	{
		this.m.Title = _t;
	}

	function isReadyToSpawnUnit()
	{
		return this.m.Units.len() <= 4;
	}

	function addPlayerRelation( _r, _reason = "" )
	{
		this.faction.addPlayerRelation(_r, _reason);

		if (_r < 0)
		{
			foreach( s in this.m.Settlements )
			{
				if (s.getFaction() != this.m.ID)
				{
					this.World.FactionManager.getFaction(s.getFaction()).addPlayerRelationEx(_r * 0.5);
				}
			}
		}

		if (this.m.PlayerRelation > 90.0)
		{
			this.updateAchievement("FriendOfTheSouth", 1, 1);
		}
	}

	function makeSettlementsFriendlyToPlayer()
	{
		this.m.PlayerRelation = this.Math.maxf(this.m.PlayerRelation, 30.0);
	}

	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.OrientalCityState;
		this.m.Base = "world_base_13";
		this.m.TacticalBase = "bust_base_southern";
		this.m.BannerPrefix = "banner_noble_";
		this.m.CombatMusic = this.Const.Music.OrientalCityStateTracks;
		this.m.RelationDecayPerDay = this.Const.World.Assets.RelationDecayPerDayNoble;
	}

	function onUpdateRoster()
	{
		for( local roster = this.getRoster(); roster.getSize() < 4;  )
		{
			local character = roster.create("scripts/entity/tactical/humans/vizier");
			character.setFaction(this.m.ID);
			character.setAppearance();

			if (character.getTitle() != "")
			{
				local currentRoster = roster.getAll();

				foreach( c in currentRoster )
				{
					if (c.getID() != character.getID() && character.getTitle() == c.getTitle())
					{
						character.setTitle("");
						break;
					}
				}
			}

			if (character.getTitle() == "")
			{
				character.setTitle(" " + this.m.Name);
			}

			character.assignRandomEquipment();
		}
	}

	function isReadyForContract()
	{
		return (this.World.getTime().Days > 5 && this.m.Contracts.len() < 3 || this.m.Contracts.len() < 2) && (this.m.LastContractTime == 0 || this.Time.getVirtualTimeF() > this.m.LastContractTime + this.World.getTime().SecondsPerDay * 4.0);
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
		_out.writeString(this.m.Title);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
		this.m.Title = _in.readString();
	}

});

