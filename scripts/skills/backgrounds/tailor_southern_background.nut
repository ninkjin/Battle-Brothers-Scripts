this.tailor_southern_background <- this.inherit("scripts/skills/backgrounds/tailor_background", {
	m = {},
	function create()
	{
		this.tailor_background.create();
		this.m.Bodies = this.Const.Bodies.SouthernThick;
		this.m.Faces = this.Const.Faces.SouthernMale;
		this.m.Hairs = this.Const.Hair.SouthernMale;
		this.m.HairColors = this.Const.HairColors.Southern;
		this.m.Beards = this.Const.Beards.Southern;
		this.m.Ethnicity = 1;
		this.m.Excluded = [
			"trait.superstitious",
			"trait.huge",
			"trait.hate_undead",
			"trait.athletic",
			"trait.deathwish",
			"trait.clumsy",
			"trait.fearless",
			"trait.spartan",
			"trait.brave",
			"trait.iron_lungs",
			"trait.strong",
			"trait.tough",
			"trait.cocky",
			"trait.dumb",
			"trait.brute",
			"trait.bloodthirsty"
		];
		this.m.Names = this.Const.Strings.SouthernNames;
		this.m.LastNames = this.Const.Strings.SouthernNamesLast;
	}

	function onBuildDescription()
	{
		return "{%name%总是对织物很好奇，在亚麻布上看到的科学比{一个占卜师在沙漠的沙子里 | 肠卜师从蟾蜍的内脏里 | 炼金术士在研钵和研杵中}看到的还要多。 | %name%小时候一直是一个古怪的男孩，比起女孩更喜欢女孩身上的丝绸裙子。 | 作为一名{屠夫 | 士兵}的儿子，%name%选择去搞时装震惊了所有人。 | 当%name%的兄弟们幻想成为战士和英雄时，%name%想要在未来成为维齐尔的服装师。 | %name%的青少年时期大部分时候都扎在女孩堆里，却不是出于人们以为的那种原因。 | %name%总是对动物着迷，尤其是对它们做成大衣和围巾后看起来怎么样。 | 随着束腰外衣和衬衫越来越受欢迎，%name%当裁缝来赚取一点克朗。 | 随着紧身裤的流行，%name%从制革匠改行裁缝来赚更多的钱。 | 裁缝是一门关于颜色和面料的科学，而%name%闻名于此。 | 由于擅长测量和计算，%name%将他的数学能力用于裁剪，以尽可能多地赚钱。 | %name%当裁缝是为了纪念自己的父亲，同样是裁缝的父亲被一名不高兴的客人杀死了。 | 因战争成为寡妇，%name%的母亲教他如何将双手更好地用于裁缝而不是杀人。}{当游牧民袭击他的家时，%name%用巧妙的打扮把所有人伪装了起来。城镇被摧毁了，但没有一个人丧命。 | 他多年来一直负责打扮贵族，直到一次有失时尚导致他被流放。 | 不幸的是，作为一个男人太喜欢布料，就像%name%习惯做的那样，使得这名裁缝遭受了众多村庄的排斥。 | 他试图在城里闯一闯，但遗憾的是他竞争不过其他的裁缝。 | 当一位维齐尔组织军队时，%name%负责处理衣服，为征召兵提供合适的制服。 | 但是裁缝之间的激烈竞争导致出现了一个亚麻布裹起来的死人，而%name%巧合般的抛下了他的店铺。 | 他曾用一根卷尺勒死了一个想偷东西的人。不管怎样这是他的说法。 | 在一次受命制作一件绣有史诗壮举的束腰外衣后，%name%想知道外面的世界到底是什么样子。 | 设计了一件饰有{史诗探险 | 史诗壮举}的衣着后，%name%好奇是否他才应该是这些纹绣故事的主角。}现在裁缝正在寻找新的生活，不问终点位于何方。{也许他能把这个单位打扮得很好，或者别的什么。 | 他挑剔而独特，对每个人的衣着都提出批评。 | 他不是天生的士兵，但他评估一个人的衣着时就仿佛要与之开战一样。 | 鉴于他测量和计算着装的方式，很可惜%name%不是一个攻城工程师。 | 虽然离军人还差的远，但%name%对裁缝的热爱是值得钦佩的。 | %name%对各种各样布料的丰富知识真的令人印象极度深刻。 | 有点偏科，%name%有剑客的步法，但他的剑法如同微风吹拂般无力。 | %name%穿着盔甲看起来很不合适，但他还是真的需要一套。 | 事实证明，%name%可以用母猪的耳朵做出一个丝绸钱包。 | 别让他的职业愚弄了你，%name%双手的灵巧度要强于一些{打牌出千者 | 杂耍者 | 扒手}。 | 裁缝似乎不适合战斗，但同样你最近遇到的绝大多数人也不适合。 | 裁缝似乎不适合战斗，但由于某种原因，你在最奇怪的地方找到的最追求品质的士兵。 | 有着一只用于{计算 | 测量}的眼睛，%name%比他第一眼看上去要聪明得多。}";
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else
		{
			items.equip(this.new("scripts/items/armor/oriental/cloth_sash"));
		}

		r = this.Math.rand(1, 4);

		if (r == 1)
		{
			items.equip(this.new("scripts/items/helmets/feathered_hat"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/helmets/oriental/southern_head_wrap"));
		}
	}

});

