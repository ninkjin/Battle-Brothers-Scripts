this.win_against_y_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		IsFulfilled = false
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.win_against_y";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "我们获得了一些声望，但现在你可以追求真正的名望。\n让我们在战斗中击败两打强大的对手！";
		this.m.UIText = "赢得一场24个或更多敌人的战斗";
		this.m.TooltipText = "赢得一场24个或更多敌人的战斗，无论是杀死他们，还是让他们四散奔逃。 你可以把它作为合同的一部分，或者按照你自己的方式来完成。";
		this.m.SuccessText = "[img]gfx/ui/events/event_22.png[/img]战斗结束后，%lowesthp_brother% 坐在那里盯着他的脚，看起来完全筋疲力尽，其他人也一样。 %SPEECH_ON%那是我生来要打的仗！ 现在如果我死了，我将和我所认识的最勇敢、最致命的一群人死在一起，我自豪地称他们为我的兄弟！%SPEECH_OFF%这在四周引起了一片疲惫的赞同声。%SPEECH_ON%农民们谈论着汗水、鲜血和泪水，但是 %companyname% 的人却经历了磨难并取得了胜利！%SPEECH_OFF%男人喊了三次战队的名字，疲惫但毕竟获胜了。\n\n在未来的日子里，你会发现无论文明人聚集在哪里，他们都会指着你，低声耳语，你并不知道他们是出于恐惧还是钦佩。 无论你走到哪里，你伟大胜利的消息已经传遍了你面前的土地。";
		this.m.SuccessButtonText = "现在谁敢挡在我们面前？";
	}

	function onUpdateScore()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 24)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.win_against_x").isDone())
		{
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 24 || this.m.IsFulfilled)
		{
			return true;
		}

		return false;
	}

	function onLocationDestroyed( _location )
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 24)
		{
			this.m.IsFulfilled = true;
		}
	}

	function onPartyDestroyed( _party )
	{
		if (this.World.Statistics.getFlags().getAsInt("LastEnemiesDefeatedCount") >= 24)
		{
			this.m.IsFulfilled = true;
		}
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeBool(this.m.IsFulfilled);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);
		this.m.IsFulfilled = _in.readBool();
	}

});

