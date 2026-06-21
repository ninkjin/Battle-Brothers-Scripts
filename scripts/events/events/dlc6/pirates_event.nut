this.pirates_event <- this.inherit("scripts/events/event", {
	m = {
		Fisherman = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.pirates";
		this.m.Title = "在路上…";
		this.m.Cooldown = 80.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_157.png[/img]{你遇到一排拷着锁链被驱赶的人。 他们的领头人声称这些人是“负债者，”但是其中一个人，显然是个北方人，喊道他们是被海盗绑架了的航船商人。 搜捕者头头走在他手下前面笑道。%SPEECH_ON%不要相信他的谎言，旅行者，这些人只是害怕向镀金者偿还债务的漫长救赎之旅。 他宁愿下地狱也不愿意麻烦自己获得救赎。 他难道没有点人性吗？%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [],
			function start( _event )
			{
				this.Options.push({
					Text = "立刻释放他们！",
					function getResult( _event )
					{
						return "B";
					}

				});

				if (_event.m.Fisherman != null)
				{
					this.Options.push({
						Text = "看起来 %fisherman% 有什么想说的。",
						function getResult( _event )
						{
							return "C";
						}

					});
				}

				if (this.World.Assets.getOrigin().getID() == "scenario.manhunters")
				{
					this.Options.push({
						Text = "把这些负债者交给我，我会亲自把他们赶向救赎。",
						function getResult( _event )
						{
							return "D";
						}

					});
				}

				this.Options.push({
					Text = "那就继续走吧，搜捕者。",
					function getResult( _event )
					{
						return "E";
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_157.png[/img]{你拔出剑要求他们释放“负债者”。 搜捕者环顾四周，吃惊。%SPEECH_ON%善良的旅行者，我只是服从于镀金者的法律。 这些人有债务要还，地狱等着那些拒不偿还的人。%SPEECH_OFF%你摇了摇头，你告诉他你不会再说一遍。 他叹气并把人们解拷了。 大部分马上就逃跑了，但是有一个留在原地。 但他不是要加入你，他留在奴隶贩子那，伸出他的手。%SPEECH_ON%求你了，把我领向镀金者的光芒。%SPEECH_OFF%还有个人没跑，但看来是想跟着你走。 他以明确的意图宣布自己：他将加入并为之而战的就是 %companyname%。%SPEECH_ON%如果我有债要还，那只会是向你，先生。%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "希望你知道怎么使用武器。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "你自由了，但是你得自己找回家的路。",
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
				this.World.Assets.addMoralReputation(2);
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"fisherman_background"
				]);
				_event.m.Dude.setTitle("船员(the Sailor)");
				_event.m.Dude.getBackground().m.RawDescription = "在 %name% 被在城邦外活动的海盗劫持后，你把他从奴隶生活中解救了出来。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.worsenMood(2.0, "被搜捕者俘虏了");
				this.Characters.push(_event.m.Dude.getImagePath());
				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "听说你要释放负债者");
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_157.png[/img]{%fisherman% 渔夫走上前。%SPEECH_ON%等等，我认识这个人！ 他可没什么债务，许多个冬天前我们一起出海过。%SPEECH_OFF%水手点头。%SPEECH_ON%是，是的没错！%SPEECH_OFF%搜捕者看了看，然后走过去放开了水手。%SPEECH_ON%我对镀金者计划展现的情形的复杂性并不陌生并看得到其中的意图。 无疑他想让这两人见面。 请接收他，然后他将完成他的救赎。%SPEECH_OFF%搜捕者继续带着他的俘虏队伍前进。 其中一个转向你说。%SPEECH_ON%真可惜我们不认识，哼？%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎。希望你知道怎么用武器。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Dude = null;
						return 0;
					}

				},
				{
					Text = "恐怕你得自己找回家的路了。",
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
				this.Characters.push(_event.m.Fisherman.getImagePath());
				this.World.Assets.addMoralReputation(2);
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"fisherman_background"
				]);
				_event.m.Dude.setTitle("船员(the Sailor)");
				_event.m.Dude.getBackground().m.RawDescription = "在 %name% 被在城邦外活动的海盗劫持后，你把他从奴隶生活中解救了出来。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.worsenMood(2.0, "被搜捕者俘虏了");
				_event.m.Dude.improveMood(0.5, "从奴隶的生活中获救被 " + _event.m.Fisherman.getName());
				_event.m.Fisherman.improveMood(2.0, "已保存 (Saved)" + _event.m.Dude.getName() + "从奴隶生活中解放");
				this.Characters.push(_event.m.Dude.getImagePath());
				local cityStates = this.World.FactionManager.getFactionsOfType(this.Const.FactionType.OrientalCityState);

				foreach( c in cityStates )
				{
					c.addPlayerRelation(this.Const.World.Assets.RelationNobleContractFail, "听说你要释放负债者");
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_157.png[/img]{你摇响了锁链并把几个负债者拉上前。 显摆着你的负债者牛仔证，你告诉搜捕者你在这些事情上很有经验而且你看得出来这些不听话的水手会找到个机会做掉他。%SPEECH_ON%把他们交给我，我将会亲自给赶向救赎。 将他们留在身边，镀金者也难保你不受他们心中的邪恶所害。%SPEECH_OFF%搜捕者想了一会，然后点头同意了。%SPEECH_ON%你说得对。收成不错，但是镀金者已经见证过我的所作所为和目的是正直的。 带走他们吧，并愿镀金者的光芒照亮你和他们的命运。%SPEECH_OFF%}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "镀金者大发慈悲来让你们偿还债务。",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getPlayerRoster().add(_event.m.Fisherman);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						_event.m.Fisherman.onHired();
						_event.m.Dude = null;
						_event.m.Fisherman = null;
						return 0;
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"slave_background"
				]);
				_event.m.Dude.setTitle("船员(the Sailor)");
				_event.m.Dude.getBackground().m.RawDescription = "%name% 在海上当水手时，城邦的海盗登上了他的船，把他和他的船员一起抓作俘虏。 由于一些偶然事件，他进入你的势力中来还清他欠镀金者的债。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.worsenMood(2.0, "被搜捕者俘虏了");
				this.Characters.push(_event.m.Dude.getImagePath());
				_event.m.Fisherman = roster.create("scripts/entity/tactical/player");
				_event.m.Fisherman.setStartValuesEx([
					"slave_background"
				]);
				_event.m.Fisherman.setTitle("航海家(the Mariner)");
				_event.m.Fisherman.getBackground().m.RawDescription = "%name% 在海上当水手时，城邦的海盗登上了他的船，把他和他的船员一起抓作俘虏。 由于一些偶然事件，他进入你的势力中来还清他欠镀金者的债。";
				_event.m.Fisherman.getBackground().buildDescription(true);
				_event.m.Fisherman.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Fisherman.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Fisherman.worsenMood(2.0, "被搜捕者俘虏了");
				this.Characters.push(_event.m.Fisherman.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_157.png[/img]{搜捕者短鞠一躬。%SPEECH_ON%愿你的道路金光闪耀，旅行者。%SPEECH_OFF%他回到路上，另一边所谓的水手呼喊到他们甚至不来自这里，他们从一开始就不理解“镀金者”和债都是什么。}",
			Banner = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你也是。",
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
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax() - 1)
			{
				return;
			}
		}
		else if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_fisherman = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.fisherman" && bro.getEthnicity() == 0)
			{
				candidates_fisherman.push(bro);
			}
		}

		if (candidates_fisherman.len() != 0)
		{
			this.m.Fisherman = candidates_fisherman[this.Math.rand(0, candidates_fisherman.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"fisherman",
			this.m.Fisherman != null ? this.m.Fisherman.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Fisherman = null;
		this.m.Dude = null;
	}

});

