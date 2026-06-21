this.schrat_exposition_event <- this.inherit("scripts/events/event", {
	m = {},
	function create()
	{
		this.m.ID = "event.schrat_exposition";
		this.m.Title = "在路上…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{你在路上遇到了一个年轻的旅行者。他的草帽里外颠倒，好像是为了接雨水。他手里拿着一根行走在泥泞的路上的手杖，杖头被削成了球形。当你走近时，他挺直身子，手抱在手杖顶端。%SPEECH_ON%哦，你们是雇佣兵吧？要是我就避开森林。他们说树现在在那些地方漫游着。它们没有恶意，但妈妈熊在吃掉你的蛋蛋之前也不会有敌意。这是自然规律，你懂的吗？%SPEECH_OFF% 哦，好的。 | 在路边，有个人正在阅读一些书卷。他抬头，翻动了其中的一页，展示出一幅树的图画，有着长长的枝叶延伸到地面，树干上还有着眼睛和光芒。%SPEECH_ON%他们叫它们Schrats。树会抓住并杀死任何靠近的东西，但我觉得那不太正确。它们不是动物，我认为它们是具有报复心态的精明的、聪明的怪物。所以不要去闯入它们的领域，明白吗？远离森林。%SPEECH_OFF%你当然不想闲扯，祝福那个人的研究，并迅速离开了。 | 一个扛着篮子的老妇人和你的队伍穿过了路口。她朝着货物做了个手势，那是一堆劈好的柴火。%SPEECH_ON%如果你想要一些柴火，最好不要去我取它的地方。%SPEECH_OFF%你问她是什么意思。她狡黠地笑了笑。%SPEECH_ON%森林里有一个Schrats在看着我，给了我合适的许可证让我用这里的柴火取暖。它并没有给我叔叔许可。它撕开了我叔叔的身体然后挂起了他的肉。也许是装饰作用，你懂的吗？%SPEECH_OFF% 噢，当然。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不应该轻视像这样的敌人。",
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

		if (currentTile.Type == this.Const.World.TerrainType.Desert || currentTile.Type == this.Const.World.TerrainType.Oasis || currentTile.TacticalType == this.Const.World.TerrainTacticalType.DesertHills)
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

