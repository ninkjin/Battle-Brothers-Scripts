this.orc_camp_head <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "穿刺头颅";
	}

	function getDescription()
	{
		return "对附近人类下场的一个可怕展示。";
	}

	function setFlipped( _flip )
	{
		this.getSprite("body").setHorizontalFlipping(_flip);
	}

	function setVariant( _variant )
	{
		local variants = [
			"15",
			"16"
		];
		this.getSprite("body").setBrush("orcs_" + variants[_variant]);
	}

	function onInit()
	{
		this.addSprite("body");
	}

});

