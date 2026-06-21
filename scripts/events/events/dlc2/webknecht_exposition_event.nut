this.webknecht_exposition_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.webknecht_exposition";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你在路边发现了一个身旁用研钵和研钉搅拌树叶的男子。他自己也在咀嚼着一些货物，并用绿色的笑容向你望来。%SPEECH_ON%我一直与虫子和昆虫打交到，但是那些织网蛛完全不同。我从来没有见过如此快的虫子。剪切和滑动着，抓起狗和猫之类的东西，让它们远离。你们避开这些该死的蜘蛛，明白吗？%SPEECH_OFF%这个陌生人吐了一口痰，然后继续他的工作，仿佛你从未经过。 | 一位站在农舍门口的妇女用一系列点头看着你的战团。手中拿着一个杯子，她指着你，嘴里含糊不清。%SPEECH_ON%啊，蜘蛛食品来了啊？嗯？那么赶快走，这八腿的混蛋们不喜欢等待和观望，他们会很快找到你们，而且他们总是饥饿的，没错，总是口吐白沫带着他们的毒液，没错没错。%SPEECH_OFF%她喝了一口酒，然后重重地摔回家门口。 | 你发现一个年轻人在白杨树上。他设法构建了一个尺寸和形状与茅房相同的小屋子。他向你俯身看去。%SPEECH_ON%是啊，你对我和这棵树感到难以置信，但是让我告诉你，那些织网蛛非常快。狗一样大小的蜘蛛！你知道我怎么说吗？他们全他娘的都得死。以后你可以在这些树上找到我，如果这些该死的野兽长出翅膀，我就自己离开，非常感谢。%SPEECH_OFF%织网蛛似乎正在折磨当地人，但你无法真正责怪他们。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "有人应该付钱让我们照顾他们。",
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
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
	}

});

