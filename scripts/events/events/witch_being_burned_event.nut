this.witch_being_burned_event <- this.inherit("scripts/events/event", {
	m = {
		Witchhunter = null,
		Townname = null
	},
	function create()
	{
		this.m.ID = "event.witch_being_burned";
		this.m.Title = "在 %townname%";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_79.png[/img]{你漫步到 %townname% 那里，正好看见一具焦黑的尸体，尸体从黑木桩上微微前倾。 几个市民从你身边经过，正为一个女巫的死欢呼。 女巫猎人，%witchhunter%，好奇这是否是真的，她上去检查它的身体。 叹了口气，回头看着你，摇了摇头。 | %townname% 的人们用可怕的尖叫声欢迎你。 三名市民在市中心被活活烧死。 火在他们的附近地面蔓延，直到火焰来舔他们的脚，然后爬上他们的腿，他们大声呼喊救命希望人们怜悯，人们却用投掷石块来回应。\n\n当你打算是否拔出你的剑来结束这种不公正时，女巫猎人 %witchhunter_short% 拉住了你的手。 他摇摇头，指着燃烧的人。 很快乞求声停止了，三个受害者张大嘴巴，发出轰隆隆的声音，人群安静下来，火光倒映在人们脸上。 他们用喉音统一的声音说话。%SPEECH_ON%你们这些看着我们灭亡的人，将自我毁灭%SPEECH_OFF%说话的人的身体突然往前倒，好像一下子就死了，烤肉的声音滋滋滋的响着，不断变小。 女巫猎人命令你的人把目光移开，你很快就会看到，在你身后又有新的尖叫声，但这次是镇上的人自己发出的。 你很快就会忘记这一刻的。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是什么…？",
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

		local towns = this.World.EntityManager.getSettlements();
		local playerTile = this.World.State.getPlayer().getTile();
		local foundTown = false;

		foreach( t in towns )
		{
			if (t.isMilitary() || t.isSouthern() || t.getSize() > 2)
			{
				continue;
			}

			if (t.getTile().getDistanceTo(playerTile) <= 3 && t.isAlliedWithPlayer())
			{
				foundTown = true;
				this.m.Townname = t.getNameOnly();
				break;
			}
		}

		if (!foundTown)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local witchhunter_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.witchhunter")
			{
				witchhunter_candidates.push(bro);
			}
		}

		if (witchhunter_candidates.len() == 0)
		{
			return;
		}

		this.m.Witchhunter = witchhunter_candidates[this.Math.rand(0, witchhunter_candidates.len() - 1)];
		this.m.Score = 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"witchhunter",
			this.m.Witchhunter.getName()
		]);
		_vars.push([
			"witchhunter_short",
			this.m.Witchhunter.getNameOnly()
		]);
		_vars.push([
			"townname",
			this.m.Townname
		]);
	}

	function onClear()
	{
		this.m.Witchhunter = null;
		this.m.Townname = "";
	}

});

