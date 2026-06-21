this.raiders_intro_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.raiders_scenario_intro";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_94.png[/img]{在你和你的战团杀掉了一半的村民之后他们终于投降了。随着一面白旗升起，他们要求阵前谈判，你很乐意答应他们。村民们排成一列走向他们之前举行节日庆典的城镇广场。他们把手中的珠宝财富堆在你的脚边，而你正踩在他们市长被砸烂的脑壳上。你的先锋%raider1%，%raider2%，%raider3%还有%raider4%小心的盯着这场仪式，就仿佛秃鹫盯着缓缓死去之人。\n\n队伍中最后一个人是个僧侣。他没带金银财宝并且反而开始对你说话，他的行为立刻让你手下的掠夺者们掏出了武器。你允许了他发言，随后他开始长篇大论旧神们的事情，以及天堂的财富如何远远的超越了凡间所能提供的一切。你告诉他灵巧的嘴巴只会造就他的死亡。胜率抿了抿嘴唇说到。%SPEECH_ON%好吧，如果你想金钱，那就赶紧放弃这愚蠢的游戏。这种烧杀掳掠根本比不上南方财富的哪怕一点点。贵族们肯定不会让你加入他们的军队，但他们总是会需要雇佣兵，并且没有闲暇去分辨他们雇佣的战士从何而来。你将会得到你梦寐以求的克朗。去南方吧，掠夺者，去升华为佣兵吧。%SPEECH_OFF%%raider3%想要把这僧侣的脑袋砍了，但你阻止了处决。相反，你听信了这个狡猾僧侣的话。你早就听说过南方的财富，以及佣兵们的旅途故事。你去南方探险，前提是这名僧侣跟你一起走。%raider3%表示抗议，但你不听。如果这个僧侣是你开始新生活的幸运护符的话，将他留下会是对旧神们的侮辱。这名掠夺者大步离开，但是%raider1%，%raider2%和%raider4%对于跟随你没有任何异议。战团里的其他人返回了北方并且分掉了掠夺来的财富。留下破败的村庄去恢复，重建，然后等着被更强的部落夺取新产生的财富。}",
			Image = "",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会向南方前进。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Banner = "ui/banners/" + this.World.Assets.getBanner() + "s.png";
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepare()
	{
		this.m.Title = "北方掠夺者";
	}

	function onPrepareVariables( _vars )
	{
		local brothers = this.World.getPlayerRoster().getAll();
		_vars.push([
			"raider1",
			brothers[0].getName()
		]);
		_vars.push([
			"raider2",
			brothers[1].getName()
		]);
		_vars.push([
			"raider3",
			this.Const.Strings.BarbarianNames[this.Math.rand(0, this.Const.Strings.BarbarianNames.len() - 1)]
		]);
		_vars.push([
			"raider4",
			brothers[2].getName()
		]);
	}

	function onClear()
	{
	}

});

