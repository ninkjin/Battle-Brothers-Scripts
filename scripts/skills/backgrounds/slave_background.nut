this.slave_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.slave";
		this.m.Name = "负债者";
		this.m.Icon = "ui/backgrounds/background_60.png";
		this.m.BackgroundDescription = "负债者实际上是城邦中的奴隶阶级，因此他们并非是被雇佣，而是被购买，同时没有每日工资。";
		this.m.GoodEnding = "负债者%name%过着艰苦的生活，你们都是其原因之一，但同时也都试着以某种方式改善它。曾经你在南方发现他被奴役，远离了家人和故乡。你'雇佣'了他，将他作为不需要工资的奴隶佣兵使用。在你离开了%companyname%之后，他的名字从负债者的名单上消除了，实际上他已经成为了一个自由人。他留在了战团里并且从那之后职位一直在上升。你和这个人之间的关系很奇怪，他从来没有感谢过你，也没有表示过不满。";
		this.m.BadEnding = "随着你从不成功的%companyname%退休，来自北方的负债者%name%继续呆在战团了一段时间。后来你听说这个佣兵团遇到了财务问题，不得不出售'军需和人力'以填补亏空。据推测，%name%在跟随战团的时光在那个时候终结，而他作为奴隶的时光又重新开始了。";
		this.m.HiringCost = this.Math.rand(19, 22) * 10;
		this.m.DailyCost = 0;
		this.m.Titles = [
			"被奴役者",
			"北方人",
			"俘虏",
			"苍白",
			"囚犯",
			"被绑架者",
			"倒霉蛋",
			"负债者",
			"负债者",
			"不自由者",
			"被束缚者",
			"戴镣铐者",
			"被捆缚者"
		];
		this.m.Excluded = [
			"trait.survivor",
			"trait.iron_jaw",
			"trait.tough",
			"trait.strong",
			"trait.spartan",
			"trait.gluttonous",
			"trait.lucky",
			"trait.loyal",
			"trait.cocky",
			"trait.fat",
			"trait.fearless",
			"trait.brave",
			"trait.drunkard",
			"trait.determined",
			"trait.greedy",
			"trait.athletic",
			"trait.hate_beasts",
			"trait.hate_undead",
			"trait.hate_greenskins"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.Hitpoints,
			this.Const.Attributes.Bravery
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
		local ret = [
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
		ret.push({
			id = 19,
			type = "text",
			icon = "ui/icons/special.png",
			text = "死亡时非负债者队友不会触发士气检定"
		});
		ret.push({
			id = 20,
			type = "text",
			icon = "ui/icons/special.png",
			text = "总是满足于充当后备"
		});
		return ret;
	}

	function onBuildDescription()
	{
		return "{你可以轻易的从外表看出%name%是北方人。 他在南方被奴役为负债者是因为他异端的旧神信仰冒犯了金铎。 | %name%具有北方人的特征，很容易吸引路过的男人或女人的目光。这同样也碰巧引起了一位牧师的注意，他声称这个北方人欠了金铎的债并立刻把这个外来者卖为奴隶。 | 作为一个北方人，%name%曾经是一个被派往南方巡逻的士兵。在沙漠中迷失方向后，他的部队人数慢慢地减少，直到他成为最后一个幸存者。搜捕者抓住了他，把他从生命危机中解救出来，然后理所当然的在他康复的身体有了价值后就把他卖作奴隶。 | 尽管%name%作为北方人很容易引起注意，他还是不明智地寻求犯罪生活，并在维齐尔的花园偷石榴时被抓。他很幸运保住了自己的的脑袋，但现在却成了搜捕者市场上的劳动力商品。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				-10,
				-10
			],
			Bravery = [
				-5,
				0
			],
			Stamina = [
				0,
				0
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
				-5,
				-5
			]
		};
		return c;
	}

	function onSetAppearance()
	{
		local actor = this.getContainer().getActor();
		local dirt = actor.getSprite("dirt");
		dirt.Visible = true;

		if (this.Math.rand(1, 100) <= 66)
		{
			local body = actor.getSprite("body");
			local tattoo_body = actor.getSprite("tattoo_body");
			tattoo_body.setBrush("scar_01_" + body.getBrush().Name);
			tattoo_body.Color = body.Color;
			tattoo_body.Saturation = body.Saturation;
			tattoo_body.Visible = true;
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 4);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}

		if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.IsContentWithBeingInReserve = true;

		if (("State" in this.World) && this.World.State != null && this.World.Assets.getOrigin() != null && this.World.Assets.getOrigin().getID() == "scenario.manhunters")
		{
			_properties.XPGainMult *= 1.1;
			_properties.SurviveWithInjuryChanceMult = 0.0;
		}
	}

});

