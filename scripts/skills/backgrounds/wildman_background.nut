this.wildman_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {
		Tattoo = 0
	},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.wildman";
		this.m.Name = "野人";
		this.m.Icon = "ui/backgrounds/background_31.png";
		this.m.BackgroundDescription = "野人习惯了只有强者才能胜出的野外艰苦生活。他们不太习惯城市的生活，在那里被精明和诡诈所主宰。";
		this.m.GoodEnding = "当%companyname%前往一座城镇休息和恢复时，当地的一位公主喜欢上了野蛮人%name%。他被以一大笔钱'购买'并送给了那位贵族女士。你最近去探望了这个人，晚餐时他坐在一张国王级别的桌子边上，傻笑着模仿着周围的贵族。他令人费解的的新妻子很喜欢他，他也很喜欢她。当你告别时，他想把头上那顶沉重的金冠给你。它承载着传统和古老的历史，你说最好让他自己保管。这个野人耸了耸肩，一边转身离开一边用手指转着金冠。";
		this.m.BadEnding = "%name%这个野人在瓦解中的%companyname%继续待了一段时间，然后就这样离开了。战团在森林中四处寻找他，最终发现了某种简陋的信息：在一堆沉甸甸的克朗旁边，泥土上画着一幅%companyname%及其部分成员的画，他们所有人都被一个带着傻笑的木头人拥抱着。那里还有一只吃了一半的死兔子作为祭品。";
		this.m.HiringCost = 100;
		this.m.DailyCost = 12;
		this.m.Excluded = [
			"trait.weasel",
			"trait.teamplayer",
			"trait.fear_beasts",
			"trait.hate_undead",
			"trait.paranoid",
			"trait.night_blind",
			"trait.ailing",
			"trait.clubfooted",
			"trait.fat",
			"trait.tiny",
			"trait.gluttonous",
			"trait.pessimist",
			"trait.optimist",
			"trait.short_sighted",
			"trait.dexterous",
			"trait.insecure",
			"trait.hesitant",
			"trait.asthmatic",
			"trait.greedy",
			"trait.fragile",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.bright",
			"trait.cocky",
			"trait.dastard",
			"trait.drunkard"
		];
		this.m.Titles = [
			"蛮子",
			"边缘人",
			"野人",
			"野化人",
			"荒野人",
			"野蛮人"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.WildMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Wild;
		this.m.BeardChance = 100;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(1, 2);
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
				id = 15,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.NegativeValue + "]-15%[/color]经验获取"
			}
		];
	}

	function onBuildDescription()
	{
		return "{对某些人来说，野外是一个庇护所。 | 据说人生来内心就充满了狂野，而背弃这点是错误的。 | 文明是一个污点，是一代代长久不停的军备竞赛，只为了更好的与终极敌人战斗，也就是大自然母亲本身。 | 在战争时期，毫不奇怪许多人又跑到野外去避难了。 | 有些人从一个城镇逃到另一个城镇，而另一些人停在中间，消失在宁静的森林里。}{%name%曾经在树林中找到了一个安全的居住地，但那段日子已经过去了。 | 曾经是猎人眼中的神秘人物，著名的马斯基瓦萨特，%name%现在因不明的原因而重返文明。 | %name%有铁匠般的手，但猪圈般的卫生水平。 | 也许是被爱抛弃，也许只是战争，%name%在过去的十年里远离了其他人。 | 可能曾是个偷猎者，在他狩猎的地方定居下来，%name%已经树林中生活了不知多少年。 | 穿着巧妙缝合的衣服，%name%的返祖形象可能掩盖了一段作为裁缝或制革匠的过去。}{这个野人有明显的语言障碍，但出于某种原因他似乎非常愿意战斗。希望他新发现的'召唤'后面没藏着什么更黑暗的目的。 | 五颜六色的仪式符号永久的包裹着他的身体。当被问到他为什么想加入一个佣兵团时，他一边叫一边用弯曲的手指在天空中比划他新奇的艺术。 | 旧伤和新伤点缀着他斑驳的身体，而且不是皮外伤，这个人在野外曾和一些凶猛的东西搏斗。 | 令人好奇的是，那些把他赶到森林里的灾难，是不是又把他赶出了森林。 | 从他狂野的咕哝声判断，他是来重返文明的这点很值得怀疑。 | 多年的隐居生活并没有让这个人忘记一些克朗带来什么。问题是他为什么回来？ | 他有力气和野猪摔跤，他身上的众多伤疤让你怀疑他是不是真的做过。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				12,
				10
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				18,
				23
			],
			MeleeSkill = [
				6,
				0
			],
			RangedSkill = [
				-5,
				0
			],
			MeleeDefense = [
				-5,
				0
			],
			RangedDefense = [
				-5,
				-5
			],
			Initiative = [
				-5,
				-5
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
		this.m.Tattoo = this.Math.rand(0, 1);
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");
		local body = actor.getSprite("body");
		tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		tattoo_body.Visible = true;
		tattoo_head.setBrush(this.m.Tattoo == 0 ? "warpaint_01_head" : "scar_02_head");
		tattoo_head.Visible = true;
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");

		if (tattoo_body.HasBrush)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush((this.m.Tattoo == 0 ? "warpaint_01_" : "scar_02_") + body.getBrush().Name);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(0, 7);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
			}
			else if (r == 3)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
			}
			else if (r == 4)
			{
				items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
			else if (r == 6)
			{
				items.equip(this.new("scripts/items/weapons/two_handed_wooden_hammer"));
			}
			else if (r == 7)
			{
				items.equip(this.new("scripts/items/weapons/two_handed_wooden_flail"));
			}
		}
		else
		{
			r = this.Math.rand(0, 6);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/hatchet"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/wooden_stick"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_metal_club"));
			}
			else if (r == 3)
			{
				items.equip(this.new("scripts/items/weapons/greenskins/orc_wooden_club"));
			}
			else if (r == 4)
			{
				items.equip(this.new("scripts/items/weapons/boar_spear"));
			}
			else if (r == 5)
			{
				items.equip(this.new("scripts/items/weapons/woodcutters_axe"));
			}
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 0.85;
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

