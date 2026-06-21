this.dead_bodies_on_road_event <- this.inherit("scripts/events/event", {
	m = {
		Hunter = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.dead_bodies_on_road";
		this.m.Title = "在路上…";
		this.m.Cooldown = 21.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_02.png[/img] {一辆载重货车，翻倒了。 它旁边有几匹死马。 一头死驴，有打斗的迹象。 女人们。孩子们。几个老人。 大部分都残肢断臂，对于发现他们的人来说是一场恶心的视觉盛宴，你确信你的战队是最优秀的，能够应付这种恶心的场面。 你让你的胃忍住不吐，因为你让它变糟了。 这些无辜的死者肠穿肚烂，然而，在无力纠正这种道德疾病的情况下，你只能继续埋葬这些死者。 遗憾的是，在他们的遗体中没有发现任何有价值的东西。 | 路边的水沟里有血。 路上到处都是血。 路另一边的水沟里也有血。 鲜血染红了载重货车的帆布。 死者眼睛和嘴里都是血。 一个可怜的农夫，死了，似乎还被一群贼洗劫了，因为这具被你偶然发现的遗骸没剩下任何有价值的东西了。 | 鸟群是第一个暗示：见到或遇到一个遥远的灾难。 你以为他们看到的东西还活着，但当你走到那儿的时候，鸟群已经降落了，你无意中发现一个靠在石头上的死人。\n\n你试着把鸟吓跑。 这些黑秃鹫们只会朝着相反的方向跳几步，然后就会转向盯着你看。 尸体是新鲜的，死亡的方式是缓慢的：几支箭从他的侧面扎出来。 他屁股上的绳子表明他有个钱包。 有人抢劫了他－不止两次。 | 你偶然发现一些被绞死的罪犯。 他们在路边的一棵树上荡来荡去，他们的脸在头上的羊毛布袋下仅仅显出轮廓。 他们中的一些人显现出受折磨的迹象：到处都是伤痕，强壮的肌肉变成了紫色，有些已经是灰色了。 脚底下有血，表明他窒息时有人对他动过手脚。 当然，他们没有任何价值，所以你又回到了路上。 | 一只带着铃铛的山羊被一个死去的牧羊人抱着。 你在路边找到了他们。 动物的喉咙是割开的，人的身体没有伤口。 也许牧羊人死于心脏病。%randombrother% 开始搜死者的口袋，空手而归。 你决定把它们的尸体留在原地。 | 两只秃鹰撕扯着一段肠子，慢慢地咀嚼着，直到它们的喙咔嗒咔嗒地碰到一起。 你被这顿饭的来历惊呆了：一个死去的孩子，他或她脸朝下躺在地上。 他的背部被撕裂了，一个可怕的胸腔在阳光下闪闪发光。\n\n你吓跑了那些鸟－尽管它们很不愿意被吓到－然后把尸体埋起来。 回到路上，你看到两只鸟儿蹲在坟墓上，{ 焦虑地在泥土中啄来啄去 | 在泥土中啄来啄去就像是想把坟墓挖出来一样}。 放弃后，它们最终会飞走，在你的队伍上空盘旋一两英里，然后飞向别处。 | 篝火噼噼啪啪地燃烧着，吞噬着一辆载重货车。%randombrother% 在一片漆黑的废墟中搜寻，却空手而归。 你可以看到有几只手从灰烬和煤烟中伸出来，它们的外表也一样黑。 尸体完全不见了，被埋了，被烧了，或者被烧完后埋了。 看到没有任何东西可以挽救，你很快让战队回到路上。 | 一匹死马。它的骑手穿过了大路，爬到了他最后的休息地点。 破碎的箭散布在小径上，它们的头被扯下来捡走了。 这名男子的头皮不见了，他的头顶反射着光。 在快速搜索之后，你意识到这里没有什么可以带走的，于是决定继续前进。 | 你在路边看到一堆裸体。 有些人看起来很可怕，好像他们已经死了很久了，虽然有些人嘴里还流着新鲜的血。 一些尸体身上被涂了颜色，但它们到处都有咬痕。 似乎是被采取了先发制人的措施，因为每个人的脖子都被割过。 他们一丝不挂，你自然只会发现它们原有的东西。你继续前进。 | 你觉得自己好像被人盯着，然后停了下来，迅速转向路边，一只手按在剑上。 一个人头盯着你，它的眼睛几乎没有从草上探出来。%randombrother% 走过去把它捡起来。 这张脸长的口眼歪斜，带着一种相当不和谐的死亡表情。 你告诉佣兵放下这个头，因为你有重要的事情要做。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "安息吧。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local myTile = this.World.State.getPlayer().getTile();

		foreach( s in this.World.EntityManager.getSettlements() )
		{
			if (s.getTile().getDistanceTo(myTile) <= 6)
			{
				return;
			}
		}

		this.m.Score = 10;
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

