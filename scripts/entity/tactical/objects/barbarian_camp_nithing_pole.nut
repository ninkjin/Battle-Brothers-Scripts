this.barbarian_camp_nithing_pole <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "诅咒长杆";
	}

	function getDescription()
	{
		return "一根顶端插着切下来没多久的马头的长木杆，用来朝向敌人或者诅咒的目标。";
	}

	function setFlipped( _flip )
	{
		this.getSprite("bottom").setHorizontalFlipping(_flip);
		this.getSprite("top").setHorizontalFlipping(_flip);
	}

	function onInit()
	{
		local variants = [
			"08"
		];
		local v = variants[this.Math.rand(0, variants.len() - 1)];
		local flip = this.Math.rand(0, 1) == 1;
		local bottom = this.addSprite("bottom");
		bottom.setBrush("barbarians_" + v + "_bottom");
		bottom.setHorizontalFlipping(flip);
		local top = this.addSprite("top");
		top.setBrush("barbarians_" + v + "_top");
		top.setHorizontalFlipping(flip);
		this.setSpriteOcclusion("top", 1, 2, -3);
		this.setBlockSight(false);
	}

});

