this.raid_caravans_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		RaidsToComplete = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.raid_caravans";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "那些大篷车装满了财富，就等着我们去抢。\n我们只需要像从树上摘下的果实一样拿走它们！";
		this.m.UIText = "突袭贸易或补给商队";
		this.m.TooltipText = "突袭4次沿途交易或供应商队。如果你和他们的派别不是敌对关系，你可以通过按住Ctrl键的同时左键点击他们来强制攻击--前提是你目前没有雇佣合同。";
		this.m.SuccessText = "[img]gfx/ui/events/event_60.png[/img]一个死去的商人的声音在你的脑海中响起。%SPEECH_ON%你为什么这么做？我们会给你所有的东西。%SPEECH_OFF%但这段记忆与他本人无关。这是关于他的货车，以及在他的生活悬而未决的情况下，他甚至不会透露出的那些部分。自从开始突袭他们以来，攻击商队已经变成了你和%companyname%的一种乐趣。在你伏击得到的的财富中醒来，战队的大家都很高兴，你的卑鄙行为也让你名声大噪。";
		this.m.SuccessButtonText = "就像从孩子手里抢糖果一样。";
	}

	function getUIText()
	{
		local d = 4 - (this.m.RaidsToComplete - this.World.Statistics.getFlags().getAsInt("CaravansRaided"));
		return this.m.UIText + " (" + this.Math.min(4, d) + "/4)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("CaravansRaided") <= 0 && this.World.Assets.getOrigin().getID() != "scenario.raiders")
		{
			return;
		}

		this.m.RaidsToComplete = this.World.Statistics.getFlags().getAsInt("CaravansRaided") + 4;
		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("CaravansRaided") >= this.m.RaidsToComplete)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU16(this.m.RaidsToComplete);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.RaidsToComplete = _in.readU16();
	}

});

