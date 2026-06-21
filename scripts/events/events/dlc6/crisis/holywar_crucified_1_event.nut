this.holywar_crucified_1_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.crisis.holywar_crucified_1";
		this.m.Title = "在路上…";
		this.m.Cooldown = 999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "{[img]gfx/ui/events/event_161.png[/img]{在荒芜的沙漠中，人必须要对任何他们经过的东西保持怀疑，特别是十字架上钉了一个人的时候。 被钉在上面的人看起来死透了，秃鹫像牧师似的啄过了两肩，但随着你靠近把鸟赶走时这个人抬起了头。 尽管手脚严重受伤，他还算是活着并且请求给点水。 比起给他水，你选择先问问为什么他在这里。他叹了叹气。%SPEECH_ON%我曾经是个十字军战士。为了旧神的荣誉随军来到这里。 只是当我到了这里，与当地人和牧师们交谈过了之后，我的想法改变了。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "其他十字军对你做的？",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "{[img]gfx/ui/events/event_161.png[/img]{这个人点头。%SPEECH_ON%是的，就是他们。 不过回想起来，当他们因为同样的原因把别人钉在十字架上时我也在场。 所以部分的讲，我选择跟着他的脚印不是什么明智之举，我也不是心地善良，因为我也是当时欢呼的人群中的一员。 不过或许镀金者会看到我心中真正的光，你知道吗？%SPEECH_OFF%他把他的头扭向天空，盯着上方盘旋的秃鹫。%SPEECH_ON%我还可以战斗，不管是和谁，南方人，北方人，不重要了。 镀金者在我心中。%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "欢迎你加入我们。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "你心中只有秃鹫。",
					function getResult( _event )
					{
						return "D";
					}

				}
			],
			function start( _event )
			{
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "{[img]gfx/ui/events/event_161.png[/img]{你掏出你的匕首把他放了下来。 他显然受了很多伤，但以他的体格他能恢复过来。 用一种对于差点丧命的人而言出奇温和的态度，他向你表示感谢。%SPEECH_ON%终于能伸展一下了。我是说，你懂的，对我而言的伸展。 带路吧，镀金者命运的领路人，他强大威严的指引者。%SPEECH_OFF%战队里的许多人对于带上一个不仅背叛了他的同胞，还背叛了他的神的人有些不满。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "啊，他在我们这帮怪胎中会很合群的。",
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
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"crucified_background"
				]);
				_event.m.Dude.getBackground().m.RawDescription = "你在沙漠中发现了%name%，他是一个来自北方的前十字军战士，因为背弃旧神而被钉上了十字架。放他下来之后，他保证会为你效劳。尽管他试图隐瞒，但他的精神状态似乎并不稳定。";
				_event.m.Dude.getBackground().buildDescription(true);
				local trait = this.new("scripts/skills/traits/deathwish_trait");

				foreach( id in trait.m.Excluded )
				{
					_event.m.Dude.getSkills().removeByID(id);
				}

				_event.m.Dude.getSkills().add(trait);
				_event.m.Dude.setHitpointsPct(0.33);
				_event.m.Dude.improveMood(3.0, "看到了光明，接受了镀金者的庄严");
				_event.m.Dude.worsenMood(3.0, "被钉在十字架上");
				this.Characters.push(_event.m.Dude.getImagePath());
				local brothers = this.World.getPlayerRoster().getAll();

				foreach( bro in brothers )
				{
					if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 66)
					{
						bro.worsenMood(1.0, "不喜欢你阻止了应该因为背叛旧神而受到的惩罚");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
		this.m.Screens.push({
			ID = "D",
			Text = "{[img]gfx/ui/events/event_161.png[/img]{你跟他说他很快就会去见他的神或神们了。他叹了一口气。%SPEECH_ON%某种程度上，我罪有应得，而我也对此感到平静。%SPEECH_OFF%战队里对这件事的反应不一，这里不一指的是不同程度的幸灾乐祸。 毕竟，这个人同时背叛了天和地，很容易让他被任何人与所有人厌恶。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "他罪有应得。",
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
					if (bro.getEthnicity() == 0 && this.Math.rand(1, 100) <= 50)
					{
						bro.improveMood(0.25, "对你的领导有信心");

						if (bro.getMoodState() < this.Const.MoodState.Neutral)
						{
							this.List.push({
								id = 10,
								icon = this.Const.MoodStateIcon[bro.getMoodState()],
								text = bro.getName() + this.Const.MoodStateEvent[bro.getMoodState()]
							});
						}
					}
				}
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Desert)
		{
			return;
		}

		if (!this.World.FactionManager.isHolyWar())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (currentTile.Type != this.Const.World.TerrainType.Desert && currentTile.Type != this.Const.World.TerrainType.Oasis && currentTile.TacticalType != this.Const.World.TerrainTacticalType.DesertHills)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local towns = this.World.EntityManager.getSettlements();

		foreach( t in towns )
		{
			if (t.getTile().getDistanceTo(currentTile) <= 5)
			{
				return;
			}
		}

		this.m.Score = 10;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

