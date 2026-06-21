this.human_camp_furniture <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "家具";
	}

	function getDescription()
	{
		return "营地住民的木制家具。";
	}

	function onInit()
	{
		local variants = [
			"14"
		];
		local body = this.addSprite("body");
		body.setBrush("camp_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

