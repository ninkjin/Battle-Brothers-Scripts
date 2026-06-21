this.anatomist_vs_dog_event <- this.inherit("scripts/events/event", {
	m = {
		Anatomist = null,
		Houndmaster = null
	},
	function create()
	{
		this.m.ID = "event.anatomist_vs_dog";
		this.m.Title = "在途中…";
		this.m.Cooldown = 9999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_27.png[/img]{%anatomist% 解剖学家过来找你，提出了一个可怕的想法：他想取一只战团的狗来进行解剖。你问他是否是打算杀死这只狗。他摇头示意在两个选择之间权衡。%SPEECH_ON%我认为在我们开始解剖之前，最好让这只狗已经去世了。%SPEECH_OFF%解剖学家解释说，狗用于研究并不罕见，并且这种要求将有助于更好地理解不怕狼，而不怕狼显然和狗有着某种关系。你无法想象屠杀战团的狗会和其他士兵相处的好，于是让他去找几百只懒散四处游荡的狗之一。他摇着头。%SPEECH_ON%所有的狗几乎可以肯定都是不怕狼的同类，但是一只战斗狗却是不同种，而且几乎可以确定是最接近这个问题的犬种。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是的，请做吧。",
					function getResult( _event )
					{
						if (_event.m.Houndmaster != null)
						{
							return "E";
						}
						else if (this.Math.rand(1, 100) <= 50)
						{
							return "B";
						}
						else
						{
							return "C";
						}
					}

				},
				{
					Text = "不，我不这么认为。",
					function getResult( _event )
					{
						return "D";
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
			Text = "[img]gfx/ui/events/event_37.png[/img]{你点头告诉这个人去做他必须做的事情。就你而言，你在这里是来帮助这些解剖学家开展业务的，有时候可能意味着动用战团的资金。在这种情况下，一只斗犬恰好代表着这些资金。%anatomist%很高兴，便开始宰杀。你听到了狗铃的叮当声，然后是短暂的嗥叫声。你忽略了接下来的声音。\n\n%anatomist%最终带着沾满血迹的手出现了。他点头表示样本令人满意，并从它的战斗精神中学到了很多东西。你告诉他埋葬这条狗。他看上去很厌恶，但是你瞪了他一眼，他便退缩了，说他会为它做一个合适的葬礼。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "安息吧，狗。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				_event.m.Anatomist.m.XP = this.Const.LevelXP[_event.m.Anatomist.getLevel()];
				_event.m.Anatomist.updateLevel();
				this.List.push({
					id = 16,
					icon = "ui/icons/level.png",
					text = _event.m.Anatomist.getName() + "升级了。"
				});
				local numWardogsToLose = 1;
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
					{
						numWardogsToLose = --numWardogsToLose;
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				if (numWardogsToLose != 0)
				{
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

						if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
						{
							numWardogsToLose = --numWardogsToLose;
							bro.getItems().unequip(item);
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "你失去了 " + item.getName()
							});
							break;
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_19.png[/img]{你让解剖学家%anatomist%开始操作。他笑得像孩子拿到了第一份礼物。他走开后，你开始怀疑自己是否做出了正确的选择。你听到解剖学家正在和狗搏斗，听到狗项圈的撞击声和被激怒的吼叫声。你等着听到狗惨叫，但却听到了一个明显是人的声音，甚至有一点点女性化。你朝着声音飞奔而去，一个大狗冲了过去。你发现%anatomist%正躺在地上握着他的手，他毫不畏惧或者说是为了寻找一些教育价值，自言自语地喃喃细语着科学的真理。%SPEECH_ON%啊，我想这证明了它确实有一点亡狼的血统。%SPEECH_OFF%尽管%anatomist%可以从这个流血的伤口中获得什么，但这只狗却不见了。毫无疑问，它明白这样的背叛不是无缘无故而来的。如果这只狗有亡狼的血统，那么其中也有普通狗的血统，即使是狗也知道什么时候该背叛它的主人。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "清洗那个伤口。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				local injury = _event.m.Anatomist.addInjury([
					{
						ID = "injury.missing_finger",
						Threshold = 0.0,
						Script = "injury_permanent/missing_finger_injury"
					}
				]);
				this.List.push({
					id = 10,
					icon = injury.getIcon(),
					text = _event.m.Anatomist.getName() + " 遭受 " + injury.getNameOnly()
				});
				local numWardogsToLose = 1;
				local stash = this.World.Assets.getStash().getItems();

				foreach( i, item in stash )
				{
					if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
					{
						numWardogsToLose = --numWardogsToLose;
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				if (numWardogsToLose != 0)
				{
					local brothers = this.World.getPlayerRoster().getAll();

					foreach( bro in brothers )
					{
						local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

						if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
						{
							numWardogsToLose = --numWardogsToLose;
							bro.getItems().unequip(item);
							this.List.push({
								id = 10,
								icon = "ui/items/" + item.getIcon(),
								text = "你失去了 " + item.getName()
							});
							break;
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_27.png[/img]{%anatomist% 叹了口气，但并没有提出抗议，最终接受了你的否决，带着点儿佝偻地走开了。你想知道如果他有尾巴的话，它会不会刚刚找到夹在腿间的位置。就在此时，他的科学设计——那条狗，摇着尾巴，嘴里叼着一根棍子出现了。它把木棍放在你的脚下，但当你去捡起来时，狗却咆哮着将它抢了走。或许这些奇怪的生物应该被研究一下……}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "好吧，你这个小杂种……",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				_event.m.Anatomist.worsenMood(0.5, "被拒绝学习战犬术的机会。");
			}

		});
		this.m.Screens.push({
			ID = "E",
			Text = "[img]gfx/ui/events/event_06.png[/img]{您让%anatomist%按他的意愿去做。如果你的工作是帮助他们完成科学任务，那么这样的事件将成为其中的一部分。你可以听到解剖学家正试图将狗按倒并迅速杀死。但接着你听到一个男人的声音从侧面喊叫进来，摔打声从人兽打斗，渐渐变成了更多的人类喊叫和互相咒骂声，最后传来了请求饶恕的声音。你意识到你完全忘记了战团的狩猎犬管理员。你赶紧走过去，发现%houndmaster%正在用狗皮带鞭打解剖师，并偶尔出手打他。%SPEECH_ON%疼吗？这样呢？告诉我，你流血时能学到什么？如果我把你的牙齿变成垃圾粉末，你认为它们会尝起来像什么？%SPEECH_OFF%你叹了口气，走过去把狩猎犬管理员拉开。%houndmaster%辩解说%anatomist%试图杀死其中一只狗。你挥手一挥，说可能某些地方出现了误解。你看着满身鲜血的解剖师，并告诉他远离狗。在他还能流血吞咽抗议之前，你就转身走开了。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "Oops.",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Anatomist.getImagePath());
				this.Characters.push(_event.m.Houndmaster.getImagePath());
				_event.m.Anatomist.addHeavyInjury();
				this.List.push({
					id = 10,
					icon = "ui/icons/days_wounded.png",
					text = _event.m.Anatomist.getName() + "遭受重伤"
				});
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

		local brothers = this.World.getPlayerRoster().getAll();
		local anatomistCandidates = [];
		local houndmasterCandidates = [];
		local numWardogs = 0;

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.anatomist" && bro.getLevel() <= 6)
			{
				anatomistCandidates.push(bro);
			}
			else if (bro.getBackground().getID() == "background.houndmaster")
			{
				houndmasterCandidates.push(bro);
			}

			local item = bro.getItems().getItemAtSlot(this.Const.ItemSlot.Accessory);

			if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
			{
				numWardogs = ++numWardogs;
			}
		}

		if (houndmasterCandidates.len() > 0)
		{
			this.m.Houndmaster = houndmasterCandidates[this.Math.rand(0, houndmasterCandidates.len() - 1)];
		}

		if (anatomistCandidates.len() == 0)
		{
			return;
		}

		if (numWardogs < 1)
		{
			local stash = this.World.Assets.getStash().getItems();

			foreach( item in stash )
			{
				if (item != null && (item.getID() == "accessory.wardog" || item.getID() == "accessory.armored_wardog" || item.getID() == "accessory.warhound" || item.getID() == "accessory.armored_warhound"))
				{
					numWardogs = ++numWardogs;

					if (numWardogs >= 1)
					{
						break;
					}
				}
			}
		}

		if (numWardogs < 1)
		{
			return;
		}

		this.m.Anatomist = anatomistCandidates[this.Math.rand(0, anatomistCandidates.len() - 1)];
		this.m.Score = 8;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"anatomist",
			this.m.Anatomist.getNameOnly()
		]);
		_vars.push([
			"houndmaster",
			this.m.Houndmaster != null ? this.m.Houndmaster.getName() : ""
		]);
	}

	function onClear()
	{
		this.m.Anatomist = null;
		this.m.Houndmaster = null;
	}

});

