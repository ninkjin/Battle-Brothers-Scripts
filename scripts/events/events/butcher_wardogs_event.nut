this.butcher_wardogs_event <- this.inherit("scripts/events/event", {
	m = {
		Butcher = null
	},
	function create()
	{
		this.m.ID = "event.butcher_wardogs";
		this.m.Title = "露营时…";
		this.m.Cooldown = 30.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_27.png[/img]你打开一箱食物来寻找你最后的储备。 一个苹果滚过底部，听起来和摇摇晃晃的空腹咕噜声没什么两样。 几条面包给了它一些陪伴，还有一块用厚叶子包着的肉。就这样了。\n\n当你关上盖子转过身来时，%butcher% 就站在那里。%SPEECH_ON%嘿，老板。我知道我们有麻烦了。 所以我…摆平它？%SPEECH_OFF%就在这时，他用拇指搭在肩膀上，朝着拴在木桩上的两只战犬的方向。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "干吧，这是必要之事。",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "我不会让我们忠实的猎犬被宰杀和吃掉。",
					function getResult( _event )
					{
						return "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_14.png[/img]这些狗很老实地坐着，气喘吁吁，看起来很满足，所以他们的幸福感是持久的。 但你有嘴要喂，有仗要打。 你让 %butcher% 去做对战队有益的事。\n\n屠夫弯弯曲曲地走向那些狗狗，伸出一只手来抚摸它们，另一只手在背后抓着一把刀。 你不忍站在那里看接下来会发生什么，但是尖锐的声音已经从你空空的胃里传出来了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少队员们今晚没挨饿。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				local numWardogsToSlaughter = 2;
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
					{
						numWardogsToSlaughter = --numWardogsToSlaughter;
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});

						if (numWardogsToSlaughter == 0)
						{
							break;
						}
					}
				}

				if (numWardogsToSlaughter != 0)
				{
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

						if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
						{
							numWardogsToSlaughter = --numWardogsToSlaughter;
							bro.getItems().unequip(item);
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "你失去了 " + item.getName()
							});

							if (numWardogsToSlaughter == 0)
							{
								break;
							}
						}
					}
				}

				local item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				item = this.new("scripts/items/supplies/strange_meat_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_27.png[/img]你摇头表示反对。%SPEECH_ON%绝对不行。他们和任何人一样是战队的一员，当然有人宁愿饿死也不能吃自己的战友。%SPEECH_OFF%屠夫耸肩。%SPEECH_ON%它们只是狗，先生。野狗。杂种狗。 只不过是一只知道自己名字的野兽。 当我们需要它们的时候，有很多只小狗可以找到。%SPEECH_OFF%再一次的，你摇了摇头。%SPEECH_ON%我们不是在杀狗，%butcher%。别以为我看不到你眼中的凶光。 屠杀这些动物意味着很多，不仅仅是喂了几口而已。%SPEECH_OFF%%butcher% 只能再次耸肩。%SPEECH_ON%我不能挑选和选择什么给了我快乐，先生，但我听从你的命令。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们会发现其它食物的。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Butcher.getImagePath());
				_event.m.Butcher.worsenMood(1.0, "请求被拒绝");
				this.List.push({
					id = 10,
					icon = this.Const.MoodStateIcon[_event.m.Butcher.getMoodState()],
					text = _event.m.Butcher.getName() + this.Const.MoodStateEvent[_event.m.Butcher.getMoodState()]
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.Assets.getFood() > 25)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local numWardogs = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.butcher")
			{
				candidates.push(bro);
			}

			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
			{
				numWardogs = ++numWardogs;
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		if (numWardogs < 2)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
				{
					numWardogs = ++numWardogs;

					if (numWardogs >= 2)
					{
						break;
					}
				}
			}
		}

		if (numWardogs < 2)
		{
			return;
		}

		this.m.Butcher = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 25;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"butcher",
			this.m.Butcher.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Butcher = null;
	}

});

