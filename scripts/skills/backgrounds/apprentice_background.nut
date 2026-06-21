this.apprentice_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.apprentice";
		this.m.Name = "学徒";
		this.m.Icon = "ui/backgrounds/background_40.png";
		this.m.BackgroundDescription = "学徒%name%也许是你见过的最聪明的人之一，他是%companyname%中学习速度最快那个。在有了充足的积蓄之后，他从作战中退役并将自己的才华施展在商界。据最近的消息，他在多个行当中都非常成功。如果你有儿子，这就是你会送其跟着去当学徒的那个人。";
		this.m.BadEnding = "学徒%name%是%companyname%中学习速度最快的人，毫不意外他也是最早意识到战团衰落不可避免的其中一人，并且及时的离开了。如果他出生在不同的时代，那他可能会成就伟大的事业。相反，战争、入侵还有瘟疫横扫土地，最终导致%name%以及其他很多才华横溢的人彻底没有用武之处。";
		this.m.HiringCost = 90;
		this.m.DailyCost = 8;
		this.m.Excluded = [
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.dumb",
			"trait.clumsy",
			"trait.asthmatic",
			"trait.athletic",
			"trait.brute",
			"trait.bloodthirsty"
		];
		this.m.Titles = [
			"学习者",
			"大头",
			"学徒",
			"替工",
			"好帮手",
			"学生",
			"小年轻",
			"小鬼头",
			"聪明人"
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.YoungMale;
		this.m.HairColors = this.Const.HairColors.Young;
		this.m.Beards = this.Const.Beards.All;
		this.m.Bodies = this.Const.Bodies.Muscular;
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
				id = 13,
				type = "text",
				icon = "ui/icons/xp_received.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+10%[/color]经验获取"
			}
		];
	}

	function onBuildDescription()
	{
		return "{一个人来到世上总是在追求他所能达到的极致， | 精通一门手艺可以让人声名远扬， | 每个人都希望成为最优秀的那个，}{但没有哪个人一下子就实现了目标。 | 那么有什么方法能比追随某个这样的人学习更好呢？ | 并且许多人都寻求大师的指点已经不是什么秘密。}{%name%就是这样想的并以学徒的身份呆在了%townname%。 | %name%认为这说法是对的并去%townname%当了学徒。 | 当%randomtown%的学院招收学徒时%name%是第一个报名的。 | 由于父母督促他继续提升手艺，%name%开始了他的学徒生涯。 | 为了不被他优秀的兄弟超越，%name%开始了他的学徒生涯。}{不幸的是，他选错了大师：一个比起砍树更喜欢砍人的疯狂木匠。为了避免被牵连进即将到来的毁灭中，%name%最终加入了佣兵团。 | 在竭尽所能地学习之后，%name%造出了可能是水下篮子编织领域有史以来最伟大的艺术作品。然而他的大师是个善妒的人，为了不被自己的学生胜过，他把这个工程烧得灰飞烟灭。%name%非常明白：他学得很快，但应该有更好的大师来追随并学习。 | 他已经把所有能学的都学完了：石工、木工、打铁、做爱。现在他把目光转向了武术，虽然他还压根算不上个战士，但%name%学习速度很快。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				0,
				0
			],
			Bravery = [
				0,
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
			items.equip(this.new("scripts/items/armor/leather_tunic"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/linen_tunic"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/apron"));
		}
	}

	function onUpdate( _properties )
	{
		this.character_background.onUpdate(_properties);
		_properties.XPGainMult *= 1.1;
	}

});

