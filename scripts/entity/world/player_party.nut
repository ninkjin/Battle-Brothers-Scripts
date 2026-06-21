// Decompiled from Battle Brothers memory (v3 - correct opcodes)
// Source: scripts/entity/world/player_party.nut
// Functions: 14

function create(this)
{
    this.m.IsPlayer = true;
    this.m.IsAttackable = true;
    this.m.IsLeavingFootprints = false;
    this.party.create();
    this.m.BaseMovementSpeed = 105;
    return;
}

function getStrength(this)
{
    return this.m.Strength;
}

function getVisibilityMult(this)
{
    if (this.World.Assets.isCamping())
    {
        if (this.World.getTime().IsDaytime)
        {
        }
    }
    return this.m.VisibilityMult;
}

function getVisionRadius(this)
{
    if (this.World.Assets.isCamping())
    {
    }
    return ((((this.m.VisionRadius * this.World.Assets.m.VisionRadiusMult) * this.World.getGlobalVisibilityMult()) * this.Const.World.TerrainTypeVisionRadiusMult["this.getTile().Type"]) * 1.0);
}

function onContact(this)
{
    return;
}

function onDeserialize(this, _in)
{
    this.party.onDeserialize(_in);
    this.getSprite("lighting").Color = this.createColor("ffffff00");
    this.m.LastUpdateTime = this.Time.getVirtualTimeF();
    return;
}

function onFinish(this)
{
    this.party.onFinish();
    return;
}

function onInit(this)
{
    this.setFaction(this.Const.FactionType.Player);
    this.party.onInit();
    this.m.VisionRadius = this.Const.World.Settings.Vision;
    this.getSprite("base").setBrush("world_base_01");
    this.getSprite("banner").setBrush(this.World.Assets.getBanner());
    this.getSprite("body").setBrush("figure_player_01");
    this.setSpriteColorization("lighting", false);
    this.addSprite("lighting").setBrush("world_player_camp_01_fire");
    this.addSprite("lighting").Visible = false;
    this.addSprite("lighting").Alpha = 0;
    this.addSprite("lighting").IgnoreAmbientColor = true;
    this.addSprite("zoom_banner").setBrush(this.World.Assets.getBanner());
    this.addSprite("zoom_banner").Alpha = 0;
    this.setSpriteScaling("zoom_banner", false);
    return;
}

function onLevelCompare(this, _bro1, _bro2)
{
    if (_bro1.getLevel() > _bro2.getLevel())
    {
        return _bro1;
    }
    else
    {
        if (_bro1.getLevel() < _bro2.getLevel())
        {
            return _bro1;
        }
    }
    return _bro1;
}

function onSerialize(this, _out)
{
    this.party.onSerialize(_out);
    return;
}

function onUpdate(this)
{
    this.party.onUpdate();
    this.World.setPlayerPos(this.getPos());
    this.World.setPlayerVisionRadius(this.getVisionRadius());
    if (this.World.Assets.isCamping())
    {
        if (this.getSprite("lighting").IsFadingDone)
        {
            if ((this.World.getTime().TimeOfDay <= 7) && (this.World.getTime().TimeOfDay <= 7))
            {
                return ((this.World.getTime().TimeOfDay <= 7) && (this.World.getTime().TimeOfDay <= 7));
                this.getSprite("lighting").Color = this.createColor("ffffff00");
                this.getSprite("lighting").fadeIn(4000);
            }
            else
            {
                if ((this.World.getTime().TimeOfDay <= 3) && (this.World.getTime().TimeOfDay <= 3))
                {
                    return ((this.World.getTime().TimeOfDay <= 3) && (this.World.getTime().TimeOfDay <= 3));
                    this.getSprite("lighting").fadeOut(2000);
                }
            }
        }
        if ((this.Time.getRealTimeF() - this.m.LastFireTime) >= 10.0)
        {
            this.spawnFire();
            this.m.LastFireTime = this.Time.getRealTimeF();
        }
    }
    return;
}

function setCamping(this, _c)
{
    if (_c)
    {
        this.getSprite("body").setBrush("world_player_camp_01");
        this.getSprite("banner").Visible = false;
        this.getSprite("lighting").Visible = true;
    }
    this.World.Assets.updateLook();
    this.getSprite("banner").Visible = true;
    this.getSprite("lighting").Visible = false;
    return;
}

function spawnFire(this)
{
    if (0 < this.Const.World.CampSmokeParticles.len())
    {
        this.World.spawnParticleEffect(this.Const.World.CampSmokeParticles["0"].Brushes, this.Const.World.CampSmokeParticles["0"].Delay, this.Const.World.CampSmokeParticles["0"].Quantity, this.Const.World.CampSmokeParticles["0"].LifeTime, this.Const.World.CampSmokeParticles["0"].SpawnRate, this.Const.World.CampSmokeParticles["0"].Stages, this.createVec(this.getPos().X, (this.getPos().Y - 30)), (-200 + this.Const.World.ZLevel.Particles), true);
    }
    if (0 < this.Const.World.CampFireParticles.len())
    {
        this.World.spawnParticleEffect(this.Const.World.CampFireParticles["0"].Brushes, this.Const.World.CampFireParticles["0"].Delay, this.Const.World.CampFireParticles["0"].Quantity, this.Const.World.CampFireParticles["0"].LifeTime, this.Const.World.CampFireParticles["0"].SpawnRate, this.Const.World.CampFireParticles["0"].Stages, this.createVec(this.getPos().X, (this.getPos().Y - 30)), ((-200 + this.Const.World.ZLevel.Particles) - 3), true);
    }
    return;
}

function updateStrength(this)
{
    this.m.Strength = 0.0;
    if (this.World.getPlayerRoster().getAll().len() > this.World.Assets.getBrothersScaleMax())
    {
        this.World.getPlayerRoster().getAll().sort(this.onLevelCompare);
    }
    if (this.World.getPlayerRoster().getAll().len() < this.World.Assets.getBrothersScaleMin())
    {
        this.m.Strength = this.m.Strength op43 (10.0 * (this.World.Assets.getBrothersScaleMin() - this.World.getPlayerRoster().getAll().len()));
    }
    foreach (local key, value in r22)
    {
        if (null >= this.World.Assets.getBrothersScaleMax())
        {
        }
        this.m.Strength = this.m.Strength op43 (10.0 + ((null.getLevel() - 1) * 2.0));
        return;
    }
}
