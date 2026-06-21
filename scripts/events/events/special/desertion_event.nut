this.desertion_event <- this.inherit("scripts/events/event", {
	m = {
		Deserter = null,
		Other = null
	},
	function setDeserter( _d )
	{
		this.m.Deserter = _d;
		this.m.Other = null;
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() > 1)
		{
			do
			{
				this.m.Other = brothers[this.Math.rand(0, brothers.len() - 1)];
			}
			while (this.m.Other == null || this.m.Other.getID() == this.m.Deserter.getID());
		}
		else
		{
			this.m.Other = this.m.Deserter;
		}
	}

	function create()
	{
		this.m.ID = "event.desertion";
		this.m.Title = "在途中…";
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%desertedbrother% 已经抛弃了 %companyname%。当白天似乎没有尽头，道路似乎更长时，人的另一种品质就会受到挑战。 你已经发现，即使是那些在战斗中无所畏惧的人，有时也没有足够的毅力来忍受雇佣兵生活的艰辛。 还有一些人既胆小又懒惰。 我只能希望你在找到他们之前不要浪费太多的硬币。\n\n%otherbrother% 走近你。%SPEECH_ON%对于 %desertedbrother% 我一点都不介意，先生。 我本来就不喜欢他的样子。 没有 %companyname% 照顾他，我敢打赌两周后他就会被绞死。%SPEECH_OFF% | 发牢骚在雇佣兵中是一种由来已久的传统，在一般人当中也是如此，但你很快就厌倦了 %desertedbrother%的抱怨。\n\n如果口粮变质了，啤酒太苦了，或者肉太硬了，他总是第一个让你知道的，而且一遍又一遍地告诉你。 对于脚疼、天气不好、盾牌易碎、盔甲擦伤、商队走得太慢、商队走得太快、刀刃钝了、第一次值勤、面包发霉、工资低、感到无聊，以及夜莺在天黑后让他无法入睡，他也会说。 这还不是他所有的抱怨，但你现在能回忆起的就只有这些了。\n\n%desertedbrother%的抱怨是雇佣兵部队旅行的家常便饭，而且几乎是不可避免的。 所以当你发现 %desertedbrother% 已经离开去过一种不这么麻烦的生活时你并没有感到惊讶。 | %desertedbrother% 已经有好几天没有一心扑向死亡，粉碎他面前的敌人了。 今天在营地附近找不到他，别人告诉你他去找柴火了。 由于捡柴火通常不需要12个小时，看来 %desertedbrother% 终于决定把他的不满带到路上，到别处碰碰运气了。 你怀疑能不能再见到他。 | 在你们最近的旅行当中战队遭遇了一系列的不幸。 这对 %desertedbrother% 的打击比其他人的都大。 他现在睡得很晚，开始打架，表现得不听话。 也就是说，当你能找到他的任何时候。 这一切都不讨你或者他的战友们的欢心，而当 %otherbrother% 把 %desertedbrother%的铺盖扔进团里用来上厕所的浅沟的时候事情就更糟糕了。\n\n让人们发泄他们的不满通常是最好的办法，既然战队最近一直运气不好，你也就宽容了。 今天早上你发现他走了，这并不奇怪。%desertedbrother% 已经离开了 %companyname%。 | 当你得知 %desertedbrother% 似乎在夜里失踪时，你感到很不安。 在询问了其他人并确定他不是简单地走到附近的一块大石头后面去方便之后，你发起了一场搜查。 你和兄弟们以为 %desertedbrother% 可能是被叛国者绑架，被绑架者勒索，或是与某个野兽作对，就花了几个小时搜索这个地区，呼喊着他的名字。\n\n这时 %otherbrother% 终于表示 %desertedbrother% 根本就没失踪，而是已经抛弃了你们所有人离开了。%SPEECH_ON%他最近一直在抱怨战队的事，但我想他是瞒着你说的，先生，这样他就有机会偷偷溜走了。%SPEECH_OFF%你抑制住了想给坏消息传递者一记耳光的冲动，问他为什么不早点说出来，但他没有回答。 | 你从来没有想过 %desertedbrother% 是会叛逃的人，但是当黎明来临的时候，他却不见了，你意识到你太天真了。 每一次行军他都落在后面越来越远的地方，每次你命令他出发他总是最后一个收拾好装备才走。 他的装备也开始显得破烂不堪。 尽管他把自己的想法藏在心里，但回想起来，他那副酸楚的表情和对战友们的漠不关心，显然表明他对战队最近的发展方向并不满意。\n\n你开始试探其他人，发现不满情绪在普遍上升。 让这些人像野兽一样吃好、喝好，确保他们按时得到报酬，希望 %desertedbrother% 会是在夜里最后一个逃跑的人。 | 你不知道是因为工资低，差点残疾的危机还是在冰冷的雨中被迫行军或者人们粗鄙的语言和粗劣难以入口食物，他战友们的虐待，孩子们冲他扔的石头，凌冽的寒风，还是一个又一个不眠之夜，但 %desertedbrother% 在最后这段时间变得越来越不快乐，直到他明显地完全放弃了雇佣兵生涯。%SPEECH_ON%我不知道他有什么可抱怨的。 我觉得一切都很正常。%SPEECH_OFF%%otherbrother% 听到这件事情后说。%desertedbrother% 选择了其他道路，而不是 %companyname%。至少他很有礼貌的当面告诉你他决定离开－尽管，考虑到这一点，也许只是为了当面收回他剩余的工资。 | 最近，%desertedbrother% 开始在白天的工作结束后的晚上散步。 虽然他独自游荡的习惯并不十分安全，但你想不出任何理由在营地不需要他的时候阻止他。 然而，战队面临的困难越多，他们走的路就越长，直到有一天早上 %desertedbrother% 再也没有回来。\n\n%desertedbrother% 已离开 %companyname%。这可能是最好的结果吧。 | %desertedbrother% 最近特别喜怒无常，他把所有的空闲时间都花在摆弄一把旧的飞刀上，一把状况很差的刀，它更像是一块废铁，而不是一件合适的武器。 前一天晚上，他把它扔向一棵枯树的树干上，每次起身时都唉声叹气着把它捡起来，然后走回几码远的地方蹲下来，再把它扔回去，一直扔到深夜。\n\n显然，他对战队最近遇到的挫折很不高兴，今天早上，他鼓足勇气走进你的帐篷，向你解释说，他将离开战队到别处去寻找他的财富。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "{很难强迫他留在战队… | 确实是个坏消息。 | 一时的挫折。 | 我不能让这样的事情再次发生。}",
					function getResult( _event )
					{
						if (this.World.Assets.getEconomicDifficulty() != this.Const.Difficulty.Hard)
						{
							_event.m.Deserter.getItems().transferToStash(this.World.Assets.getStash());
						}

						_event.m.Deserter.getSkills().onDeath(this.Const.FatalityType.None);
						this.World.getPlayerRoster().remove(_event.m.Deserter);
						_event.m.Deserter = null;
						_event.m.Other = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Deserter.getImagePath());
				this.List.push({
					id = 13,
					icon = "ui/icons/kills.png",
					text = _event.m.Deserter.getName() + "离开了" + this.World.Assets.getName()
				});
				this.updateAchievement("Deserter", 1, 1);
			}

		});
	}

	function onUpdateScore()
	{
		return;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"desertedbrother",
			this.m.Deserter.getName()
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Deserter = null;
	}

});

