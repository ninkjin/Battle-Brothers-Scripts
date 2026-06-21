this.oathtakers_skull_cracked_event <- this.inherit("scripts/events/event", {
	m = {
		Oathtaker = null
	},
	function create()
	{
		this.m.ID = "event.oathtakers_skull_cracked";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_183.png[/img]{%oathtaker%颤抖着拿着年轻的安瑟姆的骷髅冲进帐篷。%SPEECH_ON%它断了！%SPEECH_OFF%你从座位上跳起来，看了看年轻的安瑟姆圣洁的遗骸。骷髅后面有一道细小的裂痕，起初看上去并不太严重，但当你伸出小指并提起时，骨头分裂了。你俩都倒抽了一口气，放下骷髅。毫无疑问，只需再付出一点点力气就可以将骷髅分开。%SPEECH_ON%我们该怎么办？怎样修复它？%SPEECH_OFF%你仔细地思考这个问题。上次发生这样的事时，年轻的安瑟姆的下颚断了，誓言盟士们也断了——有一组仍然是誓言盟士，而另一组则成为了野蛮的亵渎者，誓言带来者。你不会让这种事情再次发生。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "修理它。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Oathtaker.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "{[img]gfx/ui/events/event_183.png[/img]{你拿出一根细绳，在上面涂满常春藤和树脂。然后你轻轻地抬起年轻的安瑟姆小骷髅，用更多的树脂沿着裂缝慢慢地擦拭。%oathtaker%紧张地注视着。满意后，你插入细绳，然后放回骷髅的部分，紧咬着细绳和粘稠的常春藤。你退后一步，看着你的作品。%oathtaker%吞了口口水。%SPEECH_ON%我...我觉得没人会注意到的。%SPEECH_OFF%你其实担心，让他们发现骷髅的缝隙，而不是看到一些潜伏的骷髅修复者试图偷偷摆弄。不管怎样，这件事情已经告一段落，年轻的安瑟姆的荣誉已经得到了恢复。%oathtaker%擦了擦额头上的汗水。%SPEECH_ON%我相信这是一次考验，队长，年轻的安瑟姆已经带领我们度过了难关。他的力量在我体内流动，无法用言语来描述我此时的荣誉之感。%SPEECH_OFF%什么？年轻的安瑟姆可能并不知道树脂和常春藤，他现在很可能连自己现在只是个无声的骷髅都不知道。但是......你让%oathtaker%自己去解释吧，虽然这对你来说缺乏令人满意的解释。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我本该成为一个接待员。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local resolveBoost = this.Math.rand(2, 4);
				_event.m.Oathtaker.getBaseProperties().Bravery += resolveBoost;
				this.List.push({
					id = 16,
					icon = "ui/icons/bravery.png",
					text = _event.m.Oathtaker.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolveBoost + "[/color] 决心"
				});

				if (!_event.m.Oathtaker.getSkills().hasSkill("trait.determined"))
				{
					local trait = this.new("scripts/skills/traits/determined_trait");
					_event.m.Oathtaker.getSkills().add(trait);
					this.List.push({
						id = 10,
						icon = trait.getIcon(),
						text = _event.m.Oathtaker.getName() + "现在变得坚定了。"
					});
				}

				_event.m.Oathtaker.improveMood(1.0, "他对年幼的安瑟姆的信任加倍了。");

				if (_event.m.Oathtaker.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Oathtaker.getMoodState()],
						text = _event.m.Oathtaker.getName() + this.Const.MoodStateEvent[_event.m.Oathtaker.getMoodState()]
					});
				}

				this.Characters.push(_event.m.Oathtaker.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "{[img]gfx/ui/events/event_183.png[/img]{你嘘住了队长%oathtaker%，并告诉他拉上帐篷帘。你拿起了骷髅头，并立即开始修复。不幸的是，你的手一旦做出任何努力，裂缝就加宽了，甚至还有碎片飞散到不知道哪里去了。你像被烧伤了一样放开了头骨，安瑟姆的恩典空洞地敲打着桌子。%oathtaker%看着你。%SPEECH_ON%现在怎么办？我们应该怎么办？也许我们应该取出最好的部分跑路，组建一个新的队伍？%SPEECH_OFF%你嘲笑这个傻瓜，问他是否认为你是一名Oathtaker或Oathbringer。他吞了口唾沫，确认是前者。当然，如果是这样的话，只有一件事要做:声称这是年轻的安瑟姆渴望拥有这个头骨裂缝，并且这是%companyname%没有履行作为真正的誓言者的身份的一个表现。他同意了，你最终向其他人展示了头骨及其新获得的骨性标记。\n\n起初，他们会因为它的崩裂而感到害怕，但很快他们就会同意您的观点，即年轻的安塞姆的影响力正在减弱，不是因为头号誓言者本人，而是因为你们所有的誓言者都没有履行你们的誓言！你们都必须更好地跟随真正的誓言者之路！男人们咆哮和欢呼，年轻安塞姆的崩裂让他们信念更加坚定。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "不错的救援。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getBackground().getID() == "background.paladin")
					{
						bro.worsenMood(0.25, "他认为自己没有恪守誓言。");

						if (this.Math.rand(1, 100) <= 33)
						{
							bro.getBaseProperties().Bravery += 1;
							this.List.push({
								id = 16,
								icon = "ui/icons/bravery.png",
								text = _event.m.Oathtaker.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+1[/color] 决心"
							});
						}

						if (this.Math.rand(1, 100) <= 20 && !bro.getSkills().hasSkill("trait.deathwish"))
						{
							local trait = this.new("scripts/skills/traits/deathwish_trait");
							bro.getSkills().add(trait);
							this.List.push({
								id = 10,
								icon = trait.getIcon(),
								text = bro.getName() + "获得死亡之愿效果。"
							});
						}
					}

					bro.improveMood(0.75, "在誓言之后，被迫加倍努力。");

					if (bro.getMoodState() >= this.Const.MoodState.Neutral)
					{
						this.List.push({
							id = 10,
							icon = this.Const.MoodStateIcon[bro.getMoodState()],
							text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
						});
					}
				}

				this.Characters.push(_event.m.Oathtaker.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.paladins")
		{
			return;
		}

		if (this.World.getTime().Days < 40)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];
		local haveSkull = false;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.paladin")
			{
				candidates.push(bro);
			}

			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.oathtaker_skull_01" || item.getID() == "accessory.oathtaker_skull_02"))
			{
				haveSkull = true;
			}
		}

		if (!haveSkull)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && (item.getID() == "accessory.oathtaker_skull_01" || item.getID() == "accessory.oathtaker_skull_02"))
				{
					haveSkull = true;
					break;
				}
			}
		}

		if (!haveSkull)
		{
			return;
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Oathtaker = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 5 * candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"oathtaker",
			this.m.Oathtaker.getName()
		]);
	}

	function onClear()
	{
		this.m.Oathtaker = null;
	}

});

