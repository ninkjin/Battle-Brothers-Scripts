this.discover_unique_locations_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		LocationsDiscovered = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.discover_unique_locations";
		this.m.Duration = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "荒野中隐藏有很多其他人不敢索取的宝藏。\n这是我们的机会，所以让我们出发去寻找三个传奇地点！";
		this.m.UIText = "探索世界发现传奇地点";
		this.m.TooltipText = "通过自己探索世界，发现3个传奇地点。 出发前一定要储备好食物！";
		this.m.SuccessText = "[img]gfx/ui/events/event_41.png[/img]一个牵着骡子的男人靠近聚会。 当他走近时，你注意到这个草食动物上搭着像望远镜一样又长、又卷曲的驮篮。 光滑的羽毛叶片从鞍袋中伸出，一桶墨水在它们旁边弹来弹去。 他介绍自己是这些地区的制图师，知道你战队的名字。他鞠躬。%SPEECH_ON%作为地图的同伴，我要感谢你。%SPEECH_OFF%你问我为什么。 这个陌生人显得很震惊，他不得不解释自己的崇拜，仿佛你不知道自己的大名。你不懂原因。%SPEECH_ON%为什么，因为开辟了这片土地！ 在你之前，没有一个灵魂会走过这些地方，除了警告我不要去那里之外，我没有什么可以在这页上写的。 你见过“这里有龙”这句话吗？那是我做的！ 现在我想把它抹掉，我从来没有这么高兴过。 谢谢你，探险家，你可以有一个这样的装饰品，让别人知道你的事迹！%SPEECH_OFF%探险家？地图的同伴？ 看来这个陌生人误解了你们，但你们还是接受了他的想法。 他递给你一根别致的羽毛表示感谢，然后道别。 %companyname% 好像正在为自我赢得一个超越杀害和屠戮的大名。 你不确定这件事是好是坏。";
		this.m.SuccessButtonText = "我们绘制自己的地图。";
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.m.LocationsDiscovered + "/3)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.discover_locations").isDone())
		{
			return;
		}

		if (!this.World.Flags.has("LegendaryLocationsDiscovered"))
		{
			this.World.Flags.set("LegendaryLocationsDiscovered", 0);
		}

		if (this.World.Flags.get("LegendaryLocationsDiscovered") >= 11 - 3)
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.m.LocationsDiscovered >= 3)
		{
			return true;
		}

		return false;
	}

	function onLocationDiscovered( _location )
	{
		if (this.World.Contracts.getActiveContract() == null || !this.World.Contracts.getActiveContract().isTileUsed(_location.getTile()))
		{
			if (_location.isLocationType(this.Const.World.LocationType.Unique))
			{
				this.m.LocationsDiscovered = this.Math.min(3, this.m.LocationsDiscovered + 1);
				this.World.Ambitions.updateUI();
			}
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

