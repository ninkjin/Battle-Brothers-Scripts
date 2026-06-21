this.taxidermist_ambition <- this.inherit("scripts/ambitions/ambition", {
	m = {},
	function create()
	{
		this.ambition.create();
		this.m.ID = "ambition.taxidermist";
		this.m.Duration = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.ButtonText = "没什么能比冻土野兽的战利品更让人尊敬。让我们去狩猎一些然后请剥制师干点活！";
		this.m.UIText = "在剥制师那里制作物品";
		this.m.TooltipText = "拥有至少12件剥制成品。剥制师主要分布在被沼泽和森林覆盖的定居点，他们能把野兽掉落的东西制成有用的物品，比如恐狼的大的不同寻常的狼皮。";
		this.m.SuccessText = "[img]gfx/ui/events/event_97.png[/img]一个年轻男孩招呼你，问你是不是%companyname%的队长。你环顾四周，问他这对他来说意味着什么。他耸了耸肩。%SPEECH_ON%啊，我没有任何意思，长官。如果我找到并找来他，我会得到三枚金币的报酬。这就是全部了。%SPEECH_OFF%你感到好奇，问谁准备支付这笔奖金。男孩在挖鼻子，抬头看着你。%SPEECH_ON%啥？啊，我还没有见过那些金币！得先找到那个人！%SPEECH_OFF%你叹了口气，把男孩的手掰开，鼻涕和其他东西都沾着，再次问他。男孩皱起眉头思考着，在地上看着蚯蚓。%SPEECH_ON%是税务员。不是拿金币的那种。他不会付给我一枚硬币。那个人就是个长手指的恶魔，我爸爸这样说。我的意思是野生动物税务员。他剥下兽皮，做成很厉害的衣服、毯子、毒药、饮料。它们都互相交流。他们说%companyname%的工作是全国最棒的生意，他们都迫不及待地想再见到他们！%SPEECH_OFF%啊，他在说制作标本的人。微笑着，你拍了拍男孩的头，祝他好运。他咕哝着，吐了口痰。%SPEECH_ON%好运并不是一切，我打算用聪明才智找到那个人。保持着警觉，听觉灵敏，紧绷我的裤子。%SPEECH_OFF%";
		this.m.SuccessButtonText = "%companyname% 自豪地展示他们的战利品。";
	}

	function getUIText()
	{
		return this.m.UIText + " (" + this.Math.min(12, this.World.Statistics.getFlags().get("ItemsCrafted")) + "/12)";
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.Ambitions.getAmbition("ambition.make_nobles_aware").isDone())
		{
			return;
		}

		if (this.World.Statistics.getFlags().get("ItemsCrafted") >= 12)
		{
			this.m.IsDone = true;
			return;
		}

		this.m.Score = 1 + this.Math.rand(0, 5);
	}

	function onCheckSuccess()
	{
		return this.World.Statistics.getFlags().get("ItemsCrafted") >= 12;
	}

	function onPrepareVariables( _vars )
	{
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

