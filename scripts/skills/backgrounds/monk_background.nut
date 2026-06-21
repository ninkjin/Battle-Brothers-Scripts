this.monk_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.monk";
		this.m.Name = "僧侣";
		this.m.Icon = "ui/backgrounds/background_13.png";
		this.m.BackgroundDescription = "僧侣往往有很高的决心，但不习惯于体力劳动或战争。";
		this.m.GoodEnding = "僧侣%name%退休后回归了平静的精神职责。他目前身在山中寺院，享受着宁静并反思着自己在雇佣军战团的时光。其他僧侣因他曾经的战斗和杀戮而憎恶他，但他正在撰写一本将影响世界的书，讲述和平与暴力之间的平衡。";
		this.m.BadEnding = "在经历了一次精神崩溃后，%name%退休并在一座修道院中找到了归所。他所有的教友和修道院长都因为他参与了那样暴力的冒险而排斥他。据说他某次被偷捐款箱被司事抓住后，最终被流放了。";
		this.m.HiringCost = 60;
		this.m.DailyCost = 5;
		this.m.Excluded = [
			"trait.weasel",
			"trait.hate_beasts",
			"trait.swift",
			"trait.impatient",
			"trait.clubfooted",
			"trait.brute",
			"trait.gluttonous",
			"trait.disloyal",
			"trait.cocky",
			"trait.quick",
			"trait.dumb",
			"trait.superstitious",
			"trait.iron_lungs",
			"trait.craven",
			"trait.greedy",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"虔诚者",
			"僧侣",
			"学者",
			"传道者",
			"虔信者",
			"宁静者",
			"平静者",
			"信徒"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.Monk;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Monk;
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
		return "{在掠夺者杀害了他的家人后，%name%退身于宗教中寻求慰藉，并在附近的一个修道院成为了僧侣。 | %name%经常离开他的教堂及其他僧侣，在数年间一直向偏远村庄的农民传教。 | 作为一个安静的僧侣，%name%花费了数不清的日子在%townname%的修道院里朝拜旧神。 | 作为众多僧侣中的其中一个，%name%曾经在%randomtown%的尖顶寺庙中游荡。 | %name%被遗弃在修道院的台阶上，在僧侣的陪伴下长大，很快就接受了他们的生活方式。 | 为了在一片荒芜的废墟上寻求安宁，%name%成为了一名僧侣。 | %name%一直是个不听话的孩子，他的父母把他交给了当地的修道院，在那里他很快成为了一个安静的僧侣。}{不幸的是，他的院长对年轻肉体的癖好导致了严重的丑闻。%name%为了保住小命和他的信仰逃离了。 | 当掠夺者的恶毒袭击使男人被阉割，女人被强奸，孩子被叉在草叉上时，他的信仰被彻彻底底的毁灭了。 | 尽管他信仰旧神，但他无法忍受他的院长以神的名义犯下的暴行。这个僧侣最终离开了，以自己的方式寻求精神修行。 | 随着世界苦难的加剧，%name%的院长要求他出去医治天下的人们，或者消灭那些做错事的人。 | 崇拜死亡的教团，恶梦般的野兽，以及残忍的人类。%name%离开了神殿的大厅去净化这一切。 | 当一个孩子问了他一个使信仰破碎的问题时，%name%放弃了他的信仰，改用其它方式去追寻精神修行。 | 不幸的是，祈祷并没有使他的教友免于屠杀。%name%意识到自食其力比起对着神念叨要好得多。 | %name%一直充满着热情，他离开修道院的庇护去'纠正'外面的世界。 | 作为附近少数有文化其中一个人，%name%放弃了修士生活去见识世界，如果可能的话，顺便去治愈让世界病态的原因。 | 但有一天晚上一个女人跟他上了床。他醒来时，信仰在周围皱巴巴的被单上碎裂了。由于羞愧异常，他再也没返回他的修道院。 | 但他利用自己被信任的地位谋取不义之财，从神殿的宝库中偷窃。没多久就爆发了丑闻把他赶走了。 | 不幸的是，一个孩子指责他有不配僧侣身份的行为。没有人知道这个故事背后的真相，但%name%没法再呆在教堂了。 | 一天晚上，他在一本旧书中发现了一个糟糕的事实。不久之后，%name%迅速离开了教堂，决口不提他发现了什么。}{这个人对战斗几乎一无所知，但他有着如同抵御风暴的高山般坚毅的信念。 | 多年的孤独和祈祷使%name%身材走样，但他坚定的信念才是最有价值的。 | 也许他从来没有真正满足于他的生活，很难完全知道为什么像%name%这样的人会加入佣兵团。 | 也许这个世界上有太多的恶魔，或者他内心有太多的恶魔，但是你是不会询问%name%为什么想要加入一支佣兵团的。 | 信仰虽无法斩杀绿皮，但也不会让像%name%这样的人从绿皮身边逃跑。 | %name%宣称想要清除世界上的'不信者'，其决心坚定的让人害怕。 | 虽然%name%的精神修行值得称赞，但不停的对旧神念叨实在有些烦人。 | 虽然%name%的双手比起握住剑柄更适合合十祈祷，但很少有佣兵有像他那样的决心。 | 死死的拿着一本圣书，%name%寻求着与雇佣兵为伍。 | 他随身携带的圣书厚到可以当盾牌用，但是当你大声说出这个想法时，%name%看起来绝对吓坏了。 | 也许因为浪漫的认为佣兵需要良好的精神净化，%name%寻求与佣兵相伴。 | 曾经在书中读到过战士牧师的事，%name%现在希望效仿那些勇敢、坚定的圣战士。 | 你感觉到%name%想要从这个罪恶的世界中解脱出来。如果那是真的，那么他来对地方了。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				11,
				11
			],
			Stamina = [
				-10,
				0
			],
			MeleeSkill = [
				-5,
				-5
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

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		items.equip(this.new("scripts/items/armor/monk_robe"));
	}

});

