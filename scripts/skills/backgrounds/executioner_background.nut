// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/skills/backgrounds/executioner_background.nut
// Functions: 8

function create(this)
{
    this.character_background.create();
    this.m.ID = "background.executioner";
    this.m.Name = "Executioner";
    this.m.Icon = "ui/backgrounds/background_72.png";
    this.m.BackgroundDescription = "Executioners are dour and used to violence, although they have little experience in true warfare.";
    this.m.GoodEnding = "While the %companyname% visited a town for rest and recuperation, a local princess took a shine to %name% the wildman. He was 'purchased' for a large sum of gold and given to the noblewoman. You went and visited the man recently. For dinner, he sat at a kingly table, grinning goofily and mimicking the nobles around him as best he could. His new and inexplicable wife adored him, and him her. When you said your goodbyes, he offered you a heavy golden crown off the top of his head. It weighed heavy with traditions and ancient histories. You said it'd be best if he kept it. The wildman shrugged and walked off, spinning the circlet around a finger.";
    this.m.BadEnding = "%name% the wildman stayed with the fragmenting %companyname% for a time and then, just like that, he was gone. The company went out looking for him in a forest, eventually finding some sort of crude note: an enormous pile of crowns next to a dirt-drawing of the %companyname% and some of its members, all of them being hugged by a big, literal stick figure with a goofy smile on its face. There was also an offering of a dead, half-eaten rabbit.";
    this.m.HiringCost = 100;
    this.m.DailyCost = 12;
    this.m.Excluded = ["trait.fragile", "trait.teamplayer", "trait.hate_beasts", "trait.hate_greenskins", "trait.hate_undead", "trait.lucky", "trait.clubfooted", "trait.cocky", "trait.clumsy", "trait.hesitant", "trait.fainthearted", "trait.craven", "trait.fearless", "trait.optimist"];
    this.m.ExcludedTalents = [this.Const.Attributes.RangedSkill];
    this.m.Titles = ["Headtaker", "Neckrender", "the Axe", "the Judicator", "the Headsman", "the Executioner", "the Hangman"];
    this.m.Faces = this.Const.Faces.AllMale;
    this.m.Hairs = this.Const.Hair.UntidyMale;
    this.m.HairColors = this.Const.HairColors.All;
    this.m.Beards = this.Const.Beards.All;
    this.m.BeardChance = 50;
    this.m.Bodies = this.Const.Bodies.Big;
    this.m.Level = this.Math.rand(1, 3);
    return;
}

function getTooltip(this)
{
    return [{id = 1, type = "title", text = this.getName()}, {id = 2, type = "description", text = this.getDescription()}, {id = 11, type = "text", icon = "ui/icons/chance_to_hit_head.png", text = "Higher Chance To Hit Head"}];
}

function onAddEquipment(this)
{
    if (this.Const.DLC.Wildmen)
    {
        [].extend([]);
    }
    this.getContainer().getActor().getItems().equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    if (this.Math.rand(0, 100) < 66)
    {
        this.getContainer().getActor().getItems().equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    }
    this.getContainer().getActor().getItems().equip(this.new(("scripts/items/" + []["this.Math.rand(0, ([].len() - 1))"])));
    return;
}

function onBuildDescription(this)
{
    return "{As with many men, %name%'s direction in life was dictated by the family business: executing criminals for the burgomeister of %randomtown%. | As a boy, %name% dreamed of becoming a knight clad in shining armor. As a man, he became an executioner clad in a dark hood. | %name%'s whole family was slain in a bandit raid. Unable to join the manhunt himself, he became an apprentice to the local executioner in the hopes of one day meting out revenge in his own way. | Once a brigand himself, %name% had a change of heart and turned himself in. The local guard offered him a pardon if he agreed to execute any criminals they captured, and he's been in the trade ever since. | With the distant stare of one who has seen much death, and the worn blade of one who has dealt it, it's obvious that %name% is an executioner. | An executioner, %name% is about as cheerful as the gallows he operates.} {Though content with his profession, it made him unpopular. After carrying out the beheading of {a local youth sentenced for stealing from a noble | a beloved whore who slept with the wrong lord | a respected craftsman accused of embezzling}, he was ostracized by the townsfolk. | He always viewed himself as a necessary, if grisly, part of law for the common folk. But when he learned {his employer was making backroom deals with brigands | the local lord was ordering the deaths of the innocent | a man he executed was innocent | of the horrible things the local lord did with the heads of the condemned}, he resigned his post in disgust. | One day he was tasked with killing a strange cultist from distant lands. After he broke a third blade halfway through the strangely cheerful man's neck, he decided it was time to find a new profession. | But one day he woke up and found he could no longer stomach the idea of slaying a man who couldn't fight back. | But eventually he grew unhappy with his role, finding little satisfaction in slaying men after they'd already performed their evil works.} {With few other careers available to him, %name% decided mercenary work seemed the best fit for his talents. | While not a warrior, %name% knows how to handle a blade, and so sellswording was the obvious career change. | With a skillset predominantly based around necklines, %name% decided he could either become a mercenary or a tailor. The former seemed like it paid better, and now here he is. | In need of a new career but with few other skills, %name% decided that mercenary work was sort of like executing with more steps.} {The man stands silently before you, staring wide-eyed and expectant but not saying a word. Ok then. | Less confident in conversation than in killing, he mumbles out a nervous greeting to you and asks about pay. | Not much for words, he grunts expectantly at you. As long as he can kill, you suppose you don't mind the quiet. | He approaches and barks something at you that his heavy hood muffles beyond comprehension. After a few moments of silence he follows up with '...please?' and you realize he's asking to join the company. Oh.}";
}

function onChangeAttributes(this)
{
    return {Hitpoints = [], Bravery = [], Stamina = [], MeleeSkill = [], RangedSkill = [], MeleeDefense = [], RangedDefense = [], Initiative = []};
}

function onSetAppearance(this)
{
    if (this.Math.rand(1, 100) <= 25)
    {
        this.getContainer().getActor().getSprite("tattoo_body").setBrush(("scar_02_" + this.getContainer().getActor().getSprite("body").getBrush().Name));
        this.getContainer().getActor().getSprite("tattoo_body").Visible = true;
    }
    if (this.Math.rand(1, 100) <= 25)
    {
        this.getContainer().getActor().getSprite("tattoo_head").setBrush("scar_02_head");
        this.getContainer().getActor().getSprite("tattoo_head").Visible = true;
    }
    return;
}

function onUpdate(this, _properties)
{
    this.character_background.onUpdate(_properties);
    _properties.HitChance["this.Const.BodyPart.Head"] = _properties.HitChance["this.Const.BodyPart.Head"] op43 10;
    return;
}

function updateAppearance(this)
{
    if (this.getContainer().getActor().getSprite("tattoo_body").HasBrush)
    {
        this.getContainer().getActor().getSprite("tattoo_body").setBrush(("scar_02_" + this.getContainer().getActor().getSprite("body").getBrush().Name));
    }
    return;
}
