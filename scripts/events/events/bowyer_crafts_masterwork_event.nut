this.bowyer_crafts_masterwork_event <- this.inherit("scripts/events/event", {
	m = {
		Bowyer = null,
		OtherGuy1 = null,
		OtherGuy2 = null
	},
	function create()
	{
		this.m.ID = "event.bowyer_crafts_masterwork";
		this.m.Title = "露营时…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]%bowyer% 这个弓匠带着小小的请求走到你面前：他希望为这个时代制造一件武器。 显然，这个人多年来一直试图建造一个具有传奇品质的弓，但是现在他已经在路上了，拣起了一些东西来填补他的知识空白。 说真的，他相信这次他能做好。 他所需要的只是一些资源来帮助他获得制作弓所需要的材料。 他谦卑要求给他五百克朗，并要你运来上等的木料。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "给我做一把传奇的弓！",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 60 ? "B" : "C";
					}

				},
				{
					Text = "我们没有时间做这个。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bowyer.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]{这把弓不是很有传奇色彩，但是很不错。 它握起来很轻，很容易使射击方向从一边转向另一边，伴随着空气的尖啸声射击。 你测试弓弦。 需要一个强壮的人来驾驭它，这是肯定的。 当你射出一支箭时，箭轴会令人难以置信地对正，而箭几乎是自动瞄准的。 这是你见过的最厉害的武器！ | 弓是用你不知道名字的木头混合而成的。 这棵树和那棵树的颜色螺旋穿过武器的弓背，看起来像是树的颜色真的变深了。 测试弓弦，就能证明它的威力。 你不是神射手，但当你射出一支箭时，它似乎能自动指向目标。 一个可怕的武器，如果没有其他原因，它使你看起来比你实际上射击技术更好了。 你向弓匠表示祝贺。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一件大师级的作品！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bowyer.getImagePath());
				this.World.Assets.addMoney(-500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] 克朗"
				});
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.quality_wood")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				local item = this.new("scripts/items/weapons/masterwork_bow");
				item.m.Name = _event.m.Bowyer.getNameOnly() + "的" + item.m.Name;
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Bowyer.improveMood(2.0, "制作了一件杰作");

				if (_event.m.Bowyer.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
						text = _event.m.Bowyer.getName() + this.Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]这是一个疯狂的实验吗？ 木头弯曲时就会出现弯曲和裂缝，每次你把它拉回来，绳子就会卷曲和变硬，你发誓你看到一只白蚁从轴中探出头来。 每一支经过测试的箭都乱了套，绕着这个或那个方向飞，除了它应该射到的地方。\n\n你通过责备自己来缓解弓匠制作武器不准确的痛苦，但是 %otherguy1% 和 %otherguy2% 都试过了，得出了更糟的结果。 弓匠最终拖着脚走开了，他怀里抱着自己的弓，然后把它扔进了武器库，在那里你会希望它看起来和其他弓一样，但它丑陋的样子让它像干草堆上的热煤一样突出。 当然没有人会不小心挥舞着它！",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我现在明白你为什么不再干弓匠这个工作了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bowyer.getImagePath());
				this.World.Assets.addMoney(-500);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]500[/color] 克朗"
				});
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.quality_wood")
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				local item = this.new("scripts/items/weapons/wonky_bow");
				item.m.Name = _event.m.Bowyer.getNameOnly() + "的" + item.m.Name;
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Bowyer.worsenMood(1.0, "制作杰作失败");

				if (_event.m.Bowyer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
						text = _event.m.Bowyer.getName() + this.Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]你告诉弓匠，%companyname% 没有多余的资源。 那人牙齿打颤，显然无论如何他得说点什么，但他什么也没说，他转过身跺着脚走掉了。 在远处，你终于听到了他为你准备的善意－一连串的咒骂和诅咒，最后是失望的低语。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "振作起来。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bowyer.getImagePath());
				_event.m.Bowyer.worsenMood(2.0, "请求被拒绝");

				if (_event.m.Bowyer.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Bowyer.getMoodState()],
						text = _event.m.Bowyer.getName() + this.Const.MoodStateEvent[_event.m.Bowyer.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getMoney() < 2000)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 6 && bro.getBackground().getID() == "background.bowyer")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numWood = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.quality_wood")
			{
				numWood = ++numWood;
				break;
			}
		}

		if (numWood == 0)
		{
			return;
		}

		this.m.Bowyer = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 4;
	}

	function onPrepare()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Bowyer.getID())
			{
				this.m.OtherGuy1 = bro;
				break;
			}
		}

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.Bowyer.getID() && bro.getID() != this.m.OtherGuy1.getID())
			{
				this.m.OtherGuy2 = bro;
				break;
			}
		}
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bowyer",
			this.m.Bowyer.getNameOnly()
		]);
		_vars.push([
			"otherguy1",
			this.m.OtherGuy1.getName()
		]);
		_vars.push([
			"otherguy2",
			this.m.OtherGuy2.getName()
		]);
	}

	function onClear()
	{
		this.m.Bowyer = null;
		this.m.OtherGuy1 = null;
		this.m.OtherGuy2 = null;
	}

});

