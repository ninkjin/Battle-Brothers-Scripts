this.training_accident_event <- this.inherit("scripts/events/event", {
	m = {
		ClumsyGuy = null,
		OtherGuy1 = null,
		OtherGuy2 = null
	},
	function create()
	{
		this.m.ID = "event.training_accident";
		this.m.Title = "露营时…";
		this.m.Cooldown = 16.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "至少他没有杀死自己。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.ClumsyGuy.getImagePath());
				local r = this.Math.rand(1, 6);
				local injury;

				if (r == 1)
				{
					this.Text = "[img]gfx/ui/events/event_19.png[/img]进行训练时，%clumsyguy%，没能成为一个灵巧的人，他用自己的武器伤了自己。";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident1);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " 遭受 " + injury.getNameOnly()
						}
					];
				}
				else if (r == 2)
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]在旅行时，你喜欢让你的人通过一些不时的训练来保持战斗力。 不幸的是，在训练还击时，%clumsyguy%，插到了自己的脚。 他看起来因尴尬受到的伤更甚。";
					_event.m.ClumsyGuy.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.ClumsyGuy.getName() + "遭受轻伤"
					});
				}
				else if (r == 3)
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]在清点库存时，你命令 %clumsyguy% 去搬一筒箭。 这趟简单的旅途以他被一块石头绊倒而结束，并且让他成为了一个大号箭靶。";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident2);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " 遭受 " + injury.getNameOnly()
						}
					];
				}
				else if (r == 4)
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]你发现 %clumsyguy% 醉着处理他脸一边的伤口。%otherguy1% 解释说这个呆子尝试在一堆尖石上跳舞，只是跌倒了然后脸狠狠撞在了地上。真好。";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident3);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " 遭受 " + injury.getNameOnly()
						}
					];
				}
				else if (r == 5)
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]当 %otherguy1% 和 %otherguy2% 训练时，%clumsyguy% 站到了他俩之间，讲着如何才能正确地训练，同时没看着他在往哪里走。 一把失控的木剑横贯在他的脸上，没过一会那个傻子就失去意识了。";
					injury = _event.m.ClumsyGuy.addInjury(this.Const.Injury.Accident3);
					this.List = [
						{
							id = 10,
							icon = injury.getIcon(),
							text = _event.m.ClumsyGuy.getName() + " 遭受 " + injury.getNameOnly()
						}
					];
				}
				else
				{
					this.Text = "[img]gfx/ui/events/event_34.png[/img]看来 %clumsyguy% 在参加训练前喝得有点太多了。 告诉给你的事情经过是这样的，那个醉汉错把一棵树当成了敌人。 之后事情是这样进行的，他，向那棵树发起了冲锋，在过程中撞到了自己。";
					_event.m.ClumsyGuy.addLightInjury();
					this.List.push({
						id = 10,
						icon = "ui/icons/days_wounded.png",
						text = _event.m.ClumsyGuy.getName() + "遭受轻伤"
					});
				}
			}

		});
	}

	function onUpdateScore()
	{
		local brothers = this.World.getPlayerRoster().getAll();

		if (brothers.len() < 3)
		{
			return;
		}

		local candidates = [];

		foreach( bro in brothers )
		{
			if ((bro.getSkills().hasSkill("trait.clumsy") || bro.getSkills().hasSkill("trait.drunkard") || bro.getSkills().hasSkill("trait.addict")) && !bro.getSkills().hasSkillOfType(this.Const.SkillType.TemporaryInjury))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.ClumsyGuy = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = candidates.len() * 8;

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.ClumsyGuy.getID())
			{
				this.m.OtherGuy1 = bro;
				break;
			}
		}

		foreach( bro in brothers )
		{
			if (bro.getID() != this.m.ClumsyGuy.getID() && bro.getID() != this.m.OtherGuy1.getID())
			{
				this.m.OtherGuy2 = bro;
				break;
			}
		}
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"clumsyguy",
			this.m.ClumsyGuy.getName()
		]);
		_vars.push([
			"otherguy1",
			this.m.OtherGuy1.getName()
		]);
		_vars.push([
			"otherguy2",
			this.m.OtherGuy2.getName()
		]);
	}

	function onClear()
	{
		this.m.ClumsyGuy = null;
		this.m.OtherGuy1 = null;
		this.m.OtherGuy2 = null;
	}

});

