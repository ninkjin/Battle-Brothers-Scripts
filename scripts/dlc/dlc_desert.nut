local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Desert" in gt.Const.DLC) || !this.Const.DLC.Desert)
{
	this.Const.DLC.Desert <- this.hasDLC(1361280) && this.Const.Serialization.Version >= 63;

	if (this.Const.DLC.Desert)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 64;
		this.Const.LoadingScreens.push("ui/screens/loading_screen_10.jpg");
		local tips = [
			"南方城邦在医学、占星术和炼金术方面取得了空前的进步。",
			"南方人以他们的神命名自己为“镀金者”，他们整日沐浴在神光之中。",
			"‘欠债人’是城市国家中的一种社会阶层，由罪犯、战俘和违犯宗教教义者组成，实质上是奴隶。",
			"南方城邦是在古代帝国的废墟上建立起来的。",
			"游牧民族是一群不受城邦统治的南方人。",
			"游牧民族是沙漠战争和利用环境优势的专家，这包括向你的面部抛洒沙尘。",
			"伊弗利特是一种控制并支配岩石和流沙的恶灵。",
			"一把卡塔尔匕首最好与其他能够使敌人茫然或击晕的武器结合使用。",
			"火铳需要一整个回合才能重新装填 - 除非你的角色拥有“弩与火器精通”特技。",
			"火铳是一种远程武器，能够一次攻击最多击中6个目标，但是射程比弓箭或十字弓都要短。",
			"火枪和投掷武器一样，每场战斗后都需要重新装填。",
			"竞技场比赛是赚取克朗的快速方法，但是比赛中不能撤退或赛后拾取战利品。",
			"竞技场锦标赛是具有不同规则的特殊活动。在连续三轮中使用五名队员进行战斗，获胜即可得到一件著名物品！",
			"每五场竞技场比赛中就有一场机会赢得一件无法通过购买获得的角斗士装备。",
			"火油罐不仅可以对对手造成伤害，而且还可以用来封锁格子和延迟对手行动。",
			"即使你的士兵已经陷入近战，烟雾弹也可以用于安全撤退。",
			"城邦的迫击炮只有在有一名工程师在旁操作时才能开火。",
			"拥有“猎人”背景，你可以在每场与人类的战斗后俘虏他们，并迫使他们为你而战。",
			"选择“角斗士”起源，你将开始拥有3个强大的角色，但失去全部3人将使你的战役结束。",
			"雇佣非战斗跟随者加入你的随行人员，根据你的游戏风格定制你的战役。",
			"被兽人击败拥有名字的盾牌？为你的战团雇一个铁匠，可以修复任何物品，即使它的耐久度降至零。",
			"训练新兵需要太长时间？雇佣一个军士长让他们更快地获得经验。",
			"面对的敌方队长太少了吗？雇佣赏金猎人来寻找更多的目标，甚至可以为每个你杀死的敌方队长得到一份赏金。",
			"工资支出太多了吗？雇佣一名出纳员来减少您需要支付的工资。",
			"想知道谁去过那里？雇佣一个侦察兵，获取地图上任何足迹的更多信息。",
			"总是没弹药和工具吗？雇佣一个清道夫来回收你使用过的弹药和从你摧毁的护甲中采集工具。",
			"背包已满？在战团界面购买手推车和货车。",
			"你可以通过获得声望来解锁随从非战斗跟随者的位置。",
			"凶猛的鬣狗在南方的沙漠漫游，它们有着强大的颚骨，可以咬碎甚至金属盔甲并造成出血伤口。",
			"尝试不同的侍从追随者，找到与您的游戏风格和选定的战团起源相匹配的人。"
		];
		this.Const.TipOfTheDay.extend(tips);
		this.Const.Music.BeastsTracksSouth.push("music/beasts_04.ogg");
		this.Const.Music.ArenaTracks.push("music/beasts_04.ogg");
		this.Const.Music.WorldmapTracksSouth.push("music/worldmap_11.ogg");
		this.Const.Music.WorldmapTracksGreaterEvilSouth.push("music/worldmap_11.ogg");
		this.Const.PlayerBanners.push("banner_28");
		this.Const.PlayerBanners.push("banner_29");
		this.Const.PlayerBanners.push("banner_30");
		this.Const.Items.NamedWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedWeapons.push("weapons/named/named_handgonne");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_spear");
		this.Const.Items.NamedSouthernWeapons.push("weapons/named/named_handgonne");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_qatal_dagger");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_swordlance");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_polemace");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_two_handed_scimitar");
		this.Const.Items.NamedSouthernMeleeWeapons.push("weapons/named/named_spear");
		this.Const.Items.NamedShields.push("shields/named/named_sipar_shield");
		this.Const.Items.NamedSouthernShields.push("shields/named/named_sipar_shield");
		this.Const.Items.NamedSouthernArmors.push("armor/named/black_and_gold_armor");
		this.Const.Items.NamedSouthernArmors.push("armor/named/leopard_armor");
		this.Const.Items.NamedArmors.push("armor/named/black_and_gold_armor");
		this.Const.Items.NamedArmors.push("armor/named/leopard_armor");
		this.Const.Items.NamedSouthernHelmets.push("helmets/named/red_and_gold_band_helmet");
		this.Const.Items.NamedSouthernHelmets.push("helmets/named/gold_and_black_turban");
		this.Const.Items.NamedHelmets.push("helmets/named/red_and_gold_band_helmet");
		this.Const.Items.NamedHelmets.push("helmets/named/gold_and_black_turban");
		this.Const.World.Settings.SizeY = 170;
		this.Const.World.Settlements.Master.push({
			Amount = 3,
			List = this.Const.World.Settlements.CityStates,
			IgnoreSide = true,
			AdditionalSpace = 13
		});
		this.Const.Faces.Barber.extend(this.Const.Faces.SouthernMale);
		this.Const.Bodies.Barber.extend(this.Const.Bodies.SouthernMale);
		this.Const.Hair.Barber.extend(this.Const.Hair.SouthernMaleOnly);
		this.Const.Beards.Barber.extend(this.Const.Beards.SouthernOnly);
	}
}

