this.cripple_southern_background <- this.inherit("scripts/skills/backgrounds/cripple_background", {
	m = {},
	function create()
	{
		this.cripple_background.create();
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.SouthernUntidy;
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.BeardChance = 90;
		this.m.Ethnicity = 1;
		this.m.Names = this.Const.Strings.SouthernNames;
	}

	function onBuildDescription()
	{
		return "%name%{像一只肮脏的狗一样蹒跚地向你走来 | 用一只失去数根手指的手向你致意 | 张开没牙的嘴对你笑了笑 | 有着背部伤残的人那种懒散的姿势 | 的腿僵硬的摇晃着，不排除是木头做的 | 拄着拐杖向你走来 | 一开始向你爬来，但后来又想教堂阶梯上的醉汉那样站了起来 | 的骨头随着步伐嘎吱作响 | 的一支手臂用吊带吊着，一条腿也需要用拐杖辅助站立 | 一副鼻青脸肿的样子 | 看起来仿佛有人试图割了他的头皮然后活活烧死他的样子 | 闻起来就像烤了一半的肉一样，每向你走一步都痛苦的皱眉 | 失去了两个耳朵，剩下的两个洞倒是还能听声 | 闻起来一股屎尿骚臭 | 少了一只眼睛，而另一只则在剧烈的晃动 | 双眼弱视，张嘴就会露出参差不齐的歪牙}。他解释说{他曾经是一名石匠，但后来因试图复制某个疯子的作品而被其袭击了 | 他曾经是名身披盔甲的骑士，但残酷的命运夺走了他的一切 | 他曾经是一名维齐尔，但他贫乏的词汇表明这可能是个谎言 | 他曾经是个小贩，但在一次交易出岔子后，他只能任凭愤怒的人群处置 | 他涉足了邪教，但后来他离开了，并为此遭受了惩罚 | 他过去曾为普通的商人们打拳击，但某一次被其他斗士打倒使他遭受残疾 | 他过去曾在角斗场战斗，但一场糟糕的比赛最终使他严重残疾 | 他过去常常盗墓，但当他被抓住时，一个教区居民把他的每根骨头都打断了至少两次 | 他曾涉足{神秘学 | 亡灵术}，但鉴于他快死的样子，那实验应该很短暂 | 他曾经是一名成功的赌徒，但事实证明，不还债对生意和骨头都是有害的 | 他曾经作为一名游吟诗人歌唱，但有一次他刚唱了一半就被一名领主残酷的折磨了 | 他曾以抓老鼠为生，但显然一只巨大的老鼠在夜里报复性地拜访了他 | 他曾服侍过%randomcitystate%的维齐尔，但在摔落一盘食物后，他被扔进地牢并遗忘在那里了好几年 | 他曾杀过一个人，好吧，但遭受不可逆转的折磨作为惩罚还是太重了点 | 他过去专门猎杀女巫，但一个残忍的妇人诱使他喝了一种使他骨质受损的混合物 | 他曾经逃离了一支军队，并且很明显的被抓住了 | 他曾经常为富人表演杂技，直到在一次把戏中不慎摔下几层台阶。台阶的边缘对他的骨头来说还是太硬了 | 他生下来就有可怕的畸形 | 他父亲因其不遵照他的期望而残暴的攻击了他 | 他母亲用无尽的折磨使他伤痕累累 | 他的兄弟姐妹折磨了他一辈子}。 {这个人看起来如此虚弱你几乎能看到他的皮囊在风中摆动。 | 雇用他几乎肯定能注定这个人的毁灭。多仁慈啊！ | 你不想让别人认为你什么人都雇佣，但如果这个人也算无名小卒，之前的'什么人'还算数吗？ | 你见过死人里有些看起来都比这人好点。 | 这家伙是长着两条腿的狼嘴午餐。 | 好消息是，如果他死了以后又爬起来，那再放倒他一次很容易。 | 梦和无生命的物体都比这个可怜的家伙更具威胁性。 | 老实说，你宁愿雇一个孩子，但显然人们不乐意看到那样所以只能这样了。 | 你竟还曾觉得%randombrother%的味道很难闻。 | 雇用这样的人会让任何人都觉得有点突破道德底线。 | 哦，拜托，看看他！%companyname%真的需要温暖的尸体吗？ | 雇用这个人应该是不对的。管他呢，真香。 | 一副拐杖都比这个可怜的人更有价值。 | 这个人的状态已经糟糕到了他能站在那儿装死。}";
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
			local item = this.new("scripts/items/helmets/oriental/nomad_head_wrap");
			item.setVariant(16);
			items.equip(item);
		}
	}

});

