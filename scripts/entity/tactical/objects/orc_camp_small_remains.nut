this.orc_camp_small_remains <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "动物遗骸";
	}

	function getDescription()
	{
		return "某种动物的可怕残骸。";
	}

	function onInit()
	{
		local variants = [
			"02",
			"03"
		];
		local body = this.addSprite("body");
		body.setBrush("orcs_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

