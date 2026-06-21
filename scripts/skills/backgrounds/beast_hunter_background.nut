this.beast_hunter_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.beast_slayer";
		this.m.Name = "野兽杀手";
		this.m.Icon = "ui/backgrounds/background_57.png";
		this.m.BackgroundDescription = "野兽杀手能熟练且专业的在各种距离猎杀野兽及怪物。";
		this.m.GoodEnding = "%name%从战团退役并购买了一处废弃城堡的地契。以那里为基础，他指挥着一支野兽杀手的队伍，穿行于大陆并保护其免受怪兽侵袭。你最后一次和他谈话时，他有一位对你不怎么友好的黑发女友，而她对其他人也都差不多这样。你确信他很开心。";
		this.m.BadEnding = "离开了%companyname%之后，%name%彻底放弃了猎杀野兽的工作并且你听说他有了一个患白化病的女儿。不幸的是，关于这个女孩有超自然的力量的传言迅速流传，她的母亲遭到火刑处死了。父亲和孩子则没被抓到，也再也没被人看到过。";
		this.m.HiringCost = 150;
		this.m.DailyCost = 15;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.weasel",
			"trait.fear_beasts",
			"trait.ailing",
			"trait.bleeder",
			"trait.dumb",
			"trait.fragile",
			"trait.night_blind",
			"trait.clubfooted",
			"trait.brute",
			"trait.short_sighted",
			"trait.fat",
			"trait.clumsy",
			"trait.gluttonous",
			"trait.asthmatic",
			"trait.craven",
			"trait.dastard"
		];
		this.m.Titles = [
			"野兽猎人",
			"林语者",
			"野兽杀手",
			"追踪者",
			"部件猎手",
			"猎人"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Level = this.Math.rand(2, 3);
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
		return "{{%name%的过去一点都不奢华。 | %name%曾经在这附近旅行过一段时间，但并不一直在从事目前的职业。 | 尽管他的工作让人害怕，%name%之前的生活并不特别。 | 一份长长的已击败的野兽列表以及用以证明的兽皮让人对%name%的背景产生误解。} {这名野兽杀手曾经只是一个简单的猎人，兼具弓箭技艺及智慧。然而当他在自己设置的陷阱中发现了一只怪物般的恐狼时，他开始喜欢追猎更危险的猎物。 | 当他的村庄不断受到织网蛛的攻击时，他开始学习一切他能学到的猎杀野兽的技术，并且随后成功的实践了。 | 据说他曾经是一个村庄的磨坊工，直到梦魔袭扰了整个村庄。他从来都不怎么嗜睡，于是每晚都开始研究这些怪兽直到成功收拾了它们。 | 他曾经是当地领主的猎物搜寻者。但是在一次打猎出了岔子并迎头撞上巨魔之后，这个人转而研究野兽以及如何杀死它们。 | 曾经只是一个普通的伐木工，他在同伴都被一棵活树也就是树人屠杀后变成了野兽杀手，之后他为同伴报了仇并誓言去了解关于怪兽的一切。 | 曾经是一名僧侣，当食尸鬼袭击了他所在修道院后，他转而研究野兽和剑术。} {然而时代正在改变，即便是这位熟练的怪兽猎人也独木难支。因此他寻求加入一个战团并尽可能多的杀死野兽。 | 日间变得反常的短，而月亮每晚都发出明亮的光芒。这名野兽杀手感受到了情况的变化。如果需要对付将要到来的东西，只靠他自己可不太行。 | 虽然并不喜欢结伴，但是如果这名野兽杀手想要杀死尽可能多的野兽，他还是需要一些优秀的兄弟来帮忙。 | 在这个变得越来越危险和绝望的世界里，这名野兽杀手同时寻求着金钱和伙伴。 | 这样一名职业熟手对于一个佣兵团来说有着巨大的用途，你毫不怀疑他会勤奋地杀敌。 | 不幸的是，他作为学徒收留的一个孩子被恐狼杀死，现在这名伤心的野兽杀手正寻求更稳固的伙伴。}}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				3
			],
			Bravery = [
				13,
				10
			],
			Stamina = [
				5,
				7
			],
			MeleeSkill = [
				5,
				5
			],
			RangedSkill = [
				11,
				7
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
				7,
				5
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local tattoo_body = actor.getSprite("tattoo_body");
		local tattoo_head = actor.getSprite("tattoo_head");

		if (this.Math.rand(1, 100) <= 75)
		{
			local body = actor.getSprite("body");
			tattoo_body.setBrush("scar_02_" + body.getBrush().Name);
			tattoo_body.Visible = true;
		}

		if (this.Math.rand(1, 100) <= 75)
		{
			tattoo_head.setBrush("scar_02_head");
			tattoo_head.Visible = true;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/hunting_bow"));
			items.equip(this.new("scripts/items/ammo/quiver_of_arrows"));
			items.addToBag(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/boar_spear"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/weapons/spetum"));
		}
		else if (r == 4)
		{
			items.equip(this.new("scripts/items/weapons/javelin"));
		}

		if (this.Math.rand(1, 100) <= 50 && items.getItemAtSlot(this.Const.ItemSlot.Offhand) == null)
		{
			items.equip(this.new("scripts/items/tools/throwing_net"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/ragged_surcoat"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/thick_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hood"));
		}
		else if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/hunters_hat"));
		}
	}

});

