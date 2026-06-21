this.bastard_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.bastard";
		this.m.Name = "私生子";
		this.m.Icon = "ui/backgrounds/background_37.png";
		this.m.BackgroundDescription = "私生子们经常接受过一定程度的近战训练。";
		this.m.GoodEnding = "{作为一个不怎么顾及家族利益的贵族造出的私生子，%name%离开了%companyname%并尝试创立自己的家族。据最新的消息说，他已经取得了一块好地并且上面有一座中规中矩的石堡。尽管很成功，他仍然对自己的家族怀有怨恨。 | 作为一个贵族私生子，%name%总是觉得自己并不属于这个世界。但%companyname%让他有了可以称之为家庭的兄弟情谊。据你所知，他至今仍在和战团一起战斗。}";
		this.m.BadEnding = "像%name%这样的私生子通常在这个世界上走不远。他们在他们所居住的贵族世界中受到憎恨，在平民中也因为平民不了解那些使私生子比任何贵族都更贴近平民的政策而受到憎恨。在你离开战团后不久，你听闻了%name%去世的消息。很明显，一个年轻而残忍的领主接管了他的贵族家庭，并将这个私生子视为对自己地位的威胁。尽管这个私生子不再想涉足那种生活，但那种生活还是逮到了他。他在旅馆床上被暗杀，喉咙在他熟睡时被割开。";
		this.m.HiringCost = 110;
		this.m.DailyCost = 14;
		this.m.Excluded = [
			"trait.teamplayer",
			"trait.ailing",
			"trait.clumsy",
			"trait.fat",
			"trait.tiny",
			"trait.hesitant",
			"trait.bleeder",
			"trait.dastard",
			"trait.asthmatic"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.Tidy;
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
			}
		];
	}

	function onBuildDescription()
	{
		return "{%name%在一次距离他父亲家甚远的焦灼军事战役中出生。 | %name%的母亲从%randomtown%的一家酒馆向他寄信问好。这很奇怪，因为他的父亲是%townname%的一个已婚贵族。 | 由于妻子被女巫诅咒，%name%的父亲将自己交给另一个女人来'延续'血脉。 | 国王离开的实在太久，%name%的王后母亲根本没法抵挡一个当地佣人的诱惑。 | %name%在劫掠者洗劫他父母的城堡九个月后出生。}{一个私生子的生活并不容易：这个人经常被善妒的嫡出兄弟们欺负。 | 就像某些得了麻风病的贵族一样，这个私生子被从公众视线中隐藏了起来。 | 幸运的是，%name%活到现在大部分时间都不知道自己是私生子。 | 在出生时就引起争论，%name%没有被抛弃全靠当地神谕的一则谕示。 | 作为贵族私生子他能得到良好的生活，但前提是他必须低调，尤其让他那不受欢迎的身份更加低调。 | 遭受陌生人和家族一致的憎恨使这个私生子准备好了去面对贵族家庭外不可避免的苦难。}{因对自己在生活中的角色感到愤怒，%name%确实尝试了政变篡位。但还没开始多久就失败了，现在他被大陆上所有宫廷所驱逐。 | 当一个嫡出兄弟向他扔石头时，%name%毫无罪恶感的用剑刺穿了他。他将其归咎于一个仆人，但之后很快离开了他的贵族家宅。 | %name%的父亲试图将他伪装成合法子嗣，但当一次贵族联姻落空后，随之而来丑闻曝光拆穿了一切。这个私生子现在在这片土地上游荡，摆脱了争议的束缚。 | 身为长子使%name%成了合法弟弟们的目标，远离那种充满政治和背刺的生活是个很容易做出的选择。 | 被发现与嫡出妹妹同床共枕，%name%生活中的丑闻最终使得他无法留在宫廷之内。 | 厌倦了宫廷内的琐事后，%name%只想加入一伙不在乎他血脉和合法性的人。 | 当一个刺客在他父亲的酒中下毒之后，%name%很快就被认为是谋杀的罪魁祸首。逃离一群愤怒的暴民只是刺激的新生活的开幕。 | 尽管深爱着他，%name%的父亲知道宫廷内并不安全。因此他把这个私生子送了出来，让他用自己的方式打造生活。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				-5,
				-5
			],
			Stamina = [
				0,
				0
			],
			MeleeSkill = [
				5,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				-5,
				5
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

		if (this.Math.rand(0, 4) == 4)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.BastardTitles[this.Math.rand(0, this.Const.Strings.BastardTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/falchion"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/shortsword"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/wooden_shield"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/nasal_helmet"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/padded_nasal_helmet"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

