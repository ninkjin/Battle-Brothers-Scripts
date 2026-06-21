this.councilman <- this.inherit("scripts/entity/tactical/human", {
	m = {},
	function create()
	{
		this.m.Type = this.Const.EntityType.Knight;
		this.m.BloodType = this.Const.BloodType.Red;
		this.m.XP = this.Const.Tactical.Actor.Councilman.XP;
		this.m.Name = this.generateName();

		if (this.Math.rand(1, 100) <= 75)
		{
			local titles = [
				"智者",
				"长老",
				"年轻人",
				"议员",
				"商人",
				"参议",
				"管家",
				"市长",
				"工会长",
				"司库",
				"贸易主管"
			];
			this.m.Title = titles[this.Math.rand(0, titles.len() - 1)];
		}

		this.human.create();
		this.m.Faces = this.Const.Faces.AllMale;
		this.m.Hairs = this.Const.Hair.CommonMale;
		this.m.HairColors = this.Const.HairColors.All;
		this.m.Beards = this.Const.Beards.All;
		this.m.AIAgent = this.new("scripts/ai/tactical/agents/military_melee_agent");
		this.m.AIAgent.setActor(this);
	}

	function generateName()
	{
		return this.Const.Strings.CharacterNames[this.Math.rand(0, this.Const.Strings.CharacterNames.len() - 1)];
	}

	function onInit()
	{
		this.human.onInit();
		local b = this.m.BaseProperties;
		b.setValues(this.Const.Tactical.Actor.Councilman);
		this.m.ActionPoints = b.ActionPoints;
		this.m.Hitpoints = b.Hitpoints;
		this.m.CurrentProperties = clone b;
		this.getSprite("socket").setBrush("bust_base_military");
	}

	function assignRandomEquipment()
	{
		local r;
		r = this.Math.rand(1, 11);
		local withDetail = true;
		local withHelmet = true;

		if (r <= 7)
		{
			this.m.Items.equip(this.new("scripts/items/armor/linen_tunic"));

			if (this.Math.rand(1, 100) <= 33)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
				withHelmet = false;
			}
		}
		else if (r <= 9)
		{
			this.m.Items.equip(this.new("scripts/items/armor/noble_tunic"));
		}
		else if (r == 10)
		{
			this.m.Items.equip(this.new("scripts/items/armor/monk_robe"));
			withDetail = false;
			withHelmet = false;
		}
		else if (r == 11)
		{
			this.m.Items.equip(this.new("scripts/items/armor/wizard_robe"));
			withDetail = false;

			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/wizard_hat"));
				withHelmet = false;
			}
		}

		if (withDetail && this.Math.rand(1, 100) <= 66)
		{
			local variants = [
				"01",
				"06",
				"07",
				"08",
				"09"
			];
			this.getSprite("surcoat").setBrush("bust_body_noble_" + variants[this.Math.rand(0, variants.len() - 1)]);
		}

		if (withHelmet && this.Math.rand(1, 100) <= 25)
		{
			if (this.Math.rand(1, 100) <= 50)
			{
				this.m.Items.equip(this.new("scripts/items/helmets/feathered_hat"));
			}
			else
			{
				this.m.Items.equip(this.new("scripts/items/helmets/noble_headgear"));
			}
		}
	}

});

