this.desert_camp_standard <- this.inherit("scripts/entity/tactical/entity", {
	m = {},
	function getName()
	{
		return "武器";
	}

	function getDescription()
	{
		return "一些展示出来的武器，或许是用来警告入侵者。";
	}

	function onInit()
	{
		local variants = [
			"09",
			"10"
		];
		local v = variants[this.Math.rand(0, variants.len() - 1)];
		local flip = this.Math.rand(0, 1) == 1;
		local bottom = this.addSprite("bottom");
		bottom.setBrush("desert_camp_" + v + "_bottom");
		bottom.setHorizontalFlipping(flip);
		local top = this.addSprite("top");
		top.setBrush("desert_camp_" + v + "_top");
		top.setHorizontalFlipping(flip);
		this.setSpriteOcclusion("top", 1, 2, -3);
		this.setBlockSight(false);
	}

});

