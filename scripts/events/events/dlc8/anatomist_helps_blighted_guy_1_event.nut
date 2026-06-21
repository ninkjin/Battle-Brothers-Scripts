this.anatomist_helps_blighted_guy_1_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_helps_blighted_guy_1";
		this.m.Title = "在路上...";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_53.png[/img]{你看到一个人被活埋了，他被捆绑着像是个死人，但还在尖叫。你询问发生了什么事情，其中一个挖掘者转身向你伸出一只手。%SPEECH_ON%离他远点。这个人被感染了，任何他碰过的人都会被感染。我们不想染病，你也不该想。%SPEECH_OFF%那个男人呼救着，又被一块泥土盖住了。他试图爬出坑来，但是一个挖掘者踢了他回去。踢人者还抱怨要烧掉他最喜欢的靴子。%anatomist%走过来，用平静的声音说道。他说这个男人有一种皮肤病，看起来像麻风或瘟疫，但实际上是良性的。你问他是否确定，他点了点头，虽然带着一丝犹豫。%SPEECH_ON%当然，我也可能错了。如果我错了，他真正的病就可能传染给我们所有人。但是活埋一个人并不是我所发现的，你如何说，科学上有说服力的做法。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "那么我们要帮他。",
					function getResult( _event )
					{
						return this.Math.rand(1, 100) <= 50 ? "B" : "C";
					}

				},
				{
					Text = "这不是我们的问题。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_88.png[/img]{你拔出剑，命令挖掘者停下。他们用难以置信的眼神看着你。其中一人指着坟墓中的那个人。%SPEECH_ON%你没听到吗？这个家伙有瘟疫。我们在这里做的或许看起来不对，但是......%SPEECH_OFF%你用剑指了指那个挖掘者，他就安静了下来。你告诉坟墓中的人出来，然后挖掘者们放下了铲子，后退了一步。他们告诉你那个人就全由你了。这个据说有传染病的人走近了，他依然很害怕，毫无疑问，他不确定救他的人是否有比把他活埋的人更好的想法。%anatomist%接管了他，你慢慢退后。解剖师说，这个人生病了，但不严重，他会尽快恢复。然而，他现在需要休息。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Alright.",
					function getResult( _event )
					{
						this.World.getPlayerRoster().add(_event.m.Dude);
						this.World.getTemporaryRoster().clear();
						_event.m.Dude.onHired();
						return 0;
					}

				},
				{
					Text = "我们不需要其他人。",
					function getResult( _event )
					{
						this.World.getTemporaryRoster().clear();
						return "D";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"vagabond_background"
				], false);
				_event.m.Dude.setTitle("");
				_event.m.Dude.getFlags().set("IsSpecial", true);
				_event.m.Dude.getBackground().m.RawDescription = "" + _event.m.Anatomist.getNameOnly() + "解剖师从被活埋的命运中拯救了%name%，因为他带着一些奇怪的疾病。现在他既被瘟疫困扰，又成为一些研究的实验品。请呆在那边。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.MeleeSkill] = 2;
				talents[this.Const.Attributes.MeleeDefense] = 2;
				talents[this.Const.Attributes.Bravery] = 2;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);

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

				if (_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body) != null)
				{
					_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Body).removeSelf();
				}

				_event.m.Dude.worsenMood(1.5, "因患病差点被活埋");
				local i = this.new("scripts/skills/injury/sickness_injury");
				i.addHealingTime(8);
				_event.m.Dude.getSkills().add(i);
				_event.m.Dude.getFlags().set("IsMilitiaCaptain", true);
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_18.png[/img]{你叹了口气，拔出剑来，下令挖掘者立刻停止。他们把手放在铁铲上，眉毛向上扬起。%SPEECH_ON%什么？你们没听到吗？这位家伙生了血污！%SPEECH_OFF%%anatomist% 走过来挥手阻止他们。你点点头，示意挖掘者照做。解剖学家帮助这个人离开坟墓，尽管你注意到他自己的袖子和手已经变得血腥。他被扶回了战团。这个人转过身来感谢你的时候，%anatomist% 用锤子敲中了他的脑后部，让他迅速昏过去。解剖学家跟着他倒在地上，开始割掉这个人的胳膊，拿出一块肉后才退开。%SPEECH_ON%这东西足够我们研究了，我相信。%SPEECH_OFF%你问这个人确实生病了吗。解剖学家点了点头。%SPEECH_ON%当然，但与其让他进坟墓像个蠕虫一样死去，倒不如让他在生病时也做点有用的事情。当然，他现在可以去死了。在这个世界上，他没有什么剩下的了。%SPEECH_OFF%这个人在地上打滚发出呻吟声。你取下他的靴子发现里面藏着一些克朗。你短暂地考虑了一下是否要结束他的痛苦，但决定既然他已经从坟墓里出来了，他可以自己决定如何返回它。然而，你拿走了他的钱。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "祝你好运，老兄。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				_event.m.Anatomist.improveMood(1.0, "不得不研究一种不同寻常的枯萎病。");

				if (_event.m.Anatomist.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Anatomist.getMoodState()],
						text = _event.m.Anatomist.getName() + this.Const.MoodStateEvent[_event.m.Anatomist.getMoodState()]
					});
				}

				_event.m.Anatomist.addXP(200, false);
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/xp_received.png",
					text = _event.m.Anatomist.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+200[/color] 经验值"
				});
				this.World.Assets.addMoney(45);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]45[/color] 克朗"
				});
				this.Characters.push(_event.m.Anatomist.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_04.png[/img]{你告诉这个人说%companyname%不需要更多的佣兵。你还暗示他在离开之前，也许应该考虑为帮助付出一些代价。他点了点头，脱下了他的靴子，露出里面藏有金子。因为不相信他有什么病，你告诉他挤到草地上摩擦硬币，然后用脚踢过去。他照做了。他点了点头。%SPEECH_ON%我理解了。你们也要多加小心。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "祝你好运。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.World.Assets.addMoney(65);
				this.List.push({
					id = 10,
					icon = "ui/icons/asset_money.png",
					text = "你获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]65[/color] 克朗"
				});

				if (this.Math.rand(1, 100) < 75)
				{
					_event.m.Anatomist.worsenMood(0.75, "被拒绝研究一种不寻常的疾病。");
				}
				else
				{
					_event.m.Anatomist.worsenMood(0.5, "被拒绝帮助一个生病的人。");
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Paladins)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.anatomists")
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomist_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist")
			{
				anatomist_candidates.push(bro);
			}
		}

		if (anatomist_candidates.len() > 0)
		{
			this.m.Anatomist = anatomist_candidates[this.Math.rand(0, anatomist_candidates.len() - 1)];
		}
		else
		{
			return;
		}

		this.m.Score = 5 + anatomist_candidates.len();
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getName()
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Dude = null;
	}

});

