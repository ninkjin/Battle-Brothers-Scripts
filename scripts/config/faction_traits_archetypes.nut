local gt = this.getroottable();
gt.Const.FactionArchetypes <- [
	[
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Warmonger,
				this.Const.FactionTrait.ManOfThePeople
			],
			Description = "%noblehousename% 家族成立的根基是一个宗教教派，他们的教义教导他们要对自己人施以同情和关怀，但也让他们在面对敌人时充满狂热，毫不留情。 在几代人以前，一场大规模的兽人入侵掠夺并摧毁了曾属于这个家族的绝大部分财产，造成了直至今日仍未恢复的损失。 自那以后，这个家族派遣了许多支打着圣战与复仇旗号的远征军深入兽人领地的心腹，但却从未能够将绿皮从大陆上真正一劳永逸地抹除。",
			Mottos = [
				"唯有美德堪称高贵",
				"誓死捍卫受难之人",
				"热忱与荣耀",
				"狂怒的贵族",
				"让火焰净化一切",
				"战火铸就和平",
				"希望永存",
				"光荣而勇猛",
				"我们蔑视变革与恐惧",
				"胜利高于一切",
				"黑暗中的灯塔",
				"齐心协力，众志成城"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Sheriff,
				this.Const.FactionTrait.ManOfThePeople
			],
			Description = "%noblehousename% 坚信正义与荣耀的原则，他们的领地因远离不公正的裁决而繁荣昌盛。他们或许因儒雅随和而闻名，但 %noblehousename% 家族的骑士却都身经百战，而且他们的军队时刻准备着与任何胆敢威胁他们的领土、下属和原则的敌人进行殊死决斗。许多贵族都觊觎他们的财富，嘲笑他们的信条；其中尤以 %othernoblehouse% 为甚，他们那些怨恨都或多或少的作用给了 %noblehousename%。",
			Mottos = [
				"为你自己而活",
				"友谊不容虚伪",
				"敢为睿智者",
				"勇者仁心",
				"予我以爱，必还之以花",
				"此地无暴虐无道者容身之处",
				"不要惹怒雄狮",
				"虽饱经沧桑，仍坚毅不拔",
				"心口如一",
				"时刻警惕着",
				"荣耀归于长者",
				"美德源于力量",
				"时刻准备就绪",
				"富则兼济天下，绝不独善其身"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Sheriff,
				this.Const.FactionTrait.Collector
			],
			Description = "许多人都追求财富，但 %noblehousename% 的诚信商人们尤其懂得抓住机遇与和气生财之道。 在他们祖先的高尚名声下，他们恪守着诚实与正直作为他们的家族价值观。",
			Mottos = [
				"理性乃人生向导",
				"行动当机立断，礼仪温和得体",
				"我们用事实说话",
				"身正不怕影子斜",
				"阳光总在风雨后",
				"困难使我们勇敢",
				"勤奋是富有之本"
			]
		}
	],
	[
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Warmonger,
				this.Const.FactionTrait.Tyrant
			],
			Description = "%noblehousename% 家族高傲而无情，有着悠久而血腥的征服家史。 安坐在他们家族的 %factionfortressname% 堡垒中，他们心安理得地用暴力夺取他们想要的一切。 他们与 %othernoblehouse% 家族间的世仇给了他们数不清的理由来让怒火同时在两个家族人们的心头和兵工厂的熔炉中熊熊燃烧。",
			Mottos = [
				"我们恃强自立",
				"逆来顺受者死有余辜",
				"凶暴勇猛，理直气壮",
				"以家徽之名征服",
				"名声乃身外之物",
				"绝不后退",
				"穿破箭雨，突破敌军",
				"勇猛与利刃无物可挡",
				"征服书写不朽",
				"我们厉兵秣马",
				"苍鹰生而只为身居高位"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Warmonger,
				this.Const.FactionTrait.Marauder
			],
			Description = "因为他们的冷酷无情与贪得无厌而饱受唾弃的 %noblehousename% 家族与其他贵族家族相交甚少。 他们麾下来自 %factionfortressname% 要塞的队长与士兵因劫掠商队、农场与聚落而闻名 人命在 %noblehousename% 家族的领地里一文不值，许多雇佣兵来到他们的领地希望赚笔快钱，而他们所获的唯一事物就是速死。",
			Mottos = [
				"万物终归于尘土",
				"我们践踏一切",
				"为了我们和我们还有我们",
				"猎鹰不食飞蝇",
				"行动胜于空谈",
				"天佑渡鸦",
				"渴望永无止境",
				"猎犬之子嗣于此猎食",
				"留下买路财"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Schemer,
				this.Const.FactionTrait.Tyrant
			],
			Description = "与其说 %noblehousename% 被人憎恨，不如说他们被人所畏惧。 无数次大大小小的起义被烈火与长剑所镇压，%noblehousename% 家族的追随者充斥在每一个阴暗的角落与每一面墙背后。 在他们祖传的 %factionfortressname% 要塞中，数不胜数的武装警卫、警惕的战犬和规模庞大的雇佣兵团拱卫着家族那偏执的领导者。",
			Mottos = [
				"当心你的背后",
				"旧的不去，新的不来",
				"整装待发",
				"守望永不停歇",
				"武力维持和平",
				"清白如鸽",
				"坚定不移",
				"服从",
				"以法律与武力之名",
				"如果无法反抗，那就忍受",
				"雄狮之怒，依然高贵"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Marauder,
				this.Const.FactionTrait.Tyrant
			],
			Description = "%noblehousename% 以其奢华的生活方式和纵情享乐的节日而闻名。 如此盛宴总得有人来为其买单，所以饿到半死不活的耕牛、空空荡荡的粮仓和目光无神的镇民在 %noblehousename% 的治下是再正常不过的现象。 尽管其他贵族都看不起这种残暴和奢侈无度，但他们也同时都在绝望地等待下一次宴会的邀请。",
			Mottos = [
				"不可战胜",
				"流言蜚语止步",
				"一飞冲天",
				"理由充分",
				"施以轻蔑",
				"羊毛出在羊身上",
				"拒绝节俭",
				"富贵险中求",
				"铭记在心，人终有一死"
			]
		}
	],
	[
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Schemer,
				this.Const.FactionTrait.Collector
			],
			Description = "俗话说商场如战场，而 %noblehousename% 家族正是对讨价还价，锱铢必较的狡诈商法登峰造极的大师。 据传言称，%noblehousename% 所进行的许多利润丰厚的交易都不只是基于诚实守信的贸易，而是更通过贿赂、敲诈与骗术所达成。 这个家族居住在他们富丽堂皇的地区首府 %factionfortressname% 要塞中，尽管他们的财富不可估量，但他们的小气抠门也同样是出了名的。",
			Mottos = [
				"忠实于自己的愿望而活",
				"幸运眷顾敢于豪赌之人",
				"这个世界还不够好",
				"诚实与实用不可相提并论",
				"我们的丰收终将到来",
				"灾难带给我们财富"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.ManOfThePeople,
				this.Const.FactionTrait.Collector
			],
			Description = "%noblehousename% 家族自称他们的家史从人类第一次踏足这片大陆，以及第一任帝王登基统治以来就已经开始了。 尽管他们现在只不过是众多普普通通的贵族家族之一，但他们为自己家族的古老传统深感荣耀，并胸怀野心，渴望再次亲自书写历史。 现在，随着他们的名望和财产一点点地减少，据说他们开始资助探险者们，试图从过去那些沉沦的都市与早已被人遗忘的地方发掘失落的宝藏。",
			Mottos = [
				"活得好等于活了两次",
				"财富属于知道如何使用它的人",
				"只有锁起来的东西才是安全的东西",
				"一如既往",
				"评估与测量",
				"狂涛巨浪，能奈我何",
				"人人为我",
				"风帆与船桨",
				"敢为天下先"
			]
		},
		{
			Traits = [
				this.Const.FactionTrait.NobleHouse,
				this.Const.FactionTrait.Marauder,
				this.Const.FactionTrait.Schemer
			],
			Description = "绝大多数 %noblehousename% 家族的成员都生活在厚厚的门窗后面，有些人甚至已经好几年没有抛头露面了。 有传言说他们高贵的血脉中流淌着疯狂与错乱的诅咒，但因为害怕他们的报复，从来没人敢当众说出这样的话。 其他的贵族多数情况下都会避免与 %noblehousename% 进行接触，因为去他们那拜访的客人有可能会同时受到敞开的双臂与弓弩的箭矢作为欢迎。",
			Mottos = [
				"无人永生",
				"预想你的终末",
				"我们不蔑视别人，我们亦无所畏惧",
				"我们不接受评判",
				"时代变了",
				"人不为己天诛地灭",
				"一切都如此反复无常",
				"当心狼群"
			]
		}
	]
];
gt.Const.CityStateArchetypes <- [
	{
		Traits = [
			this.Const.FactionTrait.OrientalCityState
		],
		Description = "一个富裕而独立的城邦主要专注于贸易和获取更多财富。",
		Mottos = [
			"和平生活的人生活得很好",
			"财富是我们的箭",
			"财富是我们的剑",
			"远处的金塔",
			"归还的礼物",
			"没有付出就没有收获"
		]
	},
	{
		Traits = [
			this.Const.FactionTrait.OrientalCityState
		],
		Description = "一个致力于获取最重要的知识的城邦——即使是以尸检、阅读禁书或与不属于这个世界的邪恶势力交往为代价。",
		Mottos = [
			"敢为睿智者",
			"智慧是财富的征服者",
			"阅读和学习",
			"智慧城堡",
			"终于有了知识"
		]
	},
	{
		Traits = [
			this.Const.FactionTrait.OrientalCityState
		],
		Description = "一个由无情的议会统治的城邦，它不择手段地获得权力。据传，许多离奇的死亡案都是 %citystatename% 的大臣下令暗杀的。",
		Mottos = [
			"草丛中的蛇",
			"利用好阴影",
			"尽一切办法",
			"鹰捉不到苍蝇"
		]
	}
];

