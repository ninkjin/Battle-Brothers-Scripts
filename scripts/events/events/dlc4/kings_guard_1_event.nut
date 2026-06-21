this.kings_guard_1_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.kings_guard_1";
		this.m.Title = "在路上…";
		this.m.Cooldown = 9999999.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{在这片白雪皑皑的荒原上什么东西也没有，所以在这片严寒的土地上发现一个半裸的人是很不寻常的。 他甚至还活着。 你蹲在他旁边。 他的眼睛是空洞的，寒霜使他眨眼睛变成一种挣扎。 他的嘴唇褶皱着，冻成了紫色。 他的鼻子是深红色的，近乎黑色。 你问他是否会说话。他点头。%SPEECH_ON%野蛮人。带上。我。%SPEECH_OFF%你询问绑架他的人在哪里。 他耸耸肩，继续他那冷冰冰的调子。%SPEECH_ON%他们。觉得。烦了。然后。走了。%SPEECH_OFF%把一个俘虏留在冰天雪地里，这似乎禽兽不如。 他解释说他曾经是一个强壮的剑士。 他在痛苦中挤出一丝微笑。%SPEECH_ON%一个国王的。卫士。在。这个。没有国王的。土地。事情。会。更糟吧？%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们给你一个容身之处，朋友。",
					function getResult( _event )
					{
						return "C";
					}

				},
				{
					Text = "在这个世界上，你只能自食其力。",
					function getResult( _event )
					{
						return "B";
					}

				}
			],
			function start( _event )
			{
				local roster = this.World.getTemporaryRoster();
				_event.m.Dude = roster.create("scripts/entity/tactical/player");
				_event.m.Dude.setStartValuesEx([
					"cripple_background"
				], false);
				_event.m.Dude.setTitle("");
				_event.m.Dude.getBackground().m.RawDescription = "你发现%name%在北方冻得半死。他声称他曾经是国王护卫，但现在你看到他只是一个残废。";
				_event.m.Dude.getBackground().buildDescription(true);
				_event.m.Dude.getFlags().set("IsSpecial", true);
				_event.m.Dude.getBaseProperties().Bravery += 15;
				_event.m.Dude.getSkills().update();
				_event.m.Dude.m.PerkPoints = 2;
				_event.m.Dude.m.LevelUps = 2;
				_event.m.Dude.m.Level = 3;
				_event.m.Dude.m.XP = this.Const.LevelXP[_event.m.Dude.m.Level - 1];
				_event.m.Dude.m.Talents = [];
				local talents = _event.m.Dude.getTalents();
				talents.resize(this.Const.Attributes.COUNT, 0);
				talents[this.Const.Attributes.MeleeSkill] = 2;
				talents[this.Const.Attributes.MeleeDefense] = 3;
				talents[this.Const.Attributes.RangedDefense] = 3;
				_event.m.Dude.m.Attributes = [];
				_event.m.Dude.fillAttributeLevelUpValues(this.Const.XP.MaxLevelWithPerkpoints - 1);
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Mainhand));
				_event.m.Dude.getItems().unequip(_event.m.Dude.getItems().getItemAtSlot(this.Const.ItemSlot.Offhand));
				_event.m.Dude.worsenMood(1.5, "被野蛮人带走，留在寒冷中死去");
				_event.m.Dude.getFlags().set("IsKingsGuard", true);
				this.Characters.push(_event.m.Dude.getImagePath());
			}

		});
		this.m.Screens.push({
			ID = "B",
			Text = "%terrainImage%{你拍了拍他的头，但告诉他一切都结束了。他点头。%SPEECH_ON%说给。你自己吧。雇佣兵。%SPEECH_OFF%他又笑了，但这次是一种释放。 他挺立起来。铿锵有力。身体前倾，眼睛睁着，不眨眼，就这样死了。 你让士兵们回到道路上，或者说是雪原上的道路。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "这是你的归宿。",
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
			}

		});
		this.m.Screens.push({
			ID = "C",
			Text = "%terrainImage%{那个几乎冻僵的人加入了战队。 他是一个衣衫褴褛的废物，但如果他说的是真的，说不定有一天他会成为一个战士，就像他之前说的那样。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "我们拭目以待。",
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
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		if (currentTile.Type != this.Const.World.TerrainType.Snow)
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		this.m.Score = 5;
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

