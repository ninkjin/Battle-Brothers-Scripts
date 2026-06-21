this.goblin_camp_brazier <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "火盆";
	}

	function getDescription()
	{
		return "一个火盆，装满了烧过的木头。";
	}

	function onInit()
	{
		local variants = [
			"04"
		];
		local body = this.addSprite("body");
		body.setBrush("goblins_" + variants[this.Math.rand(0, variants.len() - 1)]);
	}

});

