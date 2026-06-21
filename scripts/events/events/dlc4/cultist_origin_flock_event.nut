this.cultist_origin_flock_event <- this.inherit("scripts/events/event", {
	m = {
		Dude = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_flock";
		this.m.Title = "在路上…";
		this.m.Cooldown = 14.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]{%joiner%，一个流浪的达库尔信徒，已经加入了 %companyname%。战队成员们聚集在他周围，他点头，他们也点头，就像他在早就你身边一样。 | %joiner%，一个衣衫褴褛，但身披达库尔甲的人加入了 %companyname%。 | 一个名叫 %joiner% 的人向你展示了他对达库尔的奉献，一系列精神仪式造就了他的的头盔，上面有一些可怕的疤痕。 他被欢迎加入 %companyname%。 | %joiner% 在直接联系你之前，跟踪了战队一些时间。 他是达库尔目的的拥护者，他的观点已经提出，而你自己也完全同意他说的。 这个人加入了战队。 | 达库尔肯定会像一个名叫 %joiner% 的人一样守护着你，他加入了 %companyname%。他说他只有一个目的，那就是找到你，确保这个世界看到所有等待着的东西。 | %joiner% 说他看到你身后的影子在闪烁，就好像它们是“火焰”一样。 他声明他将加入你们的事业，因为毫无疑问，达库尔已经在你们身上嵌入了黑暗和无尽。 | %joiner% 与你同行。 他称你为达库尔黑暗的一面，那永恒的眼睛一定会守护你的整个团队。 %companyname% 把他带到很多暗影的羽翼之下。 | %joiner% 在行军中找到了 %companyname%，并加入了它的队伍，就好像它并不陌生一样。 没有人说什么，你只是简单地引导他去存货那里，他的目的可能是收集牙齿。 | 通过展示他伤痕累累的头颅，%joiner% 声称他是传达达库尔意志的先锋。 你点头欢迎他加入 %companyname%。 | 行走在达库尔的阴影中，你一定会发现像 %joiner% 这样的人。他渴望加入这个战队，尤其是因为你是这个战队的负责人，更重要的是，他相信是达库尔选择了你。 | %joiner% 和战队合作，至于为什么，几乎没有争论。 当被问到他来自哪里时，他耸耸肩，说是达库尔，并有意地朝你的方向点头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "是的，加入我们。",
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
					"cultist_background"
				]);
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

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		if (this.World.getPlayerRoster().getSize() >= this.World.Assets.getBrothersMax())
		{
			return;
		}

		local currentTile = this.World.State.getPlayer().getTile();

		if (!currentTile.HasRoad)
		{
			return;
		}

		this.m.Score = 75;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"joiner",
			this.m.Dude.getName()
		]);
	}

	function onClear()
	{
		this.m.Dude = null;
	}

});

