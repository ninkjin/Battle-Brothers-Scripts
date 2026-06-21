this.historian_southern_background <- this.inherit("scripts/skills/backgrounds/historian_background", {
	m = {},
	function create()
	{
		this.historian_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernSkinny;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.BeardChance = 90;
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{作为一个始终贪婪的读者，%name%的早年生活就是在%randomcitystate%的图书馆里度过漫长的夜晚。 | 遭受更强壮的同龄人欺凌，年幼的%name%躲进了书本的世界里。 | 为了寻找人类过去的真实所在，%name%阅读书籍并研究人性。 | 由于世界上发生了这么多变化，%name%决定帮忙记录它们。 | 作为一个嗜好阅读的快速学习者，%name%试图在纸上为他人展望这个世界。 | 作为一位来自%randomcitystate%的学院的学者，%name%为后代记录着世界的历史。 | 由于被发生在世界上的黑暗事件惊悚，%name%停止了对植物的研究并开始记录人类历史。} {一个真正的历史学家会寻找他够得着的最近的原始资料，这使他加入了佣兵的行列。 | 在沙漠强盗毁灭了他已写下的作品后，这个人就穿上靴子并亲自开始新的研究。 | 当他的教授说他的研究是垃圾时，这位历史学家走向世界去证明教授错了。 | 被指控剽窃后，这位历史学家被逐出学术界。他在他曾研究的领域中寻求救赎：战争。 | 由于利用他在学术界的地位去女人们上床，最终丑闻和争议把这位历史学家赶出了自己的领域，使他身无分文并准备接受任何工作。 | 厌倦了阅读冒险家故事，这位历史学家觉得它可以把自己武装起来以便能更近距离地观察些真东西。 | 由于有这么多的佣兵团四处游荡，这位历史学家试图投身其中以进行些实践研究。} {%name%与真正的士兵没有什么共同之处，但他富有想象力的头脑一样幻想着一场精彩的战斗。 | %name%毕生都在写作，从来没有花时间去战斗。到此为止了。 | %name%渴望记录你队伍的旅行。他可以用抓起武器穿上盔甲的方式帮忙。 | %name%的肩上扛着一包书。你建议用链枷代替。很相似，但更尖锐。 | %name%经常被发现乱写笔记，因为他仍然用研究者的眼光看世界。 | %name%携带了一口袋鹅毛笔。这些羽毛可以做成很好的箭。 | 你可以对%name%想要进行研究的渴望抱有信心，但对他挥剑的能力可能没法一视同仁。 | %name%跟着队伍是为了发展一套理论，但他能在实验中幸存下来吗？ | 你向%name%保证，如果他死了，你会想办法记录他的生平。他很感谢并交出遗嘱。它是用一种你不懂的语言写的，你完全看不懂。不管怎样，你还是微笑着回应着。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 0);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}

		r = this.Math.rand(0, 3);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		}
	}

});

