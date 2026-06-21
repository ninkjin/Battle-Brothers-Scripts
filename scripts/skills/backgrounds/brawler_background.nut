this.brawler_background <- this.inherit("scripts/skills/backgrounds/character_background", {
	m = {},
	function create()
	{
		this.character_background.create();
		this.m.ID = "background.brawler";
		this.m.Name = "拳师";
		this.m.Icon = "ui/backgrounds/background_27.png";
		this.m.BackgroundDescription = "拳师在徒手格斗中是无与伦比的，体育锻炼一般使得他们身体状态良好。";
		this.m.GoodEnding = "像%name%这样的拳师仅凭双手就已经很危险，他还证明了自己使用武器时一样野蛮。就在你离开%companyname%前，你与这个斗士谈论他是否会留在战团。他说他没有回去打拳击赛的意愿，与你握手的时感谢你给了他这样的机会。据你听到的最新消息，战团选了他与竞争的佣兵团进行一对一的、赢者通吃的战斗，用来解决补偿差异。他在第一轮中就获胜了。";
		this.m.BadEnding = "在战团解体的趋势变得明显并且可能害死所有继续呆着的兄弟后，拳师%name%离开了。他回到了拳击赛场，在接下来几年中不停在每周的比赛中摸滚打爬。随着变老，他的下巴不见了，速度和力量也不复存在。他只能在零散的赛事中打假赛，如果他不这么做就会输的很惨。终于，没有人再让他参加比赛了。一位贵族向他提出高价让他去和一只熊摔跤，别无他路的%name%接受了这个挑战。当'战斗'结束时，拳师被咬的死无全尸，还被野兽在泥地中拖行，而醉醺醺的贵族却欢呼雀跃。";
		this.m.HiringCost = 125;
		this.m.DailyCost = 13;
		this.m.Excluded = [
			"trait.weasel",
			"trait.fear_undead",
			"trait.hate_undead",
			"trait.ailing",
			"trait.clubfooted",
			"trait.irrational",
			"trait.asthmatic",
			"trait.clumsy",
			"trait.fat",
			"trait.craven",
			"trait.insecure",
			"trait.dastard",
			"trait.fainthearted",
			"trait.bright",
			"trait.bleeder",
			"trait.fragile",
			"trait.tiny"
		];
		this.m.ExcludedTalents = [
			this.Const.Attributes.RangedSkill
		];
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.UntidyMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.Untidy;
		this.m.Bodies = this.Const.Bodies.Muscular;
		this.m.IsCombatBackground = true;
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
				id = 12,
				type = "text",
				icon = "ui/icons/regular_damage.png",
				text = "[color=" + this.Const.UI.Color.PositiveValue + "]+100%[/color]徒手伤害"
			}
		];
	}

	function onBuildDescription()
	{
		return "{身材魁梧拳头生风，%name%在过去一年的大部分时间里都在其他拳师磨练拳击技巧。 | 由于有一张已经扭曲成别人指节形状的脸，不难发现%name%是职业拳师。 | %name%有多喜欢喝酒就有多喜欢打架，真是强而有力的组合。 | 在父亲和兄弟们的硬核教育下，%name%成为了一名颇具性情的斗士。 | %name%年少轻狂时期遇到的霸凌者们让他成了比起等着被打更喜欢主动打人的家伙。 | %name%只有一个真正的才华：用拳头血腥的修理别人的鼻子，以及无论如何都不倒下。 | 长大过程中，%name%曾在农场与公牛摔跤。对男人们来说不幸的是，去闯城市的那一天总会来的。}{在过去的一年中，他受雇于当地领主，四处与其他贵族的拳师们一决高下。 | 作为酒吧斗殴的爱好者，这个人显然已经被不计其数的酒馆拉入黑名单。 | 在%randomtown%获得斗士的名声意味着他必须和他遇到的每一个骄傲、自夸并醉酒的男人打斗。 | 尽管他成为一名不败的拳师，但他的收入依旧仅够勉强度日。 | 充满激情的他，总是乐于接受斗殴挑战。当地拳击圈子说他的左勾拳很难缠。}{在听到有更棒的战斗机会时，%name%脱下了他的拳套，开始从事更有利可图的雇佣兵行当。 | 只有一个人击败了%name%：他的妻子。在她责备他是个毫无野心的丢人玩意儿后，他决定从事更有'声望'的佣兵工作。 | 多年的打斗部分摧毁了他的记忆力。有些人认为他只是把佣兵营地误当作了他购物清单上的一个物品。 | 非常缺克朗并且几乎无法张开破损的手拥抱儿子，更不用说挥拳了，于是%name%开始寻求新职业。 | 尽管他对实际上的战争一无所知，但在经历了多年艰辛后，定期支付工资的佣兵工作前景对他非常诱人。 | 这个人可以谋杀石块打伤石头，对任何团队都是不错的助益。}";
	}

	function onChangeAttributes()
	{
		local c = {
			Hitpoints = [
				5,
				10
			],
			Bravery = [
				7,
				5
			],
			Stamina = [
				10,
				5
			],
			MeleeSkill = [
				5,
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
				5,
				0
			]
		};
		return c;
	}

	function onAdded()
	{
		this.character_background.onAdded();

		if (this.Math.rand(0, 3) == 3)
		{
			local actor = this.getContainer().getActor();
			actor.setTitle(this.Const.Strings.BrawlerTitles[this.Math.rand(0, this.Const.Strings.BrawlerTitles.len() - 1)]);
		}
	}

	function onAddEquipment()
	{
		local items = this.getContainer().getActor().getItems();
		local r;
		r = this.Math.rand(0, 2);

		if (r == 0)
		{
			items.equip(this.new("scripts/items/armor/sackcloth"));
		}
		else if (r == 1)
		{
			items.equip(this.new("scripts/items/armor/tattered_sackcloth"));
		}
		else if (r == 2)
		{
			items.equip(this.new("scripts/items/armor/leather_wraps"));
		}
	}

	function onAnySkillUsed( _skill, _targetEntity, _properties )
	{
		if (_skill.getID() == "actives.hand_to_hand")
		{
			_properties.DamageTotalMult *= 2.0;
		}
	}

});

