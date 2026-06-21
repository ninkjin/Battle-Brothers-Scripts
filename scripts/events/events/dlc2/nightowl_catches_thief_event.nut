this.nightowl_catches_thief_event <- this.inherit("scripts/events/event", {
	m = {
		NightOwl = null,
		FoundItem = null
	},
	function create()
	{
		this.m.ID = "event.nightowl_catches_thief";
		this.m.Title = "在路上…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_33.png[/img]{从一个奇怪的梦中醒来后，你走出帐篷，发现大部分的战团都在睡觉，只剩夜猫子%nightowl%。他在营地边缘背对着你，但似乎听到你的脚步声，没有看也开口说话了。%SPEECH_ON%就是这样开始的，长官。愤怒，发热。好人变得……啊啊啊。%SPEECH_OFF%他转过身来，向你展示他捉到的一只真正的猫头鹰。它的眼睑半闭，可能是累了逃脱，现在只是被抓住而感到羞辱。你问%nightowl%他是怎么抓到它的。那个佣兵放了鸟，耸了耸肩。%SPEECH_ON%用我的双手。我还抓到了这个。%SPEECH_OFF%他蹲下来，拖起一个此前未见的尸体。%SPEECH_ON%品味不错的小贼。他，嗯……打了折扣，可以这么说。我有点累得说不出话来，所以让我的刀告诉他，店关门了。然后我跟着他的脚步找到了他来的地方，找到了他，嗯，我们可以说是随身物品。%SPEECH_OFF%你点点头。好吧，当然。你告诉这个人你要回去睡觉，明天早上再判断他的行为。他也点了点头。%SPEECH_ON%明白的，长官。我会试着让自己也能睡一会儿。已经过了几天了，或者几周了吗？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好好休息。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.NightOwl.getImagePath());
				_event.m.NightOwl.improveMood(1.0, "晚上抓到一个小偷");

				if (_event.m.NightOwl.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.NightOwl.getMoodState()],
						text = _event.m.NightOwl.getName() + this.Const.MoodStateEvent[_event.m.NightOwl.getMoodState()]
					});
				}

				local trait = this.new("scripts/skills/effects_world/exhausted_effect");
				_event.m.NightOwl.getSkills().add(trait);
				this.List.push({
					id = 10,
					icon = trait.getIcon(),
					text = _event.m.NightOwl.getName() + "是筋疲力尽的"
				});
				local money = this.Math.rand(100, 300);
				this.World.Assets.addMoney(money);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (this.World.getTime().IsDaytime)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getSkills().hasSkill("trait.night_owl"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.NightOwl = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"nightowl",
			this.m.NightOwl.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.NightOwl = null;
		this.m.FoundItem = null;
	}

});

