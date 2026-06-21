this.shady_character_offers_map_event <- this.inherit("scripts/events/event", {
	m = {
		Historian = null,
		Thief = null,
		Peddler = null,
		Cost = 0,
		PricePaid = 0,
		Location = null
	},
	function create()
	{
		this.m.ID = "event.shady_character_offers_map";
		this.m.Title = "在路上…";
		this.m.Cooldown = 50.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_41.png[/img]行进中，一个孤独的商人带着他的驮马出现在你的路上。 他伸出双臂，双手清晰可见。%SPEECH_ON%晚上好，旅行者们。我可以让你对一些商品感兴趣吗？%SPEECH_OFF%他摆出很多东西但是 %companyname% 几乎都用不上，然后他提到了一张地图。 你当然已经扬起眉毛，因为他扬起眉毛笑了。%SPEECH_ON%唉，你对地图有兴趣吗？ 这是这里的绘制地图，地形，地理上奇怪的东西，我向你保证，带在一个人身上是非常有意义的！ 这篇文章告诉你著名的“%location%”的确切位置。 我肯定你过去听说过，是吗？ 拥有数不清的宝藏！ 世界上一些最好武器的安息之所！ 而这一切你将话费微不足道的 %mapcost% 克朗！%SPEECH_OFF%他咧嘴笑着转过头去。 看来他在旅途中卖掉了一些牙齿。%SPEECH_ON%所以，旅行者们，你们有什么想说的么？%SPEECH_OFF%",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我很感兴趣，我们要买这张地图。",
					function getResult( _event )
					{
						this.World.Assets.addMoney(-_event.m.Cost);
						_event.m.PricePaid = _event.m.Cost;

						if (_event.m.Historian != null)
						{
							return "B";
						}
						else
						{
							return this.Math.rand(1, 100) <= 50 ? "C" : "D";
						}
					}

				},
				{
					Text = "不感兴趣。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.Peddler != null)
				{
					this.Options.push({
						Text = "%peddler% 你曾经是个小贩。 让我们得到一个更好的成交价！",
						function getResult( _event )
						{
							return "E";
						}

					});
				}

				if (_event.m.Thief != null)
				{
					this.Options.push({
						Text = "%thief% 你曾经是一个小偷。 给我们拿到那张地图！",
						function getResult( _event )
						{
							return "F";
						}

					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_45.png[/img]得到这张地图后，你花了好长时间好好地查看。 你拿出自己的地图，开始在两者之间寻找。 购买的地图上没有任何可以相互参照的地方。 事实上，你买的地图边缘还乱画着奇怪的符文。 要么是最近的一个赝品，要么它起源于一个不是你的母语的时代。 不管怎样，它似乎非常没用。\n\n 就在你准备把它揉成一团扔掉的时候，%historian% 这个历史学家走了过来轻轻地把它捡了起来。 他看着符文，开始点头，用手指在边缘上划了划，然后再往里画，在地图上画得很差的山脉、河流和森林之间。%SPEECH_ON%哼…噢…啊，是的，我之前听说过这个地方。 我知道这些符文，虽然我不敢大声说出来。%SPEECH_OFF%他拿起战队的地图，用三支捏在手指间的羽毛笔慢慢地三角定位并翻译方向。 说完，他点了点头，用手背在战队的地图上敲了几下。%SPEECH_ON%在那里，先生。那就是我们要找的地方。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很高兴我们中有你这样的人才。",
					function getResult( _event )
					{
						this.World.uncoverFogOfWar(_event.m.Location.getTile().Pos, 700.0);
						_event.m.Location.getFlags().set("IsEventLocation", true);
						_event.m.Location.setDiscovered(true);
						this.World.getCamera().moveTo(_event.m.Location);
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Historian.getImagePath());

				if (_event.m.PricePaid != 0)
				{
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.PricePaid + "[/color] 克朗"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_45.png[/img]你拿起地图仔细一看。 你可以识别一些位置，并及时将其内容翻译到你自己的地图上。 %companyname% 正兴奋地低语着那里可能会有什么。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "这就是战队的财产！",
					function getResult( _event )
					{
						this.World.uncoverFogOfWar(_event.m.Location.getTile().Pos, 700.0);
						_event.m.Location.getFlags().set("IsEventLocation", true);
						_event.m.Location.setDiscovered(true);
						this.World.getCamera().moveTo(_event.m.Location);
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.PricePaid != 0)
				{
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.PricePaid + "[/color] 克朗"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_45.png[/img]你看着地图，你盯着它看，你实际上是在用一种很长很长的目光审视它。 但你只是没有看到而已。%randombrother% 看了一眼，然后摇了摇头。%SPEECH_ON%我一点也不认识它，先生。%SPEECH_OFF%这是一张假地图，或者是一张去你不认识的地方的地图－不管怎样，它都是完全没用的。",
			Image = "",
			List = [],
			Options = [
				{
					Text = "我们已经被骗了。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				if (_event.m.PricePaid != 0)
				{
					this.List.push({
						id = 10,
						icon = "ui/icons/asset_money.png",
						text = "你花费了 [color=" + this.Const.UI.Color.NegativeEventValue + "]" + _event.m.PricePaid + "[/color] 克朗"
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_41.png[/img]%peddler% 这个小贩向前走了几步，伸出双手，就像曾经做旅行商人的时候一样。 显然，这是诚实的盗贼常用的伎俩。%SPEECH_ON%先生，先生，请。来。 那个价格太离谱了。%SPEECH_OFF%商人的脸色变得难看。%SPEECH_ON%这没什么过分的，我向你保证。%SPEECH_OFF%但是你的小贩是固执的。%SPEECH_ON%很明显有些事情很离谱，因为我刚才就是这么说的，不是吗？%SPEECH_OFF%商人点头。小贩继续道。%SPEECH_ON%所以我们决定不按你原来的要价购买。 这一点很清楚。 所以，朋友，我想我们会以 %newcost% 的价格购买它。这对各方都是公道的，像你这样优秀的商人肯定能做成一笔交易！ 我们自己算不上商人，但我们知道那是笔好买卖！%SPEECH_OFF%商人挠了挠下巴，然后点了点头。%SPEECH_ON%好吧，这个价格是公道的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "一场更好的讨价还价！",
					function getResult( _event )
					{
						this.World.Assets.addMoney(-_event.m.Cost / 2);
						_event.m.PricePaid = _event.m.Cost / 2;

						if (_event.m.Historian != null)
						{
							return "B";
						}
						else
						{
							return this.Math.rand(1, 100) <= 50 ? "C" : "D";
						}
					}

				},
				{
					Text = "还是不值这个价。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Peddler.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "F",
			Text = "[img]gfx/ui/events/event_41.png[/img]当你和商人谈话时，%thief% 这个小偷悄悄走到你旁边，对谈话很感兴趣。 他瞥了你一眼。 你看了两眼。 他笑着点头。 你很快地看了看商人，然后回头看了看小偷，点了点头。 这名商人正在进行推销，却什么也没看到。 他不停地讲，你几乎听不到。 你只需要知道一直对一个商人点头就像他只会告诉你你想听的东西。\n\n 小偷从后面溜过去，把武器掉在泥里。%SPEECH_ON%我真笨。%SPEECH_OFF%他弯下腰，停顿了一下，有一个你几乎察觉不到的动作，然后他又站了起来。 他对你使眼色。 你告诉商人你很感激这个提议，但是你不得不放弃。 当他走后，%thief% 把地图交给你，然后咧着嘴笑。%SPEECH_ON%他们说生命中最好的东西都是免费的。%SPEECH_OFF%",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这就是我所说的打折。",
					function getResult( _event )
					{
						if (_event.m.Historian != null)
						{
							return "B";
						}
						else
						{
							return this.Math.rand(1, 100) <= 50 ? "C" : "D";
						}
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Thief.getImagePath());
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (this.World.getTime().Days < 10)
		{
			return;
		}

		if (this.World.Assets.getMoney() <= 1500)
		{
			return;
		}

		if (this.World.State.getEscortedEntity() != null)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local bases = this.World.FactionManager.getFactionOfType(this.Const.FactionType.Undead).getSettlements();
		local candidates_location = [];

		foreach( b in bases )
		{
			if (!b.getLoot().isEmpty() && !b.getFlags().get("IsEventLocation"))
			{
				candidates_location.push(b);
			}
		}

		if (candidates_location.len() == 0)
		{
			return;
		}

		this.m.Location = candidates_location[this.Math.rand(0, candidates_location.len() - 1)];
		local brothers = this.World.getPlayerRoster().getAll();
		local candidates_peddler = [];
		local candidates_thief = [];
		local candidates_historian = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.historian")
			{
				candidates_historian.push(bro);
			}
			else if (bro.getBackground().getID() == "background.thief")
			{
				candidates_thief.push(bro);
			}
			else if (bro.getBackground().getID() == "background.peddler")
			{
				candidates_peddler.push(bro);
			}
		}

		if (candidates_historian.len() != 0)
		{
			this.m.Historian = candidates_historian[this.Math.rand(0, candidates_historian.len() - 1)];
		}

		if (candidates_thief.len() != 0)
		{
			this.m.Thief = candidates_thief[this.Math.rand(0, candidates_thief.len() - 1)];
		}

		if (candidates_peddler.len() != 0)
		{
			this.m.Peddler = candidates_peddler[this.Math.rand(0, candidates_peddler.len() - 1)];
		}

		this.m.Cost = this.Math.rand(6, 14) * 100;
		this.m.Score = 7;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"historian",
			this.m.Historian != null ? this.m.Historian.getNameOnly() : ""
		]);
		_vars.push([
			"peddler",
			this.m.Peddler != null ? this.m.Peddler.getNameOnly() : ""
		]);
		_vars.push([
			"thief",
			this.m.Thief != null ? this.m.Thief.getNameOnly() : ""
		]);
		_vars.push([
			"location",
			this.m.Location.getName()
		]);
		_vars.push([
			"mapcost",
			this.m.Cost
		]);
		_vars.push([
			"newcost",
			this.m.Cost / 2
		]);
	}

	function onClear()
	{
		this.m.Historian = null;
		this.m.Thief = null;
		this.m.Peddler = null;
		this.m.Location = null;
	}

});

