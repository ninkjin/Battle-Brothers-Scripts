this.goblin_camp_supplies <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "补给";
	}

	function getDescription()
	{
		return "用于填饱这个营地住民的补给。";
	}

	function onInit()
	{
		local variants = [
			"03"
		];
		local body = this.addSprite("body");
		body.setBrush("goblins_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

