this.human_camp_wood <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "劈开的木头";
	}

	function getDescription()
	{
		return "已经劈好的木头，用来当做柴火或者建造尖栅栏。";
	}

	function onInit()
	{
		local variants = [
			"11",
			"15"
		];
		local body = this.addSprite("body");
		body.setBrush("camp_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

