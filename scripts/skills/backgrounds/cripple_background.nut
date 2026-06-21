this.cripple_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.cripple";
		this.m.Name = "残废";
		this.m.Icon = "ui/backgrounds/background_51.png";
		this.m.BackgroundDescription = "残废唯一快的就是一场真正战斗中的按预期死亡的速度。";
		this.m.GoodEnding = "你很惊讶像%name%这样的残废居然能生存下来，但他确实带着一笔可观的克朗从%companyname%退休了。如今他经营了一家孤儿院，用他的克朗帮助这个世界上那些破碎和被遗弃的孩子们。这或许也只是廉价劳动力的掩护，世道如此，不能太绝对。";
		this.m.BadEnding = "当你离开%companyname%战团时，有一件事情你几乎是肯定的：那个该死的残废%name%活不了太久。然而，尽管机会渺茫，他还是活了下来，甚至活到了自行退休，尽管他离开时携带的克朗与入伍时相差无几。你不知道他现在如何了，但现在他应该肯定死了吧。应该没错，对吧？";
		this.m.HiringCost = 30;
		this.m.DailyCost = 3;
		this.m.Excluded = [
			"trait.huge",
			"trait.weasel",
			"trait.lucky",
			"trait.iron_jaw",
			"trait.tough",
			"trait.strong",
			"trait.cocky",
			"trait.fat",
			"trait.greedy",
			"trait.athletic",
			"trait.impatient",
			"trait.quick",
			"trait.swift",
			"trait.dexterous"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Initiative
		];
		this.m.Titles = [
			"残废",
			"瘸子",
			"破碎者",
			"畸形怪"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Skinny;
		this.m.IsLowborn = true;
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
				id = 16,
				type = "text",
				icon = "ui/icons/special.png",
				text = "总是满足于充当后备"
			}
		];
	}

	function onBuildDescription()
	{
		return "%name%{像一只肮脏的狗一样蹒跚地向你走来 | 用一只失去数根手指的手向你致意 | 张开没牙的嘴对你笑了笑 | 有着背部伤残的人那种懒散的姿势 | 的腿僵硬的摇晃着，不排除是木头做的 | 拄着拐杖向你走来 | 一开始向你爬来，但后来又想教堂阶梯上的醉汉那样站了起来 | 的骨头随着步伐嘎吱作响 | 的一支手臂用吊带吊着，一条腿也需要用拐杖辅助站立 | 一副鼻青脸肿的样子 | 看起来仿佛有人试图割了他的头皮然后活活烧死他的样子 | 闻起来就像烤了一半的肉一样，每向你走一步都痛苦的皱眉 | 失去了两个耳朵，剩下的两个洞倒是还能听声 | 闻起来一股屎尿骚臭 | 少了一只眼睛，而另一只则在剧烈的晃动 | 双眼弱视，张嘴就会露出参差不齐的歪牙}。他解释说{他曾经是一名石匠，但后来因试图复制某个疯子的作品而被其袭击了 | 他曾经是名身披盔甲的骑士，但残酷的命运夺走了他的一切 | 他曾经是一名贵族，但他贫乏的词汇表明这可能是个谎言 | 他曾经是个小贩，但在一次交易出岔子后，他只能任凭愤怒的人群处置 | 他涉足了邪教，但后来他离开了，并为此遭受了惩罚 | 他曾经是名僧侣，但{邪教徒袭击了他的教堂 | 与其他僧侣的口角使他受到了严厉的惩罚 | 强盗们袭击了他，因他曾将一个强盗钉在十字架上} | 他过去曾为贵族打拳击，但某一次被其他斗士打倒使他遭受残疾 | 他过去曾四处游荡参加骑枪比武，但一场糟糕的比赛最终使他严重残疾 | 他过去常常盗墓，但当他被抓住时，一个教区居民把他的每根骨头都打断了至少两次 | 他曾涉足{神秘学 | 亡灵术}，但鉴于他快死的样子，那实验应该很短暂 | 他曾经是一名成功的赌徒，但事实证明，不还债对生意和骨头都是有害的 | 他曾经作为一名游吟诗人歌唱，但有一次他刚唱了一半就被一名领主残酷的折磨了 | 他曾以抓老鼠为生，但显然一只巨大的老鼠在夜里报复性地拜访了他 | 他曾服侍过一位领主，但在摔落一盘食物后，他被扔进地牢并遗忘在那里了好几年 | 他曾杀过一个人，好吧，但遭受不可逆转的折磨作为惩罚还是太重了点 | 他过去专门猎杀女巫，但一个残忍的妇人诱使他喝了一种使他骨质受损的混合物 | 他曾经逃离了一支军队，并且很明显的被抓住了 | 他曾经常为贵族表演杂技，直到在一次把戏中不慎摔下几层台阶。台阶的边缘对他的骨头来说还是太硬了 | 他生下来就有可怕的畸形 | 他父亲因其不遵照他的期望而残暴的攻击了他 | 他母亲用无尽的折磨使他伤痕累累 | 他的兄弟姐妹折磨了他一辈子}。 {这个人看起来如此虚弱你几乎能看到他的皮囊在风中摆动。 | 雇用他几乎肯定能注定这个人的毁灭。多仁慈啊！ | 你不想让别人认为你什么人都雇佣，但如果这个人也算无名小卒，之前的'什么人'还算数吗？ | 你见过死人里有些看起来都比这人好点。 | 这家伙是长着两条腿的狼嘴午餐。 | 好消息是，如果他死了以后又爬起来，那再放倒他一次很容易。 | 梦和无生命的物体都比这个可怜的家伙更具威胁性。 | 老实说，你宁愿雇一个孩子，但显然人们不乐意看到那样所以只能这样了。 | 你竟还曾觉得%randombrother%的味道很难闻。 | 雇用这样的人会让任何人都觉得有点突破道德底线。 | 哦，拜托，看看他！%companyname%真的需要温暖的尸体吗？ | 雇用这个人应该是不对的。管他呢，真香。 | 一副拐杖都比这个可怜的人更有价值。 | 这个人的状态已经糟糕到了他能站在那儿装死。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-20,
				-10
			],
			Bravery = [
				0,
				0
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
				-5,
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
				-25,
				-10
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/weapons/knife"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/weapons/wooden_stick"));
		}

		r = this.Math.rand(0, 1);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}

		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			local item = this.new("scripts/items/helmets/hood");
			item.setVariant(38);
			items.equip(item);
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.IsContentWithBeingInReserve = true;
	}

});

