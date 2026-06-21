this.settlement_faction <- this.inherit("scripts/factions/faction", {
	m = {
		MaxConcurrentContracts = 1
	},
	function addPlayerRelation( _r, _reason = "" )
	{
		if (_r > 0 && this.World.Ambitions.hasActiveAmbition() && this.World.Ambitions.getActiveAmbition().getID() == "ambition.allied_civilians")
		{
			_r = _r * 1.25;
		}

		if (_r > 0 && this.m.Settlements.len() != 0)
		{
			_r = _r * (1.0 - (this.m.Settlements[0].getSize() - 1) * 0.15);
		}

		this.faction.addPlayerRelation(_r, _reason);

		if (_r < 0)
		{
			foreach( s in this.m.Settlements )
			{
				local owner = s.getOwner();

				if (owner != null && owner.getID() != this.getID())
				{
					owner.addPlayerRelationEx(_r * 0.25);
				}
			}
		}

		if (this.m.PlayerRelation > 70.0)
		{
			this.updateAchievement("MakingFriends", 1, 1);
		}
	}

	function create()
	{
		this.faction.create();
		this.m.Type = this.Const.FactionType.Settlement;
		this.m.Base = "world_base_08";
		this.m.TacticalBase = "bust_base_militia";
		this.m.CombatMusic = this.Const.Music.CivilianTracks;
		this.m.RelationDecayPerDay = this.Const.World.Assets.RelationDecayPerDayCivilian;
		this.m.IsHiddenIfNeutral = true;
	}

	function onUpdateRoster()
	{
		for( local roster = this.getRoster(); roster.getSize() < 3;  )
		{
			local character = roster.create("scripts/entity/tactical/humans/councilman");
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
		if (this.m.Settlements.len() == 0)
		{
			return false;
		}

		this.m.MaxConcurrentContracts = this.getSettlements()[0].getSize();
		local delay = 5.0 - (this.getSettlements()[0].getSize() - 1);
		return this.m.Contracts.len() < this.m.MaxConcurrentContracts && (this.m.LastContractTime == 0 || this.World.getTime().Days <= 1 || this.Time.getVirtualTimeF() > this.m.LastContractTime + this.World.getTime().SecondsPerDay * delay);
	}

	function onSerialize( _out )
	{
		this.faction.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.faction.onDeserialize(_in);
	}

});

