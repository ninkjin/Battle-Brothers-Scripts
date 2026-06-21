this.adopt_wardog_event <- this.inherit("scripts/events/event", {
	m = {
		Bro = null,
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.adopt_wardog";
		this.m.Title = "在途中…";
		this.m.Cooldown = 120.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_27.png[/img]你走了一段路之后，发现几里地前看到的那条狗仍然鬼鬼祟祟地跟在后面，仿佛有意隐藏自己的行踪一般。\n\n像它这样的杂种狗，不会无缘无故地跟着一群危险的佣兵－也许受人指使？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "把那杂种狗赶走！",
					function getResult( _event )
					{
						return "B";
					}

				},
				{
					Text = "最好立刻甩掉它，免得它以后偷走我们的补给。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 60)
						{
							return "C";
						}
						else
						{
							return "D";
						}
					}

				},
				{
					Text = "战队需要一只吉祥物，带上它。",
					function getResult( _event )
					{
						local r = this.Math.rand(1, 100);

						if (r <= 75)
						{
							return "E";
						}
						else
						{
							return "F";
						}
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Houndmaster != null)
				{
					this.Options.push({
						Text = "%houndmaster%，你受过驯养狗的训练，对吗？",
						function getResult( _event )
						{
							return "G";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_75.png[/img]这里可不是养狗的地方。 当你又看到了那条狗，便拿起事先准备好的石头狠狠的砸中了它的脑门。 狗吃痛大叫，不由得退却。 呆立在原地，似乎在想自己做错了什么，但你并不给它喘息的机会，又拿起一块石头砸中了它。 狗离开了，再也没有出现过。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "滚远点！",
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
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_75.png[/img]你张弓搭箭。 几个兄弟也随着你的视线望去。 虽然没有射中，但狗识趣地跑开了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我是想吓跑它。",
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
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_27.png[/img]你张弓搭箭。 几个兄弟也随着你的视线望去。 风来了，去了，又来了。 你耐心地等着，然后拉弦，闭上一只眼睛对狗集中注意力。 狗得见如此，不由得停下身来，边剧烈喘息边看着你。\n\n你放开，射了出去。 羽箭呼啸而去，狗尖叫一声。 它向后倒下，在地上抽搐不停，直到停下来。 你收弓还袋，让战队继续赶路。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "可怜的家伙。",
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
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_27.png[/img]你拿起一块肉走向那条狗。 刚开始的时候有点不安，在你靠近的时候后退，但是你手上的香味确实很诱惑。 杂种狗不自禁便又走到你的身旁，双眼中依然满是戒备，仿佛在不停地揣测是否有陷阱。\n\n连日的奔波让这条狗瘦骨嶙峋，小狗憔悴的过了很多天。 它的耳朵有缝合的伤口，尾巴上挂满了战斗的痕迹。 这只动物知道如何战斗，从现在起它将为你所用。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎加入战队。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				local item = this.new("scripts/items/accessory/wardog_item");
				item.m.Name = "战斗兄弟(Battle Brother)";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_37.png[/img]像他这样粗犷的狗会成为一个伟大的吉祥物。 这只小杂种肯定能鼓舞士气。 你让 %bro% 喂狗，希望它能跟随。 他拿了一点剩菜剩饭，蹲下来喂给狗吃。%SPEECH_ON%好狗狗。%SPEECH_OFF%杂种狗嗅了嗅食物，然后大口大口地吃下去－雇佣兵的手也被咬了下来。 这哥们向后一跳，把胳膊搂在胸口，好像他会失去它一样。 另一方面，狗吞下碎块然后跑掉了。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "该死，他的适应力真强。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Bro.getImagePath());
				local injury = _event.m.Bro.addInjury(this.Const.Injury.FeedDog);
				this.List = [
					{
						id = 10,
						icon = injury.getIcon(),
						text = _event.m.Bro.getName() + " 遭受 " + injury.getNameOnly()
					}
				];
			}

		});
		this.m.Screens.push({
			ID = "G",
			Text = "[img]gfx/ui/events/event_27.png[/img]你问 %houndmaster% 驯兽师能否试着和狗“交流”。 他点头朝它走去。 这只野生杂种狗的耳朵尖尖的直了起来。 驯兽师蹲下，慢慢地向这只动物走去。 他伸出手来，手里拿着一块肉。 恐惧难敌饥饿，狗不由自主地接近了驯兽师的手。 狗向掌心吐出舌头，狼吞虎咽地吃下去。 驯兽员又喂了一块肉。 他把他推倒在地，并舔他的耳朵后面。 回头望了望，%houndmaster% 点头。%SPEECH_ON%是的，这是一个令人愉快的野兽，很容易被驯服。%SPEECH_OFF%这太好了。你问它是否能战斗。 驯兽师自信的噘着嘴。%SPEECH_ON%狗与人相似。 如果它能呼吸，它就能战斗。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Nice.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				local item = this.new("scripts/items/accessory/wardog_item");
				item.m.Name = "战斗兄弟(Battle Brother)";
				this.World.Assets.getStash().add(item);
				this.List.push({
					id = 10,
					icon = "ui/items/" + item.getIcon(),
					text = "你获得了" + item.getName()
				});
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

		if (currentTile.Type == this.Const.World.TerrainType.Forest || currentTile.Type == this.Const.World.TerrainType.Snow || currentTile.Type == this.Const.World.TerrainType.LeaveForest || currentTile.Type == this.Const.World.TerrainType.Mountains)
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
			if (bro.getBackground().getID() == "background.houndmaster")
			{
				candidates.push(bro);
			}
		}

		this.m.Bro = brothers[this.Math.rand(0, brothers.len() - 1)];

		if (candidates.len() != 0)
		{
			this.m.Houndmaster = candidates[this.Math.rand(0, candidates.len() - 1)];
		}

		this.m.Score = 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"bro",
			this.m.Bro.getName()
		]);
		_vars.push([
			"houndmaster",
			this.m.Houndmaster != null ? this.m.Houndmaster.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Bro = null;
		this.m.Houndmaster = null;
	}

});

