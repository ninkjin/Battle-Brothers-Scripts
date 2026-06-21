this.sacrificed_man_event <- this.inherit("scripts/events/event", {
	m = {
		Cultist = null,
		Other = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.sacrificed_man";
		this.m.Title = "在途中…";
		this.m.Cooldown = 99999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%一个奇怪的景象：一个死人被矛钉在地上。 他自己的血被用来在他的尸体上画圈。其他奇怪的仪式也用他的血来描绘。%otherbrother% 开始收回那些矛。 你试着让他停下来，但已经太晚了。 他举起其中一件武器。%SPEECH_ON%什么？这些武器质量很好。 我门为什么要把它们留在这？%SPEECH_OFF%好吧，如果这是一个神圣的守护仪式，它已经被破坏了。 你收起那些矛。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "安息吧。",
					function getResult( _event )
					{
						if (_event.m.Cultist != null)
						{
							return "Cultist";
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
				local item = this.new("scripts/items/weapons/militia_spear");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
				item = this.new("scripts/items/weapons/militia_spear");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(item.getName()) + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "Cultist",
			Text = "%terrainImage%在你离开之前，%cultist% 向那个被献祭的人低下头，在他耳边低语。 过了一会儿，那个死人的头歪了。 他睁大眼睛，鼻孔张得大大的。 异教徒看着你。%SPEECH_ON%他没死。他的血被用来使达库尔满足。 如果我们需要他死，我们应该烧死他。%SPEECH_OFF%在你目瞪口呆之前，他停顿了一下，转向那个伤口在你眼前神秘地愈合的人。%cultist% 轻拍他的脸颊。%SPEECH_ON%来吧，朋友，为达库尔服务。%SPEECH_OFF%这个未被牺牲的男人跳起来，本能地转向你。 不知怎么的，他已经知道你是这里的队长了，于是弯下了膝盖。%SPEECH_ON%如果你允许，我将为你而战，并以此来传播达库尔的信仰。%SPEECH_OFF%他的声音很机械，好像他去年一年都在练习宣誓似的。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎来到 %companyname%。",
					function getResult( _event )
					{
						return "Recruit";
					}

				},
				{
					Text = "我真的不需要了。 你自便吧。",
					function getResult( _event )
					{
						return "Deny";
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Cultist.getImagePath());
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"cultist_background"
				]);
				_event.m.Dude.setTitle("献祭(the Sacrifice)");
				_event.m.Dude.getBackground().m.RawDescription = "你发现这个作为祭品的人，但他却在命运的安排下复活了，成了达库尔的仆人。 他要求为你而战，而你，出于某种原因，实际上同意了。";
				_event.m.Dude.getBackground().buildDescription(true);

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand).removeSelf();
				}

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Head).removeSelf();
				}

				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "Recruit",
			Text = "%terrainImage%你决定收留这个人。%otherbrother% 站在路边，手里拿着一对长矛。%SPEECH_ON%我们还可以拿走这些，对吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们当然可以这么做。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Cultist.improveMood(1.0, "你招募了一个异教徒");

				if (_event.m.Cultist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Deny",
			Text = "%terrainImage%你拒绝了重生的异教徒。他点头。%SPEECH_ON%当然。我会找到其他方法侍奉达库尔。再会，兄弟。%SPEECH_OFF%在转身离开前，他向 %cultist% 鞠躬。%otherbrother% 手里拿着一对长矛站在那里。%SPEECH_ON%我们还可以拿走这些，对吗？%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们当然可以这么做。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						_event.m.Dude = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Cultist.worsenMood(1.0, "你没能招募到一个异教徒");

				if (_event.m.Cultist.getMoodState() < this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Cultist.getMoodState()],
						text = _event.m.Cultist.getName() + this.Const.MoodStateEvent[_event.m.Cultist.getMoodState()]
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local playerTile = this.World.State.getPlayer().getTile();
		local towns = this.World.EntityManager.getSettlements();
		local nearTown = false;

		foreach( t in towns )
		{
			local d = playerTile.getDistanceTo(t.getTile());

			if (d >= 6 && d <= 12)
			{
				nearTown = true;
				break;
			}
		}

		if (!nearTown)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_cultist = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				candidates_cultist.push(bro);
			}
			else if (bro.getBackground().getID() != "background.slave")
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		if (candidates_cultist.len() != 0)
		{
			this.m.Cultist = candidates_cultist[this.Math.rand(0, candidates_cultist.len() - 1)];
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];
		this.m.Score = 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"cultist",
			this.m.Cultist != null ? this.m.Cultist.getNameOnly() : ""
		]);
		_vars.push([
			"otherbrother",
			this.m.Other.getName()
		]);
	}

	function onClear()
	{
		this.m.Cultist = null;
		this.m.Other = null;
		this.m.Dude = null;
	}

});

