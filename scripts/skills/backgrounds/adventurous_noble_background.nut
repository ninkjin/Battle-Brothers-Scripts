this.adventurous_noble_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.adventurous_noble";
		this.m.Name = "冒险贵族";
		this.m.Icon = "ui/backgrounds/background_06.png";
		this.m.BackgroundDescription = "冒险贵族往往有很高的决心和近战技能，但经常不重视远程防御。";
		this.m.GoodEnding = "冒险的精神从不离开像%name%这样的男人。{比起回到他的贵族家庭，他选择离开%companyname%并向东搜寻奇珍异兽。有传言说他回到的城镇并带回了一个脑袋，看起来仿佛是属于一个巨大的蜥蜴，但你不相信这样奇幻之旅。 | 他离开了%companyname%并向西探险，航行穿越海洋前往未知的土地。现在谁也不知道他在哪里，但你毫不怀疑某一天他会带着故事回来。 | 他从%companyname%退休，但并没有回到他的贵族家庭，而是前往了南方。有传言说他参加了一场宏大的贵族内战，杀死了一个兽人军阀，登上了这片土地上最高的山，并且目前正在将他的旅行编纂成史诗。 | 这个贵族离开了%companyname%，由于比起贵族琐事更喜欢冒险生活，他前往了北方。有传言说他正率领着一队探险家前往世界的最远处。}";
		this.m.BadEnding = "%name%离开了%companyname%并到别处继续他的冒险旅程。{他向东前进，希望能发现绿皮的来源，但自那以后就再也没有听到过这位贵族的消息。 | 他向北进入蛮荒的雪原。有传言说他在一周前被看到了，只是这次是在向南前进，看起来苍白无比并且拖着身子晃动着。 | 他向南走入残酷的沼泽。有传言说迷雾中出现了神秘的火焰并且他向其走了过去。目击这个场面的人说他消失在了雾里并且再也没有回来。 | 他向西航行大海。尽管没有海上经验，但他觉得自己可以当船长。据说之后他的船的碎片还有水手不停的被冲上海岸，持续了数周之久。}";
		this.m.HiringCost = 150;
		this.m.DailyCost = 25;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_beasts",
			"trait.clubfooted",
			"trait.irrational",
			"trait.hesitant",
			"trait.drunkard",
			"trait.fainthearted",
			"trait.craven",
			"trait.dastard",
			"trait.fragile",
			"trait.insecure",
			"trait.asthmatic",
			"trait.spartan"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.TidyMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.Names = this.Const.Strings.KnightNames;
		this.m.Level = this.Math.rand(1, 3);
		this.m.IsCombatBackground = true;
		this.m.IsNoble = true;
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
		return "作为{一位小贵族 | 第三顺位继承人 | 一位年轻而傲慢的贵族 | 一位熟练的剑客}，%name%的宫廷生活{对他而言开始变得枯燥 | 对他而言不够刺激，没完没了地学习宫廷礼仪和他家族血统令他倍感无聊 | 让他觉得是在浪费生命中最美好的年华 | 对他而言还不如冒险、战斗、需要铲除的野兽和等待征服的美女这种故事一半有趣。}。{骄傲地穿戴着家族徽章 | 在他兄长的鼓励下 | 令他母亲沮丧的是 | 终于下定决心要做出改变}，%name%离开了宫廷去{证明自己 | 打出自己的名声 | 在战场上获得荣耀 | 测试自己的战斗技巧} 并且 {像他在城堡墙壁之后想象的那样享受生活 | 看遍世界上所有的奇观和奇异的地方 | 赢得他在世界上的地位 | 因英勇而受到册封 | 获得美名受到全世界爱慕 | 恶名昭彰收到全世界畏惧}。";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				15,
				20
			],
			Stamina = [
				0,
				5
			],
			MeleeSkill = [
				10,
				10
			],
			RangedSkill = [
				0,
				0
			],
			MeleeDefense = [
				5,
				8
			],
			RangedDefense = [
				-10,
				-5
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
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/arming_sword"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/winged_mace"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/weapons/hand_axe"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/shields/heater_shield"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/shields/kite_shield"));
		}

		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/mail_shirt"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/basic_mail_shirt"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/mail_hauberk"));
		}

		r = this.Math.rand(0, 4);

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
			items.equip(this.new("scripts/items/helmets/nasal_helmet_with_mail"));
		}
		else if (r == 3)
		{
			items.equip(this.new("scripts/items/helmets/mail_coif"));
		}
	}

});

