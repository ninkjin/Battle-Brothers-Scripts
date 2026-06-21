this.discover_locations_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		LocationsDiscovered = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.discover_locations";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "伟大的探险家成为传奇人物。 进入荒野是一项危险的事业，但我们随后将讲述的故事肯定会增加我们的知名度。";
		this.m.UIText = "探索世界发现隐藏的地点";
		this.m.TooltipText = "通过自己探索世界，发现8个隐藏的地点，如废墟或敌对营地。 出发前一定要储备好食物！";
		this.m.SuccessText = "[img]gfx/ui/events/event_54.png[/img]抓住命运的胡子，你宣布你打算穿越这片土地，创造作为探险家的标志。 他们认为，发现新的地点，不管是邪恶的巢穴还是繁荣的村庄，都会带来新的财富机会，人类热枕地跟随着。\n\n在接下来的几天里，战队看到了许多广阔的景观，勘察了耸立的高塔和险峻的峡谷。 你避开了敌人的侦察兵，在星空下建立了不点火的营地，就像虚空的一千支烛火。 绘制了原生态河流的路线图，绕过无法穿越的山脉的险恶边缘，%companyname% 可以坦诚宣布自己的行进范围比其他同类队伍更广泛。";
		this.m.SuccessButtonText = "我们绘制自己的地图。";
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.m.LocationsDiscovered + "/8)";
	}

	function onUpdateScore()
	{
		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.find_and_destroy_location").isDone())
		{
			return;
		}

		local locations = this.World.EntityManager.getLocations();
		local numDiscovered = 0;

		foreach( v in locations )
		{
			if (v.isDiscovered())
			{
				numDiscovered = ++numDiscovered;
			}
		}

		if (numDiscovered + 12 >= locations.len())
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.m.LocationsDiscovered >= 8)
		{
			return true;
		}

		return false;
	}

	function onLocationDiscovered( _location )
	{
		if (_location.getTypeID() == "location.battlefield")
		{
			return;
		}

		if (this.World.Contracts.getActiveContract() == null || !this.World.Contracts.getActiveContract().isTileUsed(_location.getTile()))
		{
			this.m.LocationsDiscovered = this.Math.min(8, this.m.LocationsDiscovered + 1);
			this.World.Ambitions.updateUI();
		}
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU8(this.m.LocationsDiscovered);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.LocationsDiscovered = _in.readU8();
	}

});

