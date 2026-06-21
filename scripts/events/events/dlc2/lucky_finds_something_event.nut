this.lucky_finds_something_event <- this.inherit("scripts/events/event", {
	m = {
		Lucky = null,
		FoundItem = null
	},
	function create()
	{
		this.m.ID = "event.lucky_finds_something";
		this.m.Title = "在途中…";
		this.m.Cooldown = 35.0 * this.World.getTime().SecondsPerDay;
		this.m.Screens.push({
			ID = "A",
			Text = "%terrainImage%{%lucky%这位幸运的雇佣军找到了一件有趣的东西。你问他是如何找到这个物品的。他耸了耸肩。%SPEECH_ON%{我走路的时候就踩到了它。简单吧。 | 我仰头看到一只鸟拉了一泡屎，正好没拉在我身上，我去看它拉到了哪里，然后就看到了这个。这只鸟拉了屎，你手里拿的就是这个。 | 我手指感觉到一阵刺痛，接着小弟子也是，然后我就开始四处寻找一些无聊的东西从而弥补过失，我看到它就在那里。 | 我看到一个马蹄铁只是随意扔在地上，想去捡它，接着底下就是这个。 | 你懂的，我看到一片四叶草在那里，想要放到我的包里，我已经有几十片了，当我去捡它的时候，就看到那个东西放在那里。相当不错，对吧？}%SPEECH_OFF%}",
			Image = "",
			List = [],
			Characters = [],
			Options = [
				{
					Text = "你真幸运。",
					function getResult( _event )
					{
						return 0;
					}

				}
			],
			function start( _event )
			{
				this.Characters.push(_event.m.Lucky.getImagePath());
				this.World.Assets.getStash().add(_event.m.FoundItem);
				this.List.push({
					id = 10,
					icon = "ui/items/" + _event.m.FoundItem.getIcon(),
					text = "你获得了" + this.Const.Strings.getArticle(_event.m.FoundItem.getName()) + _event.m.FoundItem.getName()
				});
			}

		});
	}

	function onUpdateScore()
	{
		if (!this.Const.DLC.Unhold)
		{
			return;
		}

		if (!this.World.getTime().IsDaytime)
		{
			return;
		}

		if (!this.World.Assets.getStash().hasEmptySlot())
		{
			return;
		}

		local brothers = this.World.getPlayerRoster().getAll();
		local candidates = [];

		foreach( bro in brothers )
		{
			if (bro.getSkills().hasSkill("trait.lucky"))
			{
				candidates.push(bro);
			}
		}

		if (candidates.len() == 0)
		{
			return;
		}

		this.m.Lucky = candidates[this.Math.rand(0, candidates.len() - 1)];
		this.m.Score = 5;
	}

	function onPrepare()
	{
		local item;
		local r = this.Math.rand(1, 19);

		if (r == 1)
		{
			item = this.new("scripts/items/weapons/militia_spear");
		}
		else if (r == 2)
		{
			item = this.new("scripts/items/armor/patched_mail_shirt");
		}
		else if (r == 3)
		{
			item = this.new("scripts/items/helmets/dented_nasal_helmet");
		}
		else if (r == 4)
		{
			item = this.new("scripts/items/helmets/mail_coif");
		}
		else if (r == 5)
		{
			item = this.new("scripts/items/helmets/cultist_hood");
		}
		else if (r == 6)
		{
			item = this.new("scripts/items/helmets/full_leather_cap");
		}
		else if (r == 7)
		{
			item = this.new("scripts/items/armor/ragged_surcoat");
		}
		else if (r == 8)
		{
			item = this.new("scripts/items/armor/noble_tunic");
		}
		else if (r == 9)
		{
			item = this.new("scripts/items/misc/ghoul_horn_item");
		}
		else if (r == 10)
		{
			item = this.new("scripts/items/weapons/knife");
		}
		else if (r == 11)
		{
			item = this.new("scripts/items/misc/wardog_armor_upgrade_item");
		}
		else if (r == 12)
		{
			item = this.new("scripts/items/armor_upgrades/joint_cover_upgrade");
		}
		else if (r == 13)
		{
			item = this.new("scripts/items/tools/throwing_net");
		}
		else if (r == 14)
		{
			item = this.new("scripts/items/weapons/throwing_spear");
		}
		else if (r == 15)
		{
			item = this.new("scripts/items/weapons/hatchet");
		}
		else if (r == 16)
		{
			item = this.new("scripts/items/weapons/lute");
		}
		else if (r == 17)
		{
			item = this.new("scripts/items/armor/thick_dark_tunic");
		}
		else if (r == 18)
		{
			item = this.new("scripts/items/armor_upgrades/mail_patch_upgrade");
		}
		else if (r == 19)
		{
			item = this.new("scripts/items/misc/paint_black_item");
		}

		if (item.getConditionMax() > 1)
		{
			item.setCondition(this.Math.max(1, item.getConditionMax() * this.Math.rand(10, 40) * 0.01));
		}

		this.m.FoundItem = item;
	}

	function onPrepareVariables( _vars )
	{
		_vars.push([
			"lucky",
			this.m.Lucky.getNameOnly()
		]);
		_vars.push([
			"finding",
			this.Const.Strings.getArticle(this.m.FoundItem.getName()) + this.m.FoundItem.getName()
		]);
	}

	function onClear()
	{
		this.m.Lucky = null;
		this.m.FoundItem = null;
	}

});

