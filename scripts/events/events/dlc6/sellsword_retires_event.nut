this.sellsword_retires_event <- this.inherit("scripts/events/event", {
	m = {
		Peddler = null
	},
	function create()
	{
		this.m.ID = "event.sellsword_retires";
		this.m.Title = "在路上…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_64.png[/img]{你遇到一个坐在路边的人。 他穿着些破损的盔甲还有把比之更加破损的武器在他腰边。 他用手用最微弱的力道挥了挥。%SPEECH_ON%晚上好。如果你不是佣兵，那我就从没把我爸爸的裤子点着。%SPEECH_OFF%他刚才说的听起来是个非常有趣的故事，但是比起那个你问他在这路中间干什么。 更重要的，你问他，一个还很健壮的小伙，需不需要工作。%SPEECH_ON%工作？不。我不需要。 我已经干过佣兵这一行而且我已经干完了。 你知道吗，这儿。%SPEECH_OFF%他开始脱下他的盔甲并把他丢到你面前。%SPEECH_ON%拿走它。我不再需要那种生活了。 把武器也拿走。 我要把这些都抛在身后。 你也应该，但我知道你不会。 在一切都太迟之前。 我要在这片大地上走到我入土。 至于你，祝你好运。%SPEECH_OFF%就像那样，陌生人离开了。}",
			Image = "",
			List = [],
			Options = [
				{
					Text = "祝好运。",
					function getResult( _event )
					{
						if (_event.m.Peddler != null)
						{
							return "B";
						}
						else
						{
							return 0;
						}
					}

				}
			],
			function start( _event )
			{
				local item;
				local stash = this.World.Assets.getStash();
				item = this.new("scripts/items/weapons/arming_sword");
				item.setCondition(item.getConditionMax() / 2 - 1);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/armor/basic_mail_shirt");
				item.setArmor(item.getArmorMax() / 2 - 1);
				stash.add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_64.png[/img]{%peddler% 小贩，总是对金子有着敏锐的嗅觉，问了问他干佣兵挣到克朗了吗。 当他点头，小贩说如果那时真的他总能“买”下他回去的路。 佣兵寻思了会，然后又点了点头。%SPEECH_ON%你知道吗？没错。 只要我有克朗，我就还有生命线回到那该死的生意上。给，拿着。%SPEECH_OFF%要退休，还有看起来马上就要隐居的佣兵伸进他的口袋里并开心的把一袋克朗丢给你，好像在摆脱负担一样。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会好好用这些的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
				local money = this.Math.rand(20, 100);
				this.World.Assets.addMoney(money);
				this.List = [
					{
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]" + money + "[/color] 克朗"
					}
				];
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getStash().getNumberOfEmptySlots() < 2)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.peddler")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() != 0)
		{
			this.m.Peddler = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"peddler",
			this.m.Peddler != null ? this.m.Peddler.getNameOnly() : ""
		]);
	}

	function onClear()
	{
		this.m.Peddler = null;
	}

});

