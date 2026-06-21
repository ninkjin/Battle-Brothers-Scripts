this.barbarian_camp_small_idol <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "神像";
	}

	function getDescription()
	{
		return "一个野蛮人的神像。";
	}

	function onInit()
	{
		local variants = [
			"orcs_08",
			"barbarians_03"
		];
		local body = this.addSprite("body");
		body.setBrush(variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

