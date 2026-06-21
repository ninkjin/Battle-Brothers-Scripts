this.witchhunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.witchhunter";
		this.m.Name = "女巫猎人";
		this.m.Icon = "ui/backgrounds/background_23.png";
		this.m.BackgroundDescription = "女巫猎人往往有一定的战斗经验，即使面对难以言喻的恐怖，他们的决心也往往不会被打破。";
		this.m.GoodEnding = "女巫猎人%name%最终听到了邪恶正在北方村庄传播的消息。他离开了%companyname%，之后一直在树立火刑堆，烧掉那些可怕的女巫。";
		this.m.BadEnding = "邪恶正在北方传播的消息从战团里吸引走了女巫猎人%name%。他带上了木桩、装有奇怪液体的小瓶和大量引火物后出发。一个月后一个农民发现他在北方荒原游荡，并且眼睛被抠出，嘴巴也被缝上。他的胸前被烙上了一个奇怪的符号，当农民碰它的时候两个人都爆炸了。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 13;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.hate_beasts",
			"trait.clubfooted",
			"trait.short_sighted",
			"trait.insecure",
			"trait.hesitant",
			"trait.craven",
			"trait.fainthearted",
			"trait.dumb",
			"trait.superstitious",
			"trait.drunkard"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 3);
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
			},
			{
				id = 14,
				type = "text",
				icon = "ui/icons/bravery.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+20[/color]进行对抗恐惧、恐慌、精神控制的士气检定时的决心。"
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name%有一天出现在了%townname%中，有人说是应邀于{地方议会 | 当地祭司}。 | %name%被熟知会在不同寻常的事情发生的地方出来，以及在夜晚最黑暗的时候外出行动。 | 作为一个沉默寡言、冷酷无情的人，%name%容易让周围的人感到不舒服甚至害怕。 | %name%这个名字在很多村子里都被知晓，因为他走遍了最需要他的才能的地方。}{他自称是女巫猎人。有着一整套奇特的工具，他在通过可怕的折磨使人在痛苦中忏悔他们与恶魔的罪恶联系方面有着大量经验。 | 他自称是一个女巫猎人，但只有迷信的傻瓜才会相信这个，以及买他那些荒谬故事的账。 | 他自称是女巫猎人，并且他声称看过了超凡的，能使不够格的人发疯的恐怖。 | 在他到达%townname%后，有传言说他正在狩猎恶魔崇拜者和午夜的生物，但没有人知道他此行的真正目的是什么。 | 在%townname%，他因为杀死了一位老妇人并被扔进地牢。事实证明，这名老妇是绑架和杀害3名婴儿的罪魁祸首，所以他又被释放了。 | 一连几个晚上，他都坐在%townname%的酒吧里，安安静静的观察每一位顾客，仿佛猎物上空盘旋的鸟一样，而他的十字弩从来不离手边。居民们对此感到不满，但他们不敢接近他。}{现在大多数当地人都希望%name%早日离开，并乐于看到他加入一个旅行中的佣兵团。 | 看起来不管他的任务是啥，现在都已经完成了，所以%name%愿意作为佣兵效力。 | 很明显%name%不容易被吓到，并且他也知道如何使用弩。因此当他靠近正在招人的佣兵团时没人感到惊讶。 | 现在，一个佣兵团正是他完成对抗超凡邪恶的任务所需要的工具。 | 大多数人都很乐意摆脱他。}";
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 25)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 25)
		{
			tattoo_head.setBrush("scar_02_head");
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
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
		}
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				0,
				0
			],
			RangedSkill = [
				15,
				8
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
				0,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.WitchhunterTitles[this.Math.rand(0, this.Const.Strings.WitchhunterTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/light_crossbow"));
		}
		else
		{
			items.equip(this.new("scripts/items/weapons/crossbow"));
		}

		items.equip(this.new("scripts/items/ammo/quiver_of_bolts"));
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}

		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/witchhunter_hat"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.MoraleCheckBravery[1] += 20;
	}

});

