this.defeat_kraken_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.defeat_kraken";
		this.m.Duration = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "有传言说沼泽地里潜伏着一只巨大的野兽。\n如果我们找到并杀死它，无上的荣誉将属于我们！";
		this.m.UIText = "击败克拉肯";
		this.m.TooltipText = "在战斗中击败一只克拉肯。你能在野外的某个地方找到它。";
		this.m.SuccessText = "[img]gfx/ui/events/event_89.png[/img]它存在于你的梦中，一个湿滑的球状脑袋，上面装点着睡莲和藤蔓，它的呼吸就像锅里的肉汤沸腾一样将沼泽掀开。它的触须在光暗之间扭动，仿佛影子投射在影子之上。所以它就在这个深远幽暗的虚空之中，它已经在此留下了烙印，并变幻为一种静态的恐惧。在它出现在你的梦中时，实际是你走向了它。你进入黑暗向前伸出手来，但这就是你所做的一切。你永远没有真正靠近。有的时候你的梦是关于别的，但你知道那个野兽就在某个地方，只需要打开一扇门或走下几级台阶，你就会再次找到它和它的领地。无需与你的人交谈，你就可以知道他们也会梦到它。\n\n全世界都开始知道你杀掉了克拉肯，但他们将其视为小道传言。他们认为这是一个母亲督促孩子睡觉的故事，或者一个父亲为了鼓励亲族而讲的人类战胜恐惧的故事。但他们没看到现场。他们看到了传闻，而不是怪兽，他们将%companyname%视为活着的传说。就跟传说一样，每天战团里的人都会从这传奇故事中消失，由真正的英雄取代。大地的每一个角落都在塑造一个更加光彩耀人的击败了克拉肯的胜利者。他们说，一个普通的雇佣兵才不敢去挑战这样的野兽！是东方的骑士！是北方的国王护卫！虚荣取代了你的位置。但是与你并肩作战的兄弟们知道真相，即使是垂死的真相也足以继续下去。\n\n所以就让他呆在黑暗中吧，你也经常去拜访它。";
		this.m.SuccessButtonText = "还有其它哪位猎人能完成如此壮举？";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().Days <= 100)
		{
			return;
		}

		if (this.World.Ambitions.getDone() < 20)
		{
			return;
		}

		if (this.World.Flags.get("IsKrakenDefeated"))
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		if (this.World.Flags.get("IsKrakenDefeated"))
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

