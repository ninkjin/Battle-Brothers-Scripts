this.cultist_origin_hood_event <- this.inherit("scripts/events/event", {
	m = {
		Tailor = null
	},
	function create()
	{
		this.m.ID = "event.cultist_origin_hood";
		this.m.Title = "露营时…";
		this.m.Cooldown = 15.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "[img]gfx/ui/events/event_03.png[/img]{%randomcultist%，你的一个追随者，进入你的帐篷，然后很快的离开了。 你站起来想看看他去哪儿了，却发现你的桌子上放着一顶皮头盔。 这种皮革是用来历不明的毛发缝制而成，然后用看似钩子和指甲的东西把它们夹在一起。 头盔上的洞是漆黑一片，你能感觉到即使你把它们填满，黑暗也永远不会消失。 然后，盯着头盔上那些空槽，你知道有什么东西在盯着你。你赞许地点头。}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "达库尔即将降临。",
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

				foreach( i, item in stash )
				{
					if (item != null && (item.getID() == "armor.head.hood" || item.getID() == "armor.head.aketon_cap" || item.getID() == "armor.head.open_leather_cap" || item.getID() == "armor.head.full_aketon_cap" || item.getID() == "armor.head.full_leather_cap"))
					{
						stash[i] = null;
						this.List.push({
							id = 10,
							icon = "ui/items/" + item.getIcon(),
							text = "你失去了 " + item.getName()
						});
						break;
					}
				}

				local item = this.new("scripts/items/helmets/cultist_leather_hood");
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
		if (!this.Const.DLC.Wildmen)
		{
			return;
		}

		if (this.World.Assets.getOrigin().getID() != "scenario.cultists")
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getBackground().getID() == "background.cultist" || bro.getBackground().getID() == "background.converted_cultist")
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		local stash = this.World.Assets.getStash().getItems();
		local numItems = 0;

		foreach( item in stash )
		{
			if (item != null && (item.getID() == "armor.head.hood" || item.getID() == "armor.head.aketon_cap" || item.getID() == "armor.head.open_leather_cap" || item.getID() == "armor.head.full_aketon_cap" || item.getID() == "armor.head.full_leather_cap"))
			{
				numItems = ++numItems;
			}
		}

		if (numItems == 0)
		{
			return;
		}

		this.m.Tailor = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = numItems * 5;
	}

	function onPrepare()
	{
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"randomcultist",
			this.m.Tailor.getNameOnly()
		]);
	}

	function onClear()
	{
		this.m.Tailor = null;
	}

});

