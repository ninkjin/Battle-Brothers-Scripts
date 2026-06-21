this.ancient_statue_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.location.ancient_statue";
		this.m.Title = "当你接近时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.IsSpecial = true;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_116.png[/img]{一座城堡大小的金人静静地坐在他的石头王座上，如此威严，甚至他这个静物似乎应该统治着这片土地。也许这世界会变得更好，这个非言语实体具有如此惊人的存在感，会成为比你们不断遇到的臭鼬更好的统治者。雕像的大部分坐落在一个由螺旋方形石块制成的巨大圆盘上。如果它们是棺材的话，把%companyname%完全存储起来只需要两块砖头。%randombrother%抬起头盔。%SPEECH_ON%如果这不是我见过的最大的东西，我就不知道是什么了。%SPEECH_OFF%%randombrother2%冷笑并伸手去抓住雇佣兵的裤裆。%SPEECH_ON%我还以为女人们说那个小虫子是有史以来最大的东西呢！%SPEECH_OFF%当众人大笑时，你走前一步仰望着这座金质亮闪闪的雕像。你不太喜欢跪拜，但这里你有这种冲动。雕像正以坚定的权威注视着这个世界，双手分别放在两侧，一只手插在钉入地面的剑上，另一只手摊开，仿佛在衡量着公正。你对着金色的光辉点点头。这里甚至没有一个假冒者刻意刮擦，这表明它庄重的存在仍然对这个世界有着某种虚幻的掌控力。但这是没有道理的。任何聪明人都会从雕像的小腿上偷走一部分黄金。一些雇佣兵问能不能尝试着收集一些金子给自己。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这并没有什么害处。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_116.png[/img]{这座雕像太巨大了，或许仅凭迷信就让那些小鬼畏缩了。你没有理由放弃这么好的东西，像一个几乎没有尽头的金子堆成的“漂亮”的东西。与历史和艺术为敌。你让士兵们去拿。他们拿起手头的工具迅速开始工作，但当%randombrother%第一次接触后，他变得软弱无力，倚在雕像上。另一名雇佣兵去帮他，碰触到那巨大的脚趾，也倒在了雕像上。就在军营开始惊慌失措时，这两名雇佣兵重新站起来，开始尖叫着谈论惊人的景象——未来世界的奇观！\n\n受到这种激励，战团高高兴兴地撞向雕像，他们撞在巨大脚趾上，像哑剧演员突然撞到真正的墙一样倒下。这是你见过的最荒谬的事情了，但每个人都会重新站起来，讲述出极好听的故事。你耸耸肩，走到雕像前，站在它的大脚趾和大脚趾甲前。士兵们敦促你往前走。你叹了口气，伸出手去触摸脚趾甲。什么也没有发生。你伸手掏出钱包。两只手恨恨地按在脚趾上，就像欠你钱似的。什么也没有。那好吧。看来你的财富可以得到了。你抽出剑...}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "到了淘金的时候啦。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_116.png[/img]{你挥剑，但第二刀刚刚碰到黄金，世界的光辉就像太阳一样闪烁在你身上，你流了血。剑在黑暗中继续向前，就像夜空中的一颗星，它在现实中开辟了一个全新的世界，就像你割开了魔术师的布片，露出了一个庄严的房间，靠角落的柱子旁有着华美的丝绸窗帘。剑继续向前，直到猛然撞上一杆长矛。你低头看到一个身穿镀金盔甲和红色眼睛的男人紧抿嘴唇，举起了长矛。他往右边滑过瓷砖地面，利用你的惯性倒地，然后转身，把矛扔向前方。你将胳膊伸开，与杀手并排站立，抓住长矛杆子，在腋下处刺中他的肩铠，将剑刺入他的心脏。这个男子的红色眼睛变成了纯白色，他失去了意识，从剑上滑落下来。\n\n他落地的一瞬间，你迅速环顾四周。远墙上有一张巨大的床，角落用大理石做成，每个雕像都是一个男人或女人的形象，他们都顶着看起来像日出的光芒，穿着奴性的服装。床上有一位胡子蓄得密密麻麻，双眼黯淡疲惫的老人，他看着你，眼神很熟悉。他微笑了一下，但很快就消失了。他喊了一声，但你听不懂他说的话。一个影子从房间的另一侧滑过来，你转身看到一个带着火热目光的巨大骑士，手持一把双手剑冲了过来。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "格挡！",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_116.png[/img]{你后退，将剑十字形翻转，蹲下膝盖以抵挡冲击。杀手的巨剑猛击你的剑，世界轰然崩塌，你仍冻结在挡刀的动作中，感觉到时间和空间的流逝，听到无尽的苦难、尖叫、生死交织。在极远的距离，有一点光亮急速靠近，直到你回到体内，剑撞击雕像，反弹力度之大，使其脱手飞出，最终刺在地面上。男人们相互看着，你走过去取回了自己的剑。%SPEECH_ON%我想您弄坏剑了，先生。%SPEECH_OFF%说道%randombrother%，并亲手搓揉他的小脚趾。你告诉他和其他人收拾行装，是时候离开这个地方了。看着雕像，你发现它现在全部生锈的古铜色。你想问其中一名雇佣兵它之前是否是金色的，但你已经知道答案。相反，你注视着雕像的头部，脸上，这张非常熟悉的脸庞。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "让我们不要沉溺于此。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					bro.improveMood(1.5, "一座宏伟的老雕像给人留下了深刻的印象");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
	}

});

