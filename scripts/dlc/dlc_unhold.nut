local gt = this.getroottable();

if (!("DLC" in gt.Const))
{
	gt.Const.DLC <- {};
	gt.Const.DLC.Mask <- 0;
}

if (!("Unhold" in gt.Const.DLC) || !this.Const.DLC.Unhold)
{
	this.Const.DLC.Unhold <- this.hasDLC(961930) && this.Const.Serialization.Version >= 46;

	if (this.Const.DLC.Unhold)
	{
		this.Const.DLC.Mask = this.Const.DLC.Mask | 4;
		this.Const.LoadingScreens.push("ui/screens/loading_screen_06.jpg");
		local tips = [
			"北方的冰原是一种巨兽的家园，其他地方都找不到它的踪影。",
			"林德虫是一种无翼的双足龙，形似于一条巨大的蛇。",
			"巨魔根据地区有不同变种。",
			"巨魔的伤口即使在战斗中也会快速愈合。",
			"树移动缓慢。",
			"梦魔以陷入恶梦中的人的恐惧与痛苦为食。",
			"探索世界，寻找传说中的地点和传奇宝藏。",
			"双手棍棒在瘫痪单个对手方面表现出色。",
			"斧头对付树木特别有效。",
			"一个树人是一棵活着的树，由树皮和木头组成的生物，其思维方式十分奇特。",
			"使用装甲附件来进一步改进和专门化你士兵的装备。",
			"一个女巫在那些被她迷住的家伙眼中看起来是一位美丽至极的年轻女士。",
			"女巫以达成令人后悔的不详交易而著称。",
			"一个女巫可以诅咒你的一个手下，使其遭受和她一样的伤害。",
			"织网蛛可以对困在它们网中的目标造成额外伤害。",
			"织网蛛的数量越多，它们的决心越高昂。",
			"织网蛛是一种大型蜘蛛，通常生活在世界各地森林深处的大型巢穴里。",
			"从被杀死的野兽身上收集奖杯，让制作动物标本的工匠为你制作有用的物品。",
			"出售击败野兽的战利品可以获得高额收益。你总是可以得到新的。",
			"刺剑在拥有高主动性的角色手里能发挥最大的威力。",
			"使用投矛来远距离击破最危险对手的盾牌。",
			"食尸鬼在世界南部地区更为常见。",
			"梦魔几乎只能在夜里遇到。",
			"离文明地区越远，漫游土地的野兽就越危险。",
			"药剂，尽管它们有着华丽的描述，本质上是毒品，角色可能会对它们上瘾。",
			"过量服用药剂会导致角色呕吐和生病。",
			"选择“野兽杀手”起源时追踪野兽会更容易，同时你可以从杀死的野兽那得到更多战利品。"
		];
		this.Const.TipOfTheDay.extend(tips);
		this.Const.Music.BeastsTracks.push("music/beasts_03.ogg");
		this.Const.Music.BattleTracks[7].push("music/beasts_03.ogg");
		this.Const.Music.WorldmapTracks.push("music/worldmap_10.ogg");
		this.Const.Music.WorldmapTracksGreaterEvil.push("music/worldmap_10.ogg");
		this.Const.Items.NamedWeapons.push("weapons/named/named_polehammer");
		this.Const.Items.NamedWeapons.push("weapons/named/named_fencing_sword");
		this.Const.Items.NamedWeapons.push("weapons/named/named_two_handed_mace");
		this.Const.Items.NamedWeapons.push("weapons/named/named_two_handed_flail");
		this.Const.Items.NamedWeapons.push("weapons/named/named_three_headed_flail");
		this.Const.Items.NamedWeapons.push("weapons/named/named_spetum");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_polehammer");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_fencing_sword");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_two_handed_mace");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_two_handed_flail");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_three_headed_flail");
		this.Const.Items.NamedMeleeWeapons.push("weapons/named/named_spetum");
	}
}

