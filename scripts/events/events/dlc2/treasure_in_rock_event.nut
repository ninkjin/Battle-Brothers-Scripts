this.treasure_in_rock_event <- this.inherit("scripts/events/event", {
	m = {
		Miner = null,
		Tiny = null,
		Other = null
	},
	function create()
	{
		this.m.ID = "event.treasure_in_rock";
		this.m.Title = "在途中…";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_66.png[/img]%randombrother%带你来到一个卡里奇峰侧面的裂缝处。你可以看到昏暗中闪烁的物体。不管那是什么，都需要费很大的力气才能挖穿它的泥土包裹。佣兵点点头。%SPEECH_ON%我知道它很结实，但我认为那是值得拿回去的东西。你怎么想?%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们开挖吧！",
					function getResult( _event )
					{
						if (this.Math.rand(1, 100) <= 50)
						{
							return "DigGood";
						}
						else
						{
							return "DigBad";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Miner != null)
				{
					this.Options.push({
						Text = "可以在这里使用一些矿工的专业知识。",
						function getResult( _event )
						{
							return "Miner";
						}

					});
				}

				if (_event.m.Tiny != null)
				{
					this.Options.push({
						Text = "你们中有谁小到能钻进那个洞里？",
						function getResult( _event )
						{
							return "Tiny";
						}

					});
				}

				this.Options.push({
					Text = "这不是我们想要的。 准备好继续前进。",
					function getResult( _event )
					{
						return 0;
					}

				});
			}

		});
		this.m.Screens.push({
			ID = "Miner",
			Text = "[img]gfx/ui/events/event_66.png[/img]%miner%在你的请求下点头。他收拾好工具，观察堡垒了几分钟。他朝岩石吐了口口水，点点头，然后开始工作。过了几分钟，这个开石匠已经找出了脆弱点，将坚硬的土壤变成了粉碎的灰尘，隐藏的宝藏也显露出来，矿工将其取出并交给了你。%SPEECH_ON%队长，锻炼身体不错，我觉得这是值得的。感谢你信任我，我是认真的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Miner.getImagePath());
				local item = this.new("scripts/items/trade/uncut_gems_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				item = this.new("scripts/items/trade/uncut_gems_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
				_event.m.Miner.improveMood(2.0, "利用他的采矿经验使战队受益");

				if (_event.m.Miner.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Miner.getMoodState()],
						text = _event.m.Miner.getName() + this.Const.MoodStateEvent[_event.m.Miner.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "Tiny",
			Text = "[img]gfx/ui/events/event_66.png[/img]小个子%tiny%走到堤坝的裂缝前，凝视着它。他像个陀螺一样转过身来。%SPEECH_ON%我不是一个轻易妥协的人，但我感觉被轻视了。%SPEECH_OFF%你向他保证，你的请求并没有对他的身材开玩笑的意思。他点点头，开始轻松地钻进裂缝里，就像他天生就为此而生一样。最终只剩下一双靴子露在地上。其中一位雇佣兵扫了一眼，悄悄问道，他有想挠脚的冲动是否很奇怪。你问他这是什么意思，并无意得到答案。幸好，%tiny%大喊他拿到了物品，众人帮忙将他拉出。%tiny%翻了个身，双手高举着宝藏，躺在他的小手中。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "做得好。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Tiny.getImagePath());
				local item = this.new("scripts/items/armor/ancient/ancient_breastplate");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
				item = this.new("scripts/items/weapons/ancient/ancient_sword");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了一个 " + item.getName()
				});
				_event.m.Tiny.improveMood(2.0, "利用他独特的身材造福战队");

				if (_event.m.Tiny.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Tiny.getMoodState()],
						text = _event.m.Tiny.getName() + this.Const.MoodStateEvent[_event.m.Tiny.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "DigGood",
			Text = "[img]gfx/ui/events/event_66.png[/img]你下令佣兵们利用任何可用的工具挖开壕沟。挖掘坚硬的黄土很费时间，但最终 %randombrother% 成功松动土壤，将隐藏的宝藏取了出来。里面有一个金杯和其他几件可以在市场上卖掉的物品。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "今天幸运女神向我们微笑。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local amount = this.Math.rand(5, 15);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 工具和补给"
				});
				local item = this.new("scripts/items/loot/golden_chalice_item");
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "DigBad",
			Text = "[img]gfx/ui/events/event_66.png[/img]你命令一些雇佣兵用任何工具进攻码头。他们尽力而为，但当他们刚开始挖掘时，一块岩盐滑落并砸中了%hurtbro%，把他击倒晕厥。期望的财宝随之滚落，结果只是一块锈迹斑斑几乎毫无用处的铁片。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Goddammit.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Other.getImagePath());
				local amount = this.Math.rand(5, 10);
				this.World.Assets.addArmorParts(amount);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_supplies.png",
					text = "你失去了 [color=" + this.Const.UI.Color.NegativeEventValue + "]-" + amount + "[/color] 工具和补给"
				});
				local injury = _event.m.Other.addInjury(this.Const.Injury.Accident3);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Other.getName() + " 遭受 " + injury.getNameOnly()
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

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Steppe && currentTile.TacticalType != this.Const.World.TerrainTacticalType.SteppeHills)
		{
			return;
		}

		if (this.World.Assets.getArmorParts() < 20)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_miner = [];
		local candidates_tiny = [];
		local candidates_other = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.player"))
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.miner")
			{
				candidates_miner.push(bro);
			}
			else if (bro.getSkills().hasSkill("trait.tiny"))
			{
				candidates_tiny.push(bro);
			}
			else if (!bro.getSkills().hasSkill("trait.lucky") && !bro.getSkills().hasSkill("trait.swift"))
			{
				candidates_other.push(bro);
			}
		}

		if (candidates_other.len() == 0)
		{
			return;
		}

		this.m.Other = candidates_other[this.Math.rand(0, candidates_other.len() - 1)];

		if (candidates_miner.len() != 0)
		{
			this.m.Miner = candidates_miner[this.Math.rand(0, candidates_miner.len() - 1)];
		}

		if (candidates_tiny.len() != 0)
		{
			this.m.Tiny = candidates_tiny[this.Math.rand(0, candidates_tiny.len() - 1)];
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"miner",
			this.m.Miner != null ? this.m.Miner.getNameOnly() : ""
		]);
		_vars.push([
			"tiny",
			this.m.Tiny != null ? this.m.Tiny.getNameOnly() : ""
		]);
		_vars.push([
			"hurtbro",
			this.m.Other.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		return "A";
	}

	function onClear()
	{
		this.m.Miner = null;
		this.m.Tiny = null;
		this.m.Other = null;
	}

});

