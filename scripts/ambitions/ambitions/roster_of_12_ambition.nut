this.roster_of_12_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.roster_of_12";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们应该让战团增加到十几个人的实力！这会让我们变得强大，可以承担更有利可图的工作。";
		this.m.UIText = "战队人数至少达到12人";
		this.m.TooltipText = "雇佣足够多的人来拥有至少12人的名册。 访问各地的定居点，寻找适合你需要的新兵。 充足的人员能使你接受更危险更高报酬的合同。";
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]最终在集齐了钱和装备后，你成功地集合了十二名有能力的战士。当你走在%currenttown%的主干道上时，人们突然唱起了一首激昂的行军歌。一些市民低声抱怨肮脏的雇佣兵占领了这个小镇，但也有些人走在旁边，和你们一起喊着。%SPEECH_ON%兄弟们，昂首挺胸。大家可以看到，这是一个真正的雇佣军战团，而不是一群流浪汉。%SPEECH_OFF%%highestexperience_brother%宣称道。%SPEECH_ON%我们以实力为价，现在我们的实力上升了，价格也会上升。%SPEECH_OFF%看起来他有权这样说。你注意到一个特别胖的贵族在打量你的战团，好像他有任务给你。%companyname%现在是一股不可忽视的力量。当战士们安顿下来喝庆祝酒时，也许你应该在城里再逛一逛，看看是否有更有利可图的合同。";
		this.m.SuccessButtonText = "我们做到了。";
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() == "scenario.militia")
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 1 && this.World.Assets.getOrigin().getID() != "scenario.deserters" && this.World.Assets.getOrigin().getID() != "scenario.raiders")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= 12)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.getPlayerRoster().getSize() >= 12)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
	}

});

