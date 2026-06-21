this.hunt_food_event <- this.inherit("scripts/events/event", {
	m = {
		Hunter = null,
		OtherGuy = null
	},
	function create()
	{
		this.m.ID = "event.hunt_food";
		this.m.Title = "在途中…";
		this.m.Cooldown = 7.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_10.png[/img]{在你的帮助下 %otherguy% 把靴子从泥浆里抽了出来，%hunter% 找到了那个挂着大约十二只兔子的灌木丛。 依次取下来，他开始把它们放在一起。 那些小兔子－瞳孔放大，神色恐慌－看起来是那么的美味。 猎人拎起一只，抓住脖子，咔得一声扭了一圈，快速地开膛破肚，清理内脏。 他重复着这个步骤，直到把所有兔子都处理干净。 接着，他在 %otherguy%的斗篷上擦了擦手，指了指地上那一堆已经处理好的兔子。%SPEECH_ON%有一堆是吃的。%SPEECH_OFF%然后他指着那堆兔子内脏。%SPEECH_ON%这一堆还不能吃，明白没？好的。%SPEECH_OFF%  | %hunter% 在队伍的前方行动了几个小时，不久前你刚刚赶上了他。 他正踏在一只死掉的鹿身上，鹿的胸口上插着一只弓箭。 当你靠近时，他咧开嘴笑了笑，然后走了过来。 他说有没有兄弟来搭把手，挂一下这只鹿，我来把它剥一下皮，处理一下。 | 战队在森林里鸟儿愉快的啼鸣中行进着。 太阳在头顶茂密的树梢中闪烁，一个个漏下来的光斑将地面晒地暖洋洋的。 你看见一只松鼠正在一道阳光中享受着温暖，一边啃着橡子一边休息。 它停了下来，感觉到你在看着它，突然，它猛地一抖，几滴血飞溅到了你的脸上。 你把它擦掉，回过头发现它已经被一支弓箭射穿，在这慢慢衰弱的生命之声面前，一切死亡时的哀嚎都好像变得那么得安静。%hunter% 突然从树丛里窜出来，手里抓着他的弓，脸上带着笑。 猎人捡起他的收获，随手把它扔进了一堆其他的猎物之中－一捆串着各种敌对的，友善的生物的绳子中。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吃。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Hunter.getImagePath());
				local food = this.new("scripts/items/supplies/cured_venison_item");
				this.World.Assets.getStash().add(food);
				this.List = [
					{
						id = 10,
						icon = "ui/items/" + food.getIcon(),
						text = "你获得了鹿肉"
					}
				];
				_event.m.Hunter.improveMood(0.5, "成功狩猎");

				if (_event.m.Hunter.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Hunter.getMoodState()],
						text = _event.m.Hunter.getName() + this.Const.MoodStateEvent[_event.m.Hunter.getMoodState()]
					});
				}
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

		if (currentTile.Type != this.Const.World.TerrainType.Forest && currentTile.Type != this.Const.World.TerrainType.LeaveForest && currentTile.Type != this.Const.World.TerrainType.AutumnForest)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 2)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.hunter" || bro.getBackground().getID() == "background.poacher" || bro.getBackground().getID() == "background.beast_slayer" || bro.getBackground().getID() == "background.barbarian")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Hunter = candidates[this.Math.rand(0, candidates.len() - 1)];

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Hunter.getID())
			{
				this.m.OtherGuy = bro;
				this.m.Score = candidates.len() * 10;
				break;
			}
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"hunter",
			this.m.Hunter.getName()
		]);
		_vars.push([
			"otherguy",
			this.m.OtherGuy.getName()
		]);
	}

	function onClear()
	{
		this.m.Hunter = null;
		this.m.OtherGuy = null;
	}

});

