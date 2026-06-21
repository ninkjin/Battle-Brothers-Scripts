this.tailor_werewolf_hide_armor_event <- this.inherit("scripts/events/event", {
	m = {
		Tailor = null
	},
	function create()
	{
		this.m.ID = "event.tailor_werewolf_hide_armor";
		this.m.Title = "露营时…";
		this.m.Cooldown = 45.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_05.png[/img]当正在努力思考什么时候该去什么地方的时候，%tailor% 裁缝走进了你的帐篷，某种又黑又重的东西包裹着他的两边张开的肩膀。 你后退了一步，看到了像爪子一样的东西，或是某种怪力乱神在烛光中显现了出来。\n\n裁缝解释说他做了一套用冰原狼皮缝合起来的盔甲。 他把盔甲放在了桌子上，那里，剩余的爪子以致命的重量叩击着木头。 他摊开了盔甲，并且完整地展示它，有一个令人毛骨悚然的黑色玩意儿，一些锋利的骨头，这是一个被脱去内脏的生物，剩下的足够让一个人披上它，或者可以让其他的一些生物暖和地躲在那张空的毛皮里，野兽的头倒置了过来，看着马上就要穿它的人。 这些全都相当可怖，毫无疑问，现在你开始考虑何时何地裁缝最初想到了这样一个主意。",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "看起来是件很可怖的盔甲。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Tailor.getImagePath());
				local stash = this.World.Assets.getStash().getItems();
				local numPelts = 0;

				foreach( i, item in stash )
				{
					if (item != null && item.getID() == "misc.werewolf_pelt")
					{
						numPelts = ++numPelts;
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});

						if (numPelts >= 2)
						{
							break;
						}
					}
				}

				local item = this.new("scripts/items/armor/werewolf_hide_armor");
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
		if (this.Const.DLC.Unhold)
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getLevel() >= 3 && bro.getBackground().getID() == "background.tailor")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numPelts = 0;

		foreach( item in stash )
		{
			if (item != null && item.getID() == "misc.werewolf_pelt")
			{
				numPelts = ++numPelts;

				if (numPelts >= 2)
				{
					break;
				}
			}
		}

		if (numPelts < 2)
		{
			return;
		}

		this.m.Tailor = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numPelts * candidates.len() * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"tailor",
			this.m.Tailor.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Tailor = null;
	}

});

