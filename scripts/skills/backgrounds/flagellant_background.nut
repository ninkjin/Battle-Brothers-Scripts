this.flagellant_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.flagellant";
		this.m.Name = "苦修者";
		this.m.Icon = "ui/backgrounds/background_26.png";
		this.m.BackgroundDescription = "苦修者对他们的所作所为抱有很高的决心，并且对疼痛有很高的容忍度，然而他们的作为往往让他们的身体伤痕累累。";
		this.m.GoodEnding = "作为团队中最令人不安的成员之一，苦修者%name%至少放下鞭子足够长的时间来拿起刀攻击你的敌人。虽然他是一个有能力的雇佣兵，但他的习惯正越来越明显的将要害死他。在某个晚上进行残酷的自我否定之后，战团再次发现这个人昏迷不醒，并几乎失血而死。为了从%name%自己的手中挽救他，战团把这个苦修者留在了一个修道院里，他最终在痛苦中醒来。一位慈祥的僧侣照料他恢复健康，教导他温和的宗教方法。直到今天，%name%仍行走在回廊中，与年轻人温和的对话，使他们远离野蛮的精神修行。";
		this.m.BadEnding = "由于战团迅速衰落，许多佣兵采取了绝望的手段，而苦修者%name%就是手段之一。由于混乱和困惑，一些人开始相信%name%可以带领他们获得荣誉和救赎。一部分%companyname%的幸存者脱离了出去并发疯了，加入了他的野蛮精神修行的教派中。在他们首领%name%的带领下，这些皈依者漫无目的地游荡，身躯佝偻，背着生皮。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 6;
		this.m.Excluded = [
			"trait.weasel",
			"trait.clubfooted",
			"trait.tough",
			"trait.strong",
			"trait.disloyal",
			"trait.insecure",
			"trait.cocky",
			"trait.fat",
			"trait.fainthearted",
			"trait.bright",
			"trait.craven",
			"trait.greedy",
			"trait.gluttonous"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsOffendedByViolence = true;
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
		return "{众神怜悯人类，驱使着去多人去寻求他们的青睐，%name%也不例外。 | 目不识丁且出身贫寒，%name%在诸神的传说中找到了慰藉。 | 作为一个一向好读书的人，没过多久%name%就发现了诸神的文字。 | 有人说神灵会跟我们说话，如果是真的，他们一定对%name%说过。 | 随着新的邪教在荒野中涌现，%name%又回到对诸神熟悉的信仰中。 | 由激进的父亲抚养长大的，%name%早年大部分时间都在护理因鞭打而造成的伤口，诸神会赞许这一点的。}{当战争降临到这片土地上时，诸神告诉他要为更大的正义而战。 | 当邪教分子像老鼠传播恶疾一样传播他们的秽语时，%name%认为应该拿起武器与异端邪说作斗争。 | 他偏离了信仰，在%randomtown%犯下了一桩可怕的罪行，和一个男人成了床伴。他不仅每晚鞭打自己，同样也寻求救赎。 | 只需听到关于圣地哪怕捕风捉影的传言，朝圣者都会拿起手杖和物资前去寻找。 | 现在战争又回到了这片土地上，诸神的虔诚信徒希望通过祈祷和肉体鞭笞来找出原因。 | 在山洞里度过的一个晚上，信徒被展示了诸神想要见血。%name%不是会拒绝诸神召唤的人。 | 在掠夺者洗劫了他教堂的金库后，%name%的任务是重新装满神圣的钱包。}{当宇宙法则向吞世的战争屈服时，一个像%name%这样的奇术士也许会有用。 | 他带着一根带绑着碎玻璃的皮鞭，声称这不是为了敌人而是为了纯洁准备的，真有意思。 | 他声称痛恨邪恶，但只要一点克朗就可以说服%name%把任何东西认作'邪恶'。 | 这个人寻求艰难的道路，毫不奇怪他认为加入一个佣兵团是合适的。 | 如果%name%有足够的力量，你相信他会净化整个世界。谢天谢地，他只是个普通人。 | 尽管关于神的言语可能有点烦人，%name%狂暴的激情很适合战场。 | 对诸神的世界如此着迷，毫不奇怪这个朝圣者眼中的真实的世界充满了敌人。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-5
			],
			Bravery = [
				12,
				12
			],
			Stamina = [
				5,
				10
			],
			MeleeSkill = [
				0,
				0
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
				0,
				0
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		this.updateAppearance();
	}

	function updateAppearance()
	{
		local actor = this.getContainer().getActor();
		local body = actor.getSprite("body");
		local tattoo_body = actor.getSprite("tattoo_body");
		tattoo_body.setBrush("scar_01_" + body.getBrush().Name);
		tattoo_body.Color = body.Color;
		tattoo_body.Saturation = body.Saturation;
		tattoo_body.Visible = true;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.PilgrimTitles[this.Math.rand(0, this.Const.Strings.PilgrimTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_flail"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/reinforced_wooden_flail"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}

		if (r == 3)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}

		if (r == 4)
		{
			items.equip(this.new("scripts/items/armor/monk_robe"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
	}

});

