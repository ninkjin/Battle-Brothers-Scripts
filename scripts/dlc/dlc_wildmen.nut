local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Wildmen" in gt.Const.DLC) || !this.Const.DLC.Wildmen)
{
	this.Const.DLC.Wildmen <- this.hasDLC(1067690) && this.Const.Serialization.Version >= 48;

	if (this.Const.DLC.Wildmen)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 16;
		this.Const.LoadingScreens.push("ui/screens/loading_screen_06.jpg");
		this.Const.LoadingScreens.push("ui/screens/loading_screen_09.jpg");
		local tips = [
			"北方居住着凶猛的野蛮部落。",
			"蛮族常常在战斗开始时压倒对手，但很快就会疲惫不堪。",
			"北方的战犬比南方的守卫犬更加结实，但不如敏捷。",
			"鼓手有规律的部落节拍使得每回合所有野蛮人的疲劳值都少量降低。",
			"兽王不能在邻近敌人时使用鞭子指挥他们的野兽战争机器。",
			"蛮族人期望在来世与他们的祖先相遇。",
			"尝试不同的起源来定制你的战役以适应你的游戏风格。",
			"在‘独狼’起源中，你将拥有一个玩家角色。如果你死了，这局游戏就结束了。",
			"选择“起义农民”这一背景，则你可以一次带领最多16名士兵参加战斗。",
			"选择“异教徒”出身，你的神将要求你献祭，但也会赐予那些忠诚于祂的人好处。",
			"选择'盗猎团'种族后，队伍在世界地图上移动速度更快。",
			"如果选择了“贸易队商”起源，则你在买入和卖出物品时都能获得更好的价格。",
			"投石索的攻击命中头部可造成“茫然”状态效果。",
			"有着无数石头，投石器永远不会用光弹药。",
			"战斗鞭能够暂时解除对手的武器，阻止他们使用武器技能。",
			"战鞭能够造成流血伤口，但对抗护甲效果低下。",
			"匕首和弯刀在打击目标时更容易造成致残伤。"
		];
		this.Const.TipOfTheDay.extend(tips);
		this.Const.PlayerBanners.push("banner_24");
		this.Const.PlayerBanners.push("banner_25");
		this.Const.Tattoos.All.push("warpaint_02");
		this.Const.Tattoos.All.push("warpaint_03");
		this.Const.Tattoos.All.push("tattoo_02");
		this.Const.Tattoos.All.push("tattoo_03");
		this.Const.Tattoos.All.push("tattoo_04");
		this.Const.Tattoos.All.push("tattoo_05");
		this.Const.Tattoos.All.push("tattoo_06");
		this.Const.Items.NamedWeapons.push("weapons/named/named_bardiche");
		this.Const.Items.NamedWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedWeapons.push("weapons/named/named_battle_whip");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_bardiche");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_shamshir");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_battle_whip");
		this.Const.Items.NamedHelmets.push("helmets/named/norse_helmet");
		this.Const.Items.NamedHelmets.push("helmets/named/named_conic_helmet_with_faceguard");
		this.Const.Items.NamedHelmets.push("helmets/named/named_nordic_helmet_with_closed_mail");
		this.Const.Items.NamedHelmets.push("helmets/named/named_steppe_helmet_with_mail");
		this.Const.Items.NamedSouthernHelmets.push("helmets/named/named_steppe_helmet_with_mail");
		this.Const.Items.NamedArmors.push("armor/named/named_golden_lamellar_armor");
		this.Const.Items.NamedArmors.push("armor/named/named_noble_mail_armor");
		this.Const.Items.NamedArmors.push("armor/named/named_sellswords_armor");
		this.Const.Items.NamedSouthernArmors.push("armor/named/named_golden_lamellar_armor");
		this.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_bull_helmet");
		this.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_nose_horn_helmet");
		this.Const.Items.NamedBarbarianHelmets.push("helmets/named/named_metal_skull_helmet");
		this.Const.Items.NamedBarbarianArmors.push("armor/named/named_bronze_armor");
		this.Const.Items.NamedBarbarianArmors.push("armor/named/named_plated_fur_armor");
		this.Const.Items.NamedBarbarianArmors.push("armor/named/named_skull_and_chain_armor");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_rusty_warblade");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_skullhammer");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_heavy_rusty_axe");
		this.Const.Items.NamedBarbarianWeapons.push("weapons/named/named_two_handed_spiked_mace");
	}
}

