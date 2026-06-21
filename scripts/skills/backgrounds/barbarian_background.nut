this.barbarian_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.barbarian";
		this.m.Name = "野蛮人";
		this.m.Icon = "ui/backgrounds/background_58.png";
		this.m.BackgroundDescription = "";
		this.m.GoodEnding = "野蛮人%name%带上所有他跟着战团赚取的金币向北探险。他用他的钱募集了一队战士并征服了非常多的部落，甚至据最新消息说，他已经被尊为'北方之王’了。";
		this.m.BadEnding = "在当时那种情况下%name%离开了。最后听到的消息是他在向北旅行。一贫如洗，默默无闻，只有一把斧头，长得不像当地人也不会他们的语言，你想这个野蛮人走不远。依照你过往看到的他这类人的遭遇，他要么已经被杀，要么就是被捕为奴隶了。";
		this.m.HiringCost = 200;
		this.m.DailyCost = 20;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_undead",
			"trait.night_blind",
			"trait.ailing",
			"trait.asthmatic",
			"trait.clubfooted",
			"trait.hesitant",
			"trait.loyal",
			"trait.tiny",
			"trait.fragile",
			"trait.clumsy",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.insecure"
		];
		this.m.Titles = this.Const.Strings.BarbarianTitles;
		this.m.Faces = this.Const.Faces.WildMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.WildExtended;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 4);
		this.m.IsCombatBackground = true;
	}

	function getTooltip()
	{
		return [
			{
				id = 1,
				type = "title",
				text = this.getName()
			},
			{
				id = 2,
				type = "description",
				text = this.getDescription()
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name%在你和他战士部落间的战斗中幸存了下来。他愿意为你的战团或你的剑效忠。由于对他的勇敢印象深刻，你决定收留他。他是个外族蛮人，几乎不会说你的母语，战团里的其他人也不怎么喜欢他。但如果有什么能让两个男人关系紧密起来的话，那无疑是并肩战斗，必要时一起杀戮，以及在酒馆里通宵喝酒。}";
	}

	function onAdded()
	{
		if (this.m.IsNew)
		{
			this.getContainer().getActor().setName(this.Const.Strings.BarbarianNames[this.Math.rand(0, this.Const.Strings.BarbarianNames.len() - 1)]);
		}

		this.character_background.onAdded();
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoos = [
			3,
			4,
			5,
			6
		];

		if (this.Math.rand(1, 100) <= 66)
		{
			this.m.Tattoo = tattoos[this.Math.rand(0, tattoos.len() - 1)];
			local tattoo_body = actor.getSprite("tattoo_body");
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 66)
		{
			local tattoo_head = actor.getSprite("tattoo_head");
			tattoo_head.setBrush("tattoo_0" + tattoos[this.Math.rand(0, tattoos.len() - 1)] + "_head");
			tattoo_head.Visible = true;
		}
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("tattoo_0" + this.m.Tattoo + "_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				10,
				5
			],
			Bravery = [
				10,
				5
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				10,
				5
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				0,
				0
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				5,
				10
			]
		};
		return c;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 3);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/axehammer"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/crude_axe"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/barbarians/blunt_cleaver"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/barbarians/thick_furs_armor"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/barbarians/reinforced_animal_hide_armor"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/barbarians/hide_and_bone_armor"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/barbarians/scrap_metal_armor"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/bear_headpiece"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/leather_headband"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/barbarians/leather_helmet"));
		}
	}

	function onSerialize( _out )
	{
		this.character_background.onSerialize(_out);
		_out.writeU8(this.m.Tattoo);
	}

	function onDeserialize( _in )
	{
		this.character_background.onDeserialize(_in);
		this.m.Tattoo = _in.readU8();
	}

});

