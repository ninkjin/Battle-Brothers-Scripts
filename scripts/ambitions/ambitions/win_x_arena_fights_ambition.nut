this.win_x_arena_fights_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {
		ArenaMatchesToWin = 0
	},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.win_x_arena_fights";
		this.m.Duration = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "让我们在呼喊着我们名字的人群面前为名利而战。\n我们会在南方的竞技场上挥洒鲜血！";
		this.m.UIText = "赢得竞技场战斗";
		this.m.TooltipText = "进入南方城邦的竞技场并赢得5场战斗。";
		this.m.SuccessText = "[img]gfx/ui/events/event_22.png[/img]杀死了各种有两条腿或更多条腿，或者可能根本没腿的生物之后，你已经为你的角斗能力赢得了相当多的声望。 南方人说起你的名字，就好像它会带来好消息一样，他们间接地享受了你的胜利，并希望看到你赢得更多比赛。 这是一种奇怪的命运，因为大多数人去竞技场是为了看角斗士们死去并且越可怕越好。 因此让大众为你欢呼虽然奇怪但毕竟是实现了，尽管你意识到你只是站在聚光灯下，但你的出现使得座无虚席，同时看客们仍然在寻找你的对手死去的凄惨景象。 说实话，你完全可以满足观众的嗜血欲望，你对得起你的硬币。";
		this.m.SuccessButtonText = "我还听到他们在喊我们的名字！";
	}

	function getUIText()
	{
		local d = 5 - (this.m.ArenaMatchesToWin - this.World.Statistics.getFlags().getAsInt("ArenaFightsWon"));
		return this.m.UIText + " (" + this.Math.min(5, d) + "/5)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 1 && this.World.Assets.getOrigin().getID() != "scenario.gladiators")
		{
			return;
		}

		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") > 10)
		{
			return;
		}

		this.m.ArenaMatchesToWin = this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") + 5;
		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Statistics.getFlags().getAsInt("ArenaFightsWon") >= this.m.ArenaMatchesToWin)
		{
			return true;
		}

		return false;
	}

	function onSerialize( _out )
	{
		this.ambition.onSerialize(_out);
		_out.writeU16(this.m.ArenaMatchesToWin);
	}

	function onDeserialize( _in )
	{
		this.ambition.onDeserialize(_in);

		if (_in.getMetaData().getVersion() >= 55)
		{
			this.m.ArenaMatchesToWin = _in.readU16();
		}
	}

});

