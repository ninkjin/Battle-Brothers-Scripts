this.swordmaster_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.swordmaster";
		this.m.Name = "剑术大师";
		this.m.Icon = "ui/backgrounds/background_30.png";
		this.m.BackgroundDescription = "剑术大师在近身战斗上无可比肩，但在远距离上可能很脆弱。年龄可能对他的身体素质造成了影响，而且可能还会继续如此。";
		this.m.GoodEnding = "作为你见过的最优秀的剑士，老剑术大师%name%是%companyname%的天然补充。但是一个人不能永远战斗，尽管战团越来越成功，这位剑术大师的身体很明显已经撑不下去了。他退休到了一块不错的土地上并享受着属于自己的时光，或者你曾是这么以为的。你去看望这位老人的时候，发现他正在秘密地训练一位贵族的女儿。你发誓保守这个秘密。";
		this.m.BadEnding = "令人遗憾的是，剑术大师%name%的暮年时光被消耗在了一个衰落中的佣兵团中。他退休了，称他已经没有体力再继续了。你认为他只是为了不让%companyname%难堪，因为一周后他毫不费力地斩杀了10名想要打劫的强盗。据你最后听说，他正在训练那些不知感恩的王子们的剑术。";
		this.m.HiringCost = 400;
		this.m.DailyCost = 35;
		this.m.Excluded = [
			"trait.huge",
			"trait.weasel",
			"trait.fear_undead",
			"trait.fear_beasts",
			"trait.fear_greenskins",
			"trait.paranoid",
			"trait.impatient",
			"trait.clubfooted",
			"trait.irrational",
			"trait.athletic",
			"trait.gluttonous",
			"trait.dumb",
			"trait.bright",
			"trait.clumsy",
			"trait.tiny",
			"trait.insecure",
			"trait.fainthearted",
			"trait.craven",
			"trait.bleeder",
			"trait.dastard",
			"trait.hesitant",
			"trait.fragile",
			"trait.iron_lungs",
			"trait.tough",
			"trait.strong",
			"trait.bloodthirsty"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Titles = [
			"传奇",
			"老将",
			"大师"
		];
		this.m.Faces = this.Const.Faces.SmartMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Old;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(3, 5);
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
		return "{%name%战斗起来仿佛如鱼在水。 | %name%不仅仅是一个人的称呼，它是一个神话。一个用来代替战争、战斗和死亡的名字。 | 说'你的动作像%name%一样'也许是一个人能给予一个战士的最大荣誉。 | %name%被认为是这片土地上古往今来最危险的剑士之一。}{他的大部分生活都是包裹在神话之中：比如他怎样通过要求和一个国王以及他所有的卫士进行决斗，之后又只用一只手击败了他们，从而摧毁了一个王国。 | 据说，他在自己的花园里和20个人战斗，一边杀戮一边用同一把武器采摘和修剪西红柿。 | 有人说他被扔在了海上300天，在那里他一边在浮木上保持平衡，一边在学会了如何移动，如何战斗，如何生存。 | 有个故事说他的家人被谋杀了，他不知道是谁杀的。他想在遇到那些罪魁祸首时做好准备，他教会自己要善于用剑刃杀死任何人。 | 被独臂的父亲养大，他一开始就学会了如何在被限制的情况下战斗。当他开始用两只手战斗的时候，他已经能够用一只手杀死任何人。}{不幸的是，时间和年龄让%name%只剩下从前自己的一副躯壳。 | 在兽人入侵期间，%name%设法单枪匹马杀死了十几个绿皮。可悲的是，一个不可能完成的壮举并不是没有代价的：他的使剑手失去了三个手指，他的惯用脚的跟腱也被切断了。 | 可悲的是，一大群醉汉来到他的家里，他们每个人都希望通过杀死著名的剑士而声名狼藉。他把他们都杀了，然而是还是受了不可逆的伤。 | 传说他和一只体型巨大的邪恶野兽争吵。它挥了挥缺指的手，眨了眨带疤的眼睛否定了这个说法。 | 在教贵族如何战斗的时候，一场席卷整个领土的政变使得他不得不逃命。 | 受聘指导贵族继承人格斗技巧后，没过多久他就卷入了一个密谋和暗算的圈套中，不得不趁早离开。}{现在这位老剑士只想把他其余的战斗知识用在战场上。 | 虽然他已经没有了锋芒，但他仍然很危险，有人说在真打算在死之前找到一个学生。 | 虽然他可能是个武林高手，但他做出的每一个动作都能让那副老骨头啪嚓作响。 | 由于沮丧和失去目标，%name%融入他以前教过的那些人来寻求生存意义。 | 这人的防守牢不可破，能抵消所有攻击，但是他已经失去了反击的步伐。令人钦佩，亦令人遗憾。 | 给了他一把剑后，这名老将令人印象深刻地展示着旋转挥舞着它。当他把它插在地上时，他靠在剑柄上喘着气。也没那么令人印象深刻。 | 这个人的运动能力已经丧失了，但他的知识却把剑术变成了数学。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-12,
				-12
			],
			Bravery = [
				12,
				10
			],
			Stamina = [
				-15,
				-10
			],
			MeleeSkill = [
				25,
				20
			],
			RangedSkill = [
				-5,
				-5
			],
			MeleeDefense = [
				10,
				15
			],
			RangedDefense = [
				0,
				0
			],
			Initiative = [
				-10,
				-10
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
			actor.setTitle(this.Const.Strings.SwordmasterTitles[this.Math.rand(0, this.Const.Strings.SwordmasterTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;

		if (this.Const.DLC.Unhold)
		{
			r = this.Math.rand(0, 2);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
			else if (r == 2)
			{
				items.equip(this.new("scripts/items/weapons/fencing_sword"));
			}
		}
		else
		{
			r = this.Math.rand(0, 1);

			if (r == 0)
			{
				items.equip(this.new("scripts/items/weapons/noble_sword"));
			}
			else if (r == 1)
			{
				items.equip(this.new("scripts/items/weapons/arming_sword"));
			}
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/padded_leather"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/padded_surcoat"));
		}

		if (this.Math.rand(1, 100) <= 33)
		{
			items.equip(this.new("scripts/items/helmets/greatsword_hat"));
		}
	}

});

