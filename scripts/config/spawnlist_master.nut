local gt = this.getroottable();

if (!("World" in gt.Const))
{
	gt.Const.World <- {};
}

if (!("Spawn" in gt.Const.World))
{
	gt.Const.World.Spawn <- {};
}

gt.Const.World.Spawn.Unit <- {
	ID = 0,
	Variant = 0,
	Strength = 0.0,
	Row = 0,
	Party = null,
	Faction = null,
	Tag = null,
	Script = "",
	Name = ""
};
gt.Const.World.Spawn.Troops <- {
	Necromancer = {
		ID = this.Const.EntityType.Necromancer,
		Variant = 1,
		Strength = 35,
		Cost = 30,
		Row = 3,
		Script = "scripts/entity/tactical/enemies/necromancer",
		NameList = this.Const.Strings.NecromancerNames,
		TitleList = null
	},
	Zombie = {
		ID = this.Const.EntityType.Zombie,
		Variant = 0,
		Strength = 6,
		Cost = 6,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie"
	},
	ZombieYeoman = {
		ID = this.Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 10,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_yeoman"
	},
	ZombieNomad = {
		ID = this.Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 10,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_nomad"
	},
	ZombieNomadBodyguard = {
		ID = this.Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 6,
		Cost = 6,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_nomad_bodyguard"
	},
	ZombieKnight = {
		ID = this.Const.EntityType.ZombieKnight,
		Variant = 1,
		Strength = 20,
		Cost = 24,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_knight",
		NameList = this.Const.Strings.KnightNames,
		TitleList = this.Const.Strings.FallenHeroTitles
	},
	ZombieBodyguard = {
		ID = this.Const.EntityType.Zombie,
		Variant = 0,
		Strength = 6,
		Cost = 6,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_bodyguard"
	},
	ZombieYeomanBodyguard = {
		ID = this.Const.EntityType.ZombieYeoman,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_yeoman_bodyguard"
	},
	ZombieKnightBodyguard = {
		ID = this.Const.EntityType.ZombieKnight,
		Variant = 0,
		Strength = 20,
		Cost = 24,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_knight_bodyguard"
	},
	ZombieBetrayer = {
		ID = this.Const.EntityType.ZombieBetrayer,
		Variant = 0,
		Strength = 25,
		Cost = 30,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/zombie_betrayer"
	},
	ZombieBoss = {
		ID = this.Const.EntityType.ZombieBoss,
		Variant = 0,
		Strength = 80,
		Cost = 80,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/zombie_boss"
	},
	Ghost = {
		ID = this.Const.EntityType.Ghost,
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/ghost"
	},
	SkeletonLight = {
		ID = this.Const.EntityType.SkeletonLight,
		Variant = 0,
		Strength = 14,
		Cost = 13,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_light"
	},
	SkeletonMedium = {
		ID = this.Const.EntityType.SkeletonMedium,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_medium"
	},
	SkeletonMediumPolearm = {
		ID = this.Const.EntityType.SkeletonMedium,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/skeleton_medium_polearm"
	},
	SkeletonHeavy = {
		ID = this.Const.EntityType.SkeletonHeavy,
		Variant = 1,
		Strength = 30,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy",
		NameList = this.Const.Strings.AncientDeadNames,
		TitleList = null
	},
	SkeletonHeavyPolearm = {
		ID = this.Const.EntityType.SkeletonHeavy,
		Variant = 0,
		Strength = 30,
		Cost = 35,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy_polearm"
	},
	SkeletonHeavyBodyguard = {
		ID = this.Const.EntityType.SkeletonHeavy,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_heavy_bodyguard"
	},
	SkeletonPriest = {
		ID = this.Const.EntityType.SkeletonPriest,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_priest"
	},
	SkeletonBoss = {
		ID = this.Const.EntityType.SkeletonBoss,
		Variant = 0,
		Strength = 80,
		Cost = 80,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/skeleton_boss"
	},
	Vampire = {
		ID = this.Const.EntityType.Vampire,
		Variant = 0,
		Strength = 40,
		Cost = 40,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/vampire"
	},
	VampireLOW = {
		ID = this.Const.EntityType.Vampire,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/vampire_low"
	},
	OrcYoung = {
		ID = this.Const.EntityType.OrcYoung,
		Variant = 0,
		Strength = 16,
		Cost = 16,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/orc_young"
	},
	OrcYoungLOW = {
		ID = this.Const.EntityType.OrcYoung,
		Variant = 0,
		Strength = 14,
		Cost = 13,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/orc_young"
	},
	OrcBerserker = {
		ID = this.Const.EntityType.OrcBerserker,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/orc_berserker"
	},
	OrcWarrior = {
		ID = this.Const.EntityType.OrcWarrior,
		Variant = 1,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/orc_warrior",
		NameList = this.Const.Strings.OrcWarlordNames,
		TitleList = null
	},
	OrcWarriorLOW = {
		ID = this.Const.EntityType.OrcWarrior,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/orc_warrior_low"
	},
	OrcWarlord = {
		ID = this.Const.EntityType.OrcWarlord,
		Variant = 10,
		Strength = 45,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/orc_warlord",
		NameList = this.Const.Strings.OrcWarlordNames,
		TitleList = null
	},
	GreenskinCatapult = {
		ID = this.Const.EntityType.GreenskinCatapult,
		Variant = 0,
		Strength = 50,
		Cost = 25,
		Row = 2,
		Script = "scripts/entity/tactical/objective/greenskin_catapult"
	},
	GoblinSkirmisher = {
		ID = this.Const.EntityType.GoblinFighter,
		Variant = 1,
		Strength = 18,
		Cost = 15,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/goblin_fighter",
		NameList = this.Const.Strings.GoblinNames,
		TitleList = this.Const.Strings.GoblinTitles
	},
	GoblinSkirmisherLOW = {
		ID = this.Const.EntityType.GoblinFighter,
		Variant = 0,
		Strength = 14,
		Cost = 10,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/goblin_fighter_low"
	},
	GoblinAmbusher = {
		ID = this.Const.EntityType.GoblinAmbusher,
		Variant = 1,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/goblin_ambusher",
		NameList = this.Const.Strings.GoblinNames,
		TitleList = this.Const.Strings.GoblinTitles
	},
	GoblinAmbusherLOW = {
		ID = this.Const.EntityType.GoblinAmbusher,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/goblin_ambusher_low"
	},
	GoblinShaman = {
		ID = this.Const.EntityType.GoblinShaman,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/goblin_shaman"
	},
	GoblinOverseer = {
		ID = this.Const.EntityType.GoblinLeader,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/goblin_leader"
	},
	GoblinWolfrider = {
		ID = this.Const.EntityType.GoblinWolfrider,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/goblin_wolfrider"
	},
	Direwolf = {
		ID = this.Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 15,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/direwolf"
	},
	DirewolfHIGH = {
		ID = this.Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/direwolf_high"
	},
	DirewolfBodyguard = {
		ID = this.Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/direwolf_bodyguard"
	},
	GhoulLOW = {
		ID = this.Const.EntityType.Ghoul,
		Variant = 0,
		Strength = 10,
		Cost = 9,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/ghoul"
	},
	Ghoul = {
		ID = this.Const.EntityType.Ghoul,
		Variant = 0,
		Strength = 15,
		Cost = 19,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/ghoul_medium"
	},
	GhoulHIGH = {
		ID = this.Const.EntityType.Ghoul,
		Variant = 0,
		Strength = 25,
		Cost = 30,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/ghoul_high"
	},
	Lindwurm = {
		ID = this.Const.EntityType.Lindwurm,
		Variant = 0,
		Strength = 100,
		Cost = 90,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/lindwurm"
	},
	Unhold = {
		ID = this.Const.EntityType.Unhold,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/unhold"
	},
	UnholdFrost = {
		ID = this.Const.EntityType.UnholdFrost,
		Variant = 0,
		Strength = 60,
		Cost = 60,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/unhold_frost"
	},
	UnholdBog = {
		ID = this.Const.EntityType.UnholdBog,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/unhold_bog"
	},
	Spider = {
		ID = this.Const.EntityType.Spider,
		Variant = 0,
		Strength = 13,
		Cost = 12,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/spider"
	},
	SpiderBodyguard = {
		ID = this.Const.EntityType.Spider,
		Variant = 0,
		Strength = 13,
		Cost = 12,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/spider_bodyguard"
	},
	Alp = {
		ID = this.Const.EntityType.Alp,
		Variant = 0,
		Strength = 30,
		Cost = 30,
		Row = -2,
		Script = "scripts/entity/tactical/enemies/alp"
	},
	Hexe = {
		ID = this.Const.EntityType.Hexe,
		Variant = 0,
		Strength = 50,
		Cost = 50,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/hexe"
	},
	Schrat = {
		ID = this.Const.EntityType.Schrat,
		Variant = 0,
		Strength = 70,
		Cost = 70,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/schrat"
	},
	Kraken = {
		ID = this.Const.EntityType.Kraken,
		Variant = 0,
		Strength = 200,
		Cost = 200,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/kraken"
	},
	TricksterGod = {
		ID = this.Const.EntityType.TricksterGod,
		Variant = 0,
		Strength = 0,
		Cost = 0,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/trickster_god"
	},
	Serpent = {
		ID = this.Const.EntityType.Serpent,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/serpent"
	},
	Hyena = {
		ID = this.Const.EntityType.Hyena,
		Variant = 0,
		Strength = 15,
		Cost = 20,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/hyena"
	},
	HyenaHIGH = {
		ID = this.Const.EntityType.Hyena,
		Variant = 0,
		Strength = 20,
		Cost = 25,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/hyena_high"
	},
	SandGolem = {
		ID = this.Const.EntityType.SandGolem,
		Variant = 0,
		Strength = 13,
		Cost = 13,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/sand_golem"
	},
	SandGolemMEDIUM = {
		ID = this.Const.EntityType.SandGolem,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/sand_golem_medium"
	},
	SandGolemHIGH = {
		ID = this.Const.EntityType.SandGolem,
		Variant = 0,
		Strength = 70,
		Cost = 70,
		Row = -1,
		Script = "scripts/entity/tactical/enemies/sand_golem_high"
	},
	Militia = {
		ID = this.Const.EntityType.Militia,
		Variant = 0,
		Strength = 9,
		Cost = 10,
		Row = 0,
		Script = "scripts/entity/tactical/humans/militia"
	},
	MilitiaRanged = {
		ID = this.Const.EntityType.MilitiaRanged,
		Variant = 0,
		Strength = 12,
		Cost = 10,
		Row = 1,
		Script = "scripts/entity/tactical/humans/militia_ranged"
	},
	MilitiaVeteran = {
		ID = this.Const.EntityType.MilitiaVeteran,
		Variant = 0,
		Strength = 14,
		Cost = 12,
		Row = 0,
		Script = "scripts/entity/tactical/humans/militia_veteran"
	},
	MilitiaCaptain = {
		ID = this.Const.EntityType.MilitiaCaptain,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/militia_captain"
	},
	BountyHunter = {
		ID = this.Const.EntityType.BountyHunter,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/bounty_hunter"
	},
	BountyHunterRanged = {
		ID = this.Const.EntityType.BountyHunter,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/bounty_hunter_ranged"
	},
	Peasant = {
		ID = this.Const.EntityType.Peasant,
		Variant = 0,
		Strength = 4,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/peasant"
	},
	SouthernPeasant = {
		ID = this.Const.EntityType.PeasantSouthern,
		Variant = 0,
		Strength = 4,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/peasant_southern"
	},
	PeasantArmed = {
		ID = this.Const.EntityType.Peasant,
		Variant = 0,
		Strength = 5,
		Cost = 10,
		Row = -1,
		Script = "scripts/entity/tactical/humans/peasant_armed"
	},
	Mercenary = {
		ID = this.Const.EntityType.Mercenary,
		Variant = 0,
		Strength = 30,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/mercenary"
	},
	MercenaryLOW = {
		ID = this.Const.EntityType.Mercenary,
		Variant = 0,
		Strength = 20,
		Cost = 18,
		Row = 0,
		Script = "scripts/entity/tactical/humans/mercenary_low"
	},
	MercenaryRanged = {
		ID = this.Const.EntityType.Mercenary,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/mercenary_ranged"
	},
	Swordmaster = {
		ID = this.Const.EntityType.Swordmaster,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/swordmaster",
		NameList = this.Const.Strings.CharacterNames,
		TitleList = this.Const.Strings.SwordmasterTitles
	},
	HedgeKnight = {
		ID = this.Const.EntityType.HedgeKnight,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/hedge_knight",
		NameList = this.Const.Strings.HedgeKnightTitles,
		TitleList = null
	},
	MasterArcher = {
		ID = this.Const.EntityType.MasterArcher,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/master_archer",
		NameList = this.Const.Strings.MasterArcherNames,
		TitleList = null
	},
	Cultist = {
		ID = this.Const.EntityType.Cultist,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = -1,
		Script = "scripts/entity/tactical/humans/cultist"
	},
	CultistAmbush = {
		ID = this.Const.EntityType.Cultist,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = -2,
		Script = "scripts/entity/tactical/humans/cultist"
	},
	CaravanHand = {
		ID = this.Const.EntityType.CaravanHand,
		Variant = 0,
		Strength = 9,
		Cost = 10,
		Row = 2,
		Script = "scripts/entity/tactical/humans/caravan_hand"
	},
	CaravanGuard = {
		ID = this.Const.EntityType.CaravanGuard,
		Variant = 0,
		Strength = 14,
		Cost = 14,
		Row = 2,
		Script = "scripts/entity/tactical/humans/caravan_guard"
	},
	CaravanDonkey = {
		ID = this.Const.EntityType.CaravanDonkey,
		Variant = 0,
		Strength = 10,
		Cost = 0,
		Row = 3,
		Script = "scripts/entity/tactical/objective/donkey"
	},
	ArmoredWardog = {
		ID = this.Const.EntityType.Wardog,
		Variant = 0,
		Strength = 9,
		Cost = 8,
		Row = 0,
		Script = "scripts/entity/tactical/armored_wardog"
	},
	Footman = {
		ID = this.Const.EntityType.Footman,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/humans/noble_footman"
	},
	Greatsword = {
		ID = this.Const.EntityType.Greatsword,
		Variant = 0,
		Strength = 30,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_greatsword"
	},
	Billman = {
		ID = this.Const.EntityType.Billman,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_billman"
	},
	Arbalester = {
		ID = this.Const.EntityType.Arbalester,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/noble_arbalester"
	},
	StandardBearer = {
		ID = this.Const.EntityType.StandardBearer,
		Variant = 0,
		Strength = 25,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/standard_bearer"
	},
	Sergeant = {
		ID = this.Const.EntityType.Sergeant,
		Variant = 0,
		Strength = 30,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/noble_sergeant"
	},
	Knight = {
		ID = this.Const.EntityType.Knight,
		Variant = 2,
		Strength = 40,
		Cost = 35,
		Row = 2,
		Script = "scripts/entity/tactical/humans/knight",
		NameList = this.Const.Strings.KnightNames,
		TitleList = null
	},
	MilitaryDonkey = {
		ID = this.Const.EntityType.MilitaryDonkey,
		Variant = 0,
		Strength = 10,
		Cost = 0,
		Row = 3,
		Script = "scripts/entity/tactical/objective/donkey_military"
	},
	Wardog = {
		ID = this.Const.EntityType.Wardog,
		Variant = 0,
		Strength = 9,
		Cost = 8,
		Row = 0,
		Script = "scripts/entity/tactical/wardog"
	},
	BanditThug = {
		ID = this.Const.EntityType.BanditThug,
		Variant = 0,
		Strength = 9,
		Cost = 9,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_thug"
	},
	BanditMarksman = {
		ID = this.Const.EntityType.BanditMarksman,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/bandit_marksman"
	},
	BanditMarksmanLOW = {
		ID = this.Const.EntityType.BanditPoacher,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 1,
		Script = "scripts/entity/tactical/enemies/bandit_poacher"
	},
	BanditRaider = {
		ID = this.Const.EntityType.BanditRaider,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_raider"
	},
	BanditRaiderLOW = {
		ID = this.Const.EntityType.BanditRaider,
		Variant = 0,
		Strength = 15,
		Cost = 16,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_raider_low"
	},
	BanditRaiderWolf = {
		ID = this.Const.EntityType.Direwolf,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/bandit_raider_wolf"
	},
	BanditLeader = {
		ID = this.Const.EntityType.BanditLeader,
		Variant = 1,
		Strength = 30,
		Cost = 25,
		Row = 2,
		Script = "scripts/entity/tactical/enemies/bandit_leader",
		NameList = this.Const.Strings.BanditLeaderNames,
		TitleList = null
	},
	NomadCutthroat = {
		ID = this.Const.EntityType.NomadCutthroat,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 0,
		Script = "scripts/entity/tactical/humans/nomad_cutthroat"
	},
	NomadArcher = {
		ID = this.Const.EntityType.NomadArcher,
		Variant = 0,
		Strength = 15,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/humans/nomad_archer"
	},
	NomadSlinger = {
		ID = this.Const.EntityType.NomadSlinger,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 1,
		Script = "scripts/entity/tactical/humans/nomad_slinger"
	},
	NomadOutlaw = {
		ID = this.Const.EntityType.NomadOutlaw,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/nomad_outlaw"
	},
	NomadLeader = {
		ID = this.Const.EntityType.NomadLeader,
		Variant = 1,
		Strength = 30,
		Cost = 30,
		Row = 2,
		Script = "scripts/entity/tactical/humans/nomad_leader",
		NameList = this.Const.Strings.SouthernNames,
		TitleList = this.Const.Strings.NomadChampionTitles
	},
	DesertDevil = {
		ID = this.Const.EntityType.DesertDevil,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/desert_devil",
		NameList = this.Const.Strings.DesertDevilChampionTitles,
		TitleList = null
	},
	Executioner = {
		ID = this.Const.EntityType.Executioner,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/executioner",
		NameList = this.Const.Strings.ExecutionerChampionTitles,
		TitleList = null
	},
	DesertStalker = {
		ID = this.Const.EntityType.DesertStalker,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/desert_stalker",
		NameList = this.Const.Strings.SouthernNames,
		TitleList = this.Const.Strings.DesertStalkerChampionTitles
	},
	Warhound = {
		ID = this.Const.EntityType.Warhound,
		Variant = 0,
		Strength = 10,
		Cost = 10,
		Row = 0,
		Script = "scripts/entity/tactical/warhound"
	},
	BarbarianThrall = {
		ID = this.Const.EntityType.BarbarianThrall,
		Variant = 0,
		Strength = 12,
		Cost = 12,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_thrall"
	},
	BarbarianMarauder = {
		ID = this.Const.EntityType.BarbarianMarauder,
		Variant = 0,
		Strength = 25,
		Cost = 25,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_marauder"
	},
	BarbarianChampion = {
		ID = this.Const.EntityType.BarbarianChampion,
		Variant = 1,
		Strength = 35,
		Cost = 35,
		Row = 0,
		Script = "scripts/entity/tactical/humans/barbarian_champion",
		NameList = this.Const.Strings.BarbarianNames,
		TitleList = this.Const.Strings.BarbarianTitles
	},
	BarbarianChosen = {
		ID = this.Const.EntityType.BarbarianChosen,
		Variant = 10,
		Strength = 999,
		Cost = 45,
		Row = 1,
		Script = "scripts/entity/tactical/humans/barbarian_chosen",
		NameList = [
			"北方之王"
		],
		TitleList = [
			""
		]
	},
	BarbarianDrummer = {
		ID = this.Const.EntityType.BarbarianDrummer,
		Variant = 0,
		Strength = 30,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/humans/barbarian_drummer"
	},
	BarbarianUnhold = {
		ID = this.Const.EntityType.BarbarianUnhold,
		Variant = 0,
		Strength = 50,
		Cost = 55,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/unhold_armored"
	},
	BarbarianUnholdFrost = {
		ID = this.Const.EntityType.BarbarianUnholdFrost,
		Variant = 0,
		Strength = 70,
		Cost = 75,
		Row = 0,
		Script = "scripts/entity/tactical/enemies/unhold_frost_armored"
	},
	BarbarianBeastmaster = {
		ID = this.Const.EntityType.BarbarianBeastmaster,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 2,
		Script = "scripts/entity/tactical/humans/barbarian_beastmaster"
	},
	Slave = {
		ID = this.Const.EntityType.Slave,
		Variant = 0,
		Strength = 7,
		Cost = 7,
		Row = 0,
		Script = "scripts/entity/tactical/humans/slave"
	},
	NorthernSlave = {
		ID = this.Const.EntityType.Slave,
		Variant = 0,
		Strength = 7,
		Cost = 7,
		Row = 0,
		Script = "scripts/entity/tactical/humans/slave_northern"
	},
	Conscript = {
		ID = this.Const.EntityType.Conscript,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 0,
		Script = "scripts/entity/tactical/humans/conscript"
	},
	ConscriptPolearm = {
		ID = this.Const.EntityType.Conscript,
		Variant = 0,
		Strength = 20,
		Cost = 15,
		Row = 1,
		Script = "scripts/entity/tactical/humans/conscript_polearm"
	},
	Officer = {
		ID = this.Const.EntityType.Officer,
		Variant = 1,
		Strength = 35,
		Cost = 25,
		Row = 1,
		Script = "scripts/entity/tactical/humans/officer",
		NameList = this.Const.Strings.SouthernNames,
		TitleList = this.Const.Strings.SouthernOfficerTitles
	},
	Gunner = {
		ID = this.Const.EntityType.Gunner,
		Variant = 0,
		Strength = 20,
		Cost = 20,
		Row = 1,
		Script = "scripts/entity/tactical/humans/gunner"
	},
	Engineer = {
		ID = this.Const.EntityType.Engineer,
		Variant = 0,
		Strength = 10,
		Cost = 10,
		Row = 2,
		Script = "scripts/entity/tactical/humans/engineer"
	},
	Mortar = {
		ID = this.Const.EntityType.Mortar,
		Variant = 0,
		Strength = 30,
		Cost = 20,
		Row = 2,
		Script = "scripts/entity/tactical/objective/mortar"
	},
	Gladiator = {
		ID = this.Const.EntityType.Gladiator,
		Variant = 2,
		Strength = 40,
		Cost = 40,
		Row = 0,
		Script = "scripts/entity/tactical/humans/gladiator",
		NameList = this.Const.Strings.SouthernNames,
		TitleList = this.Const.Strings.GladiatorTitles
	},
	Assassin = {
		ID = this.Const.EntityType.Assassin,
		Variant = 0,
		Strength = 35,
		Cost = 35,
		Row = 1,
		Script = "scripts/entity/tactical/humans/assassin"
	},
	SouthernDonkey = {
		ID = this.Const.EntityType.CaravanDonkey,
		Variant = 0,
		Strength = 10,
		Cost = 0,
		Row = 3,
		Script = "scripts/entity/tactical/objective/donkey_southern"
	},
	Oathbringer = {
		ID = this.Const.EntityType.Oathbringer,
		Variant = 1,
		Strength = 40,
		Cost = 40,
		Row = 1,
		Script = "scripts/entity/tactical/humans/oathbringer",
		NameList = this.Const.Strings.OathbringerNames,
		TitleList = null
	}
};
gt.Const.World.Spawn.Caravan <- [
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 1
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 5
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 8
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanGuard,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.Mercenary,
				Num = 6
			},
			{
				Type = this.Const.World.Spawn.Troops.MercenaryRanged,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	}
];
gt.Const.World.Spawn.CaravanEscort <- [
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 1
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 2
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 2
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 3
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	},
	{
		Cost = 0,
		MovementSpeedMult = 0.5,
		VisibilityMult = 1.0,
		VisionMult = 0.25,
		Body = "cart_02",
		Troops = [
			{
				Type = this.Const.World.Spawn.Troops.CaravanHand,
				Num = 4
			},
			{
				Type = this.Const.World.Spawn.Troops.CaravanDonkey,
				Num = 3
			}
		]
	}
];
function onCostCompare( _t1, _t2 )
{
	if (_t1.Cost < _t2.Cost)
	{
		return -1;
	}
	else if (_t1.Cost > _t2.Cost)
	{
		return 1;
	}

	return 0;
}

function calculateCosts( _p )
{
	foreach( p in _p )
	{
		p.Cost <- 0;

		foreach( t in p.Troops )
		{
			p.Cost += t.Type.Cost * t.Num;
		}

		if (!("MovementSpeedMult" in p))
		{
			p.MovementSpeedMult <- 1.0;
		}
	}

	_p.sort(this.onCostCompare);
}

this.calculateCosts(this.Const.World.Spawn.Caravan);
this.calculateCosts(this.Const.World.Spawn.CaravanEscort);

