this.greenskins_situation <- this.inherit("scripts/entity/world/settlements/situations/situation", {
	m = {},
	function create()
	{
		this.situation.create();
		this.m.ID = "situation.greenskins";
		this.m.Name = "绿皮肆虐";
		this.m.Description = "绿皮正在肆虐这附近的地区，由于兽人或哥布林不断掠夺郊外农场并摧毁商队，许多人已经丧命。补给开始缺乏，并且人们变得绝望。";
		this.m.Icon = "ui/settlement_status/settlement_effect_01.png";
		this.m.Rumors = [
			"我听说有卑鄙的绿皮在%settlement%周围到处肆虐！是真的吗？我希望他们不要过来…",
			"你看见傍晚空中的烟柱了吗？它们从%settlement%升起，绿皮正在那里的郊区烧杀掳掠。",
			"来，看看我手上还剩下什么！自从不久前撞上绿皮以后，这手就没了手指也基本再用不上了。现在我听说他们回来了，我们谈话的当下他们就在%settlement%周边肆虐。"
		];
	}

	function getAddedString( _s )
	{
		return _s + "现在有" + this.m.Name;
	}

	function getRemovedString( _s )
	{
		return _s + "不再有" + this.m.Name;
	}

	function onAdded( _settlement )
	{
		_settlement.resetShop();
		_settlement.resetRoster(true);
	}

	function onUpdate( _modifiers )
	{
		_modifiers.RarityMult *= 0.75;
		_modifiers.RecruitsMult *= 0.75;
	}

});

