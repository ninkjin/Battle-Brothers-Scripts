this.roster_of_16_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.roster_of_16";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "让我们把战队人数提升到16人！ 它将使我们成为一支强大的力量，使我们能够从事更有利可图的工作。";
		this.m.UIText = "战队人数至少达到16人";
		this.m.TooltipText = "雇佣足够多的人来拥有至少16人的名册。 访问各地的定居点，寻找适合你需要的新兵。 充足的人员能使你接受更危险更高报酬的合同。";
		this.m.SuccessText = "[img]gfx/ui/events/event_80.png[/img]终于凑齐了足够的金币和装备，你设法组建了一支由十六个健壮男子组成的队伍。当下次你走在%currenttown%的主街上，这些人开始高唱起了一首军歌。一些城镇居民低声抱怨着肮脏的雇佣军占领了这个城镇，但也有些人与你并肩行走，高声喊着这些歌词。%SPEECH_ON%站的高高的，兄弟们。人们现在可以看到这是一支真正的雇佣军了，而不是一群乌合之众。%SPEECH_OFF%%highestexperience_brother%宣布道。%SPEECH_ON%我们以力量为交易，现在我们的人数增加了，我们的价格也会提高。%SPEECH_OFF% 看来他是对的。你注意到一个特别肥胖的商人正在评估这支团队，好像他已经有了一个任务的想法。%companyname%现在是一个不容小觑的力量。当这些人被安置下来，庆祝喝的高兴时，也许你应该再去城里走走，看看是否还有更有利可图的合同可以得到。";
		this.m.SuccessButtonText = "我们做到了。";
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getOrigin().getID() != "scenario.militia")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= 16)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.getPlayerRoster().getSize() >= 16)
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

