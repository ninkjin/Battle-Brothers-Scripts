this.apprentice_learns_event <- this.inherit("scripts/events/event", {
	m = {
		Apprentice = null,
		Teacher = null
	},
	function create()
	{
		this.m.ID = "event.apprentice_learns";
		this.m.Title = "露营时…";
		this.m.Cooldown = 90.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]学徒 %apprentice% 似乎已经成为 %teacher% 的老人看护员。虽然这位剑术大师年事已高，但他似乎很想帮助这位年轻人成为一名更好的战士。 学徒用的是真剑，剑术大师用的是木剑。 剑术大师正是在这种武器的巨大差距下，展示如何有效地走位，发现弱点和避开危险。\n\n甚至在他年老的时候，这个人还在不停地闪转腾挪，使学徒根本打不动他。 一个巧妙的假动作，剑术大师看起来要被击中了，因为他离学徒很近，几乎要踩到脚了。 当学徒向后倾斜以给自己空间时，他的脚步乱了。 突然的拌蒜导致学员摔倒在地，他抬头发现一把木剑已经戳到了他的脖子。\n\n你发现这小子拍拍自己身上的泥土，现在至少能站起来继续拍泥土了。 我们只能说他这次小有提升吧。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				this.Characters.push(_event.m.Teacher.getImagePath());
				local meleeSkill = this.Math.rand(2, 4);
				local meleeDefense = this.Math.rand(2, 4);
				_event.m.Apprentice.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Apprentice.getBaseProperties().MeleeDefense += meleeDefense;
				_event.m.Apprentice.getSkills().update();
				_event.markAsLearned();
				_event.m.Apprentice.improveMood(1.0, "学习 " + _event.m.Teacher.getName());
				_event.m.Teacher.improveMood(0.5, "教授了" + _event.m.Apprentice.getName() + "某些东西");
				this.List = [
					{
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
					},
					{
						id = 17,
						icon = "ui/icons/melee_defense.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeDefense + "[/color] 近战防御"
					}
				];

				if (_event.m.Apprentice.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "[img]gfx/ui/events/event_05.png[/img]%teacher% 这位未退役的士兵很欣赏 %apprentice%。你就会发现他们俩抽空就在练习他们的武艺。 这老战士熟知进攻的技巧，教学徒如何舞动刀刃，斧头或棍棒，使之造成最大的伤害。 不幸的是，他们继续使用战队的餐具作为练习的武器战斗。 这个年轻的小伙子为了继续追求成为一个更好的战士，把那些锅碗瓢盆都弄得一塌糊涂。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				this.Characters.push(_event.m.Teacher.getImagePath());
				local meleeSkill = this.Math.rand(2, 4);
				local resolve = this.Math.rand(2, 5);
				_event.m.Apprentice.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Apprentice.getBaseProperties().Bravery += resolve;
				_event.m.Apprentice.getSkills().update();
				_event.markAsLearned();
				_event.m.Apprentice.improveMood(1.0, "学习 " + _event.m.Teacher.getName());
				_event.m.Teacher.improveMood(0.25, "教授了" + _event.m.Apprentice.getName() + "某些东西");
				this.List = [
					{
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
					},
					{
						id = 16,
						icon = "ui/icons/bravery.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + resolve + "[/color] 决心"
					}
				];

				if (_event.m.Apprentice.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "[img]gfx/ui/events/event_05.png[/img]看起来好像 %teacher% 这个老佣兵有一只跟着他的小鸟：年轻的 %apprentice%。现在，在这个雇佣兵组成的团队，学徒必须要向那些有丰富经验的人学习，赚取血汗钱。 当他们训练的时候，你会注意到佣兵把大部分的重点放在体能训练上。 比你的对手跑得快，比他更持久，就像把利刃刺穿他的大脑一样重要。 这个认真的小伙子似乎越来越健壮了，获得了一些前所未有的活力。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				this.Characters.push(_event.m.Teacher.getImagePath());
				local meleeSkill = this.Math.rand(2, 4);
				local initiative = this.Math.rand(4, 6);
				local stamina = this.Math.rand(2, 4);
				_event.m.Apprentice.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Apprentice.getBaseProperties().Initiative += initiative;
				_event.m.Apprentice.getBaseProperties().Stamina += stamina;
				_event.m.Apprentice.getSkills().update();
				_event.markAsLearned();
				_event.m.Apprentice.improveMood(1.0, "学习 " + _event.m.Teacher.getName());
				_event.m.Teacher.improveMood(0.25, "教授了" + _event.m.Apprentice.getName() + "某些东西");
				this.List = [
					{
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
					},
					{
						id = 17,
						icon = "ui/icons/initiative.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + initiative + "[/color] 主动性"
					},
					{
						id = 17,
						icon = "ui/icons/fatigue.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] 最大疲劳"
					}
				];

				if (_event.m.Apprentice.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "[img]gfx/ui/events/event_05.png[/img]有几次你发现 %apprentice% 在远处观望 %teacher%。 年轻的学徒似乎被野骑士的暴力美学折服了。 过了几天，野骑士改变了主意，让小伙子过来和他聊聊天。 你不知道他们在说什么，但现在你已经注意到他们一直在一起训练了。 雇佣骑士可不是一个慈祥的教官。 他经常暴打那个男孩，使他坚强起来。 起初，学徒在每次训练前都会退缩，但现在你可以看到，面对如此巨大的逆境，他表现出了更强的决心。 野骑士也在向他传授如何快速有效地杀人。 在你无意中听到的这些谈话中，很少有人提及防御方面的内容，但是谁需要防御一个被杀死的对手呢？",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "很出色！",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Apprentice.getImagePath());
				this.Characters.push(_event.m.Teacher.getImagePath());
				local meleeSkill = this.Math.rand(2, 4);
				local hitpoints = this.Math.rand(3, 5);
				local stamina = this.Math.rand(3, 5);
				_event.m.Apprentice.getBaseProperties().MeleeSkill += meleeSkill;
				_event.m.Apprentice.getBaseProperties().Hitpoints += hitpoints;
				_event.m.Apprentice.getBaseProperties().Stamina += stamina;
				_event.m.Apprentice.getSkills().update();
				_event.markAsLearned();
				_event.m.Apprentice.improveMood(1.0, "学习 " + _event.m.Teacher.getName());
				_event.m.Teacher.improveMood(0.25, "教授了" + _event.m.Apprentice.getName() + "某些东西");
				this.List = [
					{
						id = 16,
						icon = "ui/icons/melee_skill.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + meleeSkill + "[/color] 近战技能"
					},
					{
						id = 17,
						icon = "ui/icons/health.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + hitpoints + "[/color] 生命值"
					},
					{
						id = 17,
						icon = "ui/icons/fatigue.png",
						text = _event.m.Apprentice.getName() + " 获得了 [color=" + this.Const.UI.Color.PositiveEventValue + "]+" + stamina + "[/color] 最大疲劳"
					}
				];

				if (_event.m.Apprentice.getMoodState() >= this.Const.MoodState.Neutral)
				{
					this.List.push({
						id = 10,
						icon = this.Const.MoodStateIcon[_event.m.Apprentice.getMoodState()],
						text = _event.m.Apprentice.getName() + this.Const.MoodStateEvent[_event.m.Apprentice.getMoodState()]
					});
				}
			}

		});
	}

	function markAsLearned()
	{
		this.m.Apprentice.getFlags().add("learned");
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local apprentice_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() > 3 && bro.getBackground().getID() == "background.apprentice" && !bro.getFlags().has("learned"))
			{
				apprentice_candidates.push(bro);
			}
		}

		if (apprentice_candidates.len() < 1)
		{
			return;
		}

		local teacher_candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() < 6)
			{
				continue;
			}

			if (bro.getBackground().getID() == "background.swordmaster" || bro.getBackground().getID() == "background.old_swordmaster" || bro.getBackground().getID() == "background.retired_soldier" || bro.getBackground().getID() == "background.hedgeknight" || bro.getBackground().getID() == "background.sellsword")
			{
				teacher_candidates.push(bro);
			}
		}

		if (teacher_candidates.len() < 1)
		{
			return;
		}

		this.m.Apprentice = apprentice_candidates[this.Math.rand(0, apprentice_candidates.len() - 1)];
		this.m.Teacher = teacher_candidates[this.Math.rand(0, teacher_candidates.len() - 1)];
		this.m.Score = (apprentice_candidates.len() + teacher_candidates.len()) * 3;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"apprentice",
			this.m.Apprentice.getNameOnly()
		]);
		_vars.push([
			"teacher",
			this.m.Teacher.getNameOnly()
		]);
	}

	function onDetermineStartScreen()
	{
		if (this.m.Teacher.getBackground().getID() == "background.swordmaster" || this.m.Teacher.getBackground().getID() == "background.old_swordmaster")
		{
			return "A";
		}
		else if (this.m.Teacher.getBackground().getID() == "background.retired_soldier")
		{
			return "B";
		}
		else if (this.m.Teacher.getBackground().getID() == "background.sellsword")
		{
			return "C";
		}
		else
		{
			return "D";
		}
	}

	function onClear()
	{
		this.m.Apprentice = null;
		this.m.Teacher = null;
	}

});

