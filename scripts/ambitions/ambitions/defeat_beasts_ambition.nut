this.defeat_beasts_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		BeastsToDefeat = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_beasts";
		this.m.Duration = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "野兽困扰着处于文明边缘的村庄。\n我们要应该做的就是为了获取财富而猎杀这些野兽！";
		this.m.UIText = "击败流浪野兽群";
		this.m.TooltipText = "在战斗中击败5群流浪野兽，如恐狼或食尸鬼，无论是作为合同的一部分，还是通过自己寻找。";
		this.m.SuccessText = "[img]gfx/ui/events/event_56.png[/img]在你处决另一批野兽后，你发现自己在思考祖先的本性。 你在这里准备就绪、全副武装，周游世界，在战争、战斗方面经验丰富，但这个世界上的野兽仍像以前一样危险。 你的祖先，他们拥有什么？ 没有一种文明可以装点自我，没有一座城市可以照亮黑夜、点燃勇气，没有一张地图可以给世界一个舒适的领地。 然而…他们活了下来。 是什么让他们做到的。怎么做到的？ 也许，在过去人类构成了威胁，野兽把人类作为怪物看待。 在我们的祖先之前也许有过这样的时代，人们拥有自己的城市，从远古时代起，全世界的动物和人类均处于单纯的轮回中。 如果是这样的话，那么你就不应该沉湎于过去，而是未来的日常、岁月和纪年…";
		this.m.SuccessButtonText = "人类和野兽都应该听说我们的大名。";
	}

	function getUIText()
	{
		local d = 5 - (this.m.BeastsToDefeat - this.World.Statistics.getFlags().getAsInt("BeastsDefeated"));
		return this.m.UIText + " (" + this.Math.min(5, d) + "/5)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 1 && this.World.Assets.getOrigin().getID() != "scenario.beast_hunters")
		{
			return;
		}

		this.m.BeastsToDefeat = this.World.Statistics.getFlags().getAsInt("BeastsDefeated") + 5;
		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("BeastsDefeated") >= this.m.BeastsToDefeat)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU16(this.m.BeastsToDefeat);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.BeastsToDefeat = _in.readU16();
	}

});

