this.wildman_offers_mushrooms_event <- this.inherit("scripts/events/event", {
	m = {
		Wildman = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.wildman_offers_mushrooms";
		this.m.Title = "在途中…";
		this.m.Cooldown = 100.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_25.png[/img]你在一棵大树底下乘凉。 不知何故，一束阳光从树顶穿透重重树叶缝隙照耀到你的眼睛。 你遇到了野人 %wildman% 站起来活动了下身子。 他拿了一把各种各样的东西：蘑菇、花瓣、浆果。 放到你面前问你要不要。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "当然，%wildman%，我要一些。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "呃，不要谢谢。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Wildman.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_25.png[/img]令人惊讶的是，这些森林食物实际上相当不错。 甜，但不太甜，并带有一丝橡木的味道。 你要感谢野人的礼物。 他把双手高高举起，摇晃着你早先错误地认为是人类出于人道目的的武器的现在的树枝。 他和你开口说话时，许多彩虹猫猫从他嘴里欢跳而出。 他的舌头吐出一串晦涩难懂的古老词汇，在他的嘴边…嘴边…嘴边飘动着。拖出一声长长的叹息。 你对他的这些把戏很满意。于是向他挥一挥手，但发现你的每根手指也是一只手，你竟然以前从来都没发现。 你的信仰受到了巨大的的冲击，你童年的记忆充斥着飞逝的脚步，摇曳着你的婴儿床，你的领地，你的城堡。 都是假的。所有的一切！黑暗降临了。深渊在微笑。\n\n你醒了躺在地上，%otherguy% 轻轻地用一块湿毛巾擦着你的额头。%SPEECH_ON%他回来了！ You alright?%SPEECH_OFF%你不太记得发生了什么事，但你的理智却在拼命地告诉你不要问。 你只是点头回应，然后带着你的人继续前进。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "今天，我学到了一些东西。",
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
		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_wildman = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.wildman")
			{
				candidates_wildman.push(bro);
			}
			else
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_wildman.len() == 0)
		{
			return;
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Wildman = candidates_wildman[this.Math.rand(0, candidates_wildman.len() - 1)];
		this.m.OtherGuy = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = candidates_wildman.len() * 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"wildman",
			this.m.Wildman.getNameOnly()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Wildman = null;
		this.m.OtherGuy = null;
	}

});

