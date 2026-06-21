this.player_is_sent_for_event <- this.inherit("scripts/events/event", {
	m = {
		Town = null
	},
	function create()
	{
		this.m.ID = "event.player_is_sent_for";
		this.m.Title = "在路上…";
		this.m.Cooldown = 40.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_92.png[/img]{你的战队似乎在路上引起了一位信使的注意。%SPEECH_ON%{先生们，在 %settlement%，去往 %direction%，那急需帮助，现在正在寻找所有能胜任的人，尤其是那些佣兵队伍，来帮助他们。 | 喔，%companyname%，你们就是我在找的人。在 %settlement%，去往 %direction%，那需要解决一个麻烦。 如果你正在找活干，我敢打赌你应该走这条路。 请务必告诉他们是我给你们指的路，这样我还能再多获得几枚克朗。 | 嘿，佣兵先生们，在 %settlement%，去往 %direction%，那需要你们的服务。 如果你们在找活干的话，我建议你们往那条路走。 | 在找活干吗？看你们你们行军的速度并不像是已经找到活干了，那我告诉你们在 %settlement% 这里的 %direction%，那绝对有适合你们的工作。 | 额，一个没有事干的雇佣兵？你真是太倒霉了。 好吧，离这里不太远的 %settlement% 有些可以给你们干的活。 我建议你们去看看。 | 我是来告诉你们 %settlement% 正在找工人。 不是干粗活的，注意。我跟你说话是有原因的。 带上你的剑和杀手跟我走，如果你想挣些硬币的话。 | 嘿，这边，你应该知道知道，%settlement% 正在找你们这样的人。 赶快去那儿，没准你们就能找到一份新工作。 | 你们在找活干？ 那快点去 %settlement%，去往 %direction%，所有人都知道他们正在找你们这样的人。}%SPEECH_OFF%向信使道了声谢，你拿出了地图，思考着这一趟旅行是否值得。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你说有报酬的工作？",
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

		if (this.Const.DLC.Desert && currentTile.SquareCoords.Y <= this.World.getMapSize().Y * 0.2)
		{
			return;
		}

		if (this.World.Contracts.getActiveContract() != null)
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();
		local nearestTown;
		local nearestDist = 9000;

		foreach( t in towns )
		{
			if (t.isSouthern())
			{
				continue;
			}

			local d = t.getTile().getDistanceTo(currentTile) + this.Math.rand(0, 10);

			if (d < nearestDist && t.isAlliedWithPlayer() && this.World.FactionManager.getFaction(t.getFaction()).getContracts().len() != 0)
			{
				nearestTown = t;
				nearestDist = d;
			}
		}

		if (nearestTown == null)
		{
			return;
		}

		this.m.Town = nearestTown;

		if (this.World.getTime().Days <= 10)
		{
			this.m.Score = 30;
		}
		else
		{
			this.m.Score = 10;
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"settlement",
			this.m.Town.getName()
		]);
		_vars.push([
			"direction",
			this.Const.Strings.Direction8[this.World.State.getPlayer().getTile().getDirection8To(this.m.Town.getTile())]
		]);
	}

	function onClear()
	{
		this.m.Town = null;
	}

});

